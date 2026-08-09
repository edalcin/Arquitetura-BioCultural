# Estratégia de Manutenção do Código do BioCultTermos

**Decisão de origem:** [ADR-012](../architecture-decisions/ADR-012-manutencao-codigo-bioculttermos.md)
· **Runbook operacional:** [fluxo-de-trabalho.md](fluxo-de-trabalho.md)
· **Vocabulário:** [CONTEXT.md](../../CONTEXT.md)

---

## A resposta, em uma frase

> Você mantém o código do BioCultTermos **dentro da Unidade Hospedeira que motivou a mudança** —
> `BioCultDB/bioculttermos/`, `BioCultRelatos/bioculttermos/`, `BioCultNaturalistas/bioculttermos/` ou
> `BioCultAcervos/bioculttermos/` — e **nunca** num clone isolado do BioCultTermos.

A pergunta original oferecia duas opções: os "sub-repositórios" ou o repositório BioCultTermos. A
resposta é a primeira, mas a pergunta continha uma premissa falsa que precisa ser desfeita antes que a
resposta faça sentido.

## A premissa falsa

`BioCultDB/bioculttermos/` **não é um sub-repositório**. É uma **Cópia de Trabalho** do repositório
`github.com/edalcin/BioCultTermos` — o mesmo repositório, o mesmo remoto, o mesmo histórico.

Enquanto o vocabulário disser "sub-repo", a pergunta parece ter duas respostas possíveis, como se
existissem dois lugares onde o código mora. Existe **um** lugar onde o código mora (o remoto
compartilhado) e **quatro** lugares onde ele é editado (uma Cópia de Trabalho por Unidade Hospedeira).

Não há escolha entre "manter no sub-repo" e "manter no BioCultTermos". Manter numa Cópia de Trabalho
**é** manter no BioCultTermos.

## Por que a pergunta apareceu

Havia, na máquina de desenvolvimento, uma quinta cópia que não pertencia a unidade nenhuma:

```
origin/main (github.com/edalcin/BioCultTermos)  = a209b4d
BioCultDB/bioculttermos/  (Cópia de Trabalho)   = a209b4d   ← em dia
D:/git/BioCultTermos/     (clone standalone)    = 24ca993   ← 7 commits atrás
                                                              + CLAUDE.md modificado
                                                              + docs/agents/ não rastreado
```

`24ca993` é ancestral de `a209b4d`: **não houve bifurcação de código**. Houve uma cópia esquecida, que
parecia uma segunda fonte de verdade sem ser uma. Editar ali significaria trabalhar sobre código morto
e, ao tentar publicar, colidir com sete commits de história.

Aquele clone existia por um motivo legítimo e obsoleto: até o ADR-007 F2 (2026-07-22), o BioCultTermos
era um produto standalone com `docker/` próprio. Depois do congelamento, o diretório sobreviveu ao seu
propósito. Ninguém decidiu mantê-lo; ninguém decidiu removê-lo.

**A pergunta "onde eu mantenho o código?" foi, na verdade, o sintoma de uma cópia a mais.**

## As cinco regras

### 1. Uma Cópia de Trabalho por Unidade Hospedeira, e nenhuma fora delas

Clonar o BioCultTermos isoladamente é proibido (ADR-012 G2). Desde o congelamento do produto standalone,
um clone assim não pode ser executado, não pode ser testado, e a única coisa que faz de forma confiável
é envelhecer.

O clone `D:/git/BioCultTermos/` foi removido, depois de transplantados os três artefatos não publicados
que estavam nele.

### 2. Edite na unidade que motivou a mudança

O bug apareceu no BioCultNaturalistas? Edite em `BioCultNaturalistas/bioculttermos/`. A razão é
operacional, não estética: **é o único lugar onde a mudança pode ser executada antes de publicada**.
`docker/docker-compose.unidade.yml` sobe o container dual-app contra o SQLite real da unidade. Editar em
qualquer outro lugar obriga a publicar para descobrir se funciona.

Nenhuma unidade é "a canônica". Não há hierarquia entre unidades federadas (ADR-004 D2).

### 3. Ligue a rede de proteção do git

Ela existe, é nativa, e estava inteiramente desligada. Quatro `git config` globais e uma linha no
`.gitmodules` de cada hospedeiro. Cada uma elimina um modo de falha específico — a tabela está no
[runbook](fluxo-de-trabalho.md#0-uma-vez-por-máquina).

Isso troca disciplina por impedimento. Disciplina já foi testada aqui e produziu o clone de sete commits
atrás.

### 4. Toda unidade adota toda versão — obrigatória e assincronamente

**Isto mudou.** O ADR-007 F3 e o ADR-010 diziam que o bump entre unidades era *opcional*. O ADR-012 G4
supersede esse ponto: é **obrigatório**, mas cada unidade escolhe *quando*, não *se*.

Não é lockstep — BioCultAcervos e BioCultNaturalistas ainda não têm código, e uma unidade em produção
não deve receber automaticamente uma mudança que ela não testou. Mas também não é opcional, porque
ninguém decide bifurcar: um hospedeiro que ficou dezoito commits atrás simplesmente nunca mais é bumpado
de forma casual, e a dívida vira fork de fato.

O que torna isso executável é o **Atraso de Módulo ser visível**:

```powershell
pwsh Arquitetura-BioCultural/bin/termos-status.ps1
```

Enquanto ninguém conseguir responder "quantos commits o Naturalistas está atrás?" sem abrir três
terminais, "obrigatório" e "opcional" são indistinguíveis na prática.

### 5. Todo commit precisa ser seguro para todas as unidades

É a consequência direta da regra 4, e é o preço de um Módulo Compartilhado. Uma correção escrita contra
o schema do BioCultNaturalistas não pode quebrar o BioCultDB em produção com 2536 conceitos.

Na prática isso **proíbe comportamento específico de unidade dentro do módulo** — e o módulo viola essa
regra hoje. Ver [pendência bloqueante](#pendência-bloqueante-fonte-de-atribuição).

## Código e conteúdo: onde fica a fronteira

O princípio fundador desta estratégia:

| | Propaga entre unidades? | Onde vive |
|---|---|---|
| **Código** do Módulo Compartilhado | **Sempre.** Idêntico nas quatro unidades | `github.com/edalcin/BioCultTermos` |
| **Conteúdo Soberano** — termos, rótulos, definições, relações curadas | **Nunca.** Não atravessa | SQLite da própria unidade |

A soberania que a arquitetura protege (ADR-004 D2, princípios CARE) é sobre **dados**, jamais sobre
código. Uma comunidade que roda BioCultRelatos não expõe seu vocabulário a ninguém por rodar o mesmo
código que o BioCultDB: o isolamento é por processo, container e arquivo — não por divergência de
código-fonte.

### Um caso de fronteira, resolvido

`backend/src/data/referenceTerms.js` traz 453 termos de tipo de uso **dentro do código-fonte**. Pelo
princípio acima, conteúdo não propaga — mas este propaga, porque está no código.

**Classificação: é código.** É vocabulário de referência estrutural *da arquitetura*, não conhecimento
que uma comunidade produziu ou curou. A soberania protege o que a comunidade cria; não a lista técnica
de categorias que o sistema oferece como ponto de partida.

*Reversível:* se uma unidade precisar remover ou substituir termos dessa lista, ela deixa de ser código
e vira semente — propagada uma vez, editável localmente depois. Nesse caso a fronteira se move e esta
seção precisa ser reescrita.

## Pendência bloqueante: Fonte de Atribuição

O `AcquisitionService` viola a regra 5 hoje, e isso bloqueia três das quatro unidades.

`collectFieldValues` (`backend/src/services/AcquisitionService.js:47-96`) é uma travessia escrita à mão
da forma documental do BioCultDB:

```
biocultdb_records.doc
  └─ comunidades[]          ← com.nome vira a PROCEDÊNCIA do termo minerado
       ├─ tipo
       ├─ atividadesEconomicas
       └─ plantas[]
            ├─ nomeVernacular
            ├─ tipoUso
            └─ nomeCientifico
```

O ADR-007 F5 descreveu o bloqueio como "tabela-fonte e campos monitorados fixos no código". É maior que
isso. Tornar tabela e campos configuráveis resolve os campos — e não resolve `com.nome`, que não é um
campo colhido, é a **dimensão de atribuição** de cada termo.

E a atribuição não se generaliza por descuido:

| Unidade | Procedência de um termo | Peso |
|---|---|---|
| BioCultDB, BioCultRelatos | **Comunidade Tradicional** (Decreto 8.750/2016) | CLPI, CARE, repartição de benefícios |
| BioCultNaturalistas | Naturalista dos séculos XVII–XIX | Metadado histórico |
| BioCultAcervos | Coleção | Metadado histórico |

Achatar os três num campo genérico de procedência seria **perda irreversível**: uma vez minerados os
termos, não há como recuperar quais vieram de comunidade e quais vieram de fonte histórica sem
reprocessar tudo — e conceito minerado alimenta curadoria, que alimenta o Pluriverso.

**Decisão (ADR-012 G5):** o módulo trata procedência como **Fonte de Atribuição** — `{tipo, nome}` —
onde o `tipo` é declarado pela Unidade Hospedeira (`comunidade_tradicional`, `naturalista`, `colecao`).
Estrutura única, semântica preservada e gravada no dado. A travessia (tabela-fonte, caminhos dos campos,
caminho e tipo da Fonte de Atribuição) passa a ser configuração declarada pelo hospedeiro, não código do
módulo.

Ganho colateral: com o tipo explícito, o BioCultTermos pode exigir curadoria antes de publicar termo de
procedência `comunidade_tradicional` e dispensá-la para `naturalista`. Hoje isso é inexprimível.

**Status:** trabalho de código não feito. Pré-requisito para BioCultRelatos, BioCultNaturalistas e
BioCultAcervos entrarem em produção com o BioCultTermos integrado.

## Decisões adotadas por omissão

Registradas para revisão explícita — foram tomadas pela recomendação, sem confirmação:

| Ponto | Adotado | Onde reverter |
|---|---|---|
| Fonte de Atribuição `{tipo, nome}` em vez de campo genérico | ADR-012 G5 | Refaz G5 e a configuração de travessia |
| `referenceTerms.js` classificado como código | Este documento | Move para semente no SQLite de cada unidade |
| Detecção de atraso por script local, não por CI cross-repo | ADR-012 G4 | Troca `bin/termos-status.ps1` por workflow |
| Visibilidade por referência, não por cópia do documento | ADR-012 G6 | — (copiar reproduz o problema resolvido) |

## O que mudou nas decisões anteriores

- **ADR-007 F3** — a cláusula "bump onde/quando fizer sentido... quando cada uma decidir" foi
  substituída pela adoção obrigatória e assíncrona (ADR-012 G4). O resto de F3 permanece.
- **ADR-010** — a cláusula "bump entre unidades continua opcional" foi substituída pelo mesmo G4. As
  demais obrigações (push ao remoto, `CHANGELOG.md` central, validação de SHA e `BUILD_INFO` no build)
  permanecem e são o mecanismo que torna G4 verificável.
- **ADR-007 F1, F2, F4, F6** — ratificados sem alteração.
