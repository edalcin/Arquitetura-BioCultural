# ADR-015: Regime Enunciativo e os Três Níveis de Rotulagem de Acesso

## Status

**Proposto** — Agosto 2026. Aguarda decisão sobre os seis pontos de §"O que esta ADR não decide" e validação com comunidades, como o ADR-003 do qual depende.

## Contexto

O CHANGELOG da v3.5.0 registrou, sem resolver, uma pendência de vocabulário de arquitetura:

> "Fica registrada, sem resolver, uma pendência de vocabulário: o termo 'Evidência' foi adotado pelo BioCultDB para o resultado da extração; se o BioCultRelatos usa outro termo para o mesmo conceito, é decisão de vocabulário de arquitetura a cargo do Comitê."
> — `CHANGELOG.md`, v3.5.0, "Contexto da Versão"

Esta ADR responde a essa pendência, e descobre no caminho que ela não era de vocabulário: **os dois provedores não usam termos diferentes para o mesmo conceito; eles guardam conceitos diferentes com o mesmo termo.**

### O sintoma medido

Um vídeo de 42 segundos, `conhecimento/conhecimentoPanara.mp4` (HEVC 1080p, 61,9 MB): um homem Panará, ao lado de uma árvore, descreve a árvore e seus usos **na língua Panará** (ISO 639-3 `kre`). Não há transcrição, tradução, grafia verificada nem CLPI documentado.

Este é o registro que melhor materializa a razão de ser da arquitetura — e **não existe campo para ele em lugar nenhum**:

| Onde deveria caber | O que há hoje |
|---|---|
| `ADR-003:337-338` | `media: []` — comentado como "(futuro)" |
| `ADR-003:110` | `type: "traditional_knowledge"` — constante, não distingue nada |
| `ADR-003:371` | `language: "pt-BR"` — não codifica `kre`; contradiz a regra ISO 639-3 já vigente no BioCultTermos (`manual/03-rotulos.md:44-46`), sob a qual 2601 conceitos foram migrados de `pt` para `por` |
| `dadosEtnoJBRJ_Panara/relatos.md:84-89` | Modelo mais próximo: tem `origem_registro ENUM(…'video'…)`, `id_video`, `conteudo_transcrito`, `idioma ENUM('panara','portugues','bilingue')` — e **nenhum** campo de nível de acesso, consentimento ou detentor |

O modelo que melhor descreve o conhecimento é o que menos o protege. Isso não é descuido de implementação: é consequência de a arquitetura nunca ter declarado o que é conhecimento.

### O achatamento no vocabulário atual

A arquitetura organiza tudo em **um eixo** — a procedência do registro — e chama o conjunto de Evidência:

- `README.md:58` — **"Quatro Fontes de Evidência"**, com o BioCultRelatos entre elas.
- `README.md:52` — "um vasto conjunto de evidências: conhecimentos, práticas e usos documentados…". *Conhecimento* aparece subordinado a *evidência*.
- `CONTEXT.md` (raiz), glossário da federação, 11 termos — **não define nem "Conhecimento" nem "Evidência"**.
- `BioCultDB/CONTEXT.md:12-16` — define Evidência corretamente **e localmente**: "o conteúdo etnobotânico que um artigo científico documentou… Um artigo, uma Evidência". A definição amarra Evidência ao artefato bibliográfico e não se estende a acervo, a obra de naturalista nem a uma fala.

O sentido pretendido de Evidência na arquitetura é mais amplo que o do BioCultDB: **evidência da relação de uma comunidade com a biodiversidade que a cerca**. Mesmo nesse sentido amplo, ele não cobre o vídeo Panará — porque o vídeo não *atesta* a relação, ele **é** a relação sendo enunciada.

### A distinção que falta, e por que não é epistemológica

A tentação é definir a diferença como *fato objetivo* × *afirmação subjetiva*. Essa leitura é rejeitada por esta ADR: ela reintroduziria por via técnica a hierarquia epistêmica que os princípios C.A.R.E. existem para desfazer — precisamente o que `governanca/propostaGovernanca.md:415` já proíbe ao estabelecer que a validação comunitária pode reverter a curadoria científica.

A diferença é **enunciativa e deôntica** — quem fala, e quem tem autoridade sobre o que foi dito:

