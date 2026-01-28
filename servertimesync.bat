<# :
@echo off
title Configurador de Zona Horaria - Offline
setlocal EnableDelayedExpansion

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Por favor, ejecuta este script como ADMINISTRADOR.
    echo [COMO HACERLO] Click derecho sobre el archivo ^> Ejecutar como ADMINISTRADOR
    pause
    exit /b
)

echo ======================================================
echo   CONFIGURADOR DE ZONA HORARIA AUTOMATICO
echo ======================================================
echo.

powershell -noprofile -executionpolicy bypass -command ^
"iex ((Get-Content '%~f0' -Raw) -join [char]10)"

echo.
echo ======================================================
echo [+] Proceso finalizado.
echo [+] Hora actual: %time%
echo ======================================================
pause
exit /b
#>

# ================= POWERSHELL =================

$tzId = $null

# ----------------- DETECCIÓN POR IP -----------------
try {
    $data = Invoke-RestMethod -Uri "https://ipinfo.io/json" -TimeoutSec 5

    if ($data.timezone) {
        $ianaTz = $data.timezone
        Write-Host "IANA timezone obtenida de IP: $ianaTz" -ForegroundColor Cyan

        # ----------------- MAPEO IANA -> WINDOWS OFFLINE -----------------
        $ianaMap = @{
            "Europe/Madrid"       = "Romance Standard Time"
            "Europe/Paris"        = "Romance Standard Time"
            "Europe/Berlin"       = "W. Europe Standard Time"
            "Europe/Rome"         = "W. Europe Standard Time"
            "Europe/Lisbon"       = "GMT Standard Time"
            "America/New_York"    = "Eastern Standard Time"
            "America/Chicago"     = "Central Standard Time"
            "America/Los_Angeles" = "Pacific Standard Time"
            "America/Bogota"      = "SA Pacific Standard Time"
            "America/Lima"        = "SA Pacific Standard Time"
            "America/Santiago"    = "Pacific SA Standard Time"
        }

        if ($ianaMap.ContainsKey($ianaTz)) {
            $tzId = $ianaMap[$ianaTz]
            Write-Host "Mapeada a Windows TZ: $tzId" -ForegroundColor Green
        } else {
            Write-Host "IANA timezone desconocida, se usará la zona horaria actual." -ForegroundColor Red
        }
    } else {
        Write-Host "No se encontró timezone en la respuesta de IP." -ForegroundColor Red
    }

} catch {
    Write-Host "Error al conectar con ipinfo.io: $_" -ForegroundColor Red
}

# ----------------- FALLBACK -----------------
if (-not $tzId) {
    $tzId = (Get-TimeZone).Id
    Write-Host "Fallback: usando la zona horaria actual del sistema: $tzId" -ForegroundColor Gray
}

# ----------------- APLICAR ZONA HORARIA -----------------
if ($tzId) {
    Write-Host "Ajustando sistema a: $tzId" -ForegroundColor Green
    tzutil.exe /s "$tzId"
} else {
    Write-Host "No se pudo determinar ninguna zona horaria, no se realiza ningún cambio." -ForegroundColor Red
}
