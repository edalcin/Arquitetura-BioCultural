# ADR-012: Manutenção do Código do BioCultTermos — Cópia de Trabalho Única por Unidade e Propagação Obrigatória

## Status

**Aceito** — Agosto 2026

## Contexto

O ADR-007 estabeleceu que o BioCultTermos é um **Módulo Compartilhado**, distribuído via git submodule
e consumido pelas quatro Unidades Hospedeiras (BioCultDB, BioCultRelatos, BioCultNaturalistas,
BioCultAcervos). O ADR-010 fechou duas lacunas expostas na primeira operação real: push obrigatório ao
remoto e registro no `CHANGELOG.md` central.

Um mês depois, com o BioCultDB em produção, uma terceira lacuna apareceu — e ela não é de mecanismo,
é de **higiene de espaço de trabalho**.

### O sintoma medido

Na máquina de desenvolvimento existiam, simultaneamente, duas cópias editáveis do mesmo repositório:

```
origin/main (github.com/edalcin/BioCultTermos)  = a209b4d
BioCultDB/bioculttermos/  (Cópia de Trabalho)   = a209b4d   ← em dia
D:/git/BioCultTermos/     (clone standalone)    = 24ca993   ← 7 commits atrás
                                                              + CLAUDE.md modificado
                                                              + docs/agents/ não rastreado
```

`24ca993` é ancestral de `a209b4d`: não houve bifurcação de código, houve uma **cópia esquecida**.
Mas o efeito prático é o de uma bifurcação. Qualquer edição feita naquele diretório partiria de código
morto, e o trabalho não commitado que estava lá (um `CLAUDE.md` com onze linhas de diferença contra o
remoto e dois arquivos `docs/agents/` inexistentes no remoto) estava a um `rm -rf` de desaparecer sem
deixar rastro.

O clone existia por um motivo legítimo e obsoleto: até o ADR-007 F2 (2026-07-22), o BioCultTermos era
um produto standalone com `docker/` próprio. Depois do congelamento, o diretório sobreviveu ao seu
propósito. **Ninguém decidiu mantê-lo; ninguém decidiu removê-lo.**

### As três lacunas que restavam

1. **Nada dizia onde se edita.** O ADR-007 F3 diz que a mudança "nasce dentro do submodule de alguma
   unidade", mas não proíbe cópias fora de unidade nenhuma. O clone standalone não violava regra alguma
   porque não havia regra.

2. **A rede de proteção nativa do git estava inteiramente desligada.** Verificado em git 2.52:
   `push.recurseSubmodules`, `submodule.recurse` e `status.submoduleSummary` sem valor, e o
   `.gitmodules` do BioCultDB sem `branch`. Todos os erros clássicos de submodule estavam habilitados
   por omissão.

3. **Propagação opcional e atraso invisível.** O ADR-007 F3 e o ADR-010 declaram o bump entre unidades
   *opcional*. O documento de estratégia da federação declara o oposto: *"toda evolução, manutenção ou
   correção feita no código de BioCultTermos deve propagar para as instâncias"*. Duas regras escritas,
   contraditórias, e nenhuma forma de responder "quantos commits o BioCultNaturalistas está atrás?"
   sem abrir três terminais.

## Requisitos

### Funcionais

- Existir uma resposta única e não ambígua para "onde eu edito o código do BioCultTermos?"
- Toda correção feita a partir de qualquer unidade deve chegar a todas as demais.
- O Atraso de Módulo de cada Unidade Hospedeira deve ser consultável em um comando.
- A estratégia deve ser visível a partir de qualquer repositório da federação.

### Não-Funcionais

- Não introduzir dependência nova (registry, serviço, CI cross-repo) — princípio de simplicidade e
  de imagem Docker mínima da federação.
- Preferir mecanismo nativo do git a código próprio.
- Não acoplar o ciclo de deploy de uma unidade ao de outra (restrição herdada do ADR-007 F3).

## Opções Consideradas

### Opção 1: Reabrir o mecanismo de distribuição

Trocar submodule por `git subtree`, pacote npm privado, imagem Docker publicada ou monorepo.

**Prós:**
- Subtree elimina a categoria inteira de erros de submodule.
- Pacote versionado daria vocabulário de versão ("a unidade X está na 2.3").

**Contras:**
- Subtree apaga a rastreabilidade de qual unidade adotou qual versão — exatamente o que o requisito
  de Atraso de Módulo visível precisa.
- Pacote privado acrescenta um registry ao stack, contra o requisito não-funcional.
- Monorepo elimina a soberania por unidade (D2 do ADR-004).
- Custo de migração em quatro repositórios, três dos quais ainda não têm código.

### Opção 2: Manter submodule e resolver por disciplina documentada

Descrever o ritual correto no ADR e segui-lo.