- **Evidência** — atestação, por um terceiro, de que a relação existe. Terceira pessoa, presa a um artefato, autoridade do artefato e de quem o produziu.
- **Conhecimento** — a mesma relação enunciada por quem a detém. Primeira pessoa, presa a um ato de enunciação, autoridade do detentor e de sua comunidade.

Que a diferença é deôntica, e não epistêmica, se demonstra pelo que ela decide: **quem pode classificar o acesso.** A governança já opera essa distinção sem nomeá-la, em `propostaGovernanca.md:360-375` — a comunidade aplica *Labels*, a instituição só pode declarar *Notices*. Falta a propriedade do dado que determina qual dos dois se aplica.

### Por que o regime é campo do registro, e não propriedade do provedor

A aproximação natural — "Relatos é Conhecimento, os outros três são Evidência" — é correta como padrão, e continua sendo o padrão que esta ADR adota. O que ela não pode ser é **invariante derivada do `member_id`**, por dois motivos.

**Primeiro, há um caso real de Evidência dentro do BioCultRelatos.** A nota de campo em que o pesquisador registra o que observou é testemunho dele, não relato do detentor: falha Q2 do teste de K1. Fosse o regime derivado do provedor, esse registro seria classificado como Conhecimento, e a comunidade apareceria como autoridade sobre uma observação que não é dela.

**Segundo, o regime precisa viajar no payload de qualquer forma** (K6). Derivá-lo do `member_id` obrigaria todo consumidor do harvest a manter uma tabela de tipos de membro para interpretar cada registro — mais acoplamento entre membro e consumidor, não menos, e contra a autonomia de D1/D6 do ADR-004.

#### O caso que **não** é exceção: acervos e a narrativa da comunidade

`propostaGovernanca.md:419` adota a lição dos *Community Records* do Mukurtu: a narrativa da comunidade e a ficha catalográfica do museu coexistem sobre o mesmo item, sem que a institucional sobrescreva a comunitária. O texto diz que "as duas descrições coexistem **no registro**", e essa formulação admite uma leitura que esta ADR **rejeita expressamente**.

A leitura rejeitada é a de que a narrativa da comunidade seria gravada dentro do BioCultAcervos. Ela viola o `Conteúdo Soberano` do `CONTEXT.md` — conteúdo curado por uma unidade "vive no arquivo SQLite daquela unidade, pertence a ela, e **nunca** atravessa para outra". Guardar o Relato da comunidade no SQLite do museu põe o conhecimento dela sob custódia dele: é a soberania invertida, e seria a arquitetura contradizendo em implementação exatamente o que promete em princípio.

A leitura correta:

- O **BioCultAcervos** guarda **Evidência** — o item físico e sua documentação: o material de Spruce na coleção de Kew, a exsicata no herbário do JBRJ, a peça na coleção etnológica.
- A narrativa da comunidade sobre esse item é um **Relato no BioCultRelatos da própria comunidade**, que **referencia** o item do acervo.
- A coexistência das duas narrativas acontece **na federação** — dois registros de dois membros, vinculados e apresentados juntos pelo Pluriverso —, não dentro de um banco. O Mukurtu é honrado e a soberania também.

Isso gera um requisito, registrado aqui e **não resolvido por esta ADR**: o payload de harvest precisa expressar "este registro trata do mesmo objeto que aquele registro de outro membro". O DwC-DP tem `resource-relationship` para exatamente isso, e é o candidato natural. `[a especificar no contrato de harvest]`

**E o acervo histórico que contém a fala de um indígena nomeado** — um cilindro de cera, um caderno de campo em que Spruce cita o informante? O teste de K1 resolve sem exceção: Q4 falha, porque a comunidade não tem hoje autoridade reconhecida e exercível sobre aquele registro. Resultado: `evidencia` com atribuição incompleta, e **Notice**, não Label (K4) — que é precisamente o tratamento que a governança já prescreve para acervos sobre comunidades que nunca foram consultadas. Se e quando a comunidade se manifestar, ela o faz pela sua própria unidade, com o vínculo acima.

Na prática, portanto: **BioCultAcervos, BioCultDB e BioCultNaturalistas são `evidencia` sempre**; o único provedor com os dois regimes é o BioCultRelatos.

### A lacuna técnica: SKOS-XL rotula termos, não proposições

O BioCultTermos adota SKOS-XL porque `skosxl:Label` é recurso de primeira classe e carrega metadados próprios — `accessLevel`, `sourcePeople`, `holderPeople`, `priorInformedConsent` (`manual/03-rotulos.md:52-92`). Isso resolve o nível do **termo**: o nome da árvore em `kre` pode ser `sacred` enquanto o nome em português é `public`, exatamente como `manual/03-rotulos.md:67-68` e `propostaGovernanca.md:429` descrevem.

