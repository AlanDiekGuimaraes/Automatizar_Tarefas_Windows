# Automação de Tarefas no Windows

**Autor: Alan Diek Guimarães**

Este projeto tem como objetivo simplificar a manutenção e configuração de sistemas Windows, automatizando tarefas como instalação de programas, desinstalação de bloatwares, atualização de drivers e ajustes no sistema operacional. Ideal para técnicos e entusiastas que buscam economizar tempo e padronizar processos.

### Pré-requisitos

**Antes de rodar o script principal, siga os passos abaixo:**

Execute o arquivo PowerShell_Sem_Restições.reg
Este arquivo configura o sistema para  definir a política de execução como Unrestricted, garantindo que o script funcione corretamente.

**Como executar:**
Clique duas vezes no arquivo PowerShell_Sem_Restições.reg.
Confirme as alterações no registro.

## 🚀 Funcionalidades Principais
O script Automacao_Windows apresenta um menu interativo com as seguintes opções:

**Instalar Programas**
Realiza a instalação automatizada de um pacote de softwares essenciais.

**Atualizar Drivers**
Verifica e atualiza os drivers de dispositivos do sistema.

**Desinstalar Bloatwares**
Remove programas desnecessários que vêm pré-instalados no sistema operacional.

**Outros Ajustes no Sistema**
Contém funcionalidades adicionais para otimizar o desempenho e personalizar o ambiente Windows.

## Programas no Pacote 📦

### Instalação de Programas Essenciais
#### Os seguintes softwares estão disponíveis para instalação no pacote:


| **Nome**                      | **Nome**                       |
|-------------------------------|--------------------------------|
| Google Chrome                 | Mozilla Firefox                |
| WinRAR                        | PotPlayer                      |
| TeamViewer                    | AnyDesk                        |
| Microsoft 365                 | Internet Download Manager      |
|Skype                          |                                |
| Microsoft OneDrive *(se removido)*                             |
| Adobe Acrobat Reader DC (64-bit)                               |



### Instalação de aplicativos essenciais.
#### PowerShell - "Atualizar a versão do PowerShell"

| **Nome**                           | **Nome**                     |
|------------------------------------|------------------------------|
| Calculadora *(se removida)*        | PowerToys                    |
| Microsoft Visual C++               | Java Runtime Environment     |
| .NET Framework 4.8                 | DirectX                      |

### Desinstalação de Programas
#### Os seguintes bloatwares podem ser removidos:

### Programas Desinstalados

| **Nome**                           | **Nome**                       |
|------------------------------------|--------------------------------|
| Email e Calendário do Windows      | Microsoft 3D Builder           |
| Microsoft Outlook                  | Power Automate Desktop         |
| Windows Feedback Hub               | Gravador de Som do Windows     |
| Overlay de jogos do Xbox           | Xbox Gaming Services           |
| Aplicações Xbox                    | MS Solitaire                   |
| MS Pay                             | OneNote                        |
| Mixed Reality-Portal               | Microsoft Teams                |
| Microsoft Family                   | Third-Party Preinstalled Bloat |
| Quick Assist                       | Get Started                    |
| Vincular ao Celular                | Movies & TV                    |
| Microsoft To Do                    | Pessoas Microsoft              |
| Get Help                           | Bing Weather                   |
| Bing News                          | Cortana                        |
| Clipchamp                          | Fotos do Windows               |
| Alarmes do Windows                 | Mapas do Windows               |
| Microsoft Office Hub               | Groove Music                   |
| Copilot                            | Paint                          |
| Microsoft Teams Classic            |                                |


## 🖥️  Como Usar
Após executar o arquivo .reg, abra o PowerShell como administrador.
Navegue até o diretório onde está o script Automacao_Windows_V_0.1.ps1.
Execute o script com o comando:
powershell
Copiar código
.\Automacao_Windows_V_0.1.ps1
Siga as instruções no menu interativo.
Importante: Sempre execute o script com permissões de administrador para evitar erros durante as operações.

## 🛠️ Estrutura do Script
O código é organizado em funções para cada uma das tarefas, garantindo modularidade e facilidade de manutenção. Cada opção no menu chama uma função específica, como:

Instalar_Programas_Essenciais: Gerencia a instalação de softwares.
Atualizar_Drivers_Programas: Executa a verificação e atualização de drivers.
Desinstalar_BLOATWARES: Remove aplicativos desnecessários.
Programas_Formatação_Pessoal: Instala programas que sempre faço após miha formatação pessoal.
Funções auxiliares para configurações adicionais.

## 📜 Licença

Este projeto está licenciado sob a [MIT License](LICENSE) - consulte o arquivo para mais detalhes.

**Aviso:** Este script é fornecido "como está" e sem garantia de qualquer tipo. Seu uso é de total responsabilidade do usuário.

## 🤝 Contribuições
Sugestões, melhorias e feedback são sempre bem-vindos! Sinta-se à vontade para abrir issues ou enviar pull requests no repositório.