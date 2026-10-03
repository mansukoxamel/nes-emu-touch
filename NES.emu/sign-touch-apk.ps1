param(
    [Parameter(Mandatory = $true)][string]$InputApk,
    [Parameter(Mandatory = $true)][string]$OutputApk
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$key = Join-Path $root 'dist\signing\nes-touch-update.jks'
$secretFile = Join-Path $root 'dist\signing\nes-touch-signing.env'
$signer = 'C:\Users\jinn\AppData\Local\Android\Sdk\build-tools\35.0.0\apksigner.bat'
$aapt = 'C:\Users\jinn\AppData\Local\Android\Sdk\build-tools\35.0.0\aapt.exe'

foreach($path in @($InputApk, $key, $secretFile, $signer, $aapt)) {
    if(-not (Test-Path -LiteralPath $path)) { throw "Required file missing: $path" }
}
if(Test-Path -LiteralPath $OutputApk) { throw "Output already exists: $OutputApk" }

$badging = & $aapt dump badging $InputApk
if($LASTEXITCODE -ne 0 -or -not ($badging | Select-String "name='local.jinn.nesemutouchapp'")) {
    throw 'APK package ID is not local.jinn.nesemutouchapp'
}
$line = @(Get-Content -LiteralPath $secretFile -Encoding UTF8 | Where-Object { $_ -like 'NES_TOUCH_KEY_PASSWORD=*' })
if($line.Count -ne 1) { throw 'Signing password is missing or duplicated' }
$env:NES_TOUCH_SIGN_PASS = $line[0].Substring('NES_TOUCH_KEY_PASSWORD='.Length)
try {
    & $signer sign --ks $key --ks-key-alias nes-touch --ks-pass env:NES_TOUCH_SIGN_PASS --key-pass env:NES_TOUCH_SIGN_PASS --out $OutputApk $InputApk
    if($LASTEXITCODE -ne 0) { throw 'APK signing failed' }
    & $signer verify --print-certs $OutputApk
    if($LASTEXITCODE -ne 0) { throw 'Signed APK verification failed' }
    Get-FileHash -LiteralPath $OutputApk -Algorithm SHA256
}
finally {
    Remove-Item Env:NES_TOUCH_SIGN_PASS -ErrorAction SilentlyContinue
}
