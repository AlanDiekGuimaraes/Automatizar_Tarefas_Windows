# Programas a serem adicionados
        # @{ Nome = "Transmission"; Comando = "winget install Transmission.Transmission $parametrosInstalacao" },
        # @{ Nome = "Git"; Comando = "winget install Git.Git $parametrosInstalacao" },
        # @{ Nome = "Deluge BitTorrent"; Comando = "winget install DelugeTeam.Deluge $parametrosInstalacao" },
        # @{ Nome = "Duplicate Cleaner Pro 5"; Comando = "winget install DigitalVolcanoSoftware.DuplicateCleaner.5" },
# @{ Nome = "Câmera do Windows"; Comando = "winget uninstall WindowsCamera_8wekyb3d8bbwe $parametrosDesistalacao" },
        # @{ Nome = "Screen Sketch"; Comando = "winget uninstall Microsoft.ScreenSketch_8wekyb3d8bbwe $parametrosDesistalacao" },
        # @{ Nome = "OneDrive"; Comando = "winget uninstall Microsoft.OneDrive $parametrosDesistalacao" },
        # @{ Nome = "Calculadora"; Comando = "winget uninstall Microsoft.WindowsCalculator_8wekyb3d8bbwe $parametrosDesistalacao" },
        # @{ Nome = "Microsoft Sticky Notes"; Comando = "winget uninstall Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe $parametrosDesistalacao" },

# =================




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


# Menu opções
# 8 = "Ativar IDM"
# 9 = "Ativar Windows e Office"
# 10 = "Ativar WinRAR"

# Opção Escolhida
# 8 { Ativar_Internet_Download_Manager_IDM }
# 9 { Ativar_Windows_Office }
# 10 { Ativar_Winrar }