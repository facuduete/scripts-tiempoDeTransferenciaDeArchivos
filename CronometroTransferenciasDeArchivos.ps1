# === Configuración ===
$carpetaDestino = "C:\" #Cambiar por la ruta de la carpeta donde irá el archivo
$nombreArchivoEsperado = "ejemplo.exe"  # Cambia por el nombre del archivo que esperás junto con su extensión
$logFile = "C:\tiempos.txt"  # Archivo donde se guardará el registro

# === Esperar inicio de la transferencia ===
Write-Host "Esperando a que comience la transferencia de $nombreArchivoEsperado..."
while (-not (Test-Path "$carpetaDestino\$nombreArchivoEsperado")) {
    Start-Sleep -Milliseconds 100
}
$inicio = Get-Date
Write-Host "Transferencia iniciada a las $inicio"

# === Esperar a que finalice la transferencia ===
do {
    Start-Sleep -Milliseconds 100
    try {
        $stream = [System.IO.File]::Open("$carpetaDestino\$nombreArchivoEsperado",'Open','Read','None')
        $stream.Close()
        $locked = $false
    } catch {
        $locked = $true
    }
} while ($locked)

$fin = Get-Date
$duracion = $fin - $inicio

Write-Host ""
Write-Host "Transferencia completada a las $fin"
Write-Host "Duración total: $($duracion.TotalSeconds) segundos"

# === Guardar en archivo log ===
$lineaLog = "[{0}] Archivo: {1} | Duración: {2:F2} segundos" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $nombreArchivoEsperado, $duracion.TotalSeconds
Add-Content -Path $logFile -Value $lineaLog
Write-Host "Registro guardado en: $logFile"
