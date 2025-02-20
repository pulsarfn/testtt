$package = Get-Package
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

# URL del archivo ZIP
$zipUrl = 'https://github.com/sdasasdasdwwaasdsd/sssss/raw/refs/heads/main/Crocodile%20Clips%20v3.5.zip'

# Carpeta de destino donde se extraerán los archivos
$destinationDir = "C:\Program Files\Crocodile"

# Ruta temporal para el archivo ZIP
$tempZip = Join-Path $toolsDir 'Crocodile.zip'

# Descargar el archivo ZIP desde la URL
Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip

# Crear la carpeta de destino si no existe
If (!(Test-Path -Path $destinationDir)) {
    New-Item -Path $destinationDir -ItemType Directory
}

# Extraer el archivo ZIP en la carpeta de destino
Write-Host "Extrayendo el archivo ZIP..."
Expand-Archive -Path $tempZip -DestinationPath $destinationDir -Force

# Limpiar el archivo ZIP descargado
Remove-Item -Path $tempZip

# Verificar si el archivo ejecutable existe, incluso en subdirectorios
$exePath = Get-ChildItem -Path $destinationDir -Recurse -Filter "CROCCLIP.EXE" | Select-Object -First 1

# Crear acceso directo en el escritorio
$desktop = [System.Environment]::GetFolderPath('Desktop') 
$shortcutPath = Join-Path $desktop "Crocodile.lnk"

# Crear el acceso directo solo si el archivo ejecutable existe
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