**Prós:**
- Custo zero.

**Contras:**
- Já foi testado tacitamente e produziu o clone de sete commits atrás.
- Disciplina não protege quem edita com pressa, que é exatamente quando o erro acontece.

### Opção 3: Manter submodule, fechar as lacunas com configuração nativa e uma regra de espaço de trabalho

**Prós:**
- Nenhuma migração; o mecanismo em produção continua.
- A maior parte dos modos de falha passa a ser impedida pelo próprio git, não vigiada por humano.
- Único código novo é um leitor de estado somente-leitura.

**Contras:**
- Não impede tudo: configuração de git é por máquina, e uma máquina nova nasce desprotegida.
- O Atraso de Módulo entre repositórios continua exigindo ferramenta própria — git não enxerga
  fora do repositório.

**Escolhida.**

## Decisão

Ratifica-se integralmente o ADR-007 F1, F2, F4 e F6. Acrescentam-se os pontos G1–G6 abaixo, dos quais
**G4 supersede parcialmente o ADR-007 F3 e o ADR-010**.

### G1 — Onde se edita: dentro da Unidade Hospedeira que motivou a mudança

Uma mudança de código do BioCultTermos é editada, commitada e testada dentro da Cópia de Trabalho da
Unidade Hospedeira que a motivou — aquela em que o problema se reproduz ou a funcionalidade se
exercita. Nenhuma unidade é "a canônica". Ratifica e mantém o ADR-007 F3 nesse ponto.

A razão é operacional, não estética: uma Cópia de Trabalho dentro de um hospedeiro **pode ser
executada** (`docker/docker-compose.unidade.yml` sobe o container dual-app contra o SQLite real da
unidade). Editar em qualquer outro lugar é editar às cegas, e obriga a publicar para descobrir se
funciona.

### G2 — Uma Cópia de Trabalho por Unidade Hospedeira, e nenhuma fora delas

**É proibido manter um clone do repositório BioCultTermos fora de uma Unidade Hospedeira.** Desde o
congelamento do produto standalone (ADR-007 F2), um clone assim não tem como ser executado, não tem
como ser testado, e a única coisa que ele faz de forma confiável é envelhecer.

O clone `D:/git/BioCultTermos/` é removido pela execução desta ADR, depois de transplantados para
`BioCultDB/bioculttermos/` os três artefatos não publicados que estavam nele
(`CLAUDE.md`, `docs/agents/domain.md`, `docs/agents/issue-tracker.md`).

Corolário para quem lê o repositório BioCultTermos no GitHub: ele é o remoto compartilhado e o lugar
onde o código *reside*, não um lugar onde se *trabalha*.

### G3 — A rede de proteção nativa do git é parte da configuração de desenvolvimento

Uma vez por máquina de desenvolvimento:

```bash
git config --global push.recurseSubmodules on-demand
git config --global submodule.recurse true
git config --global status.submoduleSummary true
git config --global diff.submodule log
```

E uma vez por Unidade Hospedeira, no `.gitmodules` versionado:

```
[submodule "bioculttermos"]
    path = bioculttermos
    url = https://github.com/edalcin/BioCultTermos.git
    branch = main
```

O que cada uma impede, concretamente:

| Configuração | Modo de falha que deixa de existir |
|---|---|
| `push.recurseSubmodules = on-demand` | Bumpar o ponteiro para um commit que nunca foi publicado — o CI busca um SHA inexistente e a build quebra (bug real registrado no ADR-010) |
| `submodule.recurse = true` | `git pull` no hospedeiro deixar a Cópia de Trabalho parada na versão antiga |
| `status.submoduleSummary = true` | `git status` esconder mudanças do módulo atrás de um `modified: bioculttermos (new commits)` mudo |
| `branch = main` no `.gitmodules` | `git submodule update --remote` não ter alvo declarado, e cada unidade adotar um alvo diferente |

O ritual de edição resultante tem dois comandos, não vigilância:

```bash
git -C <hospedeiro>/bioculttermos pull --ff-only     # antes de editar
# ... editar, testar com docker-compose.unidade.yml, commitar no submodule ...
git -C <hospedeiro> push                             # publica módulo e ponteiro juntos
```

O `--ff-only` é deliberado: se aquela Cópia de Trabalho tiver commits locais esquecidos, ele **falha
em voz alta** em vez de fabricar um merge silencioso.

### G4 — Propagação obrigatória e assíncrona; o Atraso de Módulo é visível

**Supersede o ADR-007 F3 e o ADR-010 no ponto em que declaram o bump entre unidades *opcional*.**

Toda Unidade Hospedeira **deve** adotar toda versão publicada do Módulo Compartilhado. Não
imediatamente, e não em lockstep — mas obrigatoriamente, e com o atraso medido enquanto durar.

