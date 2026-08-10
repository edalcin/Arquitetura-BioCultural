# ADR-014: Nomenclatura Científica Fora do Escopo do Vocabulário Controlado

## Status

**Aceito** — Agosto 2026

## Contexto

O BioCultTermos governa o vocabulário controlado da federação em SKOS-XL. Entre os campos que ele
minera desde a primeira integração está o nome científico da espécie — no BioCultDB,
`comunidades.plantas.nomeCientifico`.

Terminada a primeira campanha de curadoria real (campo "Tipos de Usos de Plantas", 713 termos
reduzidos a 333 conceitos vivos, executada em produção em 2026-08-07), a pergunta natural era qual
campo curar em seguida. Ao planejar a campanha do nome científico, a pergunta mudou de "como curar"
para **"o que exatamente há para decidir aqui?"**.

### O sintoma medido

864 conceitos candidatos de nome científico no `etnotermos` do BioCultDB. **Zero curados** em treze
meses. Não por falta de tempo: por falta de decisão disponível. Confrontando a paleta de operações
do módulo com um binômio latino:

| Operação do BioCultTermos | Sobre um nome vernacular | Sobre um nome científico |
|---|---|---|
| `pref` / `alt` / `hidden` | Escolha real entre nomes co-iguais da comunidade | Só grafia errada — defeito de dado, não de conceito |
| Hierarquia BT/NT | Etnotáxons se aninham por significado cultural | Já existe, e fora daqui: gênero → família → ordem |
| "Sinônimo de (aceito)" | Decisão do curador | **Decisão do código nomenclatural**, não do curador |
| Depreciar com `replacedBy` | Termo inadequado ou colonial | Rebaixamento publicado em literatura externa |
| `accessLevel`, `sourcePeople`, `holderPeople` | O coração dos princípios CARE | Inertes: binômio latino é público por construção |

Restam operações inertes e uma perigosa: a interface aceita que um curador afirme uma sinonímia que
o código nomenclatural não sustenta. O campo não é apenas trabalho sem retorno — é superfície de
erro com aparência de curadoria.

A nomenclatura biológica já é governada, globalmente, por autoridades que a federação não tem como
nem porque replicar: o **ICN** para plantas, fungos e algas, o **ICZN** para animais, materializados
em WFO, IPNI, POWO e no *backbone* do GBIF, com identificadores estáveis e revisão contínua. 864
conceitos curados à mão são um espelho local que nasce desatualizado e que ninguém se comprometeu a
reconciliar.

### Por que isto não é decisão de uma unidade

