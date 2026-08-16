# Rótulos SKOS-XL da Arquitetura BioCultural — Referência Central

> **Documento normativo da arquitetura.** Consolida, num só lugar, todos os rótulos SKOS-XL que a
> arquitetura propõe e usa — tipos, metadados, regras e relações — com exemplos extraídos de
> estudos de caso reais, em especial a curadoria do Campo Semântico **"Tipos de Usos de Plantas"**
> (713 termos → 332 conceitos, executada em produção em 2026-08-07;
> [registro completo](https://github.com/edalcin/BioCultDB/tree/main/docs/curadoria/tipos-de-uso)).
>
> O [Manual de Curadoria do BioCultTermos](https://edalcin.github.io/BioCultTermos/) é o guia
> **didático** para curadores; este documento é a referência **arquitetural**: o que toda unidade
> federada (BioCultDB, BioCultRelatos, BioCultAcervos, BioCultNaturalistas) e o Pluriverso devem
> suportar. Divergência entre os dois resolve-se aqui.

## 1. Por que SKOS-XL, e não SKOS simples

No [SKOS](https://www.w3.org/TR/skos-reference/) comum, o rótulo de um conceito é só uma string.
O **SKOS-XL** (*eXtension for Labels*) promove o rótulo a **recurso de primeira classe**
(`skosxl:Label`), com identidade e metadados próprios. É exatamente o que o conhecimento
tradicional exige: *quem* deu o nome, *em que língua*, e *se ele pode ser divulgado* são
informações tão importantes quanto o nome em si.

Consequência prática: nesta arquitetura, um rótulo nunca é apagado — ele é reclassificado
(alternativo, oculto) preservando proveniência. Na campanha de tipos de uso, **nenhum** dos 713
termos foi excluído: 358 viraram rótulos alternativos, 9 viraram ocultos, e o restante
sobreviveu como conceito ou foi depreciado com substituto declarado.

## 2. Os três tipos de rótulo

| Propriedade | Nome na interface | O que é | Visível ao público? |
|---|---|---|---|
| `skosxl:prefLabel` | **Preferencial** | O nome principal do conceito **num idioma**. Máximo de um por idioma. | Sim — é o que aparece em destaque e ordena a busca |
| `skosxl:altLabel` | **Alternativo** | Outro nome válido para o mesmo conceito: plural, variação regional, sinônimo popular, tradução | Sim |
| `skosxl:hiddenLabel` | **Oculto** | Grafia incorreta ou forma obsoleta que não deve aparecer, mas ajuda a busca a encontrar o conceito | Não — só a busca o vê |

### 2.1 `skosxl:prefLabel` — Preferencial

**Descrição.** A âncora de exibição do conceito num idioma. A regra "um preferencial por idioma"
é **técnica** (a interface precisa de uma string estável por idioma), **não um juízo de valor**:
um `pref/por` e um `pref` numa língua indígena coexistem no mesmo conceito, cada um com seu
estatuto.

**Exemplos reais.** `febre`, `gripe`, `dor no estômago` — cada um o preferencial em `por` do seu
conceito na campanha de tipos de uso.

**Quando não há nome preferido** (comum em nomes vernaculares de plantas): todos os nomes
co-iguais entram como alternativos, elege-se **um** preferencial por critério neutro (convenção da
própria comunidade → frequência nas fontes → ordem alfabética) e a **Nota de Escopo** registra que
a escolha é arbitrária, só para exibição. Nunca deixar o conceito sem preferencial — ele apareceria
como *(sem rótulo)*.

### 2.2 `skosxl:altLabel` — Alternativo

**Descrição.** Nome igualmente válido e visível. É o mecanismo que impede a explosão de conceitos
duplicados: plural, variante de regência, sinônimo popular e **termo em outro idioma** viram
rótulos de um conceito só, nunca conceitos separados.

**Exemplos reais da campanha:**

| Conceito | Rótulos alternativos | Regra aplicada |
|---|---|---|
| `gripe` | `gripes`, `flu` (`eng`), `prevenir a gripe` | plural; tradução; variante |
| `dor no estômago` | `dor de estômago`, `dores estomacais` | variantes de regência/número |
| `diarreia` | `disenteria` | sinônimo popular |
| `dor de cabeça` | `headache` (`eng`) | termo em inglês → alt com `language: eng` (45 casos na campanha) |
| `anti-inflamatório` | `antiinflamatório` | grafia pré-Acordo ainda corrente |

### 2.3 `skosxl:hiddenLabel` — Oculto

**Descrição.** A forma errada continua **buscável** sem ser **exibida**. Quem digitar `diarréia`
encontra `diarreia`; ninguém vê a grafia incorreta na consulta pública.

**Exemplos reais:** `gazes` → oculto de `gases`; `diarréia` → `diarreia`; `hemorróidas` →
`hemorroidas`; `ictéricia` → `icterícia`; `inflamation`, `inflamamtion` → `anti-inflamatório`.
Total da campanha: 9 grafias incorretas preservadas como ocultas, nenhuma apagada.

**Uso especial — termo composto:** um termo que nomeia dois conceitos (`gripe e tosse`) vira
**rótulo oculto nos dois** (`gripe` e `tosse`), preservando a busca pela forma original. 12 casos
na campanha.

## 3. Metadados de cada rótulo

Todo `skosxl:Label` da arquitetura carrega:

| Campo | Obrigatório | Descrição | Exemplo |
|---|---|---|---|
| `literalForm` | sim | A forma textual do rótulo | `jagube` |
| `language` | sim | **ISO 639-3, e só ela** (`por`, `eng`, `kre`, `tup`…) — nunca ISO 639-1 (`pt` não codifica as línguas que o vocabulário existe para abrigar). Sem código: glotônimo por extenso. Conteúdo sem fala: `zxx`; língua não identificada: `und` — nunca vazio | `por` |
| `accessLevel` | sim (padrão `public`) | Nível de acesso CARE do rótulo — ver §4 | `sacred` |
| `sourcePeople` | não | Povo/comunidade de quem vem este nome | `Guarani` |
| `holderPeople` | não | Povo **detentor** do conhecimento (pode diferir de quem forneceu o dado) | `Baniwa` |
| `priorInformedConsent` | não | Consentimento prévio e informado documentado (Protocolo de Nagoya) | `true` |

Estes campos de proveniência são o que diferencia um vocabulário descolonizador de uma lista de
palavras: o nome tradicional carrega sua origem e sua governança.

## 4. Nível de acesso (`accessLevel`) — os Princípios CARE, rótulo por rótulo

| Nível | Significado | Uso típico |
|---|---|---|
| `public` | Aberto para consulta na internet | A maioria dos usos gerais: `febre`, `artesanato`, `madeira` |
| `restricted` | Visível apenas a pesquisadores autorizados | Conhecimento sensível, sob acordo (SisGen/comunidade) |
| `sacred` | Visível apenas à comunidade detentora | Nomes rituais e cerimoniais de acesso reservado |

A classificação é **por rótulo, não por conceito**: o conceito de um uso ritual pode ter o rótulo
em português `public` e o nome cerimonial na língua originária `sacred`. Exemplo concreto do
domínio: o conceito do preparo ritual pode exibir `ayahuasca`/`Daime` publicamente e reservar um
nome cerimonial específico.

O rótulo é **um dos três níveis de rotulagem de acesso** da arquitetura
([ADR-015 K3](architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md)):

| Nível | O que rotula | Padrão de omissão ([K7](architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md)) |
|---|---|---|
| **Termo** (`skosxl:Label`) | a forma textual de um conceito | `public` |
| **Relato** | a proposição atribuída ao detentor | `restricted` |
| **Registro / Mídia** | o registro e o arquivo | `restricted` se regime `conhecimento`; ADR-003 se `evidencia` |

O **nível efetivo é o mais restritivo entre os três**, herança descendente é proibida (registro
público não torna público o rótulo `sacred` que ele contém — o rótulo sai **suprimido, com a
supressão declarada** via `dwc:informationWithheld`,
[ADR-016](architecture-decisions/ADR-016-contrato-de-harvest.md)), e toda classificação tem
**data de revisão obrigatória**.

**Resultado honesto do caso real:** na campanha de tipos de uso, nenhum dos 713 rótulos exigiu
reclassificação — eram termos de literatura, em português e inglês. O CARE deixa de ser teórico no
campo `nomeVernacular` (982 termos crus), onde cada nome tem povo de origem.

> **Não confundir com os rótulos culturais TK/BC Labels** (Local Contexts): aqueles não são
> SKOS-XL — são declarações de autoridade cultural sobre **Conhecimento** (Label, aposto pela
> comunidade) ou **Evidência** (Notice, aposto pela instituição), trafegando no harvest por
> identificador, nunca por texto ([ADR-015 K4](architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md)).

## 5. Relações entre conceitos que os rótulos servem

Os rótulos nomeiam conceitos que se relacionam por:

| Relação | Propriedade | Uso na arquitetura | Exemplo real |
|---|---|---|---|
| Hierarquia | `skos:broader` / `skos:narrower` | árvore navegável por unidade; poli-hierarquia permitida | `dor de cabeça` → `dor` |
| Associação | `skos:related` | conceitos distintos mas associados | `gripe` ↔ `resfriado` |
| Sinonímia entre conceitos | (relação própria "Sinônimo de") | só para reconciliar conceitos **já curados** separadamente, com história própria; senão, prefira um conceito com vários rótulos | nenhum caso nos 713 termos da campanha |
| Mapeamento inter-membros | `skos:exactMatch` / `skos:closeMatch` / `skos:broadMatch` | mantidos **pelo Pluriverso** entre `ConceptScheme`s de membros diferentes — cada unidade é soberana sobre seu vocabulário; a harmonização vive na federação | `arumã` (membro A) `exactMatch` `warumã` (membro B) |

Notas descritivas do conceito (não do rótulo): `skos:definition`, `skos:scopeNote`,
`skos:historyNote`, `skos:editorialNote`, `skos:example` — ver
[Manual, cap. 4](https://edalcin.github.io/BioCultTermos/04-definicao-e-notas.html).

## 6. Campos Semânticos suportados e propostos

Cada unidade federada monitora campos do seu dado de origem e os entrega ao BioCultTermos como
Campos Semânticos (`sourceFields`). Estado atual e propostas:

| Campo Semântico | Unidade de origem | Estado |
|---|---|---|
| Tipos de Usos de Plantas (`comunidades.plantas.tipoUso`) | BioCultDB | **Curado** (2026-08-07): 713 → 332 conceitos, hierarquia de 10 facetas |
| Nomes Vernaculares (`comunidades.plantas.nomeVernacular`) | BioCultDB | 982 termos crus; é onde `accessLevel`, `sourcePeople` e `holderPeople` passam a ser exercidos de fato |
| Tipos de Comunidades (`comunidades.tipo`) | BioCultDB | 29 categorias (Decreto 8.750/2016) |
| Atividades Econômicas (`comunidades.atividadesEconomicas`) | BioCultDB | 36 termos |
| **Papel na composição** (proposto) | todas | Novo campo exigido pelo [ADR-017](architecture-decisions/ADR-017-composicao-multiespecie.md): papéis de cada planta num uso/preparo/artefato composto (`princípio ativo`, `ativador`, `fibra estrutural`, `corante`, `fixador`…) |
| Nomes de preparos e artefatos compostos (proposto) | todas | Conceitos como o do preparo ritual do Santo Daime, com rótulos `Daime` (pref/por), `ayahuasca`, `vegetal`, `hoasca` (alt) — nomes do **composto**, distintos dos nomes de cada planta componente (`jagube`/`cipó`/`mariri` para *Banisteriopsis caapi*; `rainha`/`chacrona`/`folha` para *Psychotria viridis*) |
| Nomenclatura científica | — | **Fora do escopo** do vocabulário por decisão ([ADR-014](architecture-decisions/ADR-014-nomenclatura-cientifica-fora-do-vocabulario.md)): autoridade externa já constituída |

## 7. Regras consolidadas (resumo normativo)

1. **Um `prefLabel` por idioma** por conceito; idiomas diferentes não competem.
2. **Idioma sempre em ISO 639-3**; `zxx` para conteúdo sem fala, `und` para língua não
   identificada; nunca vazio, nunca inferido como português.
3. **Termo em outro idioma é `altLabel`** com `language` daquele idioma, nunca conceito novo.
4. **Grafia incorreta é `hiddenLabel`**, nunca exclusão — a busca continua encontrando.
5. **Termo composto vira `hiddenLabel` nos dois conceitos** que ele nomeia.
6. **`accessLevel` é por rótulo**, padrão `public` para Termo — mude conscientemente; em dúvida
   sobre nome em língua indígena, `restricted` ou `sacred`.
7. **Nível efetivo = o mais restritivo** entre Termo, Relato e Registro; sem herança descendente;
   supressão sempre declarada no harvest.
8. **Proveniência acompanha o rótulo** (`sourcePeople`, `holderPeople`, `priorInformedConsent`).
9. **Preferencial é âncora de exibição, não juízo de valor**; ausência de preferência se registra
   na Nota de Escopo, nunca deixando o conceito sem preferencial.
10. **Mapeamentos entre vocabulários de membros vivem no Pluriverso**, nunca dentro do vocabulário
    soberano de uma unidade.

## 8. Onde cada peça está especificada

| Assunto | Documento |
|---|---|
| Guia didático para curadores | [Manual de Curadoria do BioCultTermos](https://edalcin.github.io/BioCultTermos/), esp. [cap. 3 — Rótulos](https://edalcin.github.io/BioCultTermos/03-rotulos.html) |
| Estudo de caso completo (713 termos) | [`BioCultDB/docs/curadoria/tipos-de-uso/`](https://github.com/edalcin/BioCultDB/tree/main/docs/curadoria/tipos-de-uso) |
| Regime enunciativo e três níveis de rotulagem | [ADR-015](architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md) |
| Nível efetivo e supressão no harvest | [ADR-016](architecture-decisions/ADR-016-contrato-de-harvest.md) · [contrato-harvest.md](contrato-harvest.md) |
| Composição multi-espécie (papéis, nome do composto) | [ADR-017](architecture-decisions/ADR-017-composicao-multiespecie.md) |
| Nomenclatura científica fora do vocabulário | [ADR-014](architecture-decisions/ADR-014-nomenclatura-cientifica-fora-do-vocabulario.md) |
| Padrão W3C | [SKOS-XL Reference](https://www.w3.org/TR/skos-reference/skos-xl.html) |
