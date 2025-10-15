# 💀🖥️ CortexIA (Flutter) 🖌️🖼️

# Padrões

## Nomes de _branches_

Modelo:<br>
{tipo de branch}/{código da tarefa}-{nome-da-tarefa}

Exemplo:<br>
feature/PPS-123-Criar-integracao-de-PDFs-com-o-motor-de-pagamento

<br>

| Tipos de branches |
| ----------------- |
| main              |
| develop           |
| feature           |
| realese           |
| hotfix            |

<br>

## Mensagens de _commits_

Modelo:<br>
{emoji} {prefixo}{código da tarefa}: {Mensagem do commit}

Exemplo:<br>
"🐛 fix/PPS-123: Criação do endpoint post pdf"

<br>

| Emoji                        | Prefixo  | Descrição                                                      |
| ---------------------------- | -------- | -------------------------------------------------------------- |
| ➕ `:heavy_plus_sign:`       | feat     | Inclusão de novo recurso                                       |
| 🐛 `:bug:`                   | fix      | Correção de um bug                                             |
| 📝 `:penceil:`               | docs     | Adição ou alteração de documentação                            |
| 🧪 `:test_tube:`             | test     | Adição ou alteração dos testes                                 |
| 🏗️ `:building_construction:` | build    | Alteração de arquivos de build e e dependências                |
| ⚡ `:zap:`                   | perf     | Melhoria de performance                                        |
| 🖌️ `:paintbrush:`            | style    | Mudança de formatação (não features de estilo)                 |
| 🔁 `:repeat:`                | refactor | Refatoração que não altere nenhuma funcionalidade              |
| ⚙️ `:gear:`                  | chore    | Manutenção ou configuração que não interfira em funcionalidade |
| ✅ `:white_check_mark:`      | ci       | Configuração ou automação relacionada a CI/CD                  |
| 📂 `:open_file_folder:`      | raw      | Adição de arquivos ou conteúdos sem alteração de código        |
| 🌀 `:cyclone:`               | merge    | Merge de alguma outra branch, geralmente a develop             |

<br>

## Nomes de _pull requests_

Modelo:<br>
{prefixo}{código da tarefa}: {Nome da tarefa}

Exemplo:<br>
"fix/PPS-123: Criar integracão de PDFs com o motor de pagamento"
