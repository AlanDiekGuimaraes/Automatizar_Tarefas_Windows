@echo off
cd /d "%~dp0"

rem Verifica se o script está sendo executado como administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando permissões de administrador...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

rem Executa o script PowerShell no mesmo diretório, como administrador
powershell.exe -ExecutionPolicy Bypass -File "%~dp0Instalar_Programas_com_winget.ps1"
pause