Não resolve o nível da **proposição**. "Esta árvore serve para isto, segundo este detentor" não é uma entrada de vocabulário; é uma afirmação sobre o mundo, atribuída a alguém. Um vocabulário SKOS não tem, e não deve ter, onde guardá-la. Hoje a arquitetura protege o nome e deixa a proposição a descoberto.

### O contrato de harvest não sabe expressar supressão parcial

`ADR-004:145-148` define o payload como `{id, visibility, updated_at, data}`, e o D6 estabelece que só registros `visibility: public` trafegam. É um booleano. Não há como publicar "este registro é público, mas o rótulo em `kre` foi suprimido por decisão da comunidade" — que é o caso comum, não a exceção.

Isso deixa sem implementação possível uma regra que a governança já adotou (`propostaGovernanca.md:300`): **campo restringido nunca fica nulo**, é substituído por texto explicativo, para que o consumidor saiba que há informação retida e por quê. Do lado do consumidor, hoje, não há campo onde ler esse texto.

## Requisitos

### Funcionais

- Uma resposta única, válida para as quatro unidades, sobre o que é Conhecimento e o que é Evidência, e sobre quem pode classificar o acesso de cada um.
- Um registro sonoro ou audiovisual de fala deve ter representação primária, com língua declarada.
- O nível de acesso deve ser expressável independentemente sobre o termo, sobre a proposição e sobre o registro.
- O consumidor do harvest deve conseguir distinguir "campo inexistente" de "campo retido", e saber por quê.
- Nenhum dado existente pode ser perdido nem reclassificado automaticamente pela adoção desta ADR.

### Não-Funcionais

- Reusar padrões existentes em vez de criar vocabulário novo, onde houver padrão adequado.
- Nenhuma dependência obrigatória de serviço externo em tempo de execução para que uma unidade funcione.
- Compatível com a persistência SQLite+JSON do ADR-005: nada de *triple store* nem SPARQL, coerente com `propostaGovernanca.md:394`, que adota o vocabulário do PROV-O sem adotar a pilha RDF.

## Opções Consideradas

### Opção 1: Manter um eixo só e resolver por convenção de provedor

Documentar que Relatos guarda conhecimento e os demais guardam evidência, sem campo.

**Prós:**
- Custo zero de modelo.

**Contras:**
- Quebra no caso real de Evidência dentro do BioCultRelatos (nota de campo), e obriga todo consumidor do harvest a manter tabela de tipos de membro.
- A regra fica em prosa, não em dado: nenhuma consulta consegue responder "liste todo o Conhecimento de que meu povo é detentor" — que é o requisito de CARE A2 (*Data for governance*).
- Não resolve nada no nível da proposição nem no payload.

### Opção 2: Rotular tudo no `skosxl:Label`

Estender o `accessLevel` do rótulo e considerar o problema resolvido no vocabulário.

**Prós:**
- Mecanismo já existe e está especificado.

**Contras:**
- Erro de categoria: protege nomes, não afirmações. Um enunciado inteiro pode ser restrito sem que nenhum dos seus termos seja.
- Empurra para o vocabulário uma responsabilidade que é do registro, e o vocabulário é compartilhado entre unidades por mapeamento — o que transforma o rótulo em vetor de vazamento, risco que `propostaGovernanca.md:433` já identificou.

### Opção 3: Regime como campo do registro, três níveis de rotulagem, nível efetivo pelo mais restritivo

**Prós:**
- Cobre os dois casos de exceção sem exceção.
- Separa corretamente termo, proposição e registro, dando a cada um o portador adequado.
- Reusa padrões ratificados: `dwc:Assertion` do DwC-DP para a proposição, TK/BC Labels para o protocolo cultural, `dwc:informationWithheld`/`dwc:dataGeneralizations` para a supressão declarada — os três já citados ou adotados pela governança.
- Torna a decisão de acesso consultável por máquina, que é o requisito que originou esta ADR.

**Contras:**
- Acrescenta campos ao ADR-003 e ao contrato de harvest, ambos ainda não implementados por nenhum provedor. *Mitigação:* é o momento mais barato possível — três das quatro unidades não têm código.

**Escolhida.**

## Decisão

