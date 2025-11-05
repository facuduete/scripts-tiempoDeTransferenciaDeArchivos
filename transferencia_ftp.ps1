# ================================
# Script: medir_transferencia_ftp.ps1
# ================================

$origen = "C:\Users\Stemb\OneDrive\Desktop\Archivos de prueba\vmsetup 105MB.exe"
$ftpUrl = "ftp://192.168.0.246:5296/device/Download/vmsetup 105MB.exe"
$usuario = "pc"    
$clave = "845718"   

# Obtener el nombre del archivo desde la ruta origen
$nombreArchivo = Split-Path $origen -Leaf

Write-Host "Iniciando transferencia del archivo: $nombreArchivo ..."
$cronometro = [System.Diagnostics.Stopwatch]::StartNew()

try {
    $webclient = New-Object System.Net.WebClient
    $webclient.Credentials = New-Object System.Net.NetworkCredential($usuario, $clave)
    $webclient.UploadFile($ftpUrl, $origen)

    $cronometro.Stop()
    $t = $cronometro.Elapsed
    Write-Host "Transferencia completada del archivo '$nombreArchivo' en $($t.TotalSeconds) segundos."
}
catch {
    Write-Host "Error al transferir el archivo '$nombreArchivo': $($_.Exception.Message)"
}
finally {
    Read-Host "Presione ENTER para salir"
}