Três razões para não ser lockstep e não ser opcional:

- *Lockstep é inexequível hoje*: BioCultAcervos e BioCultNaturalistas não têm uma linha de código.
  Uma regra que só passa a valer quando eles existirem não protege o período de maior risco, que é
  o atual.
- *Opcional é como o atraso vira bifurcação*: ninguém decide bifurcar. Um hospedeiro que ficou
  dezoito commits atrás simplesmente nunca mais é bumpado de forma casual, e a dívida vira fork de
  fato — com todos os custos de um fork e nenhuma das intenções.
- *A restrição original do ADR-007 F3 continua válida e é respeitada*: nenhuma unidade recebe uma
  mudança automaticamente, e nenhuma depende do ciclo de deploy de outra. O que muda é que ficar
  para trás passa a ser um estado com prazo, não uma decisão.

Consequência que precisa ser aceita de olhos abertos: se toda hospedeira adota tudo, então **todo
commit precisa ser seguro para toda hospedeira**. Uma correção escrita contra o schema do
BioCultNaturalistas não pode quebrar o BioCultDB em produção. Isso proíbe, na prática, comportamento
específico de unidade dentro do módulo — o que o ADR-007 F5 já exigia e o G5 abaixo torna executável.

Para tornar o atraso visível sem CI cross-repo, esta ADR cria um leitor de estado somente-leitura,
`bin/termos-status.ps1` neste repositório, que reporta para as quatro unidades: estado operacional,
Versão Adotada, Atraso de Módulo em número de commits, e se a Cópia de Trabalho tem alterações não
publicadas. Ele não altera nada e não tem dependência além de `git`.

**Adoção obrigatória não é carimbo.** Uma unidade só consegue *verificar* a adoção de uma versão nova
se tiver como buildar e executar o módulo — o que o ADR-010 G3 já exige via `Dockerfile.unidade` e
`BUILD_INFO`. As três unidades que hoje só têm documentação carregam a Cópia de Trabalho (G2) mas não
têm como exercitá-la: para elas, o bump é **escrituração**, não adoção verificada, e zerar o atraso
junto com o primeiro build da unidade é o comportamento correto.

Essa distinção é **derivada, não declarada**: o leitor de estado a infere da presença de
`docker/Dockerfile.unidade` no hospedeiro. Não há flag a manter, nada que possa mentir por estar
desatualizado — uma unidade passa a ser cobrada como operacional no instante em que ganha o artefato
que a torna operacional.

### G5 — Fonte de Atribuição: estrutura única, tipo preservado

Especializa o ADR-007 F5 para o bloqueio concreto do `AcquisitionService`.

O bloqueio é maior do que o ADR-007 F5 descreve. Não é apenas "tabela-fonte e campos monitorados
fixos no código": `collectFieldValues` é uma travessia escrita à mão da forma documental do BioCultDB
(`comunidades[] → tipo, atividadesEconomicas, plantas[] → nomeVernacular, tipoUso, nomeCientifico`),
e — o ponto que importa — ela usa `com.nome` como a **dimensão de atribuição** de cada termo minerado.
Tornar tabela e campos configuráveis resolve os campos e não resolve a atribuição.

E a atribuição não é generalizável por descuido. No BioCultDB e no BioCultRelatos, a procedência de um
termo é uma **Comunidade Tradicional** — categoria com definição jurídica (Decreto 8.750/2016) que
invoca CLPI, CARE e repartição de benefícios. No BioCultNaturalistas, é um naturalista dos séculos
XVII a XIX, que não se autorreconhece como nada e não tem consentimento a conceder. No BioCultAcervos,
é uma coleção.

**Decisão:** o módulo passa a tratar procedência como **Fonte de Atribuição**, `{tipo, nome}`, onde o
`tipo` é declarado pela Unidade Hospedeira (`comunidade_tradicional`, `naturalista`, `colecao`).
Estrutura única em todas as unidades; semântica preservada e gravada no dado.

Alternativas descartadas:

- *Achatar tudo num campo de procedência genérico*: perda irreversível. Uma vez minerados os termos
  com a procedência em texto livre, não há como recuperar quais vieram de comunidade e quais vieram
  de fonte histórica sem reprocessar tudo — e conceito minerado alimenta curadoria, que alimenta o
  Pluriverso.
- *Código diferente por unidade*: proibido por G4 e pelo ADR-007 F4.

Ganho colateral: com o tipo explícito, o BioCultTermos pode aplicar regra distinta por tipo — exigir
curadoria antes de publicar termo de procedência `comunidade_tradicional` e dispensá-la para
`naturalista`. Hoje isso é inexprimível.