Acrescentam-se os pontos **K1–K7**. **K6 supersede o contrato de payload do ADR-004 D6.** K1–K5 e K7 acrescentam ao ADR-003 sem invalidar nada nele.

### K1 — Regime Enunciativo é campo do registro, nunca propriedade do provedor

Todo registro de toda unidade federada declara um **Regime Enunciativo**, com dois valores possíveis: `conhecimento` ou `evidencia`.

O valor é determinado por um teste de quatro perguntas, aplicado na aquisição:

| # | Pergunta | Se **não** |
|---|---|---|
| **Q1** | Existe detentor identificável — pessoa ou coletivo nomeado — a quem esta afirmação é atribuída como **sua**? | `evidencia` |
| **Q2** | Esse detentor é membro da comunidade que detém o conhecimento, e não um observador externo que o descreveu? | `evidencia` |
| **Q3** | Existe ato de enunciação com data, lugar e língua declarados? | `conhecimento` **incompleto** — bloqueia publicação até ser ancorado |
| **Q4** | A comunidade tem, hoje, autoridade reconhecida e exercível para reclassificar ou revogar este registro? | `evidencia` com **atribuição incompleta** (`propostaGovernanca.md:271`) |

Q1 e Q2 decidem o regime; Q3 decide se o registro está completo; Q4 decide Label ou Notice (K4).

Regime **padrão** por unidade, explicitamente sobreponível registro a registro:

| Unidade | Padrão | Exceção legítima |
|---|---|---|
| BioCultRelatos | `conhecimento` | Nota de campo do pesquisador → `evidencia` (falha Q2) |
| BioCultDB | `evidencia` | — |
| BioCultAcervos | `evidencia` | Nenhuma. A narrativa da comunidade sobre um item do acervo é Relato **no BioCultRelatos dela**, referenciando o item — ver Contexto |
| BioCultNaturalistas | `evidencia` | — |

**Evidência não é regime inferior.** Uma obra de 1817 é fonte insubstituível; o que a distingue é ter outro dono. O naturalista que anotou o uso de uma planta não é autor daquele conhecimento — é a testemunha que o registrou, leitura que `propostaGovernanca.md:400` já faz com base na ressalva do art. 45 da Lei 9.610/1998.

### K2 — A unidade de Conhecimento é o Relato

Registro de regime `conhecimento` contém ao menos um **Relato**, com quatro componentes obrigatórios:

1. **Detentor** — pessoa ou coletivo, com sua comunidade. Sem detentor não há Relato; o que há é Evidência.
2. **Ato de enunciação** — data, lugar (com precisão declarada), **língua** e protocolo.
3. **Mídia-fonte** — quando houver gravação, o Relato aponta para ela.
4. **Classificação de acesso** — decidida pela comunidade, com data de revisão (K3, K7).

Um Relato **vive sempre na unidade da comunidade detentora**, nunca na unidade de quem custodia o objeto de que ele fala. Quando se refere a item sob custódia de outro membro — uma exsicata do JBRJ, o material de Spruce em Kew —, o vínculo é uma referência entre registros de membros distintos, resolvida na federação.

O que se modela **não é o conteúdo do conhecimento; é o ato de enunciá-lo, com tudo que o ancora.** Guardar `planta X → uso Y` é a compartimentalização que a crítica antropológica identifica como perda do que tornava aquilo conhecimento. Guardar *quem disse, quando, onde, em que língua, diante de quê, sob que consentimento* preserva o ato.

Em implementação, o Relato mapeia para `dwc:Assertion` do Darwin Core Data Package (guia ratificado TDWG, 2026-04-17), cujas tabelas `*-assertion` — inclusive `media-assertion` — trazem exatamente: `assertionBy` / `assertionByID` (agente responsável, interno ou externo ao dataset), `assertionType` / `assertionValue` com `assertionTypeIRI` / `assertionValueIRI` para vocabulário controlado, `assertionMadeDate`, `assertionProtocol_fk` e a chave para a mídia. O gancho para o BioCultTermos é `assertionValueIRI` + `assertionValueSource`.

**Relato** é a linguagem de domínio; `dwc:Assertion` é a implementação. Os dois nomes permanecem separados: o glossário da federação não importa jargão de padrão. O termo já é o usado pelo projeto — inclusive no modelo de entidade do projeto Panará/JBRJ (`dadosEtnoJBRJ_Panara/relatos.md`), que define Relato como "a menção de uma planta por um participante (ou grupo) em um contexto específico".