O BioCultDB executou a remoção no seu próprio escopo
([`docs/curadoria/decisao-nomes-cientificos-fora-de-escopo.md`](https://github.com/edalcin/BioCultDB/blob/main/docs/curadoria/decisao-nomes-cientificos-fora-de-escopo.md),
`BioCultTermos@2bbe950`). Isoladamente, essa remoção é **temporária**, porque o campo está inscrito
em dois lugares normativos acima dela:

1. **ADR-012 G5** descreve a travessia do `AcquisitionService` incluindo `nomeCientifico`, e decide
   que ela passará a ser **configuração declarada pela Unidade Hospedeira**. No instante em que essa
   generalização acontecer, nada impede uma unidade de declarar de volta um campo de nome científico.

2. **`BioCultNaturalistas/docs/decisions/ADR-003` V2** já declara, no seu contrato inicial de campos
   monitorados, a linha `bcn_taxons → $.nomeCientificoAtual → "nome científico aceito atual"`. Não é
   risco hipotético: é um campo de uma **tabela de táxons**, que semearia como conceitos candidatos
   uma taxonomia inteira, e não os poucos nomes citados em artigos.

Somado ao **ADR-012 G4** (toda unidade deve adotar toda versão do módulo, logo todo commit precisa
ser seguro para toda unidade), a conclusão é que o escopo do vocabulário é matéria da federação, não
de cada hospedeira.

### O que a decisão reforça

O BioCultTermos existe, declaradamente, para que os termos das línguas indígenas sejam
protagonistas, **não apêndices subordinados à nomenclatura científica ocidental**. Manter "Nomes
Científicos" como Campo Semântico **par** dos nomes vernaculares — mesma tela, mesmo peso, mesmo
papel de curador — é a equiparação que a premissa recusa.

## Requisitos

### Funcionais

- Uma resposta única, válida para as quatro unidades, sobre o que é e o que não é vocabulário
  controlado da federação.
- O nome científico deve continuar sendo dado de primeira classe onde já é: formulários, validação,
  busca, estatísticas e publicação.
- A associação entre nome tradicional e nome científico deve continuar navegável.
- Nenhum dado existente pode ser perdido pela mudança de escopo.

### Não-Funcionais

- Não introduzir dependência nova em tempo de execução (nenhum cliente de API taxonômica passa a ser
  obrigatório para o módulo funcionar).
- Compatível com o ADR-012 G4: a mudança tem de ser segura para as quatro unidades ao mesmo tempo.

## Opções Consideradas

### Opção 1: Manter o campo e finalmente curá-lo

**Prós:**
- Nenhuma mudança; o vocabulário exibe um índice de espécies.

**Contras:**
- Não há decisão de curadoria legítima a tomar (tabela acima). O trabalho seria transcrição.
- Preserva a superfície de erro: sinonímia afirmada por curador sem autoridade nomenclatural.
- Multiplica-se por unidade — e no BioCultNaturalistas, por uma tabela de táxons inteira.

### Opção 2: Manter o campo como espelho sincronizado de autoridade externa

Importar WFO/GBIF periodicamente para dentro do `etnotermos`, como conceitos de leitura.

**Prós:**
- Resolve a desatualização e elimina a sinonímia inventada.

**Contras:**
- Acrescenta um cliente de API externa, um agendador e uma política de reconciliação ao módulo —
  contra o requisito não-funcional e contra o princípio de simplicidade da federação.
- Continua sendo cópia: o identificador estável já existe do lado de lá, e é dele que se precisa.
- Resolve um problema que ninguém tem: nenhuma unidade pediu um índice taxonômico local.

### Opção 3: Fora do escopo — dado na unidade, autoridade fora, associação no dado

**Prós:**
- Elimina 864 conceitos de dívida e a superfície de erro, sem perder nada que esteja em uso.
- Alinha o vocabulário à sua premissa fundadora.
- Alinha ao Darwin Core, que a federação já adota como referência de interoperabilidade:
  `scientificName` é identidade do táxon, `vernacularName` é atributo **associado**.
- Coerente com o nível 2 da validação prevista em `governanca/propostaGovernanca.md`, que já
  atribui a conferência do nome científico a bases externas (Flora e Funga do Brasil, Fauna do
  Brasil, *fallback* GBIF) — e não ao BioCultTermos.

**Contras:**
- A ponte vernacular ↔ científico perde o alvo *local* de mapeamento SKOS.
  - *Mitigação:* a associação já está gravada no dado de cada unidade, por registro, com a
    proveniência junto. O alvo correto de um `skos:exactMatch` é a URI da autoridade, não um gêmeo
    curado à mão.

**Escolhida.**

## Decisão

Acrescentam-se os pontos N1–N5. **N3 especializa o ADR-007 F5 e corrige a travessia descrita no
ADR-012 G5.**

### N1 — Nomenclatura científica não é vocabulário controlado da federação

O BioCultTermos governa vocabulário cuja autoridade é **cultural ou classificatória interna** —
tipos de comunidade, nomes vernaculares, tipos de uso, atividades econômicas, partes usadas, povos.
**Nomenclatura biológica científica está fora desse escopo, em todas as unidades**, porque sua
autoridade é externa e já constituída: ICN para plantas, fungos e algas; ICZN para animais.

Isto vale para nome científico e para todo o aparato nomenclatural em torno dele — nome aceito,
basiônimo, sinonímia homotípica e heterotípica, autoria, ano, *rank* taxonômico.

### N2 — O nome científico permanece dado de primeira classe da Unidade Hospedeira

N1 delimita o **vocabulário**, não o dado. O nome científico continua obrigatório onde já é, com
formulário, validação, indexação de busca, estatística, exportação e publicação inalterados. Nenhuma
consequência de N1 pode reduzir a captura ou a exibição do nome científico numa unidade.

Em particular, **nada nos ADR-002 e ADR-003 muda**: `species.scientificName` segue no modelo de
dados e no contrato de API.

### N3 — Nenhuma Unidade Hospedeira declara campo de nome científico como campo monitorado

Cláusula de fechamento, e a razão de esta ADR existir. Quando a travessia do `AcquisitionService`
passar a ser configuração declarada pelo hospedeiro (ADR-012 G5), **a configuração de nenhuma unidade
pode incluir um caminho de nome científico**. A restrição é do módulo compartilhado, não de cada
unidade, e vale igualmente para caminhos que já estejam escritos em ADRs de unidade.

Consequências imediatas, com alvo nomeado:

- A lista de campos citada no **ADR-012 G5** perde `nomeCientifico` — o `AcquisitionService` já foi
  corrigido (`BioCultTermos@2bbe950`), e a redação do G5 fica retificada por esta ADR.
- O **contrato V2 do `BioCultNaturalistas/docs/decisions/ADR-003`** perde a linha
  `bcn_taxons → $.nomeCientificoAtual`. Aquela ADR é quem versiona o contrato e **deve** ser revista.
  `$.nomesVernaculares[*].nome` permanece.
- Vale por antecipação para BioCultRelatos e BioCultAcervos, que ainda não declararam contrato.

### N4 — A ponte entre nome tradicional e nome científico é associação no dado, nunca conceito espelho

O vínculo etnotáxon ↔ táxon científico se expressa em duas formas legítimas, nesta ordem:

1. **Co-ocorrência no dado da unidade** — os dois nomes convivem no mesmo registro (no BioCultDB, no
   mesmo objeto `planta`), com a proveniência documental junto. É a forma que já existe e é a que o
   Darwin Core adota.
2. **Mapeamento para identificador externo** — quando houver consumidor real (publicação RDF do
   vocabulário, exportação Darwin Core Archive com extensão *VernacularName*), a forma é um
   `skos:exactMatch`/`closeMatch` para a URI da autoridade, registrado no conceito vernacular.

**Proibida** a terceira forma: criar conceito local de nome científico para servir de alvo de
relação. Era a leitura anterior, e é o que N1 elimina.

A forma 2 **não é construída agora**: não há consumidor, e construí-la antes seria especulação.

### N5 — Os conceitos de nome científico são removidos do vocabulário

A distinção que governa esta cláusula é entre **dado de origem** e **vocabulário derivado**:

| | Natureza | Tratamento |
|---|---|---|
| `biocultdb_records` (e equivalentes por unidade) | **Dado de origem** — o nome científico como a fonte o registrou | **Intocável.** Nunca é lido nem escrito por esta decisão |
| `etnotermos` | **Vocabulário derivado** — conceito SKOS-XL semeado pela aquisição | Reconstruível por uma execução de aquisição; conceito fora de escopo é **removido** |

Remover conceito derivado **não é apagar dado**. Por isso os conceitos SKOS-XL de nome científico —
com seus rótulos, relações e entradas de índice — **saem do `etnotermos`**, e o Campo Semântico
correspondente **desaparece** da interface de curadoria: não é relabelado, não vira "histórico",
não fica no *pulldown*.

Três regras vinculam a execução:

1. **`sourceFields` misto** (nome científico + campo em escopo) → o conceito **sobrevive**; remove-se
   apenas a entrada do campo científico. Ele existe pelo outro campo, e aquele campo continua curado.
2. **Referências órfãs** nos conceitos sobreviventes (`broader`, `narrower`, `related`, `synonym`,
   `synonymFor`, `ancestors`, `replacedBy`) são limpas na mesma transação, com entrada de auditoria
   por conceito alterado. Um vocabulário com ponteiro para conceito inexistente é pior que o conceito.
3. **Backup verificado antes**, e execução seca antes da execução real. A remoção é irreversível
   dentro do banco; o backup é a reversão.

Corolário: reverter N1–N4 significa restaurar o backup e reexecutar a aquisição — não desfazer uma
marcação. É o custo aceito por não manter um vocabulário que ninguém pode curar.

## Relações

- **Especializa o ADR-007 F5** — F5 exigia que tabela-fonte e campos monitorados fossem
  configuráveis; N3 acrescenta que a configuração tem um limite de escopo, e qual é.
- **Retifica o ADR-012 G5** — a travessia descrita em G5 cita `nomeCientifico` entre os campos de
  `plantas[]`. Essa citação passa a estar incorreta; o restante de G5 (Fonte de Atribuição
  `{tipo, nome}`, travessia declarada pelo hospedeiro) permanece integralmente válido.
- **Obriga revisão de `BioCultNaturalistas/docs/decisions/ADR-003` V2** — remoção de
  `$.nomeCientificoAtual` do contrato de campos monitorados.
- **Ratifica o ADR-012 G4** — a adoção da versão que implementa esta decisão é obrigatória e
  assíncrona, como qualquer outra; para as unidades sem build próprio, é escrituração.
- **Não altera o ADR-002 nem o ADR-003** — `scientificName` como dado e como campo de API segue
  inalterado (N2).
- **Coerente com `governanca/propostaGovernanca.md`** — a validação taxonômica (nível 2) já era
  atribuída a bases externas, não ao BioCultTermos. Esta ADR remove a ambiguidade que restava.

## Consequências

### Positivas

- O escopo do vocabulário passa a ter um critério enunciável em uma frase: **a federação cura o que
  só ela pode decidir**. O que uma autoridade global já decide, ela referencia.
- Uma classe inteira de erro deixa de ser possível: sinonímia nomenclatural afirmada por quem não
  tem autoridade nomenclatural.
- O maior bloco de dívida de curadoria do vocabulário desaparece sem custo de dado.
- O risco de reintrodução silenciosa em BioCultNaturalistas — uma tabela de táxons inteira virando
  conceitos candidatos — é eliminado antes de existir.
- A premissa anticolonial do módulo deixa de ser contrariada pela própria lista de campos.

### Negativas

- O vocabulário publicado não oferece índice taxonômico. *Aceito:* nunca ofereceu, e não é o que ele
  se propõe a ser.
- O mapeamento para autoridade externa fica como capacidade **não construída**, com gatilho
  declarado em N4. Até lá, a ponte é a co-ocorrência no dado.
- A remoção é irreversível dentro do banco: desfazer exige restaurar backup e reexecutar a
  aquisição. *Aceito:* o vocabulário derivado é reconstruível, e o dado de origem nunca é tocado.
- Curadoria já feita sobre conceito de nome científico se perde. *Medido antes de executar:* no
  BioCultDB eram 864 conceitos com **zero** rótulos `alt`/`hidden`, **zero** definições e **zero**
  notas de escopo — treze meses sem uma única decisão de curadoria. O único artefato existente era
  uma relação `related` recíproca, e ela estava **errada** (ver Execução abaixo).

### Neutras

- Unidades sem código (BioCultAcervos, BioCultRelatos) absorvem N1–N5 como restrição de projeto
  antes de escreverem a primeira linha — o momento mais barato possível.

## Execução

Executada no BioCultDB (Unidade de Fontes Secundárias) em 2026-08-10, com backup verificado
(`PRAGMA integrity_check` = ok) e execução seca antes da real:

| Medida | Antes | Depois |
|---|---|---|
| Conceitos no `etnotermos` | 2632 | **1768** (−864) |
| Índice FTS | 2632 | **1768** (em sincronia) |
| Conceitos com campo científico | 864 (863 `candidate`, 1 `active`) | **0** |
| `sourceFields` misto | 0 | — |
| Referências órfãs | 1 | **0** |
| Evidências em `biocultdb_records` | 29 | **29** |
| Ocorrências de nome científico no dado de origem | 1827 | **1827** |

**O único artefato de curadoria existente confirmou a decisão em vez de contrariá-la.** Havia uma
relação `related` recíproca entre o conceito vernacular `aroeira` e o conceito científico
`schinus terebinthifolius` — exatamente a "ponte" que a leitura anterior prescrevia. O dado de
origem mostra que ela era falsa: `aroeira`, nas Evidências, corresponde a **dois gêneros distintos**
(*Schinus* e *Myracrodruon*) e a quatro grafias do nome de *Schinus*. A ponte curada afirmava um 1:1
que o dado desmente — a sub-diferenciação etnotaxonômica que a própria documentação já descrevia.
A co-ocorrência no dado (N4, forma 1) é mais verdadeira que o conceito espelho.

O conceito `aroeira` foi preservado, `active`, com a referência órfã limpa e entrada de auditoria
registrada.

## Data de Revisão

Revisitar quando (a) aparecer consumidor real para o mapeamento externo de N4 — publicação RDF do
vocabulário ou exportação Darwin Core Archive; ou (b) a generalização do `AcquisitionService`
(ADR-012 G5) for implementada, para confirmar que a configuração declarada por cada hospedeira
respeita N3.
