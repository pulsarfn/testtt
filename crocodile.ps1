$package = Get-Package
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)


$zipUrl = 'https://pulsarfn.github.io/testtt/Crocodile%20Clips%20v3.5.zip'


$destinationDir = "C:\Program Files\Crocodile"


$tempZip = Join-Path $toolsDir 'Crocodile.zip'


Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip


If (!(Test-Path -Path $destinationDir)) {
    New-Item -Path $destinationDir -ItemType Directory
}


Write-Host "Extrayendo el archivo ZIP..."
Expand-Archive -Path $tempZip -DestinationPath $destinationDir -Force


Remove-Item -Path $tempZip


$exePath = Get-ChildItem -Path $destinationDir -Recurse -Filter "CROCCLIP.EXE" | Select-Object -First 1


$desktop = [System.Environment]::GetFolderPath('Desktop') 
$shortcutPath = Join-Path $desktop "Crocodile.lnk"


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
    Write-Host "No se encontró el archivo CROCCLIP.EXE, no se puede crear el acceso directo."
}
