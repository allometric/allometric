#!/usr/bin/env Rscript
# Build Starlight-ready markdown reference docs for allometric.org from the
# package's man/*.Rd files.
#
# The website (allometric/site) vendors this repository as a git submodule and
# symlinks docs/reference/*.md into its Starlight content collection. This
# script is the single generator: run it from the package root after
# regenerating man/ with roxygen2, and commit the output.
#
#   Rscript scripts/build-docs.R
#
# Output:
#   docs/reference/<topic>.md   one page per public Rd topic
#   docs/reference/_index.json  ordered sidebar manifest consumed by the site
#
# Public topics are Rd files without a \keyword{internal}. Internal topics are
# excluded from pages; their aliases are absent from the link map so \link
# targets to them degrade to plain code instead of dead links.

root <- "."
man_dir <- file.path(root, "man")
out_dir <- file.path(root, "docs", "reference")

if (!dir.exists(man_dir)) {
  stop("Run from the allometric package root (no man/ directory found).")
}
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# ---------------------------------------------------------------------------
# Sidebar manifest: curated groups in display order. Topics not listed are
# appended to a "More" group.
# ---------------------------------------------------------------------------

sidebar_groups <- list(
  list(label = "Overview", topics = "allometric-package"),
  list(
    label = "Classes",
    topics = c(
      "FixedEffectsModel", "FixedEffectsSet",
      "MixedEffectsModel", "MixedEffectsSet",
      "Publication", "Taxa", "Taxon"
    )
  ),
  list(
    label = "Loading models",
    topics = c(
      "install_models", "load_model", "load_models", "load_set",
      "check_models_installed", "add_model", "add_set"
    )
  ),
  list(
    label = "Model selection and prediction",
    topics = c(
      "predict", "predict-set", "select_model", "merge.model_tbl",
      "unnest_models", "unnest_taxa", "unnest_taxa.model_tbl",
      "aggregate_taxa", "model_call", "descriptors",
      "filter_joined_models"
    )
  ),
  list(
    label = "Variable naming",
    topics = c("get_component_defs", "get_measure_defs", "get_variable_def")
  ),
  list(
    label = "S4 methods",
    topics = c(
      "equals-FixedEffectsModel-FixedEffectsModel-method",
      "equals-MixedEffectsModel-MixedEffectsModel-method",
      "grapes-in-grapes-Taxon-character-method"
    )
  ),
  list(
    label = "Data",
    topics = c("brackett_acer", "brackett_rubra", "fia_trees")
  )
)

# ---------------------------------------------------------------------------
# Rd tree utilities
# ---------------------------------------------------------------------------

`%||%` <- function(a, b) if (is.null(a)) b else a

rd_tag <- function(node) {
  if (is.character(node)) "" else attr(node, "Rd_tag") %||% ""
}

is_text <- function(node) is.character(node)

rd_children <- function(node) {
  if (is.list(node)) node else list()
}

# parse_Rd stores each brace-group argument of a multi-argument macro inside an
# untagged list. flat() removes those transparent containers, splicing their
# contents into the stream while keeping tagged macro nodes intact.
flat <- function(nodes) {
  out <- list()
  for (n in nodes) {
    if (is.list(n)) {
      if (is.null(attr(n, "Rd_tag"))) {
        out <- c(out, flat(n))
      } else {
        out[[length(out) + 1]] <- n
      }
    } else {
      out[[length(out) + 1]] <- n
    }
  }
  out
}

# Raw text of an Rd subtree, dropping \if / \out markup but keeping the text
# inside \code / \preformatted / \verb.
rd_raw_text <- function(nodes) {
  vapply(nodes, function(node) {
    if (is_text(node)) {
      return(node)
    }
    tag <- rd_tag(node)
    if (tag %in% c("\\if", "\\out", "\\ifelse")) {
      return("")
    }
    paste(rd_raw_text(rd_children(node)), collapse = "")
  }, character(1)) |>
    paste(collapse = "")
}

# Raw text of a subtree, keeping \out content (used to read the HTML divs
# roxygen emits around code fences).
raw_out_text <- function(nodes) {
  paste(vapply(nodes, function(node) {
    if (is_text(node)) {
      return(node)
    }
    paste(raw_out_text(rd_children(node)), collapse = "")
  }, character(1)), collapse = "")
}

