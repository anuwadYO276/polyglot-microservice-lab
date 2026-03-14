Write-Host "🚀 Installing Dev Tools for Windows"

# install chocolatey if missing
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
  Write-Host "Installing Chocolatey..."
  Set-ExecutionPolicy Bypass -Scope Process -Force
  [System.Net.ServicePointManager]::SecurityProtocol = 3072
  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

Write-Host "Updating Chocolatey..."
choco upgrade chocolatey -y

Write-Host "Installing packages..."
choco install -y `
git `
jq `
wget `
lazydocker `
k6 `
grafana `
ollama

Write-Host "Testing Docker..."
docker run hello-world

Write-Host ""
Write-Host "✅ Dev environment ready!"
Write-Host ""
Write-Host "Tools installed:"
Write-Host "- LazyDocker"
Write-Host "- k6"
Write-Host "- Grafana"
Write-Host "- Ollama"
Write-Host "- jq / wget / git"
Write-Host ""
Write-Host "Run docker containers with:"
Write-Host "docker compose up -d"