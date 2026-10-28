# Pesquisa — como o GitHub mostra o frontmatter YAML de um arquivo `.md`

> Resolve o ticket [#49](https://github.com/edalcin/Arquitetura-BioCultural/issues/49) do mapa
> [#47](https://github.com/edalcin/Arquitetura-BioCultural/issues/47) (adotar o Open Knowledge Format, OKF, v0.2).
> Pesquisa de 28/10/2026. Nenhum arquivo da documentação foi alterado.

## 0. Como ler

- **Frontmatter** = o bloco de metadados entre duas linhas `---` no começo de um arquivo `.md`.
- Cada afirmação aponta para a fonte. **[observado]** = vi acontecer no github.com, sem login, em arquivos de teste que
  criei para esta pesquisa (links na seção 6). **[inferência]** = conclusão minha, não da fonte.
- O que a GitHub documenta é pouco: só existe o aviso de 2013 (seção 1). O comportamento de hoje eu só consegui
  confirmar **observando**; não achei documentação atual da GitHub que o descreva. A pergunta "dá para esconder?"
  tem resposta em *issues* do projeto da GitHub (seção 4).

## 1. Resumo para quem decide

1. **O GitHub mostra o frontmatter como uma tabela no topo do arquivo, antes do texto.** Vale para qualquer `.md`
   (e `.markdown`), na página do arquivo, no README de uma pasta e no README da página inicial do repositório.
   [observado] A GitHub anunciou isso em 2013 ([blog](https://github.blog/news-insights/product-news/viewing-yaml-metadata-in-your-documents/)).
2. **Hoje a tabela é vertical** (uma linha por campo: nome à esquerda, valor à direita). [observado] O anúncio de 2013
   fala em tabela "horizontal" e um pedido de 2021 ([github/markup#1490](https://github.com/github/markup/issues/1490))
   reclama que era "uma linha só, uma coluna por campo". Esse formato mudou; quem lê só fontes antigas erra.
3. **Campos aninhados e listas aparecem, mas como tabelas dentro de tabelas.** `generated: {by, at}` vira uma mini-tabela
   com colunas `by` e `at`. Uma lista de textos vira uma fileira de caixinhas. Uma lista de mapas vira várias mini-tabelas
   lado a lado. [observado] Legível para 1 nível; com 2 ou mais níveis fica pesado para quem não é técnico.
4. **Não existe jeito suportado de esconder a tabela.** O pedido existe desde 2017
   ([github/markup#994](https://github.com/github/markup/issues/994)) e foi fechado sem solução.
   [observado] Todo frontmatter válido no começo do arquivo vira tabela, sem exceção.
5. **Frontmatter inválido não quebra a página, mas aparece uma mensagem de erro**, seguida do texto cru do
   bloco. [observado]
6. **O frontmatter não atrapalha links, âncoras nem a vista "Raw"/"Code".** [observado]

## 2. O que o GitHub faz, caso a caso [observado]

Observei em 28/10/2026, navegador sem login, nos arquivos da seção 6. "Tabela" abaixo = a tabela de frontmatter.

| Caso testado | Resultado |
|---|---|
| Arquivo `.md` comum com frontmatter | Tabela no topo (elemento `<markdown-accessiblity-table>` dentro do `.markdown-body`), depois o corpo. Sem `<hr>`. |
| Arquivo `.markdown` | Igual ao `.md`. |
| `README.md` dentro de uma pasta, vista da **pasta** | A tabela aparece dentro do painel do README, abaixo da lista de arquivos. |
| `README.md` na **raiz** do repositório (página inicial) | A tabela aparece como primeira coisa do README, antes do título do corpo. |
| Arquivo só com frontmatter, sem corpo | Só a tabela. |
| Comentário YAML (`# ...`) dentro do bloco | Aceito; o comentário some e os campos aparecem. |
| Frontmatter com **YAML inválido** | Sem tabela. Aparece "Error in user YAML: (&lt;unknown&gt;): did not find expected ',' or ']' ..." e abaixo o bloco como texto. O corpo continua normal. |
| Bloco `---` que **não** está na primeira linha (há linha em branco antes) | Não é frontmatter. O primeiro `---` vira linha horizontal e `title: ...` vira um título de seção (H2). Fica feio. |

### 2.1. Como cada tipo de valor aparece [observado]

| No YAML | Na página |
|---|---|
| Texto simples, número, `true` | Texto na célula. |
| Texto com `**negrito**`, `[link](url)` ou `` `código` `` | Aparece **literal**, sem formatar. (Mas uma URL solta vira link clicável.) |
| Texto com HTML (`<b>x</b>`) | Aparece como texto, sem executar. |
| `at: 2026-10-28T10:00:00Z` (data e hora) | Reescrito como `2026-10-28 10:00:00 UTC`. Data sem hora (`2026-10-28`) fica igual. |
| Valor vazio ou `null` | Célula vazia. |
| Lista de textos (`[a, b]` ou `- a`) | Mini-tabela de uma linha, uma caixinha por item. |
| Lista de URLs | Caixinhas, cada URL como link (com `rel="nofollow"`). |
| Mapa (`generated: {by, at}`) | Mini-tabela com uma coluna por chave e uma linha de valores. |
| Mapa dentro de mapa, lista dentro de mapa | Mini-tabela dentro de mini-tabela (testei até 3 níveis; funciona). |
| Lista de mapas (`relations: [{type, target}, ...]`) | Uma mini-tabela por item, lado a lado. |
| Lista ou mapa vazio (`[]`, `{}`) | Célula com uma tabela vazia (aparece só como célula em branco). |
| Texto longo em várias linhas (`>`) | Junta numa linha só e quebra na largura da célula. |

Valores entre aspas (`"0.2"`) e sem aspas (`0.2`) aparecem iguais; a tabela não distingue texto de número.

## 3. O que não muda [observado]

- **Âncoras:** o primeiro título do corpo ganha o mesmo `id` de sempre (`#corpo-com-nested`). O frontmatter não cria
  âncora nem desloca as do corpo. Links `#subtítulo-um` dentro do arquivo funcionam.
- **Links relativos** no corpo (`[aninhado](aninhado.md)`) funcionam normalmente.
- **Vista "Raw"** (`raw.githubusercontent.com/...`): devolve o arquivo exatamente como está, começando por `---`.
- **Vista "Code"** (`?plain=1`): mostra o YAML cru, com números de linha.
- A tabela é só **apresentação**: o arquivo no repositório não muda. Programas que leem o arquivo (por exemplo o
  *Harvest*) veem o YAML intacto. [inferência: não testei nenhum leitor externo]

## 4. Dá para esconder?

**Não, de forma suportada.**

- O pedido "ignorar o frontmatter" está em [github/markup#994](https://github.com/github/markup/issues/994) desde
  fev/2017. Um mantenedor respondeu em 2017 que remover é simples, mas que falta decidir como o autor liga ou desliga
  isso. O robô da GitHub o marcou como inativo (*Stale*); hoje está fechado, última atividade em 04/2025, sem implementação.
- O pedido por um layout melhor ([github/markup#1490](https://github.com/github/markup/issues/1490)) também está
  fechado, com o rótulo `no-issue-activity`. (A parte da tabela vertical, hoje, já existe de fato; a chave que o pedido sugeria, não.)
- Não achei, na documentação da GitHub, nenhuma chave do frontmatter, configuração do repositório ou
  configuração do usuário que oculte a tabela. **[não verificado]** que não exista alguma opção interna não documentada.
- Truques que "escondem" (por exemplo, não começar o bloco na primeira linha) fazem o arquivo **deixar de ter
  frontmatter** para quem lê com programa, e ainda deixam lixo visual (linha horizontal e título H2; ver seção 2).
  Por isso não servem como solução. [inferência]

## 5. O que isso significa para o OKF e para textos de leigos [inferência]

- Quem abrir um arquivo OKF no GitHub **vai ver os metadados primeiro** e o texto depois. Para leigos, dá para tratar
  isso como vantagem (a ficha do termo aparece) ou como ruído; não dá para escolher: não há como ocultar.
- **Campos simples (texto, URL, lista curta) ficam legíveis.** Aninhamento além de um nível (`generated.by/at` ainda
  passa bem) e listas de mapas (`relations`) ficam parecendo tabelas dentro de tabelas. Se o texto para leigos for
  lido no GitHub, convém manter o frontmatter raso e curto.
- **Não use formatação (negrito, link em Markdown) dentro de valores do frontmatter**: no GitHub aparece como símbolos
  literais. Coloque a formatação no corpo.
- **Garanta que o `---` de abertura seja a primeira linha do arquivo** (sem linha em branco nem BOM antes, a ser
  conferido com o editor usado). Se não, a página mostra uma linha horizontal e um título falso.
- **Valide o YAML antes de publicar.** Um erro de sintaxe aparece para todos como "Error in user YAML".
- Datas e horas em formato ISO (`2026-10-28T10:00:00Z`) são reescritas para `2026-10-28 10:00:00 UTC` na tela; o
  arquivo guarda o valor original.
- Quando um texto para leigos precisa ser a primeira coisa que a pessoa vê, o caminho que funciona é pôr esse texto
  num arquivo **separado** (por exemplo, o README da pasta sem frontmatter, apontando para o arquivo OKF); o README
  também mostra a tabela se tiver frontmatter.

## 6. Arquivos de teste (reproduzir)

Todos ficam na branch `research/okf-github-frontmatter`, em
[`docs/tecnico/pesquisa/okf-github-frontmatter-teste/`](https://github.com/edalcin/Arquitetura-BioCultural/tree/research/okf-github-frontmatter/docs/tecnico/pesquisa/okf-github-frontmatter-teste):

- [`aninhado.md`](https://github.com/edalcin/Arquitetura-BioCultural/blob/research/okf-github-frontmatter/docs/tecnico/pesquisa/okf-github-frontmatter-teste/aninhado.md) — mapas e listas aninhados, formatação em valores, datas, vazio, texto longo (e a cópia `aninhado.markdown`).
- [`lista-de-mapas.md`](https://github.com/edalcin/Arquitetura-BioCultural/blob/research/okf-github-frontmatter/docs/tecnico/pesquisa/okf-github-frontmatter-teste/lista-de-mapas.md) — lista de mapas, `[]`, `{}`, `null`, HTML.
- [`README.md`](https://github.com/edalcin/Arquitetura-BioCultural/blob/research/okf-github-frontmatter/docs/tecnico/pesquisa/okf-github-frontmatter-teste/README.md) — README de pasta (vista da pasta: [tree](https://github.com/edalcin/Arquitetura-BioCultural/tree/research/okf-github-frontmatter/docs/tecnico/pesquisa/okf-github-frontmatter-teste)).
- `yaml-invalido.md`, `sem-frontmatter-na-primeira-linha.md`, `so-frontmatter.md`, `comentario-html.md` — os casos de borda da seção 2.
- Página inicial do repositório com frontmatter no README da raiz: branch de teste
  [`research/okf-github-frontmatter-teste`](https://github.com/edalcin/Arquitetura-BioCultural/tree/research/okf-github-frontmatter-teste)
  (só troca o `README.md` da raiz; nunca foi para o `main`).

Método: abri cada URL em Chromium sem login (em 28/10/2026) e li o HTML do `.markdown-body`; a tabela é o
elemento `<markdown-accessiblity-table>`. A GitHub pode mudar a renderização sem aviso; vale repetir a observação
nos mesmos arquivos antes de depender de um detalhe visual.

## 7. Fontes

1. GitHub Blog, *Viewing YAML Metadata in your Documents* (27/09/2013, atualizado 04/01/2019) — anúncio do recurso:
   <https://github.blog/news-insights/product-news/viewing-yaml-metadata-in-your-documents/>
2. github/markup#994, *Add ability to ignore YAML front matter* — pedido de ocultar, fechado sem solução:
   <https://github.com/github/markup/issues/994>
3. github/markup#1490, *Format YAML Front Matter in vertical 2 column table* — descreve o formato antigo,
   fechado: <https://github.com/github/markup/issues/1490>
4. Observação direta no github.com (seção 6).
