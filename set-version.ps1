(Get-Content DESCRIPTION) -replace 'Version: .*', "Version: $args" | Set-Content DESCRIPTION
