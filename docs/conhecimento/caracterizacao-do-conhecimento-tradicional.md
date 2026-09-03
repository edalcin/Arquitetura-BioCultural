# Caracterização do "Conhecimento Tradicional" na Arquitetura BioCultural

**Data:** 2026-08-13
**Escopo:** distinção conceitual entre *Conhecimento* e *Evidência*, e suas consequências para a aplicação de rótulos SKOS-XL de nível de acesso (`public` / `restricted` / `sacred`), para humanos e para máquinas.
**Caso-teste:** o estudo de caso do BioCultRelatos — mestrado de Luisa Ridolph Tostes Braga, "O Uso de Plantas Medicinais e os Saberes Locais em Quintais de Silveiras (SP): diante de desafios climáticos e socioeconômicos no entorno da Serra da Bocaina" (`docs/projetoPesquisa.md` §7.3)
**Status:** documento de discussão — não é decisão. Contém pontos que exigem escolha do responsável pela arquitetura (§12).

---

## 1. Prompt original

> Quero discutir, em `conhecimento/`, a caracterização do "conhecimento tradicional" na arquitetura.
>
> O conceito de "conhecimento" deve ficar claro e caracterizado na arquitetura, pois é ele que deve receber rótulos específicos SKOS-XL relacionados com nível de acesso (public, restrict e sacred, conforme em `../BioCultDB/bioculttermos/manual/03-rotulos.md`), não só para humanos, na interface, como para máquinas (fluxo de dados entre provedores — BioCultDB, BioCultAcervos, BioCultRelatos, BioCultNaturalistas).
>
> Penso que "evidência", como o registrado em BioCult{Acervos, DB e Naturalistas} é diferente do "conhecimento", explicitamente expresso em BioCultRelatos.
>
> Faça uma pesquisa cuidadosa e profunda nos conceitos e visões sobre o tema, sempre relacionado ao "conhecimento tradicional" e reporte em `conhecimento/`, em um arquivo no formato .md, juntamente com este prompt.
>
> Considere como reconhecer, caracterizar ou diferenciar explicitamente o "conhecimento tradicional" na arquitetura, para aplicação precisa de rótulos no padrão SKOS-XL, respeitando todos os princípios C.A.R.E. e considerando toda a proposta da arquitetura, até agora.

*Paráfrase.* O prompt original ilustrava a distinção Evidência/Conhecimento com um registro específico que não faz parte desta proposta e foi removido da citação acima; a pergunta conceitual — evidência é diferente de conhecimento — permanece intacta.

**Esclarecimento (sobre o sentido de "Evidência"):**

> A "Evidência" que me refiro, e de que trata a arquitetura, é a "evidência da relação de uma comunidade com a biodiversidade que a cerca".

---

## 2. Tese

A arquitetura hoje organiza tudo em **um eixo**: a procedência do registro (secundária, primária, acervo, obra de naturalista). Sobre esse eixo, `README.md:58` nomeia as **"Quatro Fontes de Evidência"** e inclui o BioCultRelatos entre elas. O vocabulário é consistente e a intenção é clara — mas ele **achata** uma diferença que a governança já pressupõe em vários pontos e nunca declara.

A proposta deste documento é acrescentar um **segundo eixo, ortogonal ao primeiro**:

| Eixo | Pergunta que responde | Estado hoje |
|---|---|---|
| **Procedência** | De onde veio este registro? | Definido e implementado (quatro provedores) |
| **Regime enunciativo** | *Quem fala* neste registro, e com que autoridade? | **Ausente** |

O segundo eixo tem dois valores:

- **Evidência** — a atestação, por um terceiro, de que a relação entre uma comunidade e a biodiversidade **existe**. Fala em terceira pessoa, está presa a um artefato (um artigo, um tombo de museu, uma página de obra do século XVIII) e sua autoridade é a do artefato e de quem o produziu.
- **Conhecimento** — essa mesma relação **enunciada por quem a detém**. Fala em primeira pessoa, está presa a um ato de enunciação (uma fala, uma demonstração, uma oficina) e sua autoridade é a do detentor e da sua comunidade.

**O que decide a governança é o segundo eixo, não o primeiro.** É a diferença entre poder aplicar um *Label* (só a comunidade pode) e só poder declarar um *Notice* (o que resta à instituição enquanto a comunidade não se manifesta) — distinção que a `propostaGovernanca.md:360-375` já adota, sem nunca ter dado nome à propriedade do dado que a determina.

---

## 3. Quatro critérios do que é Conhecimento

A distinção entre Conhecimento e Evidência não depende de julgamento subjetivo caso a caso: um Relato primário é reconhecível por quatro critérios simultâneos, e nenhum deles é acessório.

1. **Primeira pessoa.** Não é um terceiro dizendo que a comunidade usa a planta; é quem detém o conhecimento dizendo para que ela serve.
2. **Língua originária.** O enunciado está na língua da comunidade, identificada por código ISO 639-3 — nunca ISO 639-1 —, com `zxx` para conteúdo sem fala e `und` para língua não identificada. Não existe versão "sem língua" desse conhecimento — a tradução é uma entidade *derivada*, e derivada com perda.
3. **Referente físico presente, quando houver.** Se há uma planta, um lugar, um objeto, o gesto de apontar é parte do enunciado; sem o registro que o ancora, o referente se perde.
4. **Ato datado e localizado.** Houve um momento e um lugar. O conhecimento não paira: ele foi *dito*.

**E hoje ele não cabe em lugar nenhum da arquitetura.** `ADR-003-data-model.md:337-338`:

```javascript
// Vídeos, áudios, etc. (futuro)
media: [],
```

