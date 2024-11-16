function Ativar_Internet_Download_Manager_IDM {
    iex(irm is.gd/idm_reset) # Ativar o internet Download Manager IDM Disponivel em https://github.com/lstprjct/IDM-Activation-Script
    Pause 
}
function Ativar_Windows_Office {
    #Ativa o Windows e Office Disponiveis em https://github.com/massgravel/Microsoft-Activation-Scripts
    $ativacaoBemSucedida = $false
    try {
        Write-Host "Ativando o Windows Office..."
        irm https://get.activated.win | iex # Tenta a primeira opção
        $ativacaoBemSucedida = $true
    } catch {
        Write-Host "Ocorreu um erro ao ativar o Windows Office na opção 1."
    }

    if (-not $ativacaoBemSucedida) {
        try {
            Write-Host "Tentando novamente: Ativando o Windows Office na opção 2..."
            irm https://massgrave.dev/get | iex # Tenta a segunda opção
        } catch {
            Write-Host "Ocorreu um erro ao ativar o Windows Office na opção 2."
        }
    } else {
        Write-Host "Ativação concluída com sucesso na primeira tentativa."
    }
    Pause 
}
function Ativar_Winrar {
    try { #  Ativa o WinRAR com o script disponivel em https://github.com/naeembolchhi/WinRAR-Activator
        Write-Host "Ativando o WinRAR..." 
        iwr -useb https://naeembolchhi.github.io/WinRAR-Activator/WRA.ps1 | iex
    } catch { Write-Host "Ocorreu um erro ao ativar o WinRAR." }
    Pause 
}
function Preparar_Ambiente { # Função para preparar o ambiente
    try {
        # Verifica se o NuGet está instalado
        if (-not (Get-PackageProvider -ListAvailable | Where-Object { $_.Name -eq "NuGet" })) {
            Write-Host "Verificando o provedor NuGet..." -ForegroundColor Yellow
            Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser
            Write-Host "Provedor NuGet instalado com sucesso." -ForegroundColor Green
        }

        # Verifica a versão do PowerShell e faz o upgrade se necessário
        if ($PSVersionTable.PSVersion.Major -lt 7) {
            Write-Host "Versão do PowerShell inferior a 7 detectada. Atualizando..." -ForegroundColor Yellow

            $installPath = "$env:TEMP\PowerShell-7.3.6-win-x64.msi"
            if (-not (Test-Path $installPath)) {
                Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/download/v7.3.6/PowerShell-7.3.6-win-x64.msi" -OutFile $installPath
                Write-Host "PowerShell 7 baixado com sucesso." -ForegroundColor Green
            }

            Start-Process msiexec.exe -ArgumentList "/i `"$installPath`" /quiet /norestart" -Wait
            Write-Host "PowerShell 7 instalado. Reiniciando o script com a nova versão..." -ForegroundColor Green

            Start-Process "pwsh.exe" "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -Wait
            exit
        }
        Write-Host "Ambiente preparado com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "Erro durante a preparação do ambiente: $_" -ForegroundColor Red
    }
}
function Abrir_com_Privilegios_de_Administrador {
    try {
        
        # Verifica se o script está sendo executado com privilégios de administrador
        if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
            Write-Host "Solicitando execução com privilégios de administrador..." -ForegroundColor Yellow
            Start-Process pwsh "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -Wait
            exit
        }

        Write-Host "O script está sendo executado em modo administrador." -ForegroundColor Green

        # Verifica e altera a política de execução para 'Unrestricted' se necessário
        if ((Get-ExecutionPolicy -Scope CurrentUser) -ne "Unrestricted") {
            Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
            Write-Host "Política de execução ajustada para 'Unrestricted'." -ForegroundColor Green
        }

        # Instala o módulo PSWindowsUpdate se não estiver instalado
        if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
            Install-Module PSWindowsUpdate -Force
            Write-Host "Módulo PSWindowsUpdate instalado com sucesso." -ForegroundColor Green
        }

        # Adiciona o Microsoft Update Service Manager se não estiver configurado
        if (-not (Get-WUServiceManager | Where-Object { $_.Name -eq "Microsoft Update" })) {
            Add-WUServiceManager -MicrosoftUpdate
            Write-Host "Microsoft Update Service Manager configurado com sucesso." -ForegroundColor Green
        }
        Write-Host "Terminal sendo executado com privilégios de administrador." -ForegroundColor Green
    }
    catch {
        Write-Host "Erro durante a execução com privilégios de administrador: $_" -ForegroundColor Red
    }
}
function Instalar_Programas_Essenciais { # Lista de programas essenciais após a formatação
    $novaLinha = "`n"

    $programas = @(
        @{ Nome = "Google Chrome"; Comando = "winget install Google.Chrome --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Mozilla Firefox"; Comando = "winget install Mozilla.Firefox --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "WinRAR"; Comando = "winget install RARLab.WinRAR --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "PotPlayer"; Comando = "winget install Daum.PotPlayer --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "TeamViewer"; Comando = "winget install TeamViewer.TeamViewer --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "AnyDesk"; Comando = "winget install AnyDeskSoftwareGmbH.AnyDesk --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft 365"; Comando = "winget install Microsoft.Office --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Internet Download Manager"; Comando = "winget install Tonec.InternetDownloadManager --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft OneDrive"; Comando = "winget install Microsoft.OneDrive --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Skype"; Comando = "winget install Microsoft.Skype --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Adobe Acrobat Reader DC (64-bit)"; Comando = "winget install Adobe.Acrobat.Reader.64-bit --accept-package-agreements --accept-source-agreements --silent" }
    )

    $totalProgramas = $programas.Count

    for ($i = 0; $i -lt $totalProgramas; $i++) {
        $programaAtual = $programas[$i]
        $contador = "{0:000}/{1:000}" -f ($i + 1), $totalProgramas
        Write-Host ("$contador - Instalando o aplicativo $($programaAtual.Nome)".ToUpper()) -ForegroundColor green
        Invoke-Expression $programaAtual.Comando
        Write-Host $novaLinha
    }
    Pause 
}
function Programas_Formatação_Pessoal { # Lista Pessoal: Programas que sempre instalo no meu ambiente apos a formatação

    $novaLinha = "`n"

    $programas = @(
        # @{ Nome = "Adobe Creative Cloud"; Comando = "winget install Adobe.CreativeCloud --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "UltraISO Premium"; Comando = "winget install EZBSystems.UltraISO --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual Studio Code"; Comando = "winget install Microsoft.VisualStudioCode --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Steam"; Comando = "winget install Valve.Steam --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Google Drive"; Comando = "winget install Google.GoogleDrive --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Acrobat Pro (64-bit)"; Comando = "winget install Adobe.Acrobat.Pro --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Gmail Desktop"; Comando = "winget install timche.gmail-desktop --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Rufus"; Comando = "winget install Rufus.Rufus --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "qBittorrent"; Comando = "winget install qBittorrent.qBittorrent --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "NVIDIA GeForce Experience"; Comando = "winget install Nvidia.GeForceExperience --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Notion"; Comando = "winget install Notion.Notion --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "GitHub Desktop"; Comando = "winget install GitHub.GitHubDesktop --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "CCleaner Professional Trial"; Comando = "winget install Piriform.CCleaner.ProTrial --accept-package-agreements --accept-source-agreements --silent" }
    )

    $totalProgramas = $programas.Count

    for ($i = 0; $i -lt $totalProgramas; $i++) {
        $programaAtual = $programas[$i]
        $contador = "{0:000}/{1:000}" -f ($i + 1), $totalProgramas
        Write-Host ("$contador - Instalando o aplicativo $($programaAtual.Nome)".ToUpper()) -ForegroundColor green
        Invoke-Expression $programaAtual.Comando
        Write-Host $novaLinha
    }
    Pause 
}
function Instalar_Aplicativos_Essenciais {      # Função para instalar aplicativos essenciais
    
    $novaLinha = "`n"
   
    $aplicativosEssenciais = @(
        # APLICATIVOS ESSENCIAIS A SEREM INSTALADOS
        @{ Nome = "Calculadora"; Comando = "winget install calculator --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "PowerShell"; Comando = "winget install Microsoft.PowerShell --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "PowerToys"; Comando = "winget install Microsoft.PowerToys --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2005 x64"; Comando = "winget install Microsoft.VCRedist.2005.x64 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2005 x86"; Comando = "winget install Microsoft.VCRedist.2005.x86 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2008 x64"; Comando = "winget install Microsoft.VCRedist.2008.x64 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2008 x86"; Comando = "winget install Microsoft.VCRedist.2008.x86 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2010 x64"; Comando = "winget install Microsoft.VCRedist.2010.x64 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2010 x86"; Comando = "winget install Microsoft.VCRedist.2010.x86 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2012 x64"; Comando = "winget install Microsoft.VCRedist.2012.x64 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2012 x86"; Comando = "winget install Microsoft.VCRedist.2012.x86 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2013 x64"; Comando = "winget install Microsoft.VCRedist.2013.x64 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2013 x86"; Comando = "winget install Microsoft.VCRedist.2013.x86 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2015-2022 x64"; Comando = "winget install Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Visual C++ 2015-2022 x86"; Comando = "winget install Microsoft.VCRedist.2015+.x86 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Java Runtime Environment"; Comando = "winget install Oracle.JavaRuntimeEnvironment --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = ".NET Framework 4.8"; Comando = "winget install Microsoft.DotNet.Framework.DeveloperPack_4 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "DirectX End-User Runtime Web"; Comando = "winget install Microsoft.DirectX --accept-package-agreements --accept-source-agreements --silent" }
    )

    $totalAplicativos = $aplicativosEssenciais.Count

    for ($i = 0; $i -lt $totalAplicativos; $i++) {
        $aplicativoAtual = $aplicativosEssenciais[$i]
        $contador = "{0:000}/{1:000}" -f ($i + 1), $totalAplicativos
        Write-Host ("$contador - Instalando o aplicativo $($aplicativoAtual.Nome)".ToUpper()) -ForegroundColor green
        Invoke-Expression $aplicativoAtual.Comando
        Write-Host $novaLinha
    }
    Pause 
}
function Desinstalar_BLOATWARES {   # Função para desinstalar BLOATWARES 
    
    # Define uma nova linha
    $novaLinha = "`n"
   
    # Lista de BLOATWARES para desinstalar
    $bloatwares = @(
        @{ Nome = "Email e Calendário do Windows"; Comando = "winget uninstall microsoft.windowscommunicationsapps_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Microsoft 3D Builder"; Comando = "winget uninstall Microsoft.3DBuilder_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Outlook"; Comando = "winget uninstall Microsoft.OutlookForWindows_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Power Automate Desktop"; Comando = "winget uninstall Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Windows Feedback Hub"; Comando = "winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Gravador de Som do Windows"; Comando = "winget uninstall Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Overlay de jogos do Xbox"; Comando = "winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Xbox Gaming Services"; Comando = "winget uninstall Microsoft.GamingApp_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxApp_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.Xbox.TCUI_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxIdentityProvider_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxGameOverlay_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "MS Solitaire"; Comando = "winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "MS Pay"; Comando = "winget uninstall Microsoft.Wallet_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "OneNote"; Comando = "winget uninstall Microsoft.Office.OneNote_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Mixed Reality-Portal"; Comando = "winget uninstall Microsoft.MixedReality.Portal_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Teams"; Comando = "winget uninstall MicrosoftTeams_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Family"; Comando = "winget uninstall MicrosoftCorporationII.MicrosoftFamily_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Third-Party Preinstalled bloat"; Comando = "winget uninstall disney+  --accept-source-agreements --silent" },
        @{ Nome = "Quick Assist"; Comando = "winget uninstall MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Get Started"; Comando = "winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Vincular ao Celular"; Comando = "winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Movies & TV"; Comando = "winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Microsoft To Do"; Comando = "winget uninstall Microsoft.Todos_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Pessoas Microsoft"; Comando = "winget uninstall Microsoft.People_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Get Help"; Comando = "winget uninstall Microsoft.GetHelp_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Bing Weather"; Comando = "winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Bing News"; Comando = "winget uninstall Microsoft.BingNews_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Cortana"; Comando = "winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Clipchamp"; Comando = "winget uninstall Clipchamp.Clipchamp_yxz26nhyzhsrt --accept-source-agreements --silent" },
        @{ Nome = "Fotos do Windows"; Comando = "winget uninstall Microsoft.Windows.Photos_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Alarmes do Windows"; Comando = "winget uninstall Microsoft.WindowsAlarms_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Mapas do Windows"; Comando = "winget uninstall microsoft.WindowsMaps_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Office Hub"; Comando = "winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Groove Music"; Comando = "winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Copilot"; Comando = "winget uninstall MSIX\Microsoft.Copilot_1.1.8.0_neutral__8wekyb3d8bbwe --accept-source-agreements --silent" },
        @{ Nome = "Paint"; Comando = "winget uninstall MSIX\Microsoft.Paint_11.2408.30.0_x64__8wekyb3d8bbwe --accept-source-agreements --silent" }
        @{ Nome = "Microsoft Teams classic"; Comando = "winget uninstall Microsoft.Teams.Classic --accept-source-agreements --silent" }
        # @{ Nome = ""; Comando = "winget uninstall --accept-package-agreements --accept-source-agreements --silent" },
    )

    $totalBloatwares = $bloatwares.Count
    # Itera sobre cada Bloatware na lista e desinstala
    for ($i = 0; $i -lt $totalBloatwares; $i++) {
        $bloatwareAtual = $bloatwares[$i]
        $contador = "{0:000}/{1:000}" -f ($i + 1), $totalBloatwares
        Write-Host ("$contador - Desinstalando o aplicativo $($bloatwareAtual.Nome)".ToUpper()) -ForegroundColor green
        Invoke-Expression $bloatwareAtual.Comando
        Write-Host $novaLinha
    }
    Pause 
}

function Atualizar_Drivers_Programas { # Função para atualizar drivers e programas
    try {
        Write-Host "Iniciando a atualização de programas..." -ForegroundColor Cyan
        winget upgrade --all
        Write-Host "Atualização de programas concluída com sucesso." -ForegroundColor Green
    } catch {
        Write-Host "Erro ao atualizar programas: $_" -ForegroundColor Red
    }

    try {
        Write-Host "Iniciando a verificação de drivers..." -ForegroundColor Cyan
        pnputil /scan-devices
        Write-Host "Verificação de drivers concluída com sucesso." -ForegroundColor Green
    } catch {
        Write-Host "Erro ao verificar drivers: $_" -ForegroundColor Red
    }
    Pause 
}

# function Instalar_Drivers { # Em desenvovimento. 
    # Função para instalar drivers
    # Write-Host "Iniciando a verificação e instalação de drivers..." -ForegroundColor Green
    # try {
    #     # Define o caminho do arquivo na mesma pasta do script
    # $caminhoArquivo = Join-Path -Path $PSScriptRoot -ChildPath "drivers_info.txt"
    # }
    # catch {
    #     Write-Host "O arquivo não foi encontrado." -ForegroundColor Red
    # }
    
    # Pause
    
# }

function Instalar_Drivers {
    try {
        # Verifica se o módulo PSWindowsUpdate está instalado
        if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
            Write-Host "Instalando módulo PSWindowsUpdate..."
            Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
        }

        Import-Module PSWindowsUpdate

        # Verifica se há atualizações disponíveis para os drivers
        Write-Host "Verificando atualizações de drivers disponíveis..."
        $UpdateSession = New-Object -ComObject Microsoft.Update.Session
        $UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
        $SearchResult = $UpdateSearcher.Search("Type='Driver'")

        if ($SearchResult.Updates.Count -eq 0) {
            Write-Host "Nenhuma atualização de driver encontrada."
            return
        }

        Write-Host "Atualizações de drivers encontradas: " $SearchResult.Updates.Count

        # Instala as atualizações de drivers encontradas
        foreach ($Update in $SearchResult.Updates) {
            try {
                Write-Host "Instalando driver: " $Update.Title
                $UpdateInstaller = $UpdateSession.CreateUpdateInstaller()
                $UpdateInstaller.Updates = New-Object -ComObject Microsoft.Update.UpdateColl
                $UpdateInstaller.Updates.Add($Update) | Out-Null
                $Result = $UpdateInstaller.Install()

                if ($Result.ResultCode -eq 2) {
                    Write-Host "Driver instalado com sucesso: " $Update.Title
                } else {
                    Write-Host "Falha ao instalar driver: " $Update.Title
                }
            } catch {
                Write-Host "Erro ao tentar instalar o driver: $($_.Exception.Message)"
            }
        }
    } catch {
        Write-Host "Erro durante o processo de atualização: $($_.Exception.Message)"
    }
    pause
}

# Instalar_Drivers



function Exibir_Menu {
    preparar_ambiente # Chama a função preparar_hambiente no início do script
    Abrir_com_Privilegios_de_Administrador # Chama a função para iniciar com privilegios de administrador.
    # Cria uma lista de opções com chaves numéricas simples
    $menuOpcoes = @{
        0 = "Sair"
        1 = "Instalar Drivers"
        2 = "Programas: Formatação pessoal"
        3 = "Instalar Programas Essenciais"
        4 = "Instalar Aplicativos Essenciais"
        5 = "Desinstalar Bloatwares"
        6 = "Ativar IDM"
        7 = "Ativar Windows e Office"
        8 = "Ativar WinRAR"
        9 = "Atualizar Drivers|Programas" 
    }

    $linhaHorizontal = ("=" * 46)        # Cria uma linha horizontal de 44 caracteres "=" para uso na borda superior e inferior do menu
    $opcaoEscolhida = -1                 # Inicializa a variável de controle de opção escolhida com -1

    while ($opcaoEscolhida -ne 0) {      # Loop que continua até o usuário escolher a opção "1" (Sair)
        Clear-Host                       # Limpa a tela do terminal para exibir o menu de forma organizada

        # Exibe a linha horizontal superior
        Write-Host "$linhaHorizontal" -ForegroundColor green

        # Exibe o título do menu
        Write-Host ("|") -NoNewline -ForegroundColor Green
        Write-Host "               MENU DE OPÇÕES               " -NoNewline -ForegroundColor White
        Write-Host ("|") -ForegroundColor Green

        # Exibe a linha horizontal inferior
        Write-Host "$linhaHorizontal" -ForegroundColor green

        # Exibe as opções com barras verticais e cores específicas
        foreach ($Chave in ($menuOpcoes.Keys | Sort-Object)) {
            Write-Host ("|") -NoNewline -ForegroundColor Green     # Barra de abertura em verde

            # Formata a chave com dois dígitos
            $chaveFormatada = "{0:D2}" -f $Chave

            # Verifica a cor de exibição com base na opção
            if ($menuOpcoes[$Chave] -match "Desinstalar Bloatwares") {
                Write-Host " [$chaveFormatada] - $($menuOpcoes[$Chave].PadRight(35)) " -NoNewline -ForegroundColor Red -BackgroundColor Black
            } elseif ($menuOpcoes[$Chave] -match "Formatação pessoal") {
                Write-Host " [$chaveFormatada] - $($menuOpcoes[$Chave].PadRight(35)) " -NoNewline -ForegroundColor Yellow -BackgroundColor Black
            } elseif ($menuOpcoes[$Chave] -match "^Ativar") {
                Write-Host " [$chaveFormatada] - $($menuOpcoes[$Chave].PadRight(35)) " -NoNewline -ForegroundColor Cyan -BackgroundColor Black
            } else {
                Write-Host " [$chaveFormatada] - $($menuOpcoes[$Chave].PadRight(35)) " -NoNewline -ForegroundColor White -BackgroundColor Black
            }

            Write-Host ("|") -ForegroundColor Green                # Barra de fechamento em verde
        }

        # Exibe a linha horizontal inferior de fechamento do menu
        Write-Host "$linhaHorizontal" -ForegroundColor green

        # Solicitar a escolha do usuário
        $opcaoEscolhida = Read-Host "Digite o número da opção"

        # Converte a entrada para inteiro e verifica se a escolha é uma chave válida no dicionário
        if ([int]::TryParse($opcaoEscolhida, [ref]$null) -and $menuOpcoes.ContainsKey([int]$opcaoEscolhida)) {
            $opcaoEscolhida = [int]$opcaoEscolhida  # Converte para inteiro se for válida

            # Exibe a opção escolhida
            Write-Host "Opção válida: $($menuOpcoes[$opcaoEscolhida])" -ForegroundColor Yellow

            # Executa a função associada à opção escolhida
            switch ($opcaoEscolhida) {
                0 { Write-Host "Saindo..." -ForegroundColor Green; break }
                1 { Instalar_Drivers }
                2 { Programas_Formatação_Pessoal }
                3 { Instalar_Programas_Essenciais }
                4 { Instalar_Aplicativos_Essenciais }
                5 { Desinstalar_BLOATWARES }
                6 { AtivarIDM }
                7 { Ativar_Windows_Office }
                8 { Ativar_Winrar }
                9 { Atualizar_Drivers_Programas }
                
                
                default { Write-Host "Função não definida para essa opção." -ForegroundColor Red }
            }
        } else {
            Write-Host "Opção inválida, tente novamente." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
}



Exibir_Menu  # Chamando a função para exibir o menu
