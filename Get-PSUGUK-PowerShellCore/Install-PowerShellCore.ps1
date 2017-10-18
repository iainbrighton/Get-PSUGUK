#requires -RunAsAdministrator

## Download and install VS 2015 C++ x64 Redistibutable (NOTE: Beta 8 onwards)
$vcInstallerPath = Join-Path -Path $env:TEMP -ChildPath 'vc_redist.x64.exe';
if (-not (Test-Path -Path $vcInstallerPath)) {
    $vcInstallerUri = 'https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe'
    Invoke-WebRequest -Uri $vcInstallerUri -OutFile $vcInstallerPath
}
& $vcInstallerPath /install /passive /norestart | Out-Null

## Install latest PowerShell Core MSI x64 release
$latestRelease = Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/latest -UseBasicParsing
$msiRelativeLink = $latestRelease.Links | Where href -Match '-win-x64.msi' | % href
$msiInstallerPath = Join-Path -Path $env:TEMP -ChildPath $msiRelativeLink.Split('/')[-1]

if (-not (Test-Path -Path $msiInstallerPath)) {
    Invoke-WebRequest -Uri ('https://github.com{0}' -f $msiRelativeLink) -OutFile $msiInstallerPath
}
& msiexec.exe /i $msiInstallerPath /qb