O único campo que aceitaria o registro primário do BioCultRelatos é um array vazio com um comentário — sem nenhum campo de nível de acesso, consentimento ou detentor. É exatamente essa lacuna que o estudo de caso de Silveiras (SP) — mestrado de Luisa Ridolph Tostes Braga, `docs/projetoPesquisa.md` §7.3 — torna concreta: entrevistas semiestruturadas sob TCLE, com dado sociodemográfico do participante sob LGPD convivendo com titularidade coletiva do CTA, exigem uma modelagem de detentor, consentimento e nível de acesso que o modelo atual não oferece.

> **Nota lateral, mas de governança** (caso geral da arquitetura, para quando houver gravação audiovisual). O `.gitignore` deste repositório passou a excluir `*.mp4` nesta mesma sessão. A motivação foi tamanho, mas o efeito é correto por outra razão, e ela está escrita em `propostaGovernanca.md:471`: nenhuma unidade pode manter o único original de uma gravação de CLPI em plataforma de terceiros. Um remoto público do GitHub é plataforma de terceiros. Voz e imagem de pessoa identificável associada a etnia são dado pessoal sensível (LGPD, art. 11) e o consentimento para a gravação precisa ser específico e destacado (LGPD, art. 11, I) — ponto que a `propostaGovernanca.md:317` já detalha como "tríplice regime do registro audiovisual".

---

## 4. Onde a arquitetura hoje é ambígua

Levantamento com caminho e linha. Não são erros: são consequências de nunca ter existido o segundo eixo.

| # | Onde | O que diz | Por que é ambíguo |
|---|---|---|---|
| 1 | `README.md:58-65` | "Quatro Fontes de Evidência", com BioCultRelatos entre elas | Trata a fala do detentor e a página do naturalista como o mesmo tipo de coisa |
| 2 | `README.md:52` | "vasto conjunto de evidências: conhecimentos, práticas e usos documentados…" | Subordina explicitamente *conhecimento* a *evidência* |
| 3 | `CONTEXT.md` (raiz) | Glossário da federação — 11 termos | **Não define nem "Conhecimento" nem "Evidência"** |
| 4 | `BioCultDB/CONTEXT.md:12-16` | "**Evidência**: o conteúdo etnobotânico que um artigo científico documentou… Um artigo, uma Evidência" | Definição correta **e local**: amarra Evidência ao artefato bibliográfico. Não se estende a acervo, naturalista nem fala |
| 5 | `ADR-003-data-model.md:110` | `type: "traditional_knowledge", // Fixo por enquanto` | O único campo de tipo do modelo é constante — não distingue nada |
| 6 | `ADR-003-data-model.md:337-338` | `media: []` — "(futuro)" | Sem lugar para áudio/vídeo, o Conhecimento oral não tem representação primária |
| 7 | `ADR-003-data-model.md:371` | `language: "pt-BR"` | Contradiz a regra já vigente no BioCultTermos: **ISO 639-3 e só ela** (`bioculttermos/manual/03-rotulos.md:44-46`), sob a qual 2601 conceitos foram migrados de `pt` para `por`. `pt-BR` não codifica língua indígena sem código ISO 639-1 (ex.: `tup`) |
| 8 | `ADR-004…md:145-148` | Payload de harvest: `{id, visibility, updated_at, data}` | `visibility` é binário na prática (só `public` trafega) e `data` é indefinido. Não há como dizer "público, mas com o nome na língua da comunidade suprimido" |
| 9 | `propostaGovernanca.md:419` | Mukurtu *Community Records*: narrativa comunitária e institucional coexistem sobre o mesmo item — "as duas descrições coexistem **no registro**" | A formulação admite a leitura de que a narrativa da comunidade ficaria gravada dentro do BioCultAcervos, o que violaria `Conteúdo Soberano`. Falta dizer que a coexistência é **federada** — dois registros de dois membros, vinculados —, não intra-unidade |
| 10 | `propostaGovernanca.md:429` | "um mesmo conceito pode ter rótulo público em português e rótulo restrito na língua da comunidade" | Regra correta e ainda `[a implementar]`; hoje o `accessLevel` do BioCultTermos existe no manual, não no fluxo federado |

---

## 5. O eixo é a voz, não o fato

A tentação natural é definir a distinção como *fato objetivo* × *afirmação subjetiva*. **Isso está errado e é perigoso**, porque reintroduz por via técnica a hierarquia epistêmica que os princípios C.A.R.E. existem para desfazer — precisamente o que `propostaGovernanca.md:415` já proíbe ao estabelecer que a validação comunitária pode reverter a curadoria científica.

O eixo correto é **enunciativo e deôntico**: quem fala, e quem tem autoridade sobre o que foi dito.

**O que a literatura sustenta.** A crítica antropológica consolidada é convergente e vem de três direções:

- **Berkes** define conhecimento ecológico tradicional como um *knowledge–practice–belief complex* — cumulativo, transmitido culturalmente e inseparável da prática e da cosmologia que o sustentam. Não é um conjunto de proposições destacáveis.
- **Nadasdy** documenta o que chama de *compartimentalização*: o processo pelo qual o conhecimento indígena, para ser aceito em sistemas de gestão estatal, é destilado em unidades de dado descontextualizadas — e nessa destilação perde exatamente o que o tornava conhecimento, ao mesmo tempo em que reproduz a relação colonial que dizia superar.
- **Agrawal** desmonta a dicotomia rígida indígena/científico e alerta para o efeito da arquivização: retirado do contexto de sua prática, o conhecimento vira mercadoria informacional.
- **Ellen & Harris** insistem no caráter *situado* — o conhecimento é performado, não estocado.

