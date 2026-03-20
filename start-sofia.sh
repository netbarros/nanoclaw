#!/bin/bash
# Start Sofia via NanoClaw
# Usage: bash start-sofia.sh

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use 22 > /dev/null 2>&1

cd "$(dirname "$0")"

echo "==================================="
echo "  Sofia — Software Lotus AI Agent"
echo "  Trigger: @Sofia <mensagem>"
echo "  Porta credential proxy: 3002"
echo "==================================="
echo ""

# Check if container image exists
if docker images nanoclaw-agent:latest --format "{{.Repository}}" | grep -q nanoclaw; then
  echo "[OK] Container image: nanoclaw-agent:latest"
else
  echo "[BUILD] Building agent container..."
  bash container/build.sh
fi

# Start NanoClaw
echo "[START] Iniciando Sofia..."
npm start
