(Get-Content DESCRIPTION) -replace 'Version: .*', "Version: $args" | Set-Content DESCRIPTION
(Get-Content package.json) -replace '  "version": "0.0.1"', '  "version": $args"' | Set-Content package.json