A consequência para modelagem não é "não modele". É: **o que se modela não é o conteúdo do conhecimento, é o ato de enunciá-lo, com tudo que o ancora.** Um sistema que guarda `planta X → uso Y` fez compartimentalização. Um sistema que guarda `no dia D, no local L, na língua da comunidade (código ISO 639-3), o detentor P, diante do referente do relato, disse isto (mídia M, quando houver), e sua comunidade C classificou como público` guardou um Relato.

**A língua é constitutiva, não veículo.** É por isso que o sub-princípio **R3 do CARE — *For Indigenous languages and worldviews*** — não é um item de acessibilidade: é uma condição de integridade do dado. Um enunciado na língua originária da comunidade, traduzido para `por` e armazenado só em `por`, não é o mesmo dado com outra roupa; é uma entidade derivada, e a derivação é irreversível. Daí a regra prática de documentação linguística que este documento adota: **transcrição e tradução nunca substituem a gravação, e nunca se armazenam sem apontar para ela.**

**Evidência não é inferior.** Uma obra de 1817 é fonte insubstituível. O ponto é que ela é *testemunho*, e testemunho tem outro dono: o naturalista europeu que anotou o uso de uma planta não é autor daquele conhecimento, é a testemunha que o registrou — leitura que `propostaGovernanca.md:400` já faz, com a ressalva do art. 45 da Lei 9.610/1998, que preserva "a proteção legal aos conhecimentos étnicos e tradicionais" mesmo em obra de domínio público.

---

## 6. Definições propostas para o glossário da federação

Para inclusão em `CONTEXT.md` (raiz), na seção **Vocabulário e procedência**. Seguem a convenção do arquivo, inclusive a lista `_Avoid_`.

> **Conhecimento**:
> A relação de uma Comunidade Tradicional com a biodiversidade **enunciada por quem a detém**. Existe sempre como um Relato: um ato de fala ou de demonstração, datado, localizado, numa língua declarada, atribuído a um detentor individual ou coletivo. Sua autoridade é a da comunidade detentora, que pode reclassificá-lo ou revogá-lo a qualquer tempo, sem justificativa.
> _Avoid_: Saber, Informação, Dado etnobotânico, Conteúdo
>
> **Evidência**:
> A **atestação, por um terceiro**, de que a relação entre uma Comunidade Tradicional e a biodiversidade existe. Está sempre presa a um artefato — artigo, item de acervo, obra de naturalista — e sua autoridade é a do artefato e de quem o produziu. Documenta o Conhecimento sem ser o Conhecimento.
> _Avoid_: Registro, Record, Referência, Fonte (é a procedência, não a evidência)
>
> **Relato**:
> A unidade de Conhecimento. Um Relato tem, obrigatoriamente: um detentor (pessoa ou coletivo), um ato de enunciação (quando, onde, em que língua, sob que protocolo), uma mídia-fonte quando houver gravação, e uma classificação de acesso decidida pela comunidade. Um Relato nunca existe sem detentor; sem detentor, o que existe é Evidência. Vive sempre na unidade da comunidade detentora — nunca na unidade de quem custodia o objeto de que ele fala.
> _Avoid_: Enunciado, Asserção (jargão de implementação), Fato, Afirmação, Depoimento
>
> **Regime Enunciativo**:
> A propriedade de todo registro da federação que declara se ele é Conhecimento ou Evidência. É ortogonal à Fonte de Atribuição e à procedência: determina **quem pode classificar o acesso** daquele registro, e portanto se a unidade pode aplicar um Label (Conhecimento) ou apenas um Notice (Evidência).
> _Avoid_: Tipo de registro, Categoria, Natureza

O termo **Relato** é a linguagem de domínio; a implementação mapeia para `dwc:Assertion` (§9). Manter os dois nomes separados é deliberado: o glossário não deve importar jargão de padrão. **Decidido em 2026-08-13**, em favor de *Relato* contra *Enunciado*: é a palavra que o projeto já usa, coerente com o nome da própria unidade que existe para produzi-los (BioCultRe*latos*).

---

## 7. Como reconhecer: o teste das quatro perguntas

Operacionaliza a distinção sem depender de julgamento caso a caso. É aplicado no momento da aquisição, por quem digita ou pelo formulário.

| # | Pergunta | Se **não** |
|---|---|---|
| **Q1** | Existe um detentor identificável — pessoa ou coletivo nomeado — a quem esta afirmação é atribuída como **sua**? | → **Evidência** |
| **Q2** | Esse detentor é membro da comunidade que detém o conhecimento (e não um observador externo que o descreveu)? | → **Evidência** |
| **Q3** | Existe um ato de enunciação com data, lugar e língua declarados? | → **Relato incompleto**: bloqueia publicação até ser ancorado |
| **Q4** | A comunidade tem, hoje, autoridade reconhecida e exercível para reclassificar ou revogar este registro? | → **Evidência com atribuição incompleta** (`propostaGovernanca.md:271`) |

**Q1 e Q2 decidem o regime. Q3 decide se o Relato está completo. Q4 decide Label ou Notice.**

O resultado esperado por provedor — **como padrão, não como invariante**:

| Provedor | Regime padrão | Exceção real, já prevista |
|---|---|---|
| BioCultRelatos | Conhecimento | Nota de campo do pesquisador sobre o que observou é **Evidência** produzida dentro do Relatos — Q2 falha |
| BioCultDB | Evidência | — |
| BioCultAcervos | Evidência | **Nenhuma** — ver a nota abaixo |
| BioCultNaturalistas | Evidência | — |