### K3 — Três níveis de rotulagem, e o nível efetivo é o mais restritivo

Existem três objetos rotuláveis, cada um com seu portador:

| Nível | Objeto | Portador do `accessLevel` |
|---|---|---|
| **Termo** | `skosxl:Label` — a forma textual de um conceito | `accessLevel` no Label, com `sourcePeople`, `holderPeople`, `priorInformedConsent` (já especificado) |
| **Relato** | a proposição atribuída ao detentor | `accessLevel` no Relato (**novo**) |
| **Registro / Mídia** | o registro e o arquivo | `permissions.visibility` (`ADR-003:343`) e o acesso da mídia (**novo**) |

E a regra que os amarra:

> **O nível de acesso efetivo de qualquer resposta de API é o mais restritivo entre os três níveis envolvidos, e nunca é inferido de cima para baixo.**

Três corolários que só ficam visíveis quando a regra é enunciada:

- Registro `public` contendo rótulo `sacred` **não** é rebaixado a `sacred`, nem publica o rótulo: publica-se o registro **com o rótulo suprimido e a supressão declarada** (K6).
- Rótulo `public` dentro de Relato `restricted`: o nome segue público no vocabulário, o Relato não sai.
- Herança descendente é proibida. Registro público não torna público o que ele contém.

Toda classificação de acesso, em qualquer nível, tem **data de revisão obrigatória** (`permissions.restrictions.reviewDate`, proposto em `propostaGovernanca.md:301`). Restrição imposta em 2026 por motivo específico não sobrevive por inércia a 2040 — e liberação também não.

Permanece integralmente válido o limite mais duro, de `propostaGovernanca.md:286`: **há conhecimento que não deve ser digitado.** Um valor de campo para o sagrado protege contra acesso indevido pelo sistema; não protege contra a existência do registro. Oferecer o campo não substitui dizer, na formação e na consulta prévia, que a decisão correta pode ser não registrar.

### K4 — Label sobre Conhecimento, Notice sobre Evidência

Os rótulos culturais do Local Contexts entram no modelo como campo próprio, **separado de `permissions.license`** — a separação já decidida em `propostaGovernanca.md:377` e agora confirmada empiricamente: a tabela `usage-policy` do DwC-DP, o padrão mais recente de biodiversidade, tem `rights`, `rightsHolder`, `owner`, `license`, `accessRights`, `credit` e **nenhum campo de protocolo cultural**. A lacuna que os TK/BC Labels preenchem é visível na estrutura do padrão.

A regra de quem aplica o quê decorre diretamente de K1:

| Regime | Instrumento | Quem aplica |
|---|---|---|
| `conhecimento` | **TK/BC Label** | A comunidade detentora, e somente ela |
| `evidencia` | **Notice** | A unidade custodiante, enquanto a comunidade não se manifesta |

Quando a comunidade se manifesta sobre um registro de Evidência, a Notice cede lugar ao Label que ela escolher — e o registro passa a ter, sobre o mesmo item, a narrativa institucional e a comunitária, sem que uma sobrescreva a outra (`propostaGovernanca.md:419`).

**O texto das Notices não pode ser alterado.** O identificador do rótulo e o texto canônico são referenciados, nunca editados localmente.

### K5 — Língua do Relato em ISO 639-3, obrigatória; tradução é entidade derivada

Todo Relato declara a língua em que foi proferido, em **ISO 639-3** — a mesma convenção já obrigatória no BioCultTermos (`manual/03-rotulos.md:44-46`), sob a qual 2601 conceitos foram migrados de `pt` para `por`. Onde não houver código, registra-se o glotônimo por extenso (`propostaGovernanca.md:396`). O campo `metadata.language: "pt-BR"` do `ADR-003:371` é retificado por esta cláusula: `pt-BR` não codifica `kre`.

**A língua é constitutiva, não veículo.** É a leitura operacional do sub-princípio **CARE R3 — *For Indigenous languages and worldviews***: um enunciado em `kre` armazenado apenas em português não é o mesmo dado noutra roupa, é um derivado, e a derivação é irreversível.

Daí a cadeia obrigatória, no vocabulário do PROV-O já adotado por `propostaGovernanca.md:394`:

```
gravação        prov:hadPrimarySource  ato-de-enunciação
transcrição     prov:wasDerivedFrom    gravação
tradução        prov:wasDerivedFrom    transcrição
enunciado       prov:wasAttributedTo   detentor
```

