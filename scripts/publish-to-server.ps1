param(
    [string]$Server = "192.168.0.236",
    [string]$User = "euzebio",
    [string]$RemotePath = "/var/www/html",
    [string]$HostKey = "SHA256:3KCh8QOIfaNjc0cGJspn64eZDKsH6qjWIofu88ZrG8Y"
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$tempArchive = Join-Path $env:TEMP "biblioteca-infinito-lps.zip"

if (Test-Path $tempArchive) {
    Remove-Item -LiteralPath $tempArchive -Force
}

$exclude = @(".git", ".vscode", "scripts")
$files = Get-ChildItem -LiteralPath $repoRoot -Force |
    Where-Object { $exclude -notcontains $_.Name }

Compress-Archive -Path $files.FullName -DestinationPath $tempArchive -Force

Write-Host "Enviando arquivos para $Server..."
pscp.exe -hostkey $HostKey $tempArchive "${User}@${Server}:/tmp/biblioteca-infinito-lps.zip"

Write-Host "Atualizando $RemotePath..."
plink.exe -ssh "${User}@${Server}" -hostkey $HostKey @"
set -e
sudo mkdir -p "$RemotePath"
sudo unzip -o /tmp/biblioteca-infinito-lps.zip -d "$RemotePath"
sudo chown -R www-data:www-data "$RemotePath"
sudo find "$RemotePath" -type d -exec chmod 0755 {} \;
sudo find "$RemotePath" -type f -exec chmod 0644 {} \;
sudo nginx -t
sudo systemctl reload nginx
rm -f /tmp/biblioteca-infinito-lps.zip
"@

Remove-Item -LiteralPath $tempArchive -Force
Write-Host "Publicado com sucesso."
