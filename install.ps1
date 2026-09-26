$ErrorActionPreference = "Stop"

$InstallDir = Join-Path $HOME ".local\bin"
$ScriptPath = Join-Path $InstallDir "impf"
$LauncherPath = Join-Path $InstallDir "impf.cmd"

New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null

Copy-Item -Force "impf" $ScriptPath

@"
@echo off
uv run --script "%~dp0impf" %*
"@ | Set-Content -Encoding ASCII $LauncherPath

$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
$PathEntries = @()

if ($UserPath) {
    $PathEntries = $UserPath -split ";" | Where-Object { $_ }
}

if ($PathEntries -notcontains $InstallDir) {
    $NewPath = if ($UserPath) {
        "$UserPath;$InstallDir"
    } else {
        $InstallDir
    }

    [Environment]::SetEnvironmentVariable(
        "Path",
        $NewPath,
        "User"
    )
}

Write-Host ""
Write-Host "impf installed to $InstallDir"
Write-Host ""
Write-Host "Restart your terminal, then run:"
Write-Host "  impf"