Consequência prática: **transcrição e tradução nunca substituem a gravação e nunca são armazenadas sem apontar para ela.** Uma interface que exibe só a tradução exibe um derivado de derivado; deve dizê-lo.

Corolário sobre a mídia: `media` deixa de ser `[]` com comentário "(futuro)" no ADR-003 e passa a ser entidade de primeira classe para registros de regime `conhecimento`, com `language`, duração, formato aberto sem DRM (`propostaGovernanca.md:471`) e armazenamento soberano — o único original de uma gravação nunca reside em plataforma de terceiros.

### K6 — O harvest carrega o nível efetivo e a supressão declarada

O contrato de `ADR-004 D6` é ampliado. O payload mínimo passa a ser:

```json
{
  "id": "<member_id>/<record_id>",
  "regime": "conhecimento | evidencia",
  "accessLevel": "public",
  "informationWithheld": "rótulo em kre suprimido por decisão da comunidade",
  "dataGeneralizations": "coordenada generalizada para 0,1°",
  "culturalLabels": [{ "tipo": "label | notice", "id": "…" }],
  "holderPeople": "…",
  "updated_at": "…",
  "data": { }
}
```

- `regime` e `accessLevel` substituem o booleano implícito de `visibility`. Continua valendo que **só o nível efetivo `public` atravessa o harvest** — o harvest autenticado segue extensão futura não implementada (ADR-009), e `restricted` permanece invisível para a federação até que o Comitê aprove explicitamente o mecanismo (`propostaGovernanca.md:284`).
- `informationWithheld` e `dataGeneralizations` são os termos Darwin Core homônimos, já adotados como regra em `propostaGovernanca.md:300`. São o que torna implementável, do lado do consumidor, a regra de que **campo restringido nunca fica nulo**.
- `culturalLabels` carrega identificador, nunca texto editado (K4).

**Onde a redação acontece:** na **fronteira da API**, e a fronteira é o endpoint de harvest — não a aplicação inteira. O campo restrito é gravado e filtrado na saída.

A alternativa, *redaction at rest* (nunca gravar o campo restrito), oferece proteção maior contra bug e foi **rejeitada** por dois motivos: a perda é irreversível inclusive para a própria comunidade, e contradiz o direito de exportação integral de `propostaGovernanca.md:473`. O risco de bug de filtro é mitigável; a perda de dado não é mitigável por nada. A mitigação é obrigatória: **teste automatizado que falhe se qualquer registro com nível efetivo diferente de `public` atravessar o endpoint de harvest** — condição de aceitação do endpoint em cada unidade.

### K7 — Relato nasce restrito; Termo herda o padrão do vocabulário

Padrões de omissão deliberadamente diferentes por nível:

| Nível | Padrão | Justificativa |
|---|---|---|
| **Termo** (`skosxl:Label`) | `public` | Mantém `manual/03-rotulos.md:72`. Confirmado pela campanha de tipos de uso: dos 713 termos, **nenhum** exigiu reclassificação de `accessLevel` — eram termos de literatura, em português e inglês, sem nome em língua indígena |
| **Relato** | `restricted` | Publicar por omissão o que nunca foi consentido é inaceitável |
| **Registro** de regime `conhecimento` | `restricted` | Idem |
| **Registro** de regime `evidencia` | segue o ADR-003 | Não muda |

Um Relato só se torna `public` por **ato positivo da comunidade** — que é literalmente o estágio 5 do ciclo CLPI de `propostaGovernanca.md:349`, "Classificação de acesso", cujo responsável declarado é a instância de decisão da comunidade e cujo critério de passagem é "camada definida e justificada; data de revisão fixada".

Corolário de conformidade: **nenhum Relato sem CLPI válido atinge nível efetivo `public`**, reafirmando o estágio 6 do mesmo ciclo. `visibility: public` é consequência do CLPI, nunca substituto dele (`propostaGovernanca.md:319`).

## Relações

- **Supersede o contrato de payload do ADR-004 D6** — o registro deixa de ser `{id, visibility, updated_at, data}` e passa ao contrato de K6, especificado campo a campo em [`docs/contrato-harvest.md`](../contrato-harvest.md). O restante do D6 (paginação obrigatória, `updated_since`, identificador estável `member_id` + `record_id`) permanece integralmente válido.
- **Acrescenta ao ADR-003, sem invalidar** — `regime`, entidade `relato`, `media` como primeira classe, `accessLevel` por nível, `reviewDate`. Retifica dois pontos: `metadata.language` migra para ISO 639-3 (K5) e `media: []` deixa de ser "(futuro)" (K5). O ADR-003 está em status **Proposto**; esta ADR entra na mesma rodada de validação com comunidades. Nota de retificação registrada em `ADR-003`, §"1. Registro Principal (Record)".
- **Retifica o ADR-006 E3** — o probe de admissão confere a presença de `visibility` na resposta do endpoint, campo que K6 remove; a conferência passa a ser `member_id`, `id`, `regime` e `accessLevel`. Sem isso, um membro que implemente o contrato vigente falharia o probe. O probe como sinal, nunca gate, permanece.
- **Formaliza `propostaGovernanca.md` §5.5** — a distinção Label/Notice ganha a propriedade do dado que a determina (K1/K4). A governança descrevia a regra; faltava o campo.
- **Implementa `propostaGovernanca.md:300`** — `informationWithheld` e `dataGeneralizations` saem de `[a implementar no modelo de dados]` e entram no contrato de harvest (K6).
- **Implementa `propostaGovernanca.md:429`** — a coexistência de rótulo público em português e rótulo restrito na língua da comunidade passa a ter regra de resolução (K3, a regra do mais restritivo).
- **Coerente com o ADR-014** — mesma lógica de escopo: a federação decide o que só ela pode decidir. O regime enunciativo é decisão que nenhuma autoridade externa toma por ela; a nomenclatura científica é o oposto.
- **Coerente com o ADR-005** — nenhuma pilha RDF é introduzida. PROV-O e Darwin Core entram como vocabulário e como forma de campo JSON, não como *triple store*.
- **Não altera o ADR-007, ADR-012 nem ADR-013** — nada aqui muda distribuição, manutenção ou identidade visual do Módulo Compartilhado.
- **Responde à pendência registrada em `CHANGELOG.md`, v3.5.0, "Contexto da Versão"** — "Evidência" no BioCultDB e o registro do BioCultRelatos não são o mesmo conceito com nomes diferentes; são conceitos diferentes, e agora nomeados.

## Consequências

### Positivas

- O critério de quem pode classificar o acesso passa a ser derivável do dado, e não do provedor onde ele por acaso está.
- O registro sonoro/audiovisual de fala ganha representação primária. O vídeo Panará passa a ter onde existir — com as ausências (transcrição, grafia, CLPI, classificação) **visíveis e bloqueantes** em vez de implícitas num arquivo numa pasta.
- Uma classe inteira de vazamento deixa de ser possível: rótulo sagrado dentro de registro público.
- CARE **A2** (*Data for governance*) ganha implementação: a comunidade pode consultar "todo o Conhecimento de que sou detentora" sem depender de quem digitou.
- CARE **R3** deixa de ser recomendação e vira restrição de esquema: sem língua ISO 639-3, o Relato é incompleto.
- Três das quatro unidades absorvem tudo isto como restrição de projeto **antes da primeira linha de código** — o momento mais barato possível, como no ADR-014.

### Negativas

- O contrato de harvest fica maior e o Pluriverso passa a ter de interpretar nível efetivo em vez de filtrar um booleano. *Aceito:* é o requisito que originou a ADR; um índice que só sabe "público/não público" não consegue exibir por que um campo está ausente.
- O teste do regime (K1) acrescenta atrito na aquisição. *Mitigação:* quatro perguntas, respondidas uma vez por registro, com padrão por unidade já preenchido — o operador confirma ou sobrepõe.
- O termo **Relato** passa a ter dois usos próximos: a unidade de Conhecimento e o nome da unidade hospedeira BioCultRelatos. *Aceito:* a proximidade é coerente — é a unidade que existe para produzir Relatos —, e o glossário distingue os dois verbetes.
- Registros já existentes no BioCultDB (29 Evidências) precisam de valor de `regime`. *Trivial:* padrão `evidencia`, correto para todos por construção da unidade.

### Neutras

- Nenhum dado é reclassificado automaticamente. `accessLevel` mais restritivo por omissão vale para **Relato novo**; nada que hoje está publicado muda de nível por efeito desta ADR.

## O que esta ADR não decide

Seis pontos permanecem abertos e devem ser resolvidos antes da mudança de status para *Aceito*. Estão registrados aqui, com recomendação, para que a ausência de decisão seja visível em vez de presumida.

| # | Questão | Recomendação |
|---|---|---|
| **Q1** | O regime entra no glossário da federação (`CONTEXT.md` raiz) ou fica interno a cada unidade? | **Federação.** Se determina o que trafega no harvest, é linguagem da federação por definição. Deixá-lo interno reproduz o problema atual, em que "Evidência" só existe no `BioCultDB/CONTEXT.md` |
| **Q2** | ~~"Enunciado" é o nome certo?~~ | **Decidido em 2026-08-13: o termo é `Relato`**, já usado pelo projeto e pelo modelo Panará. Descartados *Enunciado* (pouco usual), *Asserção* (jargão de padrão dentro do domínio), *Depoimento* (carga jurídico-policial) |
| **Q3** | Como identificar o detentor sem expor a pessoa? | Tensão real entre `assertionByID` (quer identificador estável) e LGPD. Opções: (a) identificador interno + `anonymized: true`, exposto só como papel; (b) atribuição exclusivamente coletiva no que for público; (c) **pseudônimo escolhido pelo próprio detentor** — a única que respeita simultaneamente CARE A1 e o direito ao reconhecimento, e a única que exige perguntar à pessoa |
| **Q4** | Adotar a API do Local Contexts Hub ou espelhar os rótulos localmente? | Adotar mantém a autoridade com a comunidade e cria dependência externa; espelhar inverte. **Meio-termo:** armazenar o identificador do rótulo e do projeto, exibir o texto canônico com cache, nunca editar o texto |
| **Q5** | Que vocabulário controlado usar em `assertionType`? | Fora do escopo desta ADR; é campo do BioCultTermos e matéria do Comitê |
| **Q6** | O vídeo Panará, concretamente | Antes de qualquer implementação: localizar ou formalizar o CLPI, obter transcrição em `kre` com falante nativo, verificar grafia com pesquisadores Panará (`dadosEtnoJBRJ_Panara/docs/esclarecer.md`), e perguntar à comunidade o nível de acesso. Até lá, `restricted` de fato |

## Referências

- `conhecimento/caracterizacao-do-conhecimento-tradicional.md` — estudo que originou esta ADR, com a pesquisa completa e as fontes
- `docs/contrato-harvest.md` — contrato de payload do harvest, campo a campo, decorrente de K6
- `governanca/propostaGovernanca.md` §5.1–§5.10 — titularidade, camadas de acesso, CLPI como ciclo, rotulagem cultural, proveniência, vocabulários sensíveis
- `BioCultDB/bioculttermos/manual/03-rotulos.md` — `accessLevel`, `sourcePeople`, `holderPeople`, ISO 639-3
- `dadosEtnoJBRJ_Panara/relatos.md` — modelo de entidade `relato` do projeto Panará/JBRJ
- Darwin Core Data Package guide, TDWG, 2026-04-17 — <https://dwc.tdwg.org/dp/>; tabelas `*-assertion` e `usage-policy` em <https://github.com/gbif/dwc-dp/tree/master/dwc-dp/table-schemas>
- Darwin Core, `informationWithheld` e `dataGeneralizations` — <https://dwc.tdwg.org/terms/>
- W3C PROV-O — <https://www.w3.org/TR/prov-o/>
- W3C SKOS Reference §5 (SKOS-XL) — <https://www.w3.org/TR/skos-reference/#xl>
- Local Contexts — TK Labels <https://localcontexts.org/labels/traditional-knowledge-labels/>; BC Labels <https://localcontexts.org/labels/biocultural-labels/>; Hub <https://localcontextshub.org/>
- CARE Principles for Indigenous Data Governance, GIDA — <https://www.gida-global.org/careprinciples>
- ISO 639-3 `kre` (Panará) — <https://iso639-3.sil.org/code/kre>; solicitação 2006-019, que trocou a *reference name* de `Kreen-Akarore` para `Panará` em 2007 — <https://iso639-3.sil.org/request/2006-019>

## Data de Revisão

Revisitar quando (a) as seis questões abertas forem decididas, para promoção a *Aceito*; (b) o ADR-003 for validado com comunidades, já que esta ADR depende dele; ou (c) o piloto de TK/BC Labels do *Task Group on Indigenous Data Governance* do GBIF (`propostaGovernanca.md:379`) publicar resultado que contradiga K4 ou K6.
