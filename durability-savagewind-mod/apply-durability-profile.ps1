param([ValidateSet("1.5x","2x","5x","10x","infinite")][string]$Profile)

if (-not $Profile) {
    $Profile = Read-Host "Profile (1.5x, 2x, 5x, 10x, infinite)"
}

if ($env:SAVAGEWIND_DATA_ROOT) {
    $DataRoot = $env:SAVAGEWIND_DATA_ROOT
} elseif (Test-Path (Join-Path $PSScriptRoot "savagewind.ini")) {
    $DataRoot = $PSScriptRoot
} else {
    $DataRoot = $PSScriptRoot
}

$Ini = Join-Path $DataRoot "savagewind.ini"
$Source = Join-Path $PSScriptRoot ("profiles\" + $Profile + ".ini")
if (-not (Test-Path $Source)) { throw "Unknown profile: $Profile" }

if (-not (Test-Path $Ini)) { throw "savagewind.ini not found at $Ini" }

$lines = Get-Content $Ini
$profileLines = Get-Content $Source
foreach ($keyLine in $profileLines) {
    $key = ($keyLine -split "=")[0].Trim()
    $rest = @($lines | Where-Object { $_ -notmatch "^$([regex]::Escape($key))\s*=*" })
    $rest += $keyLine
    $lines = $rest
}
Set-Content -Path $Ini -Value $lines -Encoding utf8
Write-Host "Applied $Profile durability profile to $Ini"