# Unescape Rd text escapes that survive parse_Rd in raw chunks.
unescape_text <- function(x) {
  x <- gsub("\\%", "%", x, fixed = TRUE)
  x <- gsub("\\_", "_", x, fixed = TRUE)
  x
}

# ---------------------------------------------------------------------------
# Inline markdown rendering
# ---------------------------------------------------------------------------

inline_md <- function(nodes) {
  nodes <- flat(nodes)
  parts <- lapply(nodes, function(node) {
    if (is_text(node)) {
      return(gsub("\\s+", " ", node))
    }
    tag <- rd_tag(node)
    kids <- rd_children(node)
    switch(tag,
      "\\code" = {
        txt <- gsub("`", "'", rd_raw_text(kids), fixed = TRUE)
        paste0("`", txt, "`")
      },
      "\\verb" = {
        txt <- gsub("`", "'", rd_raw_text(kids), fixed = TRUE)
        paste0("`", txt, "`")
      },
      "\\pkg" = paste0("`", rd_raw_text(kids), "`"),
      "\\emph" = paste0("*", inline_md(kids), "*"),
      "\\strong" = paste0("**", inline_md(kids), "**"),
      "\\sQuote" = paste0("'", inline_md(kids), "'"),
      "\\dQuote" = paste0('"', inline_md(kids), '"'),
      "\\dots" = "\u2026",
      "\\ldots" = "\u2026",
      "\\if" = "",
      "\\out" = "",
      "\\link" = {
        rest <- kids
        if (length(rest) >= 2 && is_text(rest[[1]]) && grepl("^=", rest[[1]])) {
          # \link[=topic]{text}
          target <- sub("^=", "", rest[[1]])
          label <- inline_md(rest[-1])
        } else if (length(rest) >= 2 && !is_text(rest[[1]]) &&
                   rd_tag(rest[[1]]) == "\\pkg") {
          # \link[pkg]{topic}{text}: external package, no page here
          return(paste0("`", inline_md(rest[-1]), "`"))
        } else {
          target <- rd_raw_text(rest)
          label <- target
        }
        link_md(target, label)
      },
      "\\linkS4class" = link_md(rd_raw_text(kids), rd_raw_text(kids)),
      "\\href" = {
        url <- rd_raw_text(kids[1])
        label <- inline_md(kids[-1])
        paste0("[", label, "](", url, ")")
      },
      "\\url" = paste0("<", rd_raw_text(kids), ">"),
      "\\email" = {
        addr <- rd_raw_text(kids)
        paste0("[", addr, "](mailto:", addr, ")")
      },
      "\\eqn" = paste0("$", rd_raw_text(kids), "$"),
      "\\deqn" = paste0("\n$$\n", rd_raw_text(kids), "\n$$\n"),
      "\\cr" = "\n",
      inline_md(kids)
    )
  })
  paste(parts, collapse = "")
}

# Wrap a topic cross-reference. Public topics link to their page; internal or
# unknown targets render as plain code so we never emit dead links.
link_md <- function(target, label) {
  if (nzchar(target) && target %in% names(alias_map)) {
    slug <- alias_map[[target]]
    paste0("[`", gsub("`", "'", label, fixed = TRUE), "`](/reference/", slug, "/)")
  } else {
    paste0("`", gsub("`", "'", label, fixed = TRUE), "`")
  }
}

# ---------------------------------------------------------------------------
# Block rendering
# ---------------------------------------------------------------------------

fence <- function(code, lang = "r") {
  code <- unescape_text(code)
  if (!grepl("\n$", code)) code <- paste0(code, "\n")
  paste0("```", lang, "\n", code, "```")
}

