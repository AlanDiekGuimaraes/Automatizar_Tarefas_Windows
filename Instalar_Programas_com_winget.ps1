# Define uma nova linha
$novaLinha = "`n"
# Define os parâmetros padrão para instalação silenciosa
$parametrosInstalacao = "--accept-package-agreements --accept-source-agreements"


$programas = @(
    
)

$totalProgramas = $programas.Count

for ($i = 0; $i -lt $totalProgramas; $i++) {
    $programaAtual = $programas[$i]
    $contador = "{0:000}/{1:000}" -f ($i + 1), $totalProgramas
    Write-Host "$contador - Instalando o aplicativo $($programaAtual.Nome)".ToUpper()
    Invoke-Expression $programaAtual.Comando
    Write-Host $novaLinha
}


# @{ Nome = ""; Comando = "winget install " },