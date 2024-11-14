function preparar_ambiente {
    # Verifica se o NuGet está instalado
    if (-not (Get-PackageProvider -ListAvailable | Where-Object { $_.Name -eq "NuGet" })) {
        Write-Host "Provedor NuGet não encontrado. Instalando o provedor de NuGet..." -ForegroundColor Yellow
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser
    }
        # Verifica a versão do PowerShell
    if ($PSVersionTable.PSVersion.Major -lt 7) {
        Write-Host "Versão do PowerShell inferior à 7 detectada. Iniciando a atualização..." -ForegroundColor Yellow
        
        # Caminho para o instalador do PowerShell 7
        $installPath = "$env:TEMP\PowerShell-7.3.6-win-x64.msi"

        # Faz o download do PowerShell 7 se não estiver presente
        if (-not (Test-Path $installPath)) {
            Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/download/v7.3.6/PowerShell-7.3.6-win-x64.msi" -OutFile $installPath
        }

        # Instala o PowerShell 7 silenciosamente
        Start-Process msiexec.exe -ArgumentList "/i `"$installPath`" /quiet /norestart" -Wait
        
        Write-Host "PowerShell 7 instalado. Reiniciando o script com a nova versão..." -ForegroundColor Green
        
        # Relança o script com o PowerShell 7 em modo administrador
        Start-Process "pwsh.exe" "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
    
    Write-Host "Script em execução no PowerShell 7 com todas as configurações necessárias aplicadas." -ForegroundColor Green

    # Verifica se o NuGet está instalado
    if (-not (Get-PackageProvider -ListAvailable | Where-Object { $_.Name -eq "NuGet" })) {
        Write-Host "Provedor NuGet não encontrado. Instalando o provedor de NuGet..." -ForegroundColor Yellow
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser
    }

        # Verifica se o script está sendo executado com privilégios de administrador
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        # Relança o script em modo administrador
        Start-Process powershell "-ExecutionPolicy Bypass -File '$PSCommandPath'" -Verb RunAs
        exit  # Fecha a instância atual do script
    }

    # Aqui, o script prossegue com as ações que requerem privilégios de administrador
    Write-Host "O script está sendo executado em modo administrador."
    Start-Sleep 2

    # Verifica e altera a política de execução para 'Unrestricted' se necessário
    if ((Get-ExecutionPolicy -Scope CurrentUser) -ne "Unrestricted") {
        Write-Host "Preparando o ambiente..." -ForegroundColor Green
        Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
    }

    # Instala o módulo PSWindowsUpdate se não estiver instalado
    if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
        Install-Module PSWindowsUpdate -Force
    }

    # Adiciona o Microsoft Update Service Manager se não estiver configurado
    if (-not (Get-WUServiceManager | Where-Object { $_.Name -eq "Microsoft Update" })) {
        Add-WUServiceManager -MicrosoftUpdate
    }
    Write-Host "Ambiente preparado com sucesso!" -ForegroundColor Green # Mensagem para teste
}