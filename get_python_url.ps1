$webContent = Invoke-WebRequest -Uri 'https://www.python.org/downloads/' -UseBasicParsing
$matches = $webContent | Select-String -Pattern 'https://www.python.org/ftp/python/\d+(\.\d+){2}/python-\d+(\.\d+){2}-amd64.exe' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }
$matches | Select-Object -First 1