# Walk a sequence of Rd nodes and return markdown blocks (paragraphs, code
# fences, lists) as a character vector joined by blank lines by the caller.
render_blocks <- function(nodes) {
  nodes <- flat(nodes)
  out <- character()
  para <- character()
  pending_lang <- NULL  # code language announced by a preceding \if div

  flush <- function() {
    if (length(para)) {
      text <- gsub("[ \t]{2,}", " ", paste(para, collapse = " "))
      text <- gsub(" +([,.;:!?)])", "\\1", text)
      text <- trimws(text)
      if (nzchar(text)) out <<- c(out, text)
      para <<- character()
    }
  }

  for (node in nodes) {
    if (is_text(node)) {
      txt <- unescape_text(node)
      chunks <- strsplit(txt, "\n", fixed = TRUE)[[1]]
      for (chunk in chunks) {
        if (grepl("^\\s*$", chunk)) {
          flush()
        } else {
          para <- c(para, chunk)
        }
      }
      next
    }
    tag <- rd_tag(node)
    kids <- rd_children(node)

    if (tag == "\\if") {
      # roxygen wraps markdown code fences as:
      #   \if{html}{\out{<div class="sourceCode r">}} \preformatted{...}
      #   \if{html}{\out{</div>}}
      # Announce the language for the next \preformatted and drop the wrapper.
      cond <- rd_raw_text(kids[1])
      out_html <- raw_out_text(kids[2])
      if (grepl("html", cond, fixed = TRUE)) {
        if (grepl("sourceCode", out_html, fixed = TRUE)) {
          cls <- sub(".*sourceCode\\s*([^>]*)>.*", "\\1", out_html)
          pending_lang <- if (grepl("r", cls)) "r" else ""
        } else if (grepl("</div>", out_html, fixed = TRUE)) {
          pending_lang <- NULL
        }
      }
      next
    }

    if (tag == "\\preformatted") {
      flush()
      lang <- pending_lang %||% ""
      code <- rd_raw_text(kids)
      out <- c(out, fence(code, lang))
      next
    }

    if (tag == "\\subsection") {
      flush()
      heading <- trimws(inline_md(kids[1]))
      body <- render_blocks(kids[-1])
      out <- c(out, paste0("#### ", heading), body)
      next
    }

    if (tag %in% c("\\itemize", "\\enumerate", "\\describe")) {
      flush()
      out <- c(out, list_block(tag, kids))
      next
    }

    if (tag %in% c("\\code", "\\verb")) {
      para <- c(para, inline_md(list(node)))
      next
    }

    para <- c(para, inline_md(list(node)))
  }
  flush()
  out
}

# Split a list body into item segments. Roxygen emits markdown lists with
# empty \item markers followed by streamed content; \describe (and some \item
# uses) instead give \item{content} or \item{term}{description}.
split_items <- function(nodes) {
  nodes <- flat(nodes)
  items <- list()
  cur <- list()
  for (n in nodes) {
    if (rd_tag(n) == "\\item") {
      if (length(cur)) {
        items[[length(items) + 1]] <- cur
        cur <- list()
      }
      cur <- c(cur, rd_children(n))  # \item{content} style
    } else {
      cur <- c(cur, list(n))
    }
  }
  if (length(cur)) items[[length(items) + 1]] <- cur
  # Drop segments that are only inter-item whitespace.
  items <- Filter(function(seg) any(nzchar(trimws(rd_raw_text(seg)))), items)
  items
}

list_block <- function(tag, kids) {
  if (tag == "\\describe") {
    items <- Filter(function(el) rd_tag(el) == "\\item", flat(kids))
    if (!length(items)) return("")
    out <- vapply(items, function(item) {
      parts <- rd_children(item)
      term <- trimws(inline_md(parts[1]))
      desc <- paste(render_blocks(parts[-1]), collapse = " ")
      paste0("- **", term, "** \u2014 ", desc)
    }, character(1))
    return(paste(out, collapse = "\n"))
  }
  items <- split_items(kids)
  if (!length(items)) return("")
  markers <- switch(tag,
    "\\itemize" = rep("- ", length(items)),
    "\\enumerate" = paste0(seq_along(items), ". ")
  )
  out <- character(length(items))
  for (i in seq_along(items)) {
    body <- render_blocks(items[[i]])
    if (!length(body)) body <- ""
    out[i] <- paste0(markers[i], paste(body, collapse = "\n  "))
  }
  paste(out, collapse = "\n")
}

