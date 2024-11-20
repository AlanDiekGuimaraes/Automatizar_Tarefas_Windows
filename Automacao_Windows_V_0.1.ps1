<#
Título: Automação de Tarefas no Windows
Autor: [Alan Diek Guimarães]
Descrição: Este script automatiza tarefas como instalação de programas, atualização de drivers, desinstalação de bloatwares, e ajustes no ambiente do sistema operacional.
Data de Criação: 11-11-2024

Versão: 0.1
PROJETO - https://github.com/AlanDiekGuimaraes/Automatizar_Tarefas_Windows
Última Modificação e NOTAS DE LANÇAMENTO
20-01-2024 - [Versão 0.1] - Organizando o código já criado para controle de versão.

#>

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
function Abrir_Instalador_Applicativos_Na_Loja {
    start ms-windows-store://pdp/?productid=9nblggh4nns1
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
        # @{ Nome = "Copilot"; Comando = "winget uninstall MSIX\Microsoft.Copilot_1.1.8.0_neutral__8wekyb3d8bbwe --accept-source-agreements --silent" },
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
        # Verifica se o módulo PSWindowsUpdate está instalado
        if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
            Write-Host "Instalando módulo PSWindowsUpdate..."
            Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
        }

        Import-Module PSWindowsUpdate

        # Verifica se há atualizações disponíveis para os drivers
        Write-Host "Verificando atualizações de drivers disponíveis..."
        $UpdateSession = New-Object -ComObject Microsoft.Update.Session

        if ($null -eq $UpdateSession) {
            Write-Host "Erro ao criar o objeto Update Session." -ForegroundColor Red
            return
        }

        $UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
        if ($null -eq $UpdateSearcher) {
            Write-Host "Erro ao criar o objeto Update Searcher." -ForegroundColor Red
            return
        }

        $SearchResult = $UpdateSearcher.Search("Type='Driver'")

        if ($null -eq $SearchResult) {
            Write-Host "Erro ao buscar atualizações." -ForegroundColor Red
            return
        }

        if ($SearchResult.Updates.Count -eq 0) {
            Write-Host "Nenhuma atualização de driver encontrada." -ForegroundColor Yellow
            pause
            return
        }

        Write-Host "Atualizações de drivers encontradas: $($SearchResult.Updates.Count)"

        # Cria uma coleção de atualizações uma vez
        $UpdateColl = New-Object -ComObject Microsoft.Update.UpdateColl

        # Adiciona atualizações à coleção
        foreach ($Update in $SearchResult.Updates) {
            Write-Host "Preparando para instalar driver: $($Update.Title)"
            $UpdateColl.Add($Update) | Out-Null
        }

        # Instala todas as atualizações de uma vez
        if ($UpdateColl.Count -gt 0) {
            $UpdateInstaller = $UpdateSession.CreateUpdateInstaller()
            $UpdateInstaller.Updates = $UpdateColl
            $Result = $UpdateInstaller.Install()

            foreach ($i in 0..($UpdateColl.Count - 1)) {
                $Update = $UpdateColl.Item($i)
                if ($Result.ResultCode -eq 2) {
                    Write-Host "Driver instalado com sucesso: $($Update.Title)"
                } else {
                    Write-Host "Falha ao instalar driver: $($Update.Title)" -ForegroundColor Red
                }
            }
        }
    } catch {
        Write-Host "Erro durante o processo de atualização: $($_.Exception.Message)" -ForegroundColor Red
        pause
    }
    pause
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
function Habilitar_Visualizador_Fotos_Windows7 {
    try {
        Write-Host "Habilitando Visualizador de Fotos do Windows 7..."

        $regPath = "HKLM:\SOFTWARE\Classes\Applications\photoviewer.dll"

        # Cria as chaves de registro necessárias
        New-Item -Path $regPath -Force | Out-Null
        New-Item -Path "$regPath\shell" -Force | Out-Null
        New-Item -Path "$regPath\shell\open" -Force | Out-Null
        New-Item -Path "$regPath\shell\open\command" -Force | Out-Null
        New-Item -Path "$regPath\shell\open\DropTarget" -Force | Out-Null
        New-Item -Path "$regPath\shell\print" -Force | Out-Null
        New-Item -Path "$regPath\shell\print\command" -Force | Out-Null
        New-Item -Path "$regPath\shell\print\DropTarget" -Force | Out-Null

        # Define os valores de registro
        Set-ItemProperty -Path "$regPath\shell\open" -Name "MuiVerb" -Value "@photoviewer.dll,-3043"
        Set-ItemProperty -Path "$regPath\shell\open\command" -Name "(Default)" -Value "C:\Program Files\Windows Photo Viewer\PhotoViewer.dll" -Type String
        Set-ItemProperty -Path "$regPath\shell\open\DropTarget" -Name "Clsid" -Value "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"
        Set-ItemProperty -Path "$regPath\shell\print\command" -Name "(Default)" -Value "C:\Program Files\Windows Photo Viewer\PhotoViewer.dll /print" -Type String
        Set-ItemProperty -Path "$regPath\shell\print\DropTarget" -Name "Clsid" -Value "{60fd46de-f830-4894-a628-6fa81bc0190d}"

        Write-Host "Visualizador de Fotos do Windows 7 habilitado com sucesso."
    } catch {
        Write-Host "Erro ao habilitar o Visualizador de Fotos do Windows 7: $($_.Exception.Message)"
    }
    pause
}
function Reiniciar_Computador_e_Entrar_Bios {
    # /r: Reinicia o computador.
    # /fw: Configura o computador para reiniciar e entrar diretamente no firmware (BIOS/UEFI).
    # /t 0: Define o tempo de espera para reiniciar como 0 segundos.
    shutdown /r /fw /t 0
}

function Exibir_Menu {
    preparar_ambiente # Chama a função preparar_hambiente no início do script
    Abrir_com_Privilegios_de_Administrador # Chama a função para iniciar com privilegios de administrador.

    # Cria uma lista de opções com chaves numéricas simples
    $menuOpcoes = @{
        0 = "Sair"
        1 = "Abrir Instalador de Aplicativo"
        2 = "Desinstalar Bloatwares"
        3 = "Atualizar Drivers|Programas" 
        4 = "Instalar Aplicativos Essenciais"
        5 = "Instalar Programas Essenciais"
        6 = "Programas: Formatação pessoal"
        7 = "Instalar Visualizador de Fotos W7"
        8 = "Reiniciar e entrar no BIOS"
        
        
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
                1 { Abrir_Instalador_Applicativos_Na_Loja }
                2 { Desinstalar_BLOATWARES }
                3 { Atualizar_Drivers_Programas }
                4 { Instalar_Aplicativos_Essenciais }
                5 { Instalar_Programas_Essenciais }
                6 { Programas_Formatação_Pessoal }
                7 { Habilitar_Visualizador_Fotos_Windows7 }                
                8 { Reiniciar_Computador_e_Entrar_Bios}
                default { Write-Host "Função não definida para essa opção." -ForegroundColor Red }
            }
        } else {
            Write-Host "Opção inválida, tente novamente." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
}

Exibir_Menu  # Chamando a função para exibir o menu
