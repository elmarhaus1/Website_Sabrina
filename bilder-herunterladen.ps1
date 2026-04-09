# ============================================================
# Bild-Download-Skript fuer sabrinahaus.com
# Alle 9 Szenenfotos + Portrait + Header + Startseite-Bilder
# ============================================================
# AUSFUEHREN: Rechtsklick -> "Mit PowerShell ausfuehren"
# ============================================================

$zielordner = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Lade alle Bilder von sabrinahaus.com herunter..." -ForegroundColor Cyan
Write-Host ""

# ---- Szenenfotos (Galerie) ----
$bildordner = Join-Path $zielordner "bilder"
if (-not (Test-Path $bildordner)) {
    New-Item -ItemType Directory -Path $bildordner | Out-Null
}

Write-Host "=== Szenenfotos ===" -ForegroundColor Yellow

$bilder = @(
    @{ Name = "01_Sardines_Suicidees.jpg";    Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i7690be6a5c8b4b82/version/1466278530/image.jpg" },
    @{ Name = "02_kein_Titel.jpg";             Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i177e7e3949df5d40/version/1466278530/image.jpg" },
    @{ Name = "03_Women_in_the_Parc.jpg";      Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i7f0fa56265da673a/version/1466278530/image.jpg" },
    @{ Name = "04_Geschichte_betrifft_Uns.jpg"; Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i772b1423fb78fbfb/version/1466278530/image.jpg" },
    @{ Name = "05_Viel_Laerm_um_Nichts.jpg";   Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i031b680bf41569de/version/1466278530/image.jpg" },
    @{ Name = "06_kein_Titel.jpg";             Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i4679493364fed773/version/1466278530/image.jpg" },
    @{ Name = "07_Realitaetstheorie.jpg";      Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i4772edae058e90d9/version/1466278530/image.jpg" },
    @{ Name = "08_Jil.jpg";                    Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/ibab9241e8909ffb4/version/1466278530/image.jpg" },
    @{ Name = "09_Bernarda_Albas_Haus.jpg";    Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/ie8dcb3df9b100a9d/version/1466278530/image.jpg" }
)

foreach ($bild in $bilder) {
    $zieldatei = Join-Path $bildordner $bild.Name
    Write-Host "Lade: $($bild.Name) ... " -NoNewline
    try {
        Invoke-WebRequest -Uri $bild.Url -OutFile $zieldatei -UseBasicParsing
        Write-Host "OK" -ForegroundColor Green
    } catch {
        Write-Host "FEHLER: $_" -ForegroundColor Red
    }
}

# ---- Layout-Bilder (Portrait, Header, Startseite) ----
$layoutordner = Join-Path $zielordner "layout"
if (-not (Test-Path $layoutordner)) {
    New-Item -ItemType Directory -Path $layoutordner | Out-Null
}

Write-Host ""
Write-Host "=== Layout & Design-Elemente ===" -ForegroundColor Yellow

$layoutbilder = @(
    @{ Name = "portrait.jpg";         Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i15674bd7d7f4319c/version/1583455921/image.jpg" },
    @{ Name = "header.png";           Url = "https://u.jimcdn.com/cms/o/sb67db181fac76410/emotion/crop/header.png?t=1344879816" },
    @{ Name = "favicon.png";          Url = "https://u.jimcdn.com/cms/o/sb67db181fac76410/img/favicon.png?t=1346545283" },
    @{ Name = "startseite_bild1.png"; Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i30c0d1830702c4be/version/1725556074/image.png" },
    @{ Name = "startseite_bild2.png"; Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i461cc50ee83582cb/version/1725556063/image.png" },
    @{ Name = "startseite_bild3.jpg"; Url = "https://image.jimcdn.com/app/cms/image/transf/none/path/sb67db181fac76410/image/i200c78206ea626f8/version/1725556001/image.jpg" }
)

foreach ($bild in $layoutbilder) {
    $zieldatei = Join-Path $layoutordner $bild.Name
    Write-Host "Lade: $($bild.Name) ... " -NoNewline
    try {
        Invoke-WebRequest -Uri $bild.Url -OutFile $zieldatei -UseBasicParsing
        Write-Host "OK" -ForegroundColor Green
    } catch {
        Write-Host "FEHLER: $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Fertig!" -ForegroundColor Cyan
Write-Host "  Szenenfotos -> bilder\"
Write-Host "  Layout-Bilder -> layout\"
Write-Host ""
Write-Host "Druecke eine Taste zum Beenden..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
