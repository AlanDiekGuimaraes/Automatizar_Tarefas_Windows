function Ativar_Internet_Download_Manager_IDM {
    iex(irm is.gd/idm_reset) # Ativar o internet Download Manager IDM Disponivel em https://github.com/lstprjct/IDM-Activation-Script
}
function Ativar_Windows_Office {
    try {
        Write-Host "Ativando o Windows Office..."
        irm https://get.activated.win | iex # Ativar Windows Office	
    }
    catch {
        Write-Host "Ocorreu um erro ao ativar o Windows Office."
    }
    try {
        Write-Host "Tentando novamente: Ativando o Windows Office..."
        irm https://massgrave.dev/get | iex # Ativar Windows Office
    }
    catch {
        Write-Host "Ocorreu um erro ao ativar o Windows Office na opção 2."
    }
}

function Ativar_Winrar {
    try {
        Write-Host "Ativando o WinRAR..."
        iwr -useb https://naeembolchhi.github.io/WinRAR-Activator/WRA.ps1 | iex
    }
    catch {
        Write-Host "Ocorreu um erro ao ativar o WinRAR."
    }
    
}

# Função para instalar programas
function Instalar_Programas {
    $novaLinha = "`n"
    $parametrosInstalacao = "--accept-package-agreements --accept-source-agreements"

    $programas = @(
        # PROGRAMAS A SEREM INSTALADOS
        @{ Nome = "Google Chrome"; Comando = "winget install Google.Chrome $parametrosInstalacao" },
        @{ Nome = "Mozilla Firefox"; Comando = "winget install Mozilla.Firefox $parametrosInstalacao" },
        @{ Nome = "WinRAR"; Comando = "winget install RARLab.WinRAR $parametrosInstalacao" },
        @{ Nome = "PotPlayer"; Comando = "winget install Daum.PotPlayer $parametrosInstalacao" },
        @{ Nome = "PowerToys"; Comando = "winget install Microsoft.PowerToys $parametrosInstalacao" },
        @{ Nome = "UltraISO Premium"; Comando = "winget install EZBSystems.UltraISO $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual Studio Code"; Comando = "winget install Microsoft.VisualStudioCode $parametrosInstalacao" },
        @{ Nome = "Microsoft 365"; Comando = "winget install Microsoft.Office $parametrosInstalacao" },
        @{ Nome = "Internet Download Manager"; Comando = "winget install Tonec.InternetDownloadManager $parametrosInstalacao" },
        @{ Nome = "Steam"; Comando = "winget install Valve.Steam $parametrosInstalacao" },
        @{ Nome = "Google Drive"; Comando = "winget install Google.GoogleDrive $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        kjm

        # @{ Nome = "Acrobat Pro (64-bit)"; Comando = "winget install Adobe.Acrobat.Pro $parametrosInstalacao" },
        # @{ Nome = "Adobe Acrobat Reader DC (64-bit)"; Comando = "winget install Adobe.Acrobat.Reader.64-bit $parametrosInstalacao" },
        # @{ Nome = "Adobe Creative Cloud"; Comando = "winget install Adobe.CreativeCloud $parametrosInstalacao" },
        # @{ Nome = "TeamViewer"; Comando = "winget install TeamViewer.TeamViewer $parametrosInstalacao" },
        # @{ Nome = "AnyDesk"; Comando = "winget install AnyDeskSoftwareGmbH.AnyDesk $parametrosInstalacao" },
        # @{ Nome = "K-Lite Mega"; Comando = "winget install CodecGuide.K-LiteCodecPack.Mega $parametrosInstalacao" },
        # @{ Nome = "Duplicate Cleaner Pro 5"; Comando = "winget install DigitalVolcanoSoftware.DuplicateCleaner.5" },
        @{ Nome = "DirectX End-User Runtime Web"; Comando = "winget install Microsoft.DirectX $parametrosInstalacao" }
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

# Função para instalar aplicativos essenciais
function Instalar_Aplicativos_Essenciais {
    $novaLinha = "`n"
    $parametrosInstalacao = "--accept-package-agreements --accept-source-agreements"

    $aplicativosEssenciais = @(
        # APLICATIVOS ESSENCIAIS A SEREM INSTALADOS
        @{ Nome = "Calculadora"; Comando = "winget install calculator $parametrosInstalacao" },
        @{ Nome = "PowerShell"; Comando = "winget install Microsoft.PowerShell $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2005 x64"; Comando = "winget install Microsoft.VCRedist.2005.x64 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2005 x86"; Comando = "winget install Microsoft.VCRedist.2005.x86 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2008 x64"; Comando = "winget install Microsoft.VCRedist.2008.x64 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2008 x86"; Comando = "winget install Microsoft.VCRedist.2008.x86 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2010 x64"; Comando = "winget install Microsoft.VCRedist.2010.x64 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2010 x86"; Comando = "winget install Microsoft.VCRedist.2010.x86 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2012 x64"; Comando = "winget install Microsoft.VCRedist.2012.x64 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2012 x86"; Comando = "winget install Microsoft.VCRedist.2012.x86 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2013 x64"; Comando = "winget install Microsoft.VCRedist.2013.x64 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2013 x86"; Comando = "winget install Microsoft.VCRedist.2013.x86 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2015-2022 x64"; Comando = "winget install Microsoft.VCRedist.2015+.x64 $parametrosInstalacao" },
        @{ Nome = "Microsoft Visual C++ 2015-2022 x86"; Comando = "winget install Microsoft.VCRedist.2015+.x86 $parametrosInstalacao" },
        @{ Nome = "Java Runtime Environment"; Comando = "winget install Oracle.JavaRuntimeEnvironment $parametrosInstalacao" }
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

# Função para desinstalar BLOATWARES
function Desinstalar_BLOATWARES {
    # Define uma nova linha
    $novaLinha = "`n"
    $parametrosDesistalacao = "--accept-source-agreements --silent"
    
    # Lista de BLOATWARES para desinstalar
    $bloatwares = @(
        # @{ Nome = "Câmera do Windows"; Comando = "winget uninstall WindowsCamera_8wekyb3d8bbwe $parametrosDesistalacao" },
        # @{ Nome = "Screen Sketch"; Comando = "winget uninstall Microsoft.ScreenSketch_8wekyb3d8bbwe $parametrosDesistalacao" },
        # @{ Nome = "OneDrive"; Comando = "winget uninstall Microsoft.OneDrive $parametrosDesistalacao" },
        # @{ Nome = "Calculadora"; Comando = "winget uninstall Microsoft.WindowsCalculator_8wekyb3d8bbwe $parametrosDesistalacao" },
        # @{ Nome = "Microsoft Sticky Notes"; Comando = "winget uninstall Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Email e Calendário do Windows"; Comando = "winget uninstall microsoft.windowscommunicationsapps_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Microsoft 3D Builder"; Comando = "winget uninstall Microsoft.3DBuilder_8wekyb3d8bbwe $parametrosDesistalaca" },
        @{ Nome = "Microsoft Outlook"; Comando = "winget uninstall Microsoft.OutlookForWindows_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Power Automate Desktop"; Comando = "winget uninstall Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Windows Feedback Hub"; Comando = "winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Gravador de Som do Windows"; Comando = "winget uninstall Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Overlay de jogos do Xbox"; Comando = "winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Xbox Gaming Services"; Comando = "winget uninstall Microsoft.GamingApp_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxApp_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.Xbox.TCUI_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxIdentityProvider_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Aplicações Xbox"; Comando = "winget uninstall Microsoft.XboxGameOverlay_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "MS Solitaire"; Comando = "winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "MS Pay"; Comando = "winget uninstall Microsoft.Wallet_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "OneNote"; Comando = "winget uninstall Microsoft.Office.OneNote_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Mixed Reality-Portal"; Comando = "winget uninstall Microsoft.MixedReality.Portal_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Microsoft Teams"; Comando = "winget uninstall MicrosoftTeams_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Microsoft Family"; Comando = "winget uninstall MicrosoftCorporationII.MicrosoftFamily_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Third-Party Preinstalled bloat"; Comando = "winget uninstall disney+  $parametrosDesistalacao" },
        @{ Nome = "Quick Assist"; Comando = "winget uninstall MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Get Started"; Comando = "winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Vincular ao Celular"; Comando = "winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Movies & TV"; Comando = "winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Microsoft To Do"; Comando = "winget uninstall Microsoft.Todos_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Pessoas Microsoft"; Comando = "winget uninstall Microsoft.People_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Get Help"; Comando = "winget uninstall Microsoft.GetHelp_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Bing Weather"; Comando = "winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Bing News"; Comando = "winget uninstall Microsoft.BingNews_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Cortana"; Comando = "winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Clipchamp"; Comando = "winget uninstall Clipchamp.Clipchamp_yxz26nhyzhsrt $parametrosDesistalacao" },
        @{ Nome = "Fotos do Windows"; Comando = "winget uninstall Microsoft.Windows.Photos_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Alarmes do Windows"; Comando = "winget uninstall Microsoft.WindowsAlarms_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Mapas do Windows"; Comando = "winget uninstall microsoft.WindowsMaps_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Microsoft Office Hub"; Comando = "winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Groove Music"; Comando = "winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Copilot"; Comando = "winget uninstall MSIX\Microsoft.Copilot_1.1.8.0_neutral__8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Paint"; Comando = "winget uninstall MSIX\Microsoft.Paint_11.2408.30.0_x64__8wekyb3d8bbwe $parametrosDesistalacao" }
        @{ Nome = "Microsoft Teams classic"; Comando = "winget uninstall Microsoft.Teams.Classic $parametrosDesistalacao" },
        
        
        
        
        
        # @{ Nome = ""; Comando = "winget uninstall $parametrosDesistalacao" },
        # @{ Nome = ""; Comando = "winget uninstall $parametrosDesistalacao" },
        # @{ Nome = ""; Comando = "winget uninstall $parametrosDesistalacao" },
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
# Função para exibir o menu e executar a escolha do usuário
function Exibir_Menu {
    $menuOpcoes = @{
        1 = "Sair"
        2 = "Instalar Programas"
        3 = "Instalar Aplicativos Essenciais"
        4 = "Desinstalar Bloatwares"
        5 = "Ativar IDM"
        6 = "Ativar Windows e Office"
        7 = "Ativar WinRAR"        
        
    }

    $opcaoEscolhida = 0
    while ($opcaoEscolhida -ne 1) {
        Clear-Host
        Write-Host "======================================="
        Write-Host "           MENU DE OPÇÕES"
        Write-Host "======================================="

        # Exibe as opções de forma mais visual
        foreach ($Chave in ($menuOpcoes.Keys | Sort-Object)) {
            Write-Host "[$Chave] - $($menuOpcoes[$Chave])"
        }
        Write-Host "======================================="

        # Captura a escolha do usuário
        $opcaoEscolhida = Read-Host "Digite o número da opção"

        # Valida a escolha do usuário
        switch ($opcaoEscolhida) {
            1 {
                Write-Host "Saindo..."
                break
            }
            2 {
                Instalar_Programas
            }
            3 {
                Instalar_Aplicativos_Essenciais
            }
            4 {
                Desinstalar_BLOATWARES
            }
            5 {
                AtivarIDM
            }
            6 {
                Ativar_Windows_Office
            }
            7 {
                Ativar_Winrar
            }            
            default {
                Write-Host "Opção inválida, tente novamente."
                Start-Sleep -Seconds 2
            }
        }
    }
}
    
# Chamando a função para exibir o menu
Exibir_Menu