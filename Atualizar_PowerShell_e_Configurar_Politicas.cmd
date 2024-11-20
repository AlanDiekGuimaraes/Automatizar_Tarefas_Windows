@echo off

:: Definindo a pasta onde o script está localizado
setlocal enabledelayedexpansion
set script_dir=%~dp0

:menu
cls
echo ==========================
echo     MENU DE OPCOES
echo ==========================
echo [1] Abrir Microsoft Store Instalador Applicativos
echo [2] Atualizar PowerShell via Winget
echo [3] Adicionar registros do PowerShell
echo [0] Sair
echo ==========================
set /p escolha="Digite o numero da opcao: "

if "%escolha%"=="1" goto loja
if "%escolha%"=="2" goto atualizar
if "%escolha%"=="3" goto adicionar_registros
if "%escolha%"=="0" goto sair

echo Opcao invalida, tente novamente.
pause
goto menu

:loja
start ms-windows-store://pdp/?productid=9nblggh4nns1
pause
goto menu

:atualizar
winget install Microsoft.PowerShell --accept-package-agreements --accept-source-agreements --silent
if %errorlevel% equ 0 (
    echo PowerShell atualizado com sucesso!
) else (
    echo Falha ao atualizar o PowerShell. Verifique se o Winget esta instalado.
)
pause
goto menu

:adicionar_registros
    set reg_file=%script_dir%temp_reg.reg
    echo Windows Registry Editor Version 5.00 > %reg_file%
    echo. >> %reg_file%

    :: Configura a política de execução como Unrestricted para o PowerShell (versão 7+ incluída)
    echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\7\ShellIds\Microsoft.PowerShell] >> %reg_file%
    echo "ExecutionPolicy"="Unrestricted" >> %reg_file%
    echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\PowerShell\7\ShellIds\Microsoft.PowerShell] >> %reg_file%
    echo "ExecutionPolicy"="Unrestricted" >> %reg_file%

    :: Configura a política de execução para usuários específicos no PowerShell (CurrentUser)
    echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\PowerShell\7\ShellIds\Microsoft.PowerShell] >> %reg_file%
    echo "ExecutionPolicy"="Unrestricted" >> %reg_file%

    :: Configura o PowerShell para abrir com privilégios de administrador por padrão
    echo [HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.7\Shell\RunAs\Command] >> %reg_file%
    echo @="\"C:\\Program Files\\PowerShell\\7\\pwsh.exe\" -ExecutionPolicy Unrestricted -File \"%1\"" >> %reg_file%

    :: Configuração para evitar avisos de confirmação ao executar scripts
    echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell] >> %reg_file%
    echo "EnableScripts"=dword:00000001 >> %reg_file%
    echo "DisableConfirmPrompt"=dword:00000001 >> %reg_file%

    :: Configurar todas as políticas de execução como Unrestricted para o PowerShell 7+
    echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\7\ShellIds\Microsoft.PowerShell] >> %reg_file%
    echo "ExecutionPolicy"="Unrestricted" >> %reg_file%
    echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\PowerShell\7\ShellIds\Microsoft.PowerScript.7\Shell\RunAs\Command] >> %reg_file%
    echo "ExecutionPolicy"="Unrestricted" >> %reg_file%

    reg import "%reg_file%"
    if %errorlevel% neq 0 (
        echo Erro ao adicionar os registros. Verifique o arquivo de log: %errorlevel%
        pause
    ) else (
        echo Registros adicionados com sucesso!
        pause
    )
    del "%reg_file%"
goto menu

:sair
echo Saindo...
exit