> **Correção de 2026-08-13.** Uma versão anterior desta tabela dava o *Community Record* como exceção do BioCultAcervos: a comunidade gravaria um relato sobre um item do acervo, e esse relato seria Conhecimento dentro do Acervos. **Está errado.** O BioCultAcervos guarda evidência física custodiada por instituições — o material de Spruce na coleção de Kew, a exsicata no herbário do JBRJ, a peça na coleção etnológica. A narrativa da comunidade sobre esse item é um **Relato no BioCultRelatos da própria comunidade**, que *referencia* o item do acervo. Gravá-la no SQLite do museu violaria `Conteúdo Soberano` (`CONTEXT.md`): poria o conhecimento da comunidade sob custódia de outra unidade — soberania invertida. A coexistência das duas narrativas, que é a lição correta do Mukurtu, acontece **na federação**: dois registros de dois membros, vinculados e apresentados juntos pelo Pluriverso. Isso gera um requisito novo, ainda não especificado: o payload de harvest precisa expressar "este registro trata do mesmo objeto que aquele registro de outro membro" — o DwC-DP tem `resource-relationship` para exatamente isso.
>
> E o acervo histórico que contém a fala de um indígena nomeado — um cilindro de cera, um caderno em que Spruce cita o informante? O teste resolve sem exceção: **Q4 falha**, porque a comunidade não tem hoje autoridade exercível sobre aquele registro. Resultado: Evidência com atribuição incompleta, e Notice, não Label.

**O regime continua sendo campo do registro, e não propriedade do provedor** — por dois motivos, agora mais modestos que na primeira redação: existe um caso real de Evidência dentro do BioCultRelatos (a nota de campo do pesquisador, que falha Q2), e o `regime` precisa viajar no payload de qualquer forma, de modo que derivá-lo do `member_id` obrigaria todo consumidor a manter uma tabela de tipos de membro. Na prática: **BioCultAcervos, BioCultDB e BioCultNaturalistas são Evidência sempre**; o único provedor com os dois regimes é o BioCultRelatos.

---

## 8. Os três níveis de rotulagem — e por que SKOS-XL sozinho não basta

Aqui está o ponto técnico mais importante do documento.

**SKOS-XL rotula termos. Conhecimento tradicional é proposição.** `skosxl:Label` é o portador certo para "o nome desta planta na língua da comunidade". Ele não é, e não pode ser, o portador de "*esta* planta serve para *isto*, segundo *este* detentor". A primeira é uma entrada de vocabulário; a segunda é um enunciado sobre o mundo. Aplicar `accessLevel` só no rótulo protege o nome e deixa a proposição a descoberto.

Existem, portanto, **três objetos rotuláveis**, e cada um precisa do seu campo:

| Nível | Objeto | Exemplo ilustrativo | Portador do `accessLevel` | Estado |
|---|---|---|---|---|
| **1. Termo** | `skosxl:Label` — a forma textual de um conceito | o nome popular de uma planta na língua da comunidade | `accessLevel` no Label + `sourcePeople`, `holderPeople`, `priorInformedConsent` | Especificado no manual (`03-rotulos.md:52-92`); **não trafega no fluxo federado** |
| **2. Relato** | a proposição atribuída ao detentor | "esta planta serve para X" | **campo inexistente** | **Lacuna central** |
| **3. Registro / Mídia** | o registro que embala tudo, com ou sem mídia associada | `comunidade-exemplo/rec-0042` | `permissions.visibility` (`ADR-003:343`) | Especificado, **não implementado em nenhum provedor** |

E a regra que amarra os três:

> **O nível de acesso efetivo de qualquer resposta da API é o mais restritivo entre os três níveis envolvidos — e nunca é inferido de cima para baixo.**

Consequências que só aparecem quando se enuncia a regra:

- Um registro `public` pode conter um rótulo `sacred`. A resposta correta **não** é rebaixar o registro para `sacred`, nem publicar o rótulo: é publicar o registro **com o rótulo suprimido e a supressão declarada**.
- Um rótulo `public` (o nome em português) pode aparecer num Relato `restricted`. O nome continua público no vocabulário; o Relato não sai.
- O par `public` no registro + `sacred` no rótulo é o caso comum, não a exceção: é exatamente o exemplo que `03-rotulos.md:67-68` e `propostaGovernanca.md:429` já descrevem.

**Para máquinas, isso significa que `visibility: public` no payload de harvest é insuficiente.** O contrato de `ADR-004…md:145-148` só sabe dizer sim ou não para o registro inteiro. Precisa carregar, no mínimo:

```json
{
  "id": "<member_id>/<record_id>",
  "regime": "conhecimento",
  "accessLevel": "public",
  "informationWithheld": "rótulo em língua indígena sem código ISO 639-1 suprimido por decisão da comunidade (sacred)",
  "dataGeneralizations": "coordenada generalizada para 0,1°",
  "culturalLabels": ["tk-attribution", "tk-community-voice", "tk-non-commercial"],
  "holderPeople": "…",
  "updated_at": "…",
  "data": { }
}
```

Os dois primeiros campos de supressão não são invenção: `dwc:informationWithheld` e `dwc:dataGeneralizations` são termos Darwin Core, já adotados como regra em `propostaGovernanca.md:300` — com o princípio correto de que **campo restringido nunca fica nulo**, para que o consumidor saiba que há informação retida e por quê, em vez de concluir que o dado não existe.

**Onde redigir a supressão.** Duas opções, com risco assimétrico:

- *Redaction at rest* — o campo restrito nunca é gravado. Máxima proteção, perda irreversível para a própria comunidade. Contradiz `propostaGovernanca.md:473` (exportação integral como direito da comunidade).
- *Redaction at the API boundary* — o campo é gravado e filtrado na saída. Preserva o dado para o detentor; um bug de filtro vira vazamento.

**Recomendação: fronteira de API, com a fronteira sendo o endpoint de harvest e não a aplicação inteira**, e um teste automatizado que falhe se qualquer registro com nível efetivo diferente de `public` atravessar. Justificativa: a comunidade tem direito ao próprio dado completo; o risco de bug é mitigável por teste, a perda de dado não é reversível por nada. E permanece válido o limite mais duro, escrito em `propostaGovernanca.md:286`: **há conhecimento que não deve ser digitado** — para o sagrado iniciático, a decisão correta pode ser não registrar, e a plataforma tem obrigação de dizer isso antes de oferecer o campo.

---

## 9. Ganchos técnicos disponíveis — o que não precisa ser inventado

Levantamento verificado nas fontes primárias.

### 9.1 `dwc:Assertion` (Darwin Core Data Package) — o portador do Relato

O DwC-DP, ratificado pelo TDWG (guia de 2026-04-17), tem tabelas `*-assertion` para praticamente todas as classes: `occurrence-assertion`, `material-assertion`, `event-assertion`, `organism-assertion`, **`media-assertion`**, entre outras. Os campos de `media-assertion`, lidos do *table schema* oficial:

```
assertionID, media_fk,
verbatimAssertionType, assertionType, assertionTypeIRI, assertionTypeSource,
assertionMadeDate, assertionEffectiveDate,
assertionValue, assertionValueIRI, assertionValueSource,
assertionUnit, assertionUnitIRI, assertionUnitSource, assertionError,
assertionBy, assertionByID,
assertionProtocols, assertionProtocol_fk,
assertionReferences, assertionRemarks
```

Isto é, literalmente: **quem asseriu (`assertionBy` / `assertionByID` → tabela `agent`), o quê (`assertionType` / `assertionValue`, com IRI de vocabulário controlado), quando (`assertionMadeDate`), sob que protocolo (`assertionProtocol_fk`), ancorado em qual mídia (`media_fk`).** É a estrutura do Relato, já padronizada, já com o gancho para o BioCultTermos via `assertionValueIRI` + `assertionValueSource`.

`assertionByID` aceita identificador de `dcterms:Agent` interno ou externo ao dataset — ou seja, **nada impede que o agente seja um detentor de uma comunidade tradicional ou o coletivo de uma aldeia**. O que o padrão não resolve é *como* identificar esse agente sem expor pessoa; isso é decisão da arquitetura (§12, Q3).

### 9.2 `dwc:UsagePolicy` — existe, e **não** serve para protocolo cultural

O DwC-DP tem uma tabela `usage-policy`, ligada a mídia e material por `media-usage-policy` / `material-usage-policy`. Seus campos: `rights`, `rightsIRI`, `rightsHolder`, `owner`, `usageTerms`, `webStatement`, `accessRights`, `license`, `licenseLogoURL`, `licensingException`, `credit`, `attributionLogoURL`, `attributionLinkURL`.

É um modelo **de direito autoral** (herdado do Audubon Core). Não há um único campo para protocolo cultural. Isso **confirma empiricamente** o argumento de `propostaGovernanca.md:377` — "rótulo não é licença, e os dois campos nunca se fundem". A lacuna que os TK/BC Labels existem para preencher é visível na estrutura do padrão mais moderno de biodiversidade: ele sabe dizer quem detém o *copyright*, e não sabe dizer que um nome é `sacred`.

### 9.3 TK/BC Labels (Local Contexts) — o vocabulário de protocolo

Confirmado na fonte oficial: **20 TK Labels em três categorias** — *Provenance* (TK Attribution, TK Clan, TK Family, TK Multiple Communities, TK Community Voice, TK Creative), *Protocol* (TK Verified, TK Non-Verified, TK Seasonal, TK Women General, TK Men General, TK Men Restricted, TK Women Restricted, TK Culturally Sensitive, **TK Secret / Sacred**), *Permission* (TK Open to Commercialization, TK Non-Commercial, TK Community Use Only, TK Outreach, TK Open to Collaboration). Mais os **BC Labels** para dados derivados de recursos genéticos e coleções, e as **Notices** para quando a comunidade ainda não se manifestou.

Existe **API REST** no Local Contexts Hub: `GET` por *Project*, retornando Labels e Notices em JSON, com filtros por usuário, instituição, pesquisador e *provider's ID*. O propósito declarado é que o rótulo exibido em sistema externo permaneça sincronizado com o Hub — se a comunidade muda o rótulo, o sistema externo reflete a mudança. Isso resolve, sem código novo, o requisito de que **a autoridade sobre o rótulo permaneça com a comunidade e não com a cópia**.

Precedente institucional já citado em `propostaGovernanca.md:379`: o GBIF instituiu em 28/07/2025 um *Task Group on Indigenous Data Governance* cujo segundo eixo é pilotar TK/BC Labels sobre registros de ocorrência.

### 9.4 PROV-O — a cadeia gravação → transcrição → tradução

Já adotado como vocabulário (não como pilha RDF) em `propostaGovernanca.md:394`. Para um Relato com gravação em língua sem tradução direta — caso geral da arquitetura; o estudo de caso de Silveiras é conduzido por entrevista em português —, a modelagem correta é:

```
:relato-001         a prov:Entity ;
                    prov:wasAttributedTo :detentor-001 ;
                    prov:wasGeneratedBy  :ato-de-enunciacao-20260401 .
:midia-001          a prov:Entity ;
                    prov:hadPrimarySource :ato-de-enunciacao-20260401 .
:transcricao-001    prov:wasDerivedFrom  :midia-001 .
:traducao-001       prov:wasDerivedFrom  :transcricao-001 .
```

A cadeia deixa explícito o que a prosa deste documento afirma: quando há tradução, ela está a **duas derivações** de distância da fonte primária. Um sistema que mostra só a tradução está mostrando um derivado de derivado e chamando de dado.

### 9.5 Documentação linguística

Para uma gravação de fala — vídeo ou áudio, caso geral da arquitetura, não necessariamente presente no estudo de caso de Silveiras, conduzido por entrevista —, o conjunto mínimo de metadados é consenso na área (OLAC / IMDI / ELAN): falante, língua em ISO 639-3, data, local, gênero discursivo, consentimento, transcrição alinhada temporalmente, tradução, e o vínculo persistente entre anotação e gravação. O ponto operacional para a arquitetura: **transcrição sem ponteiro para a gravação é dado degradado**, e o campo `media` de `ADR-003-data-model.md:337-338` hoje não tem o objeto que deveria apontar.

---

## 10. Um Relato de exemplo, modelado ponta a ponta

Como ficaria um Relato do estudo de caso de Silveiras (SP) sob a proposta — uma indicação de uso de planta medicinal enunciada por moradora de quintal, em entrevista semiestruturada em português, sob TCLE e submissão ao SisGen (`docs/projetoPesquisa.md` §7.3). Formato ilustrativo, coerente com o JSON do ADR-003.

```json
{
  "id": "biocultrelatos-silveiras/relato-0001",
  "regime": "conhecimento",

  "relato": {
    "detentor": {
      "tipo": "individuo",
      "nomePublico": null,
      "papel": "detentor",
      "anonimizado": true,
      "comunidade": "moradores de quintal de Silveiras (SP)",
      "localidade": "<id_quintal>"
    },
    "atoDeEnunciacao": {
      "data": "2026-03-20",
      "ambiente": "entrevista_semiestruturada",
      "coordenadas": { "precision": "region-only" },
      "lingua": "por",
      "protocolo": "entrevista semiestruturada, amostragem estratificada"
    },
    "conteudo": {
      "linguaOriginal": "por",
      "transcricao": null,
      "transcricaoRevisadaPor": null,
      "traducao": []
    },
    "sobre": {
      "nomeVernacular": { "label": "<nome popular da planta>", "language": "por" },
      "nomeCientifico": null,
      "usos": ["indicação de uso", "modo de preparo", "dosagem", "contraindicação"]
    }
  },

  "media": [],

  "consentimento": {
    "obtained": true,
    "type": "TCLE",
    "scope": "pesquisa acadêmica, PPG em Botânica, ENBT/JBRJ",
    "purpose": "inventário do Conhecimento Ecológico Local sobre plantas medicinais",
    "permittedUses": ["pesquisa", "devolutiva à comunidade"],
    "expiresAt": null,
    "protocolReference": "CONEP — Resolução CNS 466/2012; SisGen",
    "language": "por",
    "revokedAt": null,
    "_bloqueio": null
  },

  "acesso": {
    "registro":  { "accessLevel": "restricted", "definidoPor": null },
    "relato":    { "accessLevel": "restricted", "definidoPor": null },
    "rotulos":   [{ "label": "<nome popular da planta>", "accessLevel": "restricted" }],
    "efetivo":   "restricted",
    "reviewDate": null
  },

  "rotulosCulturais": {
    "tipo": "notice",
    "valores": ["attribution-incomplete", "open-to-collaborate"],
    "_nota": "Notices, não Labels: a comunidade ainda não classificou"
  }
}
```

**Leia os `null`.** Não descrevem lacuna real do estudo de caso — o TCLE, a aprovação da CONEP e a submissão ao SisGen já estão documentados (`docs/projetoPesquisa.md` §7.3) — descrevem a lista de trabalho que todo Relato carrega até ser transcrito, verificado e classificado pela comunidade quanto ao nível de acesso. O modelo torna essas etapas **visíveis e bloqueantes**, em vez de deixá-las implícitas numa planilha de campo.

**Consentimento de participação não é classificação de acesso.** O TCLE autoriza a pesquisa; não decide, por si, se o Relato pode circular publicamente. Essa segunda decisão é da comunidade, e é o que os campos `acesso.*` capturam separadamente de `consentimento.*`.

**Caso geral, não deste estudo de caso.** Quando o Relato inclui gravação audiovisual em língua sem código ISO 639-1, `media[]` carrega `language` em ISO 639-3 — nunca ISO 639-1 —, com `zxx` para conteúdo sem fala e `und` para língua não identificada, e a tradução é modelada como entidade derivada (PROV-O, §9.4). O estudo de caso de Silveiras é conduzido por entrevista em português e não aciona este requisito, que permanece como regra geral da arquitetura.

**Padrão seguro por omissão.** Note que `accessLevel` nasce `restricted`, não `public`. Isto é uma inversão deliberada do padrão do BioCultTermos, onde `03-rotulos.md:72` registra que "o padrão do sistema é `public`". Para **Termo** de literatura, `public` por omissão é defensável — foi a conclusão honesta da campanha de tipos de uso, em que nenhum dos 713 termos exigiu reclassificação. Para **Relato**, `public` por omissão é inaceitável mesmo quando o consentimento de participação (TCLE) já foi obtido: significaria publicar por inércia o que a comunidade ainda não classificou. A regra proposta é: **Termo herda o padrão do vocabulário; Relato nasce restrito e só se torna público por ato positivo da comunidade** — que é literalmente o estágio 5 do ciclo CLPI de `propostaGovernanca.md:349`.