A travessia em si (tabela-fonte, caminhos dos campos, caminho da Fonte de Atribuição e seu tipo) passa
a ser declarada pela Unidade Hospedeira em configuração, não em código do módulo. Continua sendo
trabalho de código real, pré-requisito bloqueante para BioCultRelatos, BioCultNaturalistas e
BioCultAcervos entrarem em produção com BioCultTermos integrado.

### G6 — Visibilidade: uma decisão central, referenciada por todos

A estratégia completa vive em `docs/gestaoBioCultTermos/` neste repositório, e esta ADR é a decisão de
origem. Cada repositório que hospeda ou é o BioCultTermos carrega, no seu `CLAUDE.md`, uma seção curta
apontando para cá.

Descartadas: replicar o documento em cada repositório (reproduz, um nível acima, exatamente o problema
de cópia envelhecida que esta ADR resolve) e usar submodule de documentação (cerimônia de mecanismo
para ler markdown).

## Relações

- **Supersede parcialmente o ADR-007 F3** — a cláusula "bump onde/quando fizer sentido... quando cada
  uma decidir" é substituída por G4 (adoção obrigatória, assíncrona, com atraso medido). O restante de
  F3 (mudança nasce dentro de uma unidade; sem propagação automática; sem unidade canônica) permanece
  e é ratificado por G1.
- **Supersede parcialmente o ADR-010** — a cláusula "bump entre unidades continua opcional" é
  substituída por G4. As demais obrigações do ADR-010 (push ao remoto, `CHANGELOG.md` central,
  validação de SHA e `BUILD_INFO` antes de buildar) permanecem inalteradas e continuam sendo o
  mecanismo pelo qual G4 é verificável no build.
- **Especializa o ADR-007 F5** — G5 detalha o bloqueio do `AcquisitionService` e decide a forma da
  generalização.
- **Ratifica o ADR-007 F1, F2, F4 e F6** sem alteração.
- **Depende do ADR-005 (DA1)** — a Cópia de Trabalho é executável porque a unidade é um container com
  um arquivo SQLite compartilhado.

## Consequências

### Positivas

- Uma resposta só para "onde eu edito", e ela coincide com o único lugar onde o código pode ser
  executado antes de publicado.
- A classe inteira de erros de submodule (commit não publicado, pull que não desce, status mudo)
  passa a ser impedida pelo git, não vigiada por pessoa.
- O Atraso de Módulo deixa de ser invisível: um comando responde pelas quatro unidades.
- A contradição entre o documento de estratégia e o ADR-007/ADR-010 deixa de existir.
- A distinção entre Comunidade Tradicional e procedência histórica passa a estar gravada no dado, e
  não implícita no repositório em que ele nasceu.

### Negativas

- Configuração de git é por máquina. Uma máquina de desenvolvimento nova nasce sem a rede de proteção.
  - *Mitigação*: o runbook em `docs/gestaoBioCultTermos/fluxo-de-trabalho.md` abre com o bloco de
    configuração, e `bin/termos-status.ps1` reporta quando as chaves não estão definidas.
- G4 aumenta a carga de manutenção: quatro bumps por ciclo em vez de um, e a responsabilidade de
  manter todo commit seguro para todas as unidades.
  - *Mitigação*: é o custo direto de um Módulo Compartilhado. A alternativa não é menos trabalho, é
    trabalho adiado até virar fork.
- G5 é trabalho de código ainda não feito, e bloqueia três unidades.
  - *Mitigação*: nenhuma; é pré-requisito reconhecido desde o ADR-007 F5 e continua sendo o próximo
    item de código do módulo.

## Referências

- [ADR-004: Arquitetura Federada v3.0](ADR-004-federated-architecture.md) — D2, soberania de dados
- [ADR-005: Persistência SQLite com JSON por Unidade Federada](ADR-005-sqlite-json-persistence.md) — DA1
- [ADR-007: Distribuição do Módulo BioCultTermos via Git Submodule Compartilhado](ADR-007-shared-bioculttermos-module.md) — F3 e F5 afetados
- [ADR-010: Documentação Central e Verificação de Build](ADR-010-central-documentation-and-build-verification.md) — cláusula de bump opcional superseded
- `docs/gestaoBioCultTermos/BioCultTermosEstrategia.md` — a estratégia completa
- `docs/gestaoBioCultTermos/fluxo-de-trabalho.md` — o runbook operacional
- `CONTEXT.md` — Módulo Compartilhado, Cópia de Trabalho, Atraso de Módulo, Fonte de Atribuição

## Data de Revisão

Revisar quando a segunda Unidade Hospedeira (BioCultRelatos ou BioCultNaturalistas) entrar em produção
com o BioCultTermos integrado — primeiro momento em que G4 é exercido de verdade e em que o custo de
manter todo commit seguro para todas as unidades passa a ser medível em vez de previsto.
