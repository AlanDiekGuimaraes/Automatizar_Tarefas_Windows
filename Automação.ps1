

# Função para instalar programas
function Instalar-Programas {
    # Define a codificação do console para UTF-8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
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
        @{ Nome = "Acrobat Pro (64-bit)"; Comando = "winget install Adobe.Acrobat.Pro $parametrosInstalacao" },
        @{ Nome = "Adobe Acrobat Reader DC (64-bit)"; Comando = "winget install Adobe.Acrobat.Reader.64-bit $parametrosInstalacao" },
        @{ Nome = "Adobe Creative Cloud"; Comando = "winget install Adobe.CreativeCloud $parametrosInstalacao" },
        @{ Nome = "AnyDesk"; Comando = "winget install AnyDeskSoftwareGmbH.AnyDesk $parametrosInstalacao" },
        @{ Nome = "K-Lite Mega"; Comando = "winget install CodecGuide.K-LiteCodecPack.Mega $parametrosInstalacao" },
        #@{ Nome = "Duplicate Cleaner Pro 5"; Comando = "winget install DigitalVolcanoSoftware.DuplicateCÔÇª $parametrosInstalacao" },
        @{ Nome = "DirectX End-User Runtime Web"; Comando = "winget install Microsoft.DirectX $parametrosInstalacao" }
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
        # @{ Nome = ""; Comando = "winget install $parametrosInstalacao" },
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
function Instalar-AplicativosEssenciais {
    # Define a codificação do console para UTF-8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $novaLinha = "`n"
    $parametrosInstalacao = "--accept-package-agreements --accept-source-agreements"

    $aplicativosEssenciais = @(
        # APLICATIVOS ESSENCIAIS A SEREM INSTALADOS
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
function Desinstalar-BLOATWARES {
    # Define uma nova linha
    $novaLinha = "`n"
    $parametrosDesistalacao = "--accept-source-agreements --silent"
    
    # Lista de BLOATWARES para desinstalar
    $bloatwares = @(
        # @{ Nome = "Câmera do Windows"; Comando = "winget uninstall WindowsCamera_8wekyb3d8bbwe $parametrosDesistalacao" },
        # @{ Nome = "Screen Sketch"; Comando = "winget uninstall Microsoft.ScreenSketch_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Email e Calendário do Windows"; Comando = "winget uninstall microsoft.windowscommunicationsapps_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Microsoft Sticky Notes"; Comando = "winget uninstall Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Microsoft 3D Builder"; Comando = "winget uninstall Microsoft.3DBuilder_8wekyb3d8bbwe $parametrosDesistalaca" },
        @{ Nome = "Microsoft Outlook"; Comando = "winget uninstall Microsoft.OutlookForWindows_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Power Automate Desktop"; Comando = "winget uninstall Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Windows Feedback Hub"; Comando = "winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Gravador de Som do Windows"; Comando = "winget uninstall Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Overlay de jogos do Xbox"; Comando = "winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Xbox Gaming Services"; Comando = "winget uninstall Microsoft.GamingApp_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Quick Assist"; Comando = "winget uninstall MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Get Started"; Comando = "winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Your Phone"; Comando = "winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Zune Video"; Comando = "winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe $parametrosDesistalacao" },
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
        @{ Nome = "Zune Music"; Comando = "winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Copilot"; Comando = "winget uninstall MSIX\Microsoft.Copilot_1.1.8.0_neutral__8wekyb3d8bbwe $parametrosDesistalacao" },
        @{ Nome = "Paint"; Comando = "winget uninstall MSIX\Microsoft.Paint_11.2408.30.0_x64__8wekyb3d8bbwe $parametrosDesistalacao" }
        
    )

    $totalBloatwares = $bloatwares.Count
    # Define a codificação do console para UTF-8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    # Itera sobre cada Bloatware na lista e desinstala
    for ($i = 0; $i -lt $totalBloatwares; $i++) {
        $bloatwareAtual = $bloatwares[$i]
        $contador = "{0:000}/{1:000}" -f ($i + 1), $totalBloatwares
        Write-Host "$contador - Desinstalando o aplicativo $($bloatwareAtual.Nome)".ToUpper()
        Invoke-Expression $bloatwareAtual.Comando
        Write-Host $novaLinha
    }
}

# Dicionário de opções do menu
$menuOpcoes = @{
    # Define a codificação do console para UTF-8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    1 = "Instalar programas"
    2 = "Instalar aplicativos essenciais"
    3 = "Desinstalar BLOATWARES"
    4 = "Sair"
}


# Função para exibir o menu e executar a escolha do usuário
function Exibir-Menu {
    $menuOpcoes = @{
        1 = "Instalar Programas"
        2 = "Instalar Aplicativos Essenciais"
        3 = "Desinstalar Bloatwares"
        4 = "Sair"
    }

    $opcaoEscolhida = 0
    while ($opcaoEscolhida -ne 4) {
        Write-Host "Escolha uma opção:"
        $menuOpcoes.GetEnumerator() | ForEach-Object { Write-Host "$($_.Key): $($_.Value)" }
        
        $opcaoEscolhida = Read-Host "Digite o número da opção"
        
        switch ($opcaoEscolhida) {
            1 {
                Instalar-Programas
            }
            2 {
                Instalar-AplicativosEssenciais
            }
            3 {
                Desinstalar-BLOATWARES
            }
            4 {
                Write-Host "Saindo..."
            }
            default {
                Write-Host "Opção inválida, tente novamente."
            }
        }
    }
}

# Chamando a função para exibir o menu
Exibir-Menu