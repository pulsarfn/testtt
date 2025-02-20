$package = Get-Package
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)


$zipUrl = 'https://pulsarfn.github.io/testtt/PSeInt.zip'


$destinationDir = "C:\Program Files (x86)\PSeInt"


$tempZip = Join-Path $toolsDir 'PSeInt.zip'


Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip


If (!(Test-Path -Path $destinationDir)) {
    New-Item -Path $destinationDir -ItemType Directory
}


Write-Host "Extrayendo el archivo ZIP..."
Expand-Archive -Path $tempZip -DestinationPath $destinationDir -Force


Remove-Item -Path $tempZip


$exePath = Get-ChildItem -Path $destinationDir -Recurse -Filter "wxPSeInt.exe" | Select-Object -First 1


$desktop = [System.Environment]::GetFolderPath('Desktop') 
$shortcutPath = Join-Path $desktop "PSeInt.lnk"


If ($exePath) {
    Try {
        $WshShell = New-Object -ComObject WScript.Shell
        $shortcut = $WshShell.CreateShortcut($shortcutPath)
        $shortcut.TargetPath = $exePath.FullName
        $shortcut.IconLocation = $exePath.FullName
        $shortcut.Save()
        Write-Host "Acceso directo creado en el escritorio."
    }
    Catch {
        Write-Host "Hubo un error al crear el acceso directo: $_"
    }
} else {
    Write-Host "No se encontró el archivo wxPSeInt.exe, no se puede crear el acceso directo."
}
