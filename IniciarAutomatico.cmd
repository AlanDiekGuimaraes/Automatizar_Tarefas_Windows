@echo off
cd /d "%~dp0"

rem Verifica se o script está sendo executado como administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando permissões de administrador...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit /b
)

rem Executa o script PowerShell no mesmo diretório, como administrador
pwsh.exe -ExecutionPolicy Bypass -File "%~dp0Automacao.ps1"



pause


