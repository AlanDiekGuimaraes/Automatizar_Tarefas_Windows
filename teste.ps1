function Exibir_Menu {
    # Cria uma lista de opções com nome e função associada
    $menuOpcoes = @(
        @{ Nome = "Sair"; Comando = { Write-Host "Saindo..."; break } }                          # Opção para sair do menu e encerrar o loop
        @{ Nome = "Minha Lista Pessoal de Programas".ToUpper(); Comando = { Meus_Programas } }   # Opção para chamar a função que exibe a lista pessoal de programas
        @{ Nome = "Instalar Programas Essenciais"; Comando = { Instalar_Programas } }            # Opção para instalar programas essenciais
        @{ Nome = "Instalar Aplicativos Essenciais"; Comando = { Instalar_Aplicativos_Essenciais } } # Opção para instalar aplicativos essenciais
        @{ Nome = "Desinstalar Bloatwares"; Comando = { Desinstalar_BLOATWARES } }               # Opção para desinstalar bloatwares
        @{ Nome = "Ativar IDM"; Comando = { AtivarIDM } }                                        # Opção para ativar o IDM
        @{ Nome = "Ativar Windows e Office"; Comando = { Ativar_Windows_Office } }               # Opção para ativar o Windows e o Office
        @{ Nome = "Ativar Winrar"; Comando = { Ativar_Winrar } }                                 # Opção para ativar o WinRAR       
        @{ Nome = "Atualizar Drivers"; Comando = { Atualizar_Drivers } } # Opção para atualizar os drivers
    )

    $linhaHorizontal = ("=" * 44)        # Cria uma linha horizontal de 44 caracteres "=" para uso na borda superior e inferior do menu
    $opcaoEscolhida = -1                 # Inicializa a variável de controle de opção escolhida com -1

    while ($opcaoEscolhida -ne 0) {      # Loop que continua até o usuário escolher a opção de sair (opção 0)
        Clear-Host                       # Limpa a tela do terminal para exibir o menu de forma organizada

        # Exibe a linha horizontal superior
        Write-Host "$linhaHorizontal" -ForegroundColor green         # Linha superior do menu em verde

        # Exibe o título do menu
        Write-Host ("|") -NoNewline -ForegroundColor Green           # Barra de abertura em verde
        Write-Host "              MENU DE OPÇÕES              " -NoNewline -ForegroundColor White   # Título centralizado em branco
        Write-Host ("|") -ForegroundColor Green                      # Barra de fechamento em verde

        # Exibe a linha horizontal inferior
        Write-Host "$linhaHorizontal" -ForegroundColor green         # Linha horizontal abaixo do título em verde

        # Loop para exibir todas as opções do menu
        for ($Contador = 0; $Contador -lt $menuOpcoes.Count; $Contador++) {
            Write-Host ("|") -NoNewline -ForegroundColor Green       # Barra de abertura de cada linha de opção em verde
            if ($menuOpcoes[$Contador].Nome -match "Desinstalar Bloatwares") {  # Exibe a opção "Desinstalar Bloatwares" em vermelho
                Write-Host " [$($Contador)] - $($menuOpcoes[$Contador].Nome.PadRight(34)) " -NoNewline -ForegroundColor Red -BackgroundColor Black
            } elseif ($menuOpcoes[$Contador].Nome -match "MINHA LISTA PESSOAL DE PROGRAMAS") { # Exibe a opção "MINHA LISTA PESSOAL DE PROGRAMAS" em Amarelo
                Write-Host " [$($Contador)] - $($menuOpcoes[$Contador].Nome.PadRight(34)) " -NoNewline -ForegroundColor Yellow -BackgroundColor Black
            } elseif ($menuOpcoes[$Contador].Nome -match "^Ativar") { # Exibe qualquer opção que comece com "Ativar" em ciano
                Write-Host " [$($Contador)] - $($menuOpcoes[$Contador].Nome.PadRight(34)) " -NoNewline -ForegroundColor Cyan -BackgroundColor Black
            } else { # Exibe todas as outras opções em branco
                Write-Host " [$($Contador)] - $($menuOpcoes[$Contador].Nome.PadRight(34)) " -NoNewline -ForegroundColor White -BackgroundColor Black
            }
            Write-Host ("|") -ForegroundColor Green                  # Barra de fechamento de cada linha de opção em verde
        }

        # Exibe a linha horizontal inferior de fechamento do menu
        Write-Host "$linhaHorizontal" -ForegroundColor green         # Linha de fechamento do menu em verde

        # Captura a escolha do usuário
        $opcaoEscolhida = Read-Host "Digite o número da opção"       # Solicita que o usuário insira a opção desejada

        # Valida a escolha do usuário e executa o comando correspondente
        if ([int]::TryParse($opcaoEscolhida, [ref]$null) -and $opcaoEscolhida -ge 0 -and $opcaoEscolhida -lt $menuOpcoes.Count) {
            & $menuOpcoes[$opcaoEscolhida].Comando                   # Executa a função associada à opção escolhida
        } else {
            Write-Host "Opção inválida, tente novamente.".ToUpper() -ForegroundColor Yellow  # Mensagem de erro para entrada inválida
            Start-Sleep -Seconds 2                                   # Pausa de 2 segundos antes de retornar ao menu
        }
    }
}