---

## 11. Mapeamento com os princípios C.A.R.E.

Sub-princípios conforme a formulação da GIDA.

| Sub-princípio | O que a distinção Conhecimento/Evidência acrescenta |
|---|---|
| **A1** — *Recognizing rights and interests* | Torna verificável **quem** tem direito sobre cada registro: no Conhecimento, o detentor e sua comunidade; na Evidência, a comunidade de origem quando identificável, e o custodiante do artefato sempre |
| **A2** — *Data for governance* | O regime é um campo consultável: a comunidade pode listar "tudo que é meu Conhecimento" sem depender de quem digitou |
| **A3** — *Governance of data* | Só o Conhecimento admite Label. É a tradução mecânica de "só a comunidade classifica o que é seu" |
| **R1** — *For positive relationships* | O Notice em Evidência é convite explícito ao contato, não simulação de consentimento |
| **R3** — *For Indigenous languages and worldviews* | língua da comunidade como língua do Relato (ISO 639-3), não como campo opcional; tradução modelada como derivada, com perda declarada |
| **E1** — *For minimizing harm* | A regra do mais restritivo impede que um rótulo sagrado vaze dentro de um registro público |
| **E3** — *For future use* | `reviewDate` obrigatório: nenhuma classificação sobrevive por inércia |
| **C2** — *For improved governance and citizen engagement* | O log de uso por regime permite o relatório anual devolvido à comunidade (`propostaGovernanca.md:455`) |

---

## 12. Decisões que exigem escolha

Nenhuma destas é técnica; todas mudam o documento se respondidas de outra forma.

**Q1 — O regime entra no glossário da federação ou fica interno a cada provedor?**
Recomendação: **glossário da federação** (`CONTEXT.md` raiz). Se o regime determina o que trafega no harvest, ele é linguagem da federação por definição. Deixá-lo interno reproduz o problema atual, em que "Evidência" só está definida no `BioCultDB/CONTEXT.md`.

**Q2 — ~~"Enunciado" é o nome certo?~~ Decidido em 2026-08-13.**
O termo é **Relato**. É a palavra que o projeto já usa, em português natural, coerente com o nome da unidade que existe para produzi-los (BioCultRe*latos*). Descartados: *Enunciado* (preciso, mas pouco usual em português técnico corrente), *Asserção* (importa jargão de padrão para dentro do domínio) e *Depoimento* (carga jurídico-policial).

**Q3 — Como identificar o detentor sem expor a pessoa?**
Tensão real e não resolvida: `assertionByID` quer um identificador estável; a LGPD e o bom senso querem anonimato. Opções: (a) identificador interno estável + `anonymized: true`, exposto só como papel ("ancião", "detentora"); (b) atribuição exclusivamente coletiva (a aldeia, o povo) para tudo que é público; (c) pseudônimo escolhido pelo próprio detentor. A opção (c) é a única que respeita simultaneamente CARE A1 e o direito ao reconhecimento — e é a que exige perguntar à pessoa.

**Q4 — O harvest passa a carregar rótulo e supressão, ou continua binário?**
Recomendação: carregar. Um índice federado que só sabe "público/não público" não consegue exibir, na interface do Pluriverso, por que um campo está ausente — e a regra de `propostaGovernanca.md:300` (campo restringido nunca fica nulo) fica sem implementação possível do lado do consumidor.

**Q5 — Adotar a API do Local Contexts Hub ou espelhar os rótulos localmente?**
Adotar a API mantém a autoridade da comunidade sobre o rótulo (ela muda no Hub, muda em todo lugar) e cria dependência de serviço externo — o que colide com a diretriz de simplicidade e soberania. Espelhar localmente inverte os dois. Meio-termo defensável: **armazenar o identificador do rótulo e o identificador do projeto no Hub, exibir o texto canônico obtido por consulta com cache, e nunca editar o texto** (as Notices, em particular, não podem ter o texto alterado).

---

## 13. Resumo do que muda

| Artefato | Mudança proposta |
|---|---|
| `CONTEXT.md` (raiz) | Acrescentar **Conhecimento**, **Evidência**, **Relato**, **Regime Enunciativo** |
| `README.md:58` | "Quatro Fontes de Evidência" → "Quatro Fontes", com a distinção de regime explicitada logo abaixo |
| `ADR-003` | Campo `regime`; entidade `relato`; `media[]` deixa de ser "(futuro)"; `language` migra para ISO 639-3; `accessLevel` por nível; `permissions.restrictions.reviewDate` |
| `ADR-004` D6 | Payload de harvest ganha `regime`, `accessLevel` efetivo, `informationWithheld`, `dataGeneralizations`, `culturalLabels`, `holderPeople` |
| BioCultTermos | `accessLevel` do `skosxl:Label` passa a trafegar no fluxo federado, não só na interface de curadoria |
| Novo ADR | "Regime enunciativo e níveis de rotulagem de acesso" — a regra do mais restritivo e a fronteira de redação |

---

## 14. Fontes

**Normas e padrões**

- Darwin Core Data Package guide, TDWG, 2026-04-17: <https://dwc.tdwg.org/dp/> · <http://rs.tdwg.org/dwc/doc/dp/2026-04-17>
- DwC-DP *table schemas* (tabelas `*-assertion`, `agent`, `media`, `usage-policy`): <https://github.com/gbif/dwc-dp/tree/master/dwc-dp/table-schemas>
- DwC-DP Quick Reference Guide: <https://gbif.github.io/dwc-dp/qrg/>
- Darwin Core, termos `informationWithheld` e `dataGeneralizations`: <https://dwc.tdwg.org/terms/>
- W3C PROV-O: <https://www.w3.org/TR/prov-o/>
- W3C SKOS-XL (SKOS Reference, §5): <https://www.w3.org/TR/skos-reference/#xl>
- Frictionless Data Package: <https://specs.frictionlessdata.io/>

**Governança de dados indígenas**

- CARE Principles for Indigenous Data Governance, GIDA: <https://www.gida-global.org/careprinciples>
- Local Contexts — TK Labels (20 rótulos, três categorias): <https://localcontexts.org/labels/traditional-knowledge-labels/>
- Local Contexts — BC Labels: <https://localcontexts.org/labels/biocultural-labels/>
- Local Contexts — Notices (índice em `/notices/`; ex. de notice individual): <https://localcontexts.org/notices/> · <https://localcontexts.org/notice/tk-notice/>
- Local Contexts Hub — API: <https://localcontextshub.org/> · guia de implementação: <https://localcontexts.org/wp-content/uploads/2023/08/API-Implementation-Guide.pdf>
- Mukurtu CMS — Cultural Protocols: <https://mukurtu.org/>

**Legislação brasileira** (conforme já compilado em `governanca/propostaGovernanca.md`)

- Lei nº 13.123/2015 — art. 9º, §1º (quatro formas de comprovação do CLPI); arts. 19-24 (repartição): <https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2015/lei/l13123.htm>
- Decreto nº 8.772/2016 (regulamentação, CGen, SisGen): <https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2016/decreto/d8772.htm>
- Decreto nº 8.750/2016 (CNPCT — lista de povos e comunidades tradicionais)
- Lei nº 9.610/1998, art. 45 (domínio público ressalva conhecimentos étnicos e tradicionais)
- LGPD, art. 11 (dado pessoal sensível; consentimento específico e destacado)

**Literatura**

- BERKES, F. *Sacred Ecology*. Routledge — conhecimento ecológico tradicional como *knowledge–practice–belief complex*
- NADASDY, P. "The Politics of TEK: Power and the 'Integration' of Knowledge". *Arctic Anthropology*, 36(1-2), 1999 — compartimentalização e destilação em dados
- AGRAWAL, A. "Dismantling the Divide Between Indigenous and Scientific Knowledge". *Development and Change*, 26(3), 1995
- ELLEN, R.; HARRIS, H. *Indigenous Environmental Knowledge and its Transformations*. Routledge, 2000 — conhecimento como prática situada
- ANDERSON, J.; HUDSON, M. "The Biocultural Labels Initiative". *Biodiversity Information Science and Standards*, 4, 2020: <https://doi.org/10.3897/biss.4.59230>
- CARROLL, S. R. et al. "The CARE Principles for Indigenous Data Governance". *Data Science Journal*, 19(1), 2020: <https://doi.org/10.5334/dsj-2020-043>
- CHAPMAN, A. D. *Current Best Practices for Generalizing Sensitive Species Occurrence Data*. GBIF, 2020: <https://doi.org/10.15468/doc-5jp4-5g10>

**Documentos internos consultados**

`README.md` · `CONTEXT.md` · `docs/architecture-decisions/ADR-003-data-model.md` · `ADR-004-federated-architecture.md` · `docs/c4-model/01-context-diagram.md` · `governanca/propostaGovernanca.md` (§5.1-§5.10) · `BioCultDB/CONTEXT.md` · `BioCultDB/bioculttermos/manual/03-rotulos.md` · `docs/projetoPesquisa.md` (§7.3)

---

## 15. Mídia neste diretório — `conhecimentoPanara.mp4`

Este diretório contém um arquivo de vídeo que **não está sob controle de versão** e nunca estará: `.gitignore` exclui `*.mp4` em todo o repositório. A regra tem motivação de tamanho e efeito exigido por `governanca/propostaGovernanca.md` §5.10 — nenhuma unidade mantém o único original de gravação de CLPI em plataforma de terceiros, e um remoto público é plataforma de terceiros.

Registro do arquivo, porque um arquivo de 62 MB sem documentação é pior que um arquivo exposto:

| Campo | Valor |
|---|---|
| Nome | `conhecimentoPanara.mp4` |
| Tamanho e formato | 61,9 MB · 1920×1080 · 42,2 s · HEVC + AAC |
| O que é | Exemplo de **Conhecimento** no sentido deste documento — a relação com a biodiversidade enunciada por quem a detém, registrada em vídeo, e portanto também um exemplo do objeto do BioCultRelatos, em que a mídia **é** o Relato e a descrição é derivada (ADR-015, K8.1) |
| Detentor e povo | `[não verificado]` — o nome do arquivo indica o povo **Panará**; a identificação de quem fala, a que título e sob que forma quer ser nomeado é exatamente a Pauta 1 de `pauta-comunidades.md`, e não se presume aqui |
| Estado do consentimento | `[não verificado]` — não há CLPI registrado como dado para este arquivo. Enquanto não houver, ele é material de estudo da arquitetura e **não** dado de nenhuma unidade federada |
| Onde deve morar | Não aqui, no destino final. O lugar correto é o armazenamento soberano que o BioCultRelatos vier a usar, fora da árvore de qualquer repositório — pelo mesmo princípio do ADR-005, que já mantém o arquivo SQLite de cada unidade fora do container, em caminho declarado por variável de ambiente. É a pendência ⑩ ("onde mora o vídeo") de `docs/proximosPassos.md` |

A permanência dele neste diretório é, portanto, **transitória e declarada**, não uma decisão de arquitetura.
