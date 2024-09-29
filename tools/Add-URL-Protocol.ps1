param (
    [string]$protocolName,
    [string]$appPath
)

if (-not $protocolName -or -not $appPath) {
    Write-Host "Usage: .\Add-URL-Protocol.ps1 <protocolName> <appPath>`nIf protocolName and appPath contain spaces, you must use double quotes."

    exit
}

$regPath = "HKCU:\Software\Classes\$protocolName"
New-Item -Path $regPath -Force
Set-ItemProperty -Path $regPath -Name "(default)" -Value "URL:$protocolName Protocol"
Set-ItemProperty -Path $regPath -Name "URL Protocol" -Value ""

$commandPath = "$regPath\shell\open\command"
New-Item -Path $commandPath -Force
Set-ItemProperty -Path $commandPath -Name "(default)" -Value "`"$appPath`" `"%1`""

Write-Host "Protocol association has been successfully added: $protocolName"
