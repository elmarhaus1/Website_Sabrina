# ============================================================
# Audio + PDF Download-Skript fuer sabrinahaus.com
# ============================================================
# AUSFUEHREN: Rechtsklick -> "Mit PowerShell ausfuehren"
# ============================================================

$zielordner = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Lade Audio-Dateien und PDFs herunter..." -ForegroundColor Cyan
Write-Host ""

$dateien = @(
    # MP3-Dateien
    @{ Name = "Maries_Fest_Teil1.mp3";         Ordner = "audios"; Url = "https://www.sabrinahaus.com/app/download/6523535686/1.mp3?t=1346542679" },
    @{ Name = "Maries_Fest_Teil2.mp3";         Ordner = "audios"; Url = "https://www.sabrinahaus.com/app/download/6523538786/2.mp3?t=1346542733" },
    @{ Name = "Nokia_Werbetrailer.mp3";        Ordner = "audios"; Url = "https://www.sabrinahaus.com/app/download/6523547286/1.mp3?t=1346544094" },
    @{ Name = "Edith.mp3";                     Ordner = "audios"; Url = "https://www.sabrinahaus.com/app/download/6523552386/1.mp3?t=1468273331" },
    @{ Name = "Shoppen_und_Ficken.mp3";        Ordner = "audios"; Url = "https://www.sabrinahaus.com/app/download/6523553586/1.mp3?t=1468273331" },
    # PDFs
    @{ Name = "Sabrina_Haus_VITA_2022.pdf";    Ordner = "pdfs";   Url = "https://www.sabrinahaus.com/app/download/10074994386/2022+Sabrina+Haus+VITA+.pdf?t=1651686099" },
    @{ Name = "Sabrina_Haus_VITA_2020_FR.pdf"; Ordner = "pdfs";   Url = "https://www.sabrinahaus.com/app/download/9610437386/Sabrina+Haus+VITA+2020.pdf?t=1583456164" }
)

foreach ($datei in $dateien) {
    $unterordner = Join-Path $zielordner $datei.Ordner
    if (-not (Test-Path $unterordner)) {
        New-Item -ItemType Directory -Path $unterordner | Out-Null
    }
    $zieldatei = Join-Path $unterordner $datei.Name
    Write-Host "Lade: $($datei.Name) ... " -NoNewline
    try {
        Invoke-WebRequest -Uri $datei.Url -OutFile $zieldatei -UseBasicParsing
        Write-Host "OK" -ForegroundColor Green
    } catch {
        Write-Host "FEHLER: $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Fertig!" -ForegroundColor Cyan
Write-Host "Druecke eine Taste zum Beenden..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
