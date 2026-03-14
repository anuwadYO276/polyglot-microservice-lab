#!/bin/bash

echo "🚀 Installing Dev Environment for Mac (Colima stack)"

# install brew if missing
if ! command -v brew &> /dev/null
then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating brew..."
brew update

echo "Installing core packages..."
brew install \
  colima \
  docker \
  docker-compose \
  lazydocker \
  k6 \
  jq \
  wget \
  git

echo "Installing Grafana..."
brew install grafana

echo "Installing Ollama..."
brew install ollama

echo "Starting Colima..."
colima start --cpu 4 --memory 6 --disk 80

echo "Starting Grafana..."
brew services start grafana

echo "Starting Ollama..."
brew services start ollama

echo "Testing Docker..."
docker run hello-world

echo "✅ Dev environment ready!"
echo ""
echo "Tools installed:"
echo "- Colima"
echo "- Docker CLI"
echo "- Docker Compose"
echo "- LazyDocker"
echo "- k6"
echo "- Grafana"
echo "- Ollama"
echo ""
echo "Run docker containers with:"
echo "docker compose up -d"
