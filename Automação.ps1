
function Ativar_Internet_Download_Manager_IDM {
    iex(irm is.gd/idm_reset) # Ativar o internet Download Manager IDM Disponivel em https://github.com/lstprjct/IDM-Activation-Script
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
}
function Ativar_Winrar {
    try { #  Ativa o WinRAR com o script disponivel em https://github.com/naeembolchhi/WinRAR-Activator
        Write-Host "Ativando o WinRAR..." 
        iwr -useb https://naeembolchhi.github.io/WinRAR-Activator/WRA.ps1 | iex
    } catch { Write-Host "Ocorreu um erro ao ativar o WinRAR." }
}


function Instalar_Programas {
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
        # @{ Nome = ""; Comando = "winget install --accept-package-agreements --accept-source-agreements --silent" },
    )

    $totalProgramas = $programas.Count

    for ($i = 0; $i -lt $totalProgramas; $i++) {
        $programaAtual = $programas[$i]
        $contador = "{0:000}/{1:000}" -f ($i + 1), $totalProgramas
        Write-Host "$contador - Instalando o aplicativo $($programaAtual.Nome)".ToUpper()
        Invoke-Expression $programaAtual.Comando
        Write-Host $novaLinha
    }
}
function Meus_Programas { # Lista Pessoal

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
        Write-Host "$contador - Instalando o aplicativo $($programaAtual.Nome)".ToUpper()
        Invoke-Expression $programaAtual.Comando
        Write-Host $novaLinha
    }
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
        @{ Nome = ".NET Framework 4.8"; Comando = "winget install winget install Microsoft.DotNet.Framework.DeveloperPack_4 --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "DirectX End-User Runtime Web"; Comando = "winget install Microsoft.DirectX --accept-package-agreements --accept-source-agreements --silent" }
        
        # @{ Nome = ""; Comando = "winget install --accept-package-agreements --accept-source-agreements --silent" },
    )

    $totalAplicativos = $aplicativosEssenciais.Count

    for ($i = 0; $i -lt $totalAplicativos; $i++) {
        $aplicativoAtual = $aplicativosEssenciais[$i]
        $contador = "{0:000}/{1:000}" -f ($i + 1), $totalAplicativos
        Write-Host "$contador - Instalando o aplicativo $($aplicativoAtual.Nome)".ToUpper()
        Invoke-Expression $aplicativoAtual.Comando
        Write-Host $novaLinha
    }
}
function Desinstalar_BLOATWARES {   # Função para desinstalar BLOATWARES
    
    # Define uma nova linha
    $novaLinha = "`n"
   
    # Lista de BLOATWARES para desinstalar
    $bloatwares = @(
        @{ Nome = "Email e Calendário do Windows"; Comando = "winget uninstall microsoft.windowscommunicationsapps_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft 3D Builder"; Comando = "winget uninstall Microsoft.3DBuilder_8wekyb3d8bbwe $parametrosDesistalaca" },
        @{ Nome = "Microsoft Outlook"; Comando = "winget uninstall Microsoft.OutlookForWindows_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Power Automate Desktop"; Comando = "winget uninstall Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Windows Feedback Hub"; Comando = "winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Gravador de Som do Windows"; Comando = "winget uninstall Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Overlay de jogos do Xbox"; Comando = "winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Xbox Gaming Services"; Comando = "winget uninstall Microsoft.GamingApp_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxApp_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.Xbox.TCUI_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxIdentityProvider_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxGameOverlay_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "MS Solitaire"; Comando = "winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "MS Pay"; Comando = "winget uninstall Microsoft.Wallet_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "OneNote"; Comando = "winget uninstall Microsoft.Office.OneNote_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Mixed Reality-Portal"; Comando = "winget uninstall Microsoft.MixedReality.Portal_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Teams"; Comando = "winget uninstall MicrosoftTeams_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Family"; Comando = "winget uninstall MicrosoftCorporationII.MicrosoftFamily_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Third-Party Preinstalled bloat"; Comando = "winget uninstall disney+  --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Quick Assist"; Comando = "winget uninstall MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Get Started"; Comando = "winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Vincular ao Celular"; Comando = "winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Movies & TV"; Comando = "winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft To Do"; Comando = "winget uninstall Microsoft.Todos_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Pessoas Microsoft"; Comando = "winget uninstall Microsoft.People_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Get Help"; Comando = "winget uninstall Microsoft.GetHelp_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Bing Weather"; Comando = "winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Bing News"; Comando = "winget uninstall Microsoft.BingNews_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Cortana"; Comando = "winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Clipchamp"; Comando = "winget uninstall Clipchamp.Clipchamp_yxz26nhyzhsrt --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Fotos do Windows"; Comando = "winget uninstall Microsoft.Windows.Photos_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Alarmes do Windows"; Comando = "winget uninstall Microsoft.WindowsAlarms_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Mapas do Windows"; Comando = "winget uninstall microsoft.WindowsMaps_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Microsoft Office Hub"; Comando = "winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Groove Music"; Comando = "winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Copilot"; Comando = "winget uninstall MSIX\Microsoft.Copilot_1.1.8.0_neutral__8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" },
        @{ Nome = "Paint"; Comando = "winget uninstall MSIX\Microsoft.Paint_11.2408.30.0_x64__8wekyb3d8bbwe --accept-package-agreements --accept-source-agreements --silent" }
        @{ Nome = "Microsoft Teams classic"; Comando = "winget uninstall Microsoft.Teams.Classic --accept-package-agreements --accept-source-agreements --silent" }
        # @{ Nome = ""; Comando = "winget uninstall --accept-package-agreements --accept-source-agreements --silent" },
    )

    $totalBloatwares = $bloatwares.Count
    # Itera sobre cada Bloatware na lista e desinstala
    for ($i = 0; $i -lt $totalBloatwares; $i++) {
        $bloatwareAtual = $bloatwares[$i]
        $contador = "{0:000}/{1:000}" -f ($i + 1), $totalBloatwares
        Write-Host "$contador - Desinstalando o aplicativo $($bloatwareAtual.Nome)".ToUpper()
        Invoke-Expression $bloatwareAtual.Comando
        Write-Host $novaLinha
    }
}

function Atualizar_Drivers_Programas { 
    Write-Host "Verificando para atualizar todos os programas e drivers..." -ForegroundColor Green
    winget upgrade --all  --accept-package-agreements --accept-source-agreements --silent
}
function Instalar_Drivers {
    Write-Host "Instalando/Atualizando os drivers... " -ForegroundColor Green
  
}


function Exibir_Menu {
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
                2 { Meus_Programas }
                3 { Instalar_Programas }
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