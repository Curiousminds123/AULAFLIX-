# ==============================================================================
# EDOCENTIA EN VÍDEO - ACTUALIZADOR DE ENLACES Y PUBLICADOR EN GITHUB
# Materiales creados por Ana H. Iranzo
# ==============================================================================
param(
    [string]$TxtFile = "Lista de videos para el catalogo de AULAXLIX.txt",
    [string]$HtmlFile = "index.html",
    [switch]$AutoPush
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "Edocentia en vídeo - Actualizador"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   EDOCENTIA EN VÍDEO · Actualizador de Enlaces Web" -ForegroundColor Yellow
Write-Host "   Materiales creados por Ana H. Iranzo" -ForegroundColor Gray
Write-Host "==========================================================" -ForegroundColor Cyan

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $scriptDir) { $scriptDir = Get-Location }
Set-Location $scriptDir

$htmlPath = Join-Path $scriptDir $HtmlFile
$txtPath  = Join-Path $scriptDir $TxtFile

if (-not (Test-Path $htmlPath)) {
    Write-Host "ERROR: No se encuentra el archivo $HtmlFile en $scriptDir" -ForegroundColor Red
    exit 1
}

function Read-LinksFromTxt {
    param([string]$path)
    $links = @{}
    if (Test-Path $path) {
        $lines = Get-Content -Path $path -Encoding UTF8
        foreach ($line in $lines) {
            $line = $line.Trim()
            if ($line.StartsWith("#") -or [string]::IsNullOrWhiteSpace($line)) { continue }
            if ($line -match 'T(\d+)E(\d+)[\s\S]*?=\s*(https?://[^\s]+)') {
                $code = "T" + $Matches[1] + "E" + $Matches[2]
                $url = $Matches[3].Trim()
                $links[$code] = $url
            }
        }
    }
    return $links
}

function Update-HtmlWithLinks {
    param(
        [string]$path,
        [hashtable]$links
    )

    $content = Get-Content -Path $path -Raw -Encoding UTF8
    $totalUpdated = 0

    foreach ($key in $links.Keys) {
        $url = $links[$key]
        if ($key -match 'T(\d+)E(\d+)') {
            $season = [int]$Matches[1]
            $ep = [int]$Matches[2]

            # Buscar en el HTML la definición de este episodio dentro de su módulo y actualizar el url
            # Patrón para el array de videos del módulo
            # Buscaremos por título o posición
        }
    }

    # Forma robusta y segura: parsear y actualizar línea a línea
    $lines = Get-Content -Path $path -Encoding UTF8
    $newLines = @()
    $currentModule = 0
    $currentEpInModule = 0

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]

        if ($line -match 'id:\s*"m(\d+)"') {
            $currentModule = [int]$Matches[1]
            $currentEpInModule = 0
        }

        if ($line -match '\{\s*t:\s*"([^"]+)"') {
            $currentEpInModule++
            $code = "T$currentModule" + "E$currentEpInModule"

            if ($links.ContainsKey($code) -and -not [string]::IsNullOrWhiteSpace($links[$code])) {
                $newUrl = $links[$code]
                if ($line -match 'url:\s*"[^"]*"') {
                    $line = $line -replace 'url:\s*"[^"]*"', "url:`"$newUrl`""
                    $totalUpdated++
                }
            }
        }

        $newLines += $line
    }

    [System.IO.File]::WriteAllLines($path, $newLines, [System.Text.Encoding]::UTF8)
    return $totalUpdated
}

# --- Menú interactivo ---
Write-Host "`n¿Qué deseas hacer?" -ForegroundColor Green
Write-Host "1) Actualizar index.html usando '$TxtFile'"
Write-Host "2) Introducir un enlace manualmente (ej: T1E2 o por temporada/episodio)"
Write-Host "3) Subir cambios a GitHub (Curiousminds123/AULAFLIX-)"
Write-Host "4) Salir"

$opcion = Read-Host "`nElige una opción (1-4)"

if ($opcion -eq "1") {
    $links = Read-LinksFromTxt -path $txtPath
    if ($links.Count -eq 0) {
        Write-Host "`nNo se encontraron URLs con enlace en $TxtFile." -ForegroundColor Yellow
        Write-Host "Asegúrate de poner la URL después del '=' en cada episodio." -ForegroundColor Yellow
    } else {
        Write-Host "`nSe han encontrado $($links.Count) enlaces definidos en ${TxtFile}:" -ForegroundColor Cyan
        foreach ($k in ($links.Keys | Sort-Object)) {
            Write-Host "  $k -> $($links[$k])" -ForegroundColor Gray
        }
        $count = Update-HtmlWithLinks -path $htmlPath -links $links
        Write-Host "`n¡ÉXITO! index.html ha sido actualizado con los nuevos enlaces." -ForegroundColor Green
    }
}
elseif ($opcion -eq "2") {
    $code = Read-Host "`nIntroduce el código del episodio (ejemplo: T1E2 o T2E5)"
    $code = $code.ToUpper().Trim()
    $url = Read-Host "Introduce la URL del vídeo (ejemplo: https://youtu.be/...)"
    $url = $url.Trim()

    if ($code -match '^T[1-4]E[1-6]$' -and $url -match '^https?://') {
        $dict = @{ $code = $url }
        $count = Update-HtmlWithLinks -path $htmlPath -links $dict

        # Actualizar también el archivo .txt para que quede registrado
        if (Test-Path $txtPath) {
            $txtContent = Get-Content -Path $txtPath -Raw -Encoding UTF8
            $pattern = "(?m)^(" + [regex]::Escape($code) + "[^=\n]*=\s*).*$"
            if ($txtContent -match $pattern) {
                $txtContent = [regex]::Replace($txtContent, $pattern, "${1}$url")
                [System.IO.File]::WriteAllText($txtPath, $txtContent, [System.Text.Encoding]::UTF8)
            }
        }

        Write-Host "`n¡ÉXITO! Episodio $code actualizado con: $url" -ForegroundColor Green
    } else {
        Write-Host "Código de episodio o URL no válidos." -ForegroundColor Red
    }
}
elseif ($opcion -eq "3") {
    # Solo push
}
else {
    Write-Host "Saliendo..." -ForegroundColor Gray
    exit 0
}

# Preguntar si desea hacer push a GitHub
Write-Host "`n----------------------------------------------------------" -ForegroundColor DarkGray
$doPush = Read-Host "¿Deseas guardar los cambios y subirlos a GitHub ahora mismo? (s/n)"
if ($doPush -eq "s" -or $doPush -eq "S" -or $AutoPush) {
    Write-Host "`nSubiendo a GitHub..." -ForegroundColor Cyan
    git add .
    git commit -m "Actualizar enlaces y contenidos de Edocentia en video"
    git branch -M main
    git push -u origin main
    Write-Host "`n¡Subida completada en https://github.com/Curiousminds123/AULAFLIX-!" -ForegroundColor Green
}
Write-Host "`nListo. ¡Gracias por usar Edocentia en vídeo!" -ForegroundColor Cyan
