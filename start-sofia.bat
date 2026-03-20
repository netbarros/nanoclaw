@echo off
title Sofia - NanoClaw Agent
echo ===================================
echo   Sofia - Software Lotus AI Agent
echo   WhatsApp: @Sofia [mensagem]
echo ===================================
echo.
echo Parando servico systemd (se ativo)...
wsl -d Ubuntu -- bash -c "systemctl --user stop nanoclaw.service 2>/dev/null; systemctl --user disable nanoclaw.service 2>/dev/null" 2>nul
echo.
echo Aguardando Docker ficar pronto...
:wait_docker
wsl -d Ubuntu -- bash -c "docker info > /dev/null 2>&1" 2>nul
if errorlevel 1 (
    echo   Docker ainda iniciando... aguardando 5s
    timeout /t 5 /nobreak >nul
    goto wait_docker
)
echo Docker OK!
echo.
echo Liberando porta 3002...
wsl -d Ubuntu -- bash -c "fuser -k 3002/tcp 2>/dev/null; sleep 1" 2>nul
echo Iniciando Sofia...
echo.
wsl -d Ubuntu -- bash -c "source /home/fabiano/.nvm/nvm.sh && nvm use 22 && cd /mnt/c/lotus/nanoclaw && node dist/index.js"
pause