# Render the \usage section as code, rewriting S4/S3 method macros to a
# signature comment plus the call. Usage is extracted textually from the Rd
# file: parse_Rd separates a method's argument list from its \S4method macro,
# while the source keeps them on one line.
read_usage_text <- function(path) {
  txt <- paste(readLines(path, warn = FALSE), collapse = "\n")
  m <- regexpr("\\\\usage\\{", txt)
  if (m == -1L) return(NULL)
  body <- substr(txt, m + attr(m, "match.length"), nchar(txt))
  # Scan for the matching closing brace; depth starts at 1 (inside \usage{).
  chars <- strsplit(body, "", fixed = TRUE)[[1]]
  depth <- 1L
  end <- NA_integer_
  for (i in seq_along(chars)) {
    if (chars[[i]] == "{") {
      depth <- depth + 1L
    } else if (chars[[i]] == "}") {
      depth <- depth - 1L
      if (depth == 0L) {
        end <- i - 1L
        break
      }
    }
  }
  if (is.na(end)) return(NULL)
  code <- substr(body, 1L, end)
  code <- gsub("\\\\S4method\\{([^}]*)\\}\\{([^}]*)\\}", "## S4 method for signature '\\2':\n\\1", code)
  code <- gsub("\\\\method\\{([^}]*)\\}\\{([^}]*)\\}", "## S3 method for class '\\2':\n\\1", code)
  code
}

# ---------------------------------------------------------------------------
# Topic building
# ---------------------------------------------------------------------------

first_text <- function(rd, tag) {
  hits <- which(vapply(rd, rd_tag, character(1)) == tag)
  if (!length(hits)) return(NULL)
  rd[[hits[[1]]]]
}

all_text <- function(rd, tag) {
  hits <- which(vapply(rd, rd_tag, character(1)) == tag)
  lapply(hits, function(i) rd[[i]])
}

is_internal_topic <- function(rd) {
  any(vapply(all_text(rd, "\\keyword"), function(k) {
    any(grepl("internal", rd_raw_text(rd_children(k)), fixed = TRUE))
  }, logical(1)))
}

extract_description <- function(node) {
  if (is.null(node)) return("")
  txt <- inline_md(rd_children(node))
  txt <- gsub("\\[([^]]*)\\]\\([^)]*\\)", "\\1", txt)  # keep link labels only
  txt <- gsub("<([^>]*)>", "\\1", txt)                 # autolinks
  txt <- trimws(gsub("\\s+", " ", txt))
  txt <- sub("\\.\\s+.*$", ".", txt)
  txt
}

title_text <- function(rd) {
  t <- first_text(rd, "\\title")
  if (is.null(t)) return("")
  txt <- trimws(inline_md(rd_children(t)))
  if (grepl("^allometric:", txt)) "allometric" else txt
}

topic_kind <- function(rd) {
  doc_types <- unlist(lapply(all_text(rd, "\\docType"), rd_raw_text))
  if ("package" %in% doc_types) return("package")
  if ("data" %in% doc_types) return("data")
  if ("class" %in% doc_types) return("class")
  if ("methods" %in% doc_types) return("methods")
  "function"
}

build_topic <- function(path) {
  rd <- tools::parse_Rd(path)
  tags <- vapply(rd, rd_tag, character(1))

  name <- sub("[.]Rd$", "", basename(path))
  if (is_internal_topic(rd)) return(NULL)

  slug <- slugify(name)
  title <- title_text(rd)
  desc_node <- first_text(rd, "\\description")
  description <- extract_description(desc_node)
  kind <- topic_kind(rd)

  lead <- if (!is.null(desc_node)) {
    paste(render_blocks(rd_children(desc_node)), collapse = "\n\n")
  } else ""

  section_md <- character()
  add_named <- function(heading, body) {
    if (length(body)) {
      section_md <<- c(section_md, paste0("## ", heading), body)
    }
  }

  # Usage.
  usage_txt <- read_usage_text(path)
  if (!is.null(usage_txt)) {
    is_data_ref <- kind == "data" &&
      grepl("^\\s*[A-Za-z0-9_.]+\\s*$", usage_txt)
    if (!is_data_ref) {
      add_named("Usage", fence(usage_txt, "r"))
    }
  }

  # Arguments -> bullet list of **`name`** — description.
  args_node <- first_text(rd, "\\arguments")
  if (!is.null(args_node)) {
    items <- split_items(rd_children(args_node))
    arg_lines <- vapply(items, function(seg) {
      parts <- flat(seg)
      nm <- trimws(inline_md(parts[1]))
      desc <- paste(render_blocks(parts[-1]), collapse = " ")
      paste0("- **", nm, "** \u2014 ", desc)
    }, character(1))
    add_named("Arguments", arg_lines)
  }

  body_tags <- c("\\value", "\\details")
  body_heads <- c("\\value" = "Value", "\\details" = "Details")
  for (tag in body_tags) {
    node <- first_text(rd, tag)
    if (!is.null(node)) {
      add_named(body_heads[[tag]], render_blocks(rd_children(node)))
    }
  }

  # Custom \section{Title}{body} blocks, in file order.
  for (sn in all_text(rd, "\\section")) {
    kids <- rd_children(sn)
    if (!length(kids)) next
    heading <- trimws(inline_md(kids[1]))
    body <- render_blocks(kids[-1])
    section_md <- c(section_md, paste0("## ", heading), body)
  }

  # Remaining standard tags, each under its own heading.
  tail_heads <- c(
    "\\format" = "Format", "\\source" = "Source", "\\note" = "Note",
    "\\references" = "References", "\\seealso" = "See also",
    "\\author" = "Author"
  )
  for (tag in names(tail_heads)) {
    if (tag %in% tags) {
      node <- rd[[which(tags == tag)[1]]]
      add_named(tail_heads[[tag]], render_blocks(rd_children(node)))
    }
  }

  # Examples last, unevaluated.
  ex_node <- first_text(rd, "\\examples")
  if (!is.null(ex_node)) {
    add_named("Examples", fence(rd_raw_text(rd_children(ex_node)), "r"))
  }

  body <- trimws(paste(c(lead, section_md), collapse = "\n\n"))
  list(
    name = name, slug = slug, title = title,
    description = description, kind = kind, body = body
  )
}

slugify <- function(name) {
  # Starlight slugs keep letters, digits, hyphens, and underscores but drop
  # other punctuation; map dots to hyphens so routes stay predictable.
  tolower(gsub("\\.", "-", name))
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

rd_files <- list.files(man_dir, pattern = "[.]Rd$", full.names = TRUE)
alias_map <- list()

# First pass: register aliases of public topics only, so \link targets to
# internal topics degrade to plain code instead of dead links.
for (f in rd_files) {
  rd <- tools::parse_Rd(f)
  nm <- sub("[.]Rd$", "", basename(f))
  if (is_internal_topic(rd)) next
  for (al in unlist(lapply(all_text(rd, "\\alias"), rd_raw_text))) {
    alias_map[[al]] <- slugify(nm)
  }
}

topics <- list()
for (f in rd_files) {
  topic <- tryCatch(build_topic(f), error = function(e) {
    warning("Failed to build ", basename(f), ": ", conditionMessage(e), call. = FALSE)
    NULL
  })
  if (!is.null(topic)) topics[[topic$name]] <- topic
}

if (!length(topics)) stop("No topics generated.")
message("Generated ", length(topics), " topics.")

# Write pages.
for (topic in topics) {
  front <- c(
    "---",
    paste0('title: "', gsub('"', "'", topic$title), '"'),
    paste0('description: "', gsub('"', "'", topic$description), '"'),
    "---",
    ""
  )
  writeLines(c(front, topic$body, ""), file.path(out_dir, paste0(topic$slug, ".md")))
}

# Write the sidebar manifest, preserving curated group order.
listed <- unlist(lapply(sidebar_groups, function(g) g$topics))
extra <- setdiff(listed, names(topics))
if (length(extra)) {
  warning("Sidebar lists unknown topics (no Rd page generated): ",
          paste(extra, collapse = ", "))
}
groups <- lapply(sidebar_groups, function(g) {
  items <- lapply(g$topics, function(nm) {
    t <- topics[[nm]]
    if (is.null(t)) return(NULL)
    list(name = t$name, slug = t$slug, title = t$title, kind = t$kind)
  })
  items <- Filter(Negate(is.null), items)
  list(label = g$label, items = items)
})
missing <- setdiff(names(topics), listed)
if (length(missing)) {
  groups[[length(groups) + 1]] <- list(
    label = "More",
    items = lapply(missing, function(nm) {
      t <- topics[[nm]]
      list(name = t$name, slug = t$slug, title = t$title, kind = t$kind)
    })
  )
}
manifest <- list(
  generator = "allometric/scripts/build-docs.R (see vendor submodule commit)",
  groups = groups
)
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("jsonlite is required to write the sidebar manifest.")
}
writeLines(
  jsonlite::toJSON(manifest, auto_unbox = TRUE, pretty = TRUE),
  file.path(out_dir, "_index.json")
)
message("Wrote ", length(topics), " pages and _index.json to ", out_dir)
