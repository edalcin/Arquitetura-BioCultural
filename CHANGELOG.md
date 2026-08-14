# Histórico de Versões - Arquitetura do Sistema de Conhecimento Tradicional

Todas as mudanças significativas nesta proposta de arquitetura serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/), e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

---

## [3.10.1] - 2026-08-14

### Modificado

- **Apresentação `Arquitetura BioCultural v2` — paleta harmonizada com os diagramas.** Os diagramas embutidos já tinham fundo `#FAF6EF`; os slides eram brancos (`FFFFFF` do tema) ou cinza-frio (`F3F2F2`), e a moldura aparecia em volta de cada imagem. Agora:
  - **Fundo de todos os 27 slides**: `#FAF6EF`. Aplicado nos dois lugares que decidem a cor — `p:bg` explícito dos slides e `lt1` do tema do slide-mestre (`theme2.xml`), que é de onde vinham os slides sem fundo próprio
  - **Slides de seção** (3, 6, 9, 17, 19): o quase-preto frio `#262525` passa a `#26221D`, mesma luminosidade, matiz da família do fundo. O texto claro sobre eles vira o próprio creme
  - **Tinta do texto**: `#000000` passa a `#201F1D` — a cor que já dominava o restante do deck (205 ocorrências). Preto puro sobre creme é duro; contraste do novo par é 15,3:1, bem acima de WCAG AAA
  - **Quatro imagens-tira** (`image6`, `image8`, `image9`, `image11`), que traziam fundo `F3F2F2` embutido: neutros claros re-tingidos para a família do creme, preservando os glifos e os acentos de cor
- PDF exportado regenerado a partir do `.pptx`

### Contexto da Versão

Só estética, nenhuma decisão de arquitetura. Verificado por renderização, não por inspeção de XML: os 27 slides foram convertidos e a cor dominante de cada um conferida — 22 em `#FAF6EF`, 5 em `#26221D`, nenhum branco restante.

## [3.10.0] - 2026-08-14

### Adicionado

- **ADR-016 — Contrato de Harvest da Federação** (`docs/architecture-decisions/ADR-016-contrato-de-harvest.md`), status *Proposto*. Extrai o ponto **K6** da ADR-015 para ADR própria, com quatro pontos: **H1** payload com nível efetivo e supressão declarada; **H2** redação na fronteira da API, com *redaction at rest* rejeitada; **H3** vocabulário fechado de `relationshipType`; **H4** condição de aceitação do endpoint. Motivo da extração: K6 supersede o ADR-004 D6, que está **Aceito**, a partir de texto *Proposto* que depende de validação com comunidades. O contrato de harvest é consequência técnica e não precisa dessa espera — passa a ter ciclo de aceitação próprio
- **Vocabulário de `relationshipType` fechado em três valores** (ADR-016 H3, `contrato-harvest.md` §6): `refers to` (o registro fala sobre recurso de outro membro), `same as` (mesmo objeto, duplicata entre acervos) e `derived from` (versão editada, transcrição, tradução). Ampliar é ato do Comitê Federado

### Corrigido

- **`same as` estava errado no vínculo entre Relato e item de acervo.** O Relato Panará **não é** a exsicata do herbário; ele fala sobre ela. `same as` afirma identidade e colapsaria os dois no índice do Pluriverso, apagando exatamente a distinção que a ADR-015 existe para preservar. O caso normal passa a ser `refers to`
- **ADR-015, §"O que esta ADR não decide"**: Q1 (regime no glossário da federação) constava como aberta desde a v3.7.0, que já a respondeu. Fechada. A contagem passa de seis para **quatro questões abertas** (Q3–Q6), refletida no Status e na Data de Revisão

### Modificado

- **`docs/contrato-harvest.md`**: passa a ser normativo em conjunto com a ADR-016; §4.1 marca a equivalência `sacred` ≡ `private` como **regra interina, conservadora**, com a pendência aberta em destaque; nova pendência ⑤ em §8
- **ADR-004 D6** e **ADR-015 K6/Relações**: notas repontadas para a ADR-016
- **Apresentação** (`docs/apresentacoes/Arquitetura BioCultural v2.pptx` e o PDF exportado): o slide de perguntas às lideranças passa de quatro para **cinco perguntas**, com a nova — "O que é sagrado — e o que acontece com ele" — em card de largura inteira; grade re-espaçada em três linhas
- **`conhecimento/proximosPassos.md`**: estado do repositório, pendências ③ e ⑤ fechadas, ④ movida para a pauta da reunião, e referência residual a projeto externo removida de §8

### Contexto da Versão

Sessão de triagem: separar o que se decide na mesa do que só se decide na roda.

Três pendências de arquitetura pura estavam paradas junto com as que dependem das comunidades, e não precisavam estar. Duas foram decididas (③ extração de K6, ⑤ vocabulário de vínculo). A terceira, ④ — se `sacred` equivale a `private` —, parecia técnica e não é: **o que é sagrado quem diz é a comunidade**, e a equivalência pode estar tecnicamente certa e semanticamente errada. Foi para a pauta da reunião com as lideranças, e virou a quinta pergunta da apresentação. Até a resposta vale a regra interina, que erra para o lado de não publicar.

A extração de K6 resolve um impasse de status que se arrastava desde a v3.8.0: um ADR *Aceito* sendo supersedido por um *Proposto*, sem prazo. Agora o contrato pode ser aceito sozinho, e a ADR-015 continua o ciclo dela, no tempo das comunidades.

## [3.9.1] - 2026-08-13

### Modificado

- **Reorganização de `docs/`**: as 12 imagens soltas na raiz (`arquitetura-biocultural`, `integracao-federada`, `pluriverso-multi-instancia` em `.png`/`.svg`, mais `arquiteturaV1.4{,b}.png` e as quatro `IlustraBlog*.png`) e a pasta `etnoImagens/` movidas para `docs/images/`, com `legacy/` (diagramas de versões anteriores) e `blog/` (ilustrações do artigo externo) como subpastas; `etnoImagens/` renomeada para `docs/images/etno/`. Movidas com `git mv`, histórico preservado. Nenhum arquivo perdido; nenhuma pasta já organizada (`architecture-decisions/`, `c4-model/`, `gestaoBioCultTermos/`, `iniciativas/`, `agents/`, `diagrams/`, `apresentacoes/`) foi alterada
- Referências atualizadas em `README.md` (3 imagens embutidas + diagrama de estrutura da documentação) e `governanca/planoPropostaGovernanca.md` (3 citações do SVG-fonte)

### Contexto da Versão

Organização puramente estrutural, sem mudança de conteúdo técnico ou decisão de arquitetura.

## [3.9.0] - 2026-08-13

### Adicionado

- **ADR-015, ponto K8: Relato de prática** — a ADR-015 foi escrita a partir de um caso de fala (um homem descrevendo uma árvore) e generalizou desse caso. K8 corrige a generalização em três frentes, antes que ela vire esquema:
  - **K8.1 — o ato de enunciação inclui o ato de demonstração.** Alguém preparando um chá, trançando uma cesta com fibra de palmeira, escolhendo qual folha colher: **o conhecimento está no gesto, na sequência e no material**, e pode não haver uma palavra dita. Consequência que muda o modelo: em Relato de prática, **a mídia não é anexo do Relato — ela é o Relato**, e a descrição escrita é derivada dela, com a mesma cadeia PROV-O que K5 impõe à tradução
  - **K8.2 — língua obrigatória passa a língua declarada.** Deixar `language` vazio reintroduz o problema que K5 existe para resolver, porque campo nulo é lido como português. Registro sem fala recebe **`zxx`** (*No linguistic content*) e língua não identificada recebe **`und`** (*Undetermined*) — ambos ISO 639-3 *Active*, escopo *Special*, verificados na fonte primária. Fala em mais de uma língua vira lista, na ordem em que ocorrem
  - **K8.3 — enunciação coletiva.** Oficina, mutirão, roda de conversa: cada participante identificável é detentor com direito próprio sobre voz e imagem (LGPD art. 11; CARE A1; Lei 13.123). O nível efetivo da mídia é **o mais restritivo entre as pessoas gravadas** — a regra de K3 aplicada a um eixo novo, entre pessoas. Revogação por um participante retira a mídia da publicação, sem exigir justificativa; **editar a gravação para suprimir alguém não é decisão da plataforma**, é derivado novo e só existe se a comunidade pedir. Consentimento individual sobre voz e imagem e CLPI da comunidade são **dois consentimentos**, e nenhum substitui o outro
  - **K8.4** reafirma para vídeo o corolário de K5: nasce `restricted` no BioCultRelatos da comunidade, formato aberto sem DRM, e **o único original nunca reside em plataforma de terceiros** — vídeo é justamente onde o custo de armazenamento torna a cessão tentadora
- **Três cenários novos na condição de aceitação do harvest** (§7 de `docs/contrato-harvest.md`, agora dez): gravação coletiva com **um** participante `restricted` não atravessa; revogação de um participante retira a mídia na coleta seguinte, sem gerar versão editada; registro de prática sem fala publica `language: zxx`, e falha se vier vazio ou inferido como `por`

### Modificado

- **`docs/contrato-harvest.md`**: §4.1 ganha o **quarto eixo** do nível efetivo — entre as pessoas gravadas —, com a consequência explícita para quem implementa o filtro: não basta olhar o `accessLevel` do registro e do Relato, é preciso percorrer a lista de participantes; `holderPeople` passa a cobrir explicitamente o Relato de enunciação coletiva
- **Nota de retificação do ADR-003** estendida com K8: `media` em Relato de prática **é** o Relato; `language` aceita `zxx` e `und`; detentor coletivo com direito individual sobre voz e imagem; nova linha de acréscimo "acesso de mídia coletiva"
- **ADR-015**: cabeçalho da Decisão passa de K1–K7 para **K1–K8**, com notas de "Ampliado por K8" em K2 e K5, nos pontos exatos que pressupunham fala
- **`proximosPassos.md`**: quinta pauta para a conversa com a comunidade — gravações de prática e oficinas coletivas, incluindo o que fazer quando um participante muda de ideia depois
- **Apresentação** (`Arquitetura BioCultural.pptx`, fora deste repositório): o slide de perguntas às lideranças deixa de falar em "gravações de fala" e passa a tratar de prática filmada e oficinas coletivas

### Contexto da Versão

A v3.9.0 nasce de uma observação de campo, não de uma revisão de documento: **vídeo não é fala com imagem.** Uma pessoa fazendo um chá ou trançando uma cesta com determinada planta está registrando conhecimento inteiro, e uma gravação de oficina registra várias pessoas ao mesmo tempo, cada uma com direito próprio sobre a própria imagem.

As duas coisas quebravam premissas da ADR-015 escritas dias antes: K5 exigia "a língua em que foi proferido", e K2 tratava o detentor coletivo como um bloco que decide junto. A correção foi feita como ponto novo (K8) em vez de reescrita, para que a premissa antiga e sua correção fiquem visíveis lado a lado — o mesmo critério das notas de retificação da v3.6.0 e da v3.8.0.

A regra adotada para o caso difícil — um participante de gravação coletiva muda de ideia — é deliberadamente a mais conservadora: **a gravação inteira sai**. É pergunta aberta para as comunidades, registrada como quinta pauta em `proximosPassos.md` §5. A plataforma não decide isso; enquanto não houver decisão, obedece ao mais restritivo.

---

## [3.8.0] - 2026-08-13

### Adicionado

- **`docs/contrato-harvest.md`** (status **Proposto**) — o contrato de payload do harvest especificado **campo a campo**, decorrente de K6 da ADR-015. Fixa a envoltória (inalterada), o registro (`id`, `regime`, `accessLevel`, `informationWithheld`, `dataGeneralizations`, `culturalLabels`, `holderPeople`, `relatedResources`, `updated_at`, `data`), a ordem de restritividade `public < restricted < community-only < private` para o cálculo do **nível efetivo** de K3, e a regra de que campo **ausente** e campo **retido** são coisas distintas — retido exige `informationWithheld` preenchido, e campo restringido nunca fica nulo (`propostaGovernanca.md:300`)
- **`relatedResources`** no payload — resolve o requisito que a ADR-015 registrou e deixou sem especificação: "este registro trata do mesmo objeto que aquele registro de outro membro". Subconjunto da tabela `resource-relationship` do DwC-DP com os nomes de campo do padrão preservados, verificados na fonte primária (`relationshipType`, `relatedResourceID`, `externalRelatedResourceID`, `externalRelatedResourceSource`, `relatedResourceType`, `relationshipAccordingTo`, `relationshipEstablishedDate`, `relationshipRemarks`). É a lição do Mukurtu (`propostaGovernanca.md:419`) implementada **na federação** — Relato na unidade da comunidade, ficha do museu na unidade do museu, os dois vinculados e nenhum gravado dentro do banco do outro
- **Condição de aceitação do endpoint de harvest** (§7 do contrato) — sete cenários que o teste automatizado obrigatório de K6 deve cobrir, inclusive os dois que costumam faltar: registro `public` de regime `conhecimento` **sem CLPI válido** deve estar ausente, e mudança de nível de `public` para `restricted` deve desaparecer da coleta seguinte, com `purge` no índice do Pluriverso (ADR-004 D4)

### Modificado

- **Nota de retificação** acrescentada à seção "1. Registro Principal (Record)" do **ADR-003**, apontando para a ADR-015 — três retificações (`type` constante ganha `regime` de K1; `media: []` deixa de ser "(futuro)" por K5; `metadata.language: "pt-BR"` migra para ISO 639-3 por K5) e quatro acréscimos (entidade `relato` de K2, `accessLevel` por nível de K3, `permissions.restrictions.reviewDate` de K3, padrão de acesso por regime de K7). Texto original preservado integralmente abaixo da nota, seguindo a convenção do ADR-001 e da v3.6.0. A nota **não promove nem reescreve** o ADR-003, que segue *Proposto*
- **Nota de retificação** acrescentada ao ponto **D6** do **ADR-004** e ao bloco "Contrato de Publicação", registrando a supersessão do payload por K6 e o que **permanece válido**: paginação obrigatória, `updated_since`, identificador estável `member_id` + `record_id` e a regra de que só o nível efetivo `public` atravessa o harvest. Fica **sinalizado no próprio texto** que o ADR-004 está *Aceito* e a ADR-015 está *Proposta* — a supersessão só tem efeito quando a ADR-015 for aceita; até lá a nota registra a decisão em discussão, não a aplica
- **Nota de retificação** acrescentada ao ponto **E3** do **ADR-006** — o probe de admissão conferia a presença de `visibility` na resposta do endpoint, campo que K6 remove. Um membro que implementasse o contrato vigente **falharia o probe**. A conferência passa a ser `member_id`, `id`, `regime` e `accessLevel`; o probe como **sinal, nunca gate**, e a mitigação anti-SSRF permanecem intactos
- **ADR-015**: corrigida a citação "entidade `enunciado`" em Relações, que contradizia K2 e a decisão de 2026-08-13 pelo termo **`Relato`**; K6 e as Referências passam a apontar para `docs/contrato-harvest.md`
- **README** e **`CONTEXT.md`**: `docs/contrato-harvest.md` acrescentado à Estrutura da Documentação, à Navegação da Documentação (item 9) e às Referências da linguagem da federação

### Contexto da Versão

A v3.8.0 executa os três passos que a v3.7.0 deixou prontos e sem dependência: leva a decisão da ADR-015 aos lugares normativos que ela toca (ADR-003, ADR-004 D6 e — descoberto no caminho — ADR-006 E3) e converte o esqueleto de K6 em contrato implementável.

Nada aqui decide o que a ADR-015 deixou aberto. As duas pendências que bloqueiam o esquema do Relato continuam abertas e agora estão nomeadas dentro do próprio contrato (§8): o **formato do detentor individual** — nome protegido, atribuição só coletiva, ou pseudônimo escolhido pela própria pessoa, sendo esta a única que exige perguntar — e o **texto dos rótulos culturais**, API do Local Contexts Hub ou cache local. A segunda não bloqueia o contrato: as duas resoluções consomem o mesmo identificador, e o texto do rótulo não trafega no payload em nenhuma hipótese.

Uma regra derivada foi introduzida e está marcada como tal, para que não passe por decisão tomada: o `accessLevel` `sacred` do nível de Termo não pertence à escala de quatro camadas de `propostaGovernanca.md:277-282` e, para efeito de cálculo do nível efetivo, equivale a `private` — nunca atravessa. Se o Comitê discordar, o lugar de corrigir é §4.1 do contrato.

---

## [3.7.0] - 2026-08-13

### Adicionado

- **ADR-015: Regime Enunciativo e os Três Níveis de Rotulagem de Acesso** (status **Proposto**) — responde à pendência de vocabulário de arquitetura deixada em aberto pela v3.5.0 e conclui que ela não era de vocabulário: BioCultDB e BioCultRelatos não usam termos diferentes para o mesmo conceito, guardam **conceitos diferentes com o mesmo termo**. Acrescenta um segundo eixo, ortogonal ao da procedência — o **Regime Enunciativo**, com dois valores: `conhecimento` (a relação com a biodiversidade enunciada por quem a detém, em primeira pessoa, presa a um ato de enunciação) e `evidencia` (a atestação, por um terceiro, de que essa relação existe, em terceira pessoa, presa a um artefato). A distinção é **deôntica, não epistêmica**: Evidência não é regime inferior, é conhecimento com outro dono; o que ela decide é **quem pode classificar o acesso** — e portanto se cabe um TK/BC Label (comunidade) ou apenas um Notice (instituição), regra que `propostaGovernanca.md` §5.5 já aplicava sem ter a propriedade do dado que a determina. Sete pontos de decisão: **K1** regime é campo do registro, nunca propriedade do provedor — na prática BioCultDB, BioCultAcervos e BioCultNaturalistas são `evidencia` sempre, e o único provedor com os dois regimes é o BioCultRelatos, onde a nota de campo do pesquisador é Evidência por falhar Q2 do teste; **K2** a unidade de Conhecimento é o **Relato** — detentor, ato de enunciação, mídia-fonte e classificação de acesso —, mapeado para `dwc:Assertion` do Darwin Core Data Package, e vivendo **sempre na unidade da comunidade detentora**, nunca na de quem custodia o objeto de que ele fala; **K3** três níveis de rotulagem (Termo `skosxl:Label`, Relato, Registro/Mídia) com **nível efetivo pelo mais restritivo** e herança descendente proibida; **K4** Label sobre Conhecimento, Notice sobre Evidência, em campo separado de `permissions.license`; **K5** língua do Relato em ISO 639-3 obrigatória, com transcrição e tradução como entidades derivadas que nunca substituem a gravação; **K6** o payload de harvest passa a carregar regime, nível efetivo e supressão declarada (`dwc:informationWithheld`, `dwc:dataGeneralizations`), com redação na fronteira do endpoint e teste automatizado como condição de aceitação; **K7** Relato nasce `restricted` e só se torna público por ato positivo da comunidade, enquanto o Termo mantém o padrão `public` do vocabulário. Cinco questões ficam **explicitamente abertas** antes da promoção a *Aceito*, entre elas como identificar o detentor sem expor a pessoa
- **`conhecimento/sessao-2026-08-13-decisoes-e-pendencias.md`** — registro da sessão, com destaque para a **pauta do que precisa ser conversado com a comunidade** (§5): identificação de quem fala, rótulos culturais, as quatro pendências do vídeo Panará, e o que não deve ser registrado, com roteiro de perguntas em linguagem não-técnica
- **`proximosPassos.md`** — guia de retomada para a próxima sessão
- **`conhecimento/caracterizacao-do-conhecimento-tradicional.md`** — estudo que originou a ADR-015, com o prompt que o encomendou, o levantamento das dez ambiguidades atuais (com arquivo e linha), a fundamentação conceitual e jurídica, os ganchos técnicos verificados nas fontes primárias (tabelas `*-assertion` e `usage-policy` do DwC-DP, TK/BC Labels e a API do Local Contexts Hub, PROV-O, ISO 639-3), o caso Panará modelado ponta a ponta e as decisões pendentes
- **Quatro termos no glossário da federação** (`CONTEXT.md`), em nova seção "Conhecimento e evidência": **Conhecimento**, **Evidência**, **Relato** e **Regime Enunciativo**, cada um com sua lista `_Avoid_`. Fecha a lacuna de o glossário da federação não definir nenhum dos dois conceitos centrais — "Evidência" só existia, e em sentido mais estreito, no `BioCultDB/CONTEXT.md`
- **`.gitignore`**: `*.mp4` em todo o repositório. Motivação imediata é tamanho; o efeito é exigido por `propostaGovernanca.md` §5.10 — nenhuma unidade mantém o único original de gravação de CLPI em plataforma de terceiros, e um remoto público é plataforma de terceiros

### Modificado

- **README**: seção "O Problema" renomeada para "Conhecimento e Evidências Dispersos e Não Registrados" e reescrita para nomear as duas naturezas em vez de subordinar conhecimento a evidência; "Quatro Fontes de Evidência" passa a **"Quatro Fontes"**, com nova coluna *Regime predominante* e o BioCultRelatos promovido à primeira linha; nota de escopo esclarecendo que **regime é do registro, não da ferramenta**; item 8 na Navegação da Documentação; `conhecimento/` e `CONTEXT.md` acrescentados à árvore de Estrutura da Documentação
- **`docs/architecture-decisions/README.md`**: nova entrada da ADR-015 na Lista de ADRs e no Histórico de Mudanças
- **`CONTEXT.md`**: ADR-015 acrescentada às Referências

### Contexto da Versão

A v3.7.0 não altera infraestrutura, persistência nem topologia da federação. Ela fecha uma lacuna **conceitual** que estava travando duas coisas ao mesmo tempo: a aplicação precisa dos rótulos de nível de acesso (`public` / `restricted` / `sacred`) e a promessa de que só a comunidade classifica o que é seu.

O sintoma que a expôs é concreto e verificável: um vídeo de 42 segundos em que um homem Panará, ao lado de uma árvore, descreve a árvore e seus usos **na língua Panará** (ISO 639-3 `kre`). É o registro que melhor materializa a razão de ser desta arquitetura, e não havia onde guardá-lo — `ADR-003:337-338` é `media: []` com o comentário `// (futuro)`, e o modelo que chega mais perto (`dadosEtnoJBRJ_Panara/relatos.md`) tem `id_video`, `idioma` e `conteudo_transcrito`, mas nenhum campo de nível de acesso, consentimento ou detentor. O modelo que melhor descreve o conhecimento era o que menos o protegia.

A ADR-015 é a primeira a **superseder o contrato de payload do ADR-004 D6** (K6): `{id, visibility, updated_at, data}` é um booleano e não consegue expressar o caso comum — registro público contendo rótulo sagrado, que deve ser publicado com o rótulo suprimido e a supressão declarada. Sem isso, a regra de `propostaGovernanca.md:300` ("campo restringido nunca fica nulo") não tinha implementação possível do lado do consumidor.

Duas retificações menores ficam registradas na própria ADR-015, sem reescrever o ADR-003, que segue em status *Proposto* e entra na mesma rodada de validação com comunidades: `metadata.language: "pt-BR"` migra para ISO 639-3 (K5) — `pt-BR` não codifica `kre`, e o BioCultTermos já exige ISO 639-3 desde a migração de 2601 conceitos de `pt` para `por` —, e `media` deixa de ser "(futuro)".

Pendências abertas e nomeadas: as seis questões de decisão da ADR-015; nenhuma unidade implementou ainda os campos de acesso do ADR-003; e o caso Panará depende de localizar ou formalizar o CLPI, obter transcrição em `kre` com falante nativo e verificar a grafia com pesquisadores Panará antes de qualquer publicação.

---

## [3.6.0] - 2026-08-10

### Adicionado

- **ADR-014: Nomenclatura Científica Fora do Escopo do Vocabulário Controlado** — nomenclatura biológica científica sai do escopo do vocabulário controlado do BioCultTermos em todas as unidades: sua autoridade é externa e já constituída (ICN, ICZN, WFO, IPNI, POWO, GBIF), sem decisão de curadoria legítima a tomar. O nome científico permanece dado de primeira classe da Unidade Hospedeira (N2); a ponte com o nome tradicional passa a ser associação no dado, nunca conceito espelho (N4). Os conceitos SKOS-XL de nome científico são removidos do `etnotermos` — rótulos, relações, e a opção "Nomes Científicos de Plantas" sai do pulldown "Campo semântico" do Admin —, exceto onde um conceito tiver `sourceFields` misto (nome científico + outro campo em escopo), caso em que só a entrada do campo científico é removida do `sourceFields`; relações órfãs são limpas e o SQLite é copiado em backup antes da purga (N5). `biocultdb_records` é dado de origem e não é tocado: o nome científico segue ali, na Evidência, exibido no BioCultDB. Origem operacional: `BioCultDB/docs/curadoria/decisao-nomes-cientificos-fora-de-escopo.md`, `BioCultTermos@2bbe950`.

### Modificado

- **Nota de retificação** acrescentada à seção G5 do **ADR-012**, apontando para a ADR-014 — a citação de `nomeCientifico` na travessia do `AcquisitionService` está incorreta desde 2026-08-10; texto original preservado abaixo da nota, seguindo a convenção já usada no ADR-001
- **Nota de retificação** acrescentada à seção F5 do **ADR-007**, registrando que a configurabilidade de campos monitorados tem limite de escopo declarado por ADR-014 N3
- **`docs/gestaoBioCultTermos/BioCultTermosEstrategia.md`**: árvore de campos monitorados do `AcquisitionService` atualizada para remover `nomeCientifico`, com nota apontando para a ADR-014
- **`docs/architecture-decisions/README.md`**: nova entrada da ADR-014 na Lista de ADRs e no Histórico de Mudanças

### Contexto da Versão

A v3.6.0 não altera modelo de dados, contrato de harvest nem infraestrutura — fecha uma lacuna de escopo do vocabulário controlado exposta pela primeira tentativa real de curar o campo de nome científico (864 conceitos candidatos, zero curados em treze meses). Retifica, sem reescrever, os dois lugares normativos onde a travessia do `AcquisitionService` citava `nomeCientifico` entre os campos monitorados. Pendência aberta e fora deste repositório: `BioCultNaturalistas/docs/decisions/ADR-003` V2 precisa remover `bcn_taxons → $.nomeCientificoAtual` do seu contrato de campos monitorados.

---

## [3.5.0] - 2026-08-02

### Adicionado

- **ADR-011: Absorção do BioCultPapers pelo BioCultDB** — o BioCultPapers deixa de ser componente da arquitetura; sua funcionalidade de extração de dados por IA a partir de artigos científicos passa a ser **Extração por IA**, funcionalidade nativa do BioCultDB no contexto de Aquisição, acessível pelo navegador (PDF nunca sai do navegador do usuário; texto extraído vai ao provedor de IA; resultado vira Evidência pendente que entra na Curadoria como qualquer outra). Supersede o ponto D7 do ADR-004 e os pontos DA1 (parcial) e DA6 do ADR-005; registra a premissa corrigida de que o BioCultPapers já não usava MongoDB no momento da absorção — havia migrado para SQLite pelo próprio ADR-005 — e que o ganho real foi eliminar a entrega por arquivo entre as duas aplicações, não trocar de banco de dados. Registra pendência (não resolvida) de vocabulário: o termo "Evidência" adotado pelo BioCultDB precisa, se necessário, ser harmonizado pelo Comitê Federado caso o BioCultRelatos use outro termo para o mesmo conceito.
- Subseção **"Extração por IA"** no README, descrevendo a funcionalidade como parte do BioCultDB, e componente **Extração por IA** no diagrama C4 de componentes (`docs/c4-model/03-component-diagram.md`), dentro do container do BioCultDB

### Modificado

- **README**: inventário de componentes ativos, tabela de tipos de membro da federação, seção "Integração Federada entre Projetos" e lista de "Projetos da Arquitetura (Implementados)" atualizados para remover o BioCultPapers como componente separado; título e badge de versão promovidos para 3.5.0
- **Nota de status** adicionada ao ponto D7 do ADR-004 e aos pontos DA1 e DA6 do ADR-005, apontando para o ADR-011 — texto original de cada ponto preservado abaixo da nota, seguindo a convenção já usada no ADR-001
- **`docs/c4-model/02-container-diagram.md`**: container `.NET 8/WPF` do BioCultPapers removido do diagrama de containers (nós, relações, estilo e descrição detalhada)
- **BioCultPapers** removido do inventário de componentes ativos da federação — o repositório é congelado (fora do escopo desta versão); dados existentes migrados uma única vez via script de importação já existente entre as duas aplicações

### Contexto da Versão

O BioCultPapers nasceu como aplicativo desktop separado para suprir, no BioCultDB da época, a ausência de uma forma de processar PDFs com IA. Essa lacuna não existe mais: o BioCultDB ganhou a funcionalidade de Extração por IA diretamente no contexto de Aquisição, eliminando a ponte manual de entrega por arquivo entre as duas aplicações (DA6 do ADR-005). A v3.5 não altera o modelo de dados nem o contrato de harvest — apenas remove um componente cuja razão de existir (rodar fora do BioCultDB) deixou de se aplicar. Fica registrada, sem resolver, uma pendência de vocabulário: o termo "Evidência" foi adotado pelo BioCultDB para o resultado da extração; se o BioCultRelatos usa outro termo para o mesmo conceito, é decisão de vocabulário de arquitetura a cargo do Comitê Federado (ADR-011).

---


## [3.4.0] - 2026-08-01

### Adicionado

- **Proposta de Governança** (`governanca/propostaGovernanca.md`) — documento estruturante que define, em três camadas (dados, ferramentas e arquitetura), quem decide o quê, com que processo e o que acontece quando a decisão muda: princípios C.A.R.E. e a regra de precedência sobre FAIR, marco legal brasileiro e internacional artigo por artigo, a lacuna dos dados coletivos entre a LGPD e a Lei 13.123/2015, casos documentados de apropriação indevida, sete salvaguardas com seus limites declarados, CLPI como ciclo revisável, rotulagem cultural TK/BC, repartição de benefícios rastreável, conformidade LGPD, compromissos negativos, matriz de decisão e catorze lacunas abertas nomeadas
- **Plano de elaboração da proposta** (`governanca/planoPropostaGovernanca.md`) — registro do planejamento que originou o documento de governança, com fontes, correções factuais obrigatórias e critérios de verificação
- **Quatro ilustrações** no sistema visual da arquitetura (SVG fonte + PNG embutido), em `governanca/`: `governanca-tres-camadas`, `governanca-camadas-acesso`, `governanca-ciclo-clpi` e `governanca-reparticao`
- Pasta **`governanca/`** na raiz do repositório, reunindo o documento de governança, seu plano de elaboração e as quatro ilustrações
- Seção de destaque **"Novidade da v3.4 — Proposta de Governança"** no README, com a tabela das três camadas de decisão e link para o documento principal

### Modificado

- **README** promovido à versão 3.4: título, badge de versão, novo badge de governança, Visão Geral, seção "Arquitetura do Sistema", Estrutura da Documentação, Navegação (Proposta de Governança como item 1) e blocos de citação
- **Seção "Licença" do README** passa a apontar para a proposta concreta de licenciamento em três regimes (§6.4 da Proposta de Governança), em vez de apenas registrar a lacuna
- **Diagrama `docs/arquitetura-biocultural.svg/.png`** relabelado de "versão 3.3" para "versão 3.4"; o conteúdo técnico do diagrama não mudou

### Contexto da Versão

A v3.4 não altera o modelo de dados, o contrato de harvest nem qualquer ADR: acrescenta a camada de governança que os ADRs pressupõem mas não descrevem. O documento é publicado com status **"Proposta para consulta"**, submetido à validação das comunidades federadas e do Comitê Federado, e nomeia explicitamente o que ainda não existe — inclusive o bloqueador E4 do ADR-006 (autenticação da decisão do Comitê) e a licença do projeto, para a qual passa a haver proposta concreta (código em licença permissiva OSI, documentação em CC BY 4.0, dados de CTA fora de licença aberta).

---

## [3.3.0] - 2026-07-20

### Adicionado

- **ADR-008: Engine de Banco de Dados do Pluriverso** — fixa SQLite embutida (JSON1 + FTS5, WAL,
  `better-sqlite3`) como engine do índice do Pluriverso, arquivo único externo via `SQLITE_DB_PATH`,
  consolidando o DA7 do ADR-005 com análise dedicada ao workload de agregador
- **ADR-009: Topologia Multi-Instância do Pluriverso** — o Pluriverso passa a ser componente instanciável
  (múltiplas instâncias soberanas: global + privadas/escopadas por associação), cada uma com container e
  arquivo SQLite próprios
- Subseção **"Múltiplas Instâncias do Pluriverso"** no README

### Contexto da Versão

A v3.3 não altera o modelo de dados nem o contrato de harvest; apenas (1) fixa a engine de persistência do
Pluriverso alinhada ao padrão SQLite da federação e (2) reconhece múltiplas instâncias do Pluriverso,
estendendo a soberania à camada de federação — associações podem operar sua própria federação privada sobre
seus `BioCultRelatos`.

---

## [3.2.0] - 2026-07-15

### Adicionado

- **BioCultAcervos**: novo tipo de membro da federação — **Acervos Históricos e Museológicos** — para registrar evidências de conhecimento tradicional preservadas em museus e acervos históricos
- **BioCultNaturalistas**: novo tipo de membro da federação — **Obras de Naturalistas (séc. XVII–XIX)** — para registrar evidências de conhecimento tradicional documentadas em obras de naturalistas em visita ao Brasil
- Subseção **"Iniciativas Governamentais e Institucionais Brasileiras"**, recontextualizando GEF Entre-Ciências, RCS e SISGEN como iniciativas complementares (não como motivação da arquitetura)

### Modificado

- **Motivação e Justificativa** redefinida: a motivação central passa a ser registrar e documentar evidências da relação entre comunidades tradicionais e a biodiversidade, provenientes de múltiplas fontes, com respeito pleno e absoluto aos princípios C.A.R.E. — substituindo a narrativa anterior centrada na "fragmentação de iniciativas"
- **Objetivos** reescritos para refletir as quatro fontes de evidência (secundárias, primárias, acervos históricos/museológicos, obras de naturalistas)
- **Diagrama de arquitetura federada e tabela "Tipos de Membros da Federação"** atualizados de 2 para 4 tipos de membro

### Contexto da Versão

Esta versão não altera a infraestrutura técnica (persistência, federação, harvest — inalteradas desde a v3.1), mas redefine o propósito central da arquitetura: de uma resposta à fragmentação de iniciativas institucionais para uma missão própria — registrar e compartilhar evidências da relação entre comunidades tradicionais e a biodiversidade, de qualquer fonte, com respeito pleno e absoluto aos princípios C.A.R.E. Essa redefinição amplia o escopo de fontes suportadas de duas (secundária/científica e primária/campo) para quatro, incorporando acervos históricos/museológicos (BioCultAcervos) e obras de naturalistas dos séculos XVII-XIX (BioCultNaturalistas).

---

## [3.1.0] - 2026-07-11

### Modificado

- **Persistência de cada unidade federada** migrada de MongoDB para **SQLite com JSON** (JSON1): um arquivo SQLite por unidade, compartilhado pelas ferramentas da unidade (tabelas distintas), em modo WAL, um único container por unidade
- **ADR-001** (Seleção de Banco de Dados) marcado como **Depreciado**, substituído pelo ADR-005
- **Decisão D5 do ADR-004** ("Posição do MongoDB: Pertence à Iniciativa #1") **superada** pelo ADR-005 — o MongoDB deixa de existir na arquitetura; cada unidade passa a operar seu próprio arquivo SQLite
- **Harmonização em todas as ferramentas** da federação: BioCultDB, BioCultTermos, BioCultRelatos, BioCultPapers e pluriverso adotam o mesmo padrão de persistência SQLite+JSON
- **BioCultPapers** deixa de sincronizar diretamente com MongoDB e passa a **entregar dados por arquivo** (exportação de JSON, importado pelo BioCultDB)
- **Contrato de harvest REST** do Pluriverso (D6 do ADR-004) permanece inalterado — a mudança de persistência é transparente à federação

### Adicionado

- **ADR-005: Persistência SQLite com JSON** registrando a decisão de substituir o MongoDB por SQLite+JSON (JSON1) em cada unidade federada, com FTS5 para busca textual e empacotamento em container único por unidade

### Contexto da Versão

Esta versão reforça a soberania de dados introduzida pela federação (v3.0): cada unidade federada passa a operar um banco de dados **embutido, portável e sem servidor** (SQLite), eliminando a dependência de um serviço MongoDB e simplificando drasticamente o empacotamento Docker de cada unidade. O BioCultTermos passa a compartilhar o mesmo arquivo SQLite das demais ferramentas de sua unidade (BioCultDB ou BioCultRelatos), e o BioCultPapers — aplicativo desktop fora dos containers de unidade — passa a entregar seus dados por arquivo, importado explicitamente pelo BioCultDB.

---

## [3.0.0] - 2026-06-08

### Adicionado

- **Pluriverso** como novo componente de arquitetura: middleware de federação
  - Harvest periódico via REST paginado dos endpoints públicos de cada membro (D1)
  - Índice central dos dados públicos federados
  - Camada de mapeamento semântico entre `ConceptScheme`s de membros diferentes (`skos:exactMatch`, `skos:closeMatch`, `skos:broadMatch`) (D2)
  - Governança por comitê federado, com representantes de cada membro (D3)
  - API pública de acesso ao conjunto federado de CTAs

- **ADR-004: Arquitetura Federada v3.0** documentando as decisões estruturantes da federação (D1–D7)

### Modificado

- **Arquitetura redefinida como explicitamente federada**: cada entidade (iniciativa de fontes secundárias ou comunidade tradicional) passa a ser completamente independente e soberana
- **BioCultDB** e **BioCultRelatos**: implementação obrigatória do endpoint `GET /api/federation/records` (paginado, com suporte a `updated_since`) para harvest pelo Pluriverso (D6)
- **BioCultTermos**: cada instância torna-se soberana, com `skos:ConceptScheme` próprio publicado para mapeamento pelo Pluriverso (D2)
- **Posição do MongoDB**: deixa de ser "recurso compartilhado da arquitetura" e passa a ser recurso de infraestrutura pertencente à Iniciativa #1 (BioCultDB + BioCultTermos + BioCultPapers); cada novo membro da federação opera seu próprio MongoDB (D5)
- **Política de saída de membro**: remoção imediata e completa dos dados e mapeamentos do índice central do Pluriverso (D4)
- **BioCultPapers**: permanece exclusivo de iniciativas de fontes secundárias; sem alterações funcionais nesta versão (D7)

### Contexto da Versão

Esta versão resolve uma contradição estrutural entre o modelo centralizado da v2.0 (MongoDB compartilhado entre todos os componentes) e os princípios **C.A.R.E.**: uma comunidade tradicional não tem controle real sobre seu conhecimento se ele reside em um banco gerido por terceiros. A federação torna cada membro soberano sobre sua própria infraestrutura de dados, com o Pluriverso atuando como middleware de coleta (harvest), indexação e mapeamento semântico — nunca como detentor direto dos dados dos membros.

---

## [2.0.0] - 2026-06-08

### Adicionado

- **BioCultRelatos** como novo componente da Arquitetura BioCultural
  - Plataforma para aquisição de dados primários sobre conhecimento tradicional associado à biodiversidade
  - Dados provenientes diretamente de comunidades tradicionais (fontes primárias), com protocolo CLPI
  - Contrasta explicitamente com BioCultDB, que lida com fontes secundárias (artigos científicos)
  - Atua no Contexto de Aquisição, alimentando o mesmo MongoDB compartilhado com BioCultDB e BioCultPapers
  - Suporte terminológico do BioCultTermos (SKOS-XL)
  - Projeto em fase inicial de desenvolvimento

### Modificado

- **BioCultTermos** refatorado com integração total ao BioCultDB
  - Migração do padrão ANSI/NISO Z39.19-2005 para **SKOS-XL** (W3C Simple Knowledge Organization System eXtension for Labels)
  - Integração nativa com BioCultDB em todos os contextos (Aquisição, Curadoria, Apresentação)
  - Vocabulários controlados e tesauros agora representados como Linked Data com URIs
  - Labels reificados via `skosxl:prefLabel` / `skosxl:altLabel` — mais expressivos que USE/UF do Z39.19
  - Exportação atualizada: SKOS-XL/RDF, JSON-LD, Dublin Core, CSV
  - Interoperabilidade ampliada com GBIF, SiBBr, Wikidata e iniciativas internacionais

- **Diagrama de contexto no README** simplificado para nível de abstração mais alto
  - Substituído por diagrama didático mostrando os 4 contextos principais sem detalhes de implementação
  - Mais acessível para novos leitores; diagramas C4 detalhados mantidos em `docs/c4-model/`

- **Documentação técnica** (C4 Model) atualizada para incluir BioCultRelatos e refletir mudanças no BioCultTermos
  - Diagramas de Contexto (Level 1), Containers (Level 2) e Componentes (Level 3) atualizados

### Contexto da Versão

Esta versão marca a expansão da Arquitetura BioCultural para lidar com **ambas as categorias de fontes** de conhecimento tradicional sobre biodiversidade:

1. **Fontes Secundárias** (BioCultDB + BioCultPapers): conhecimento extraído de artigos científicos, livros e publicações
2. **Fontes Primárias** (BioCultRelatos): conhecimento registrado diretamente com comunidades tradicionais, com todos os protocolos éticos e legais (CLPI, Lei 13.123/2015)

A migração do BioCultTermos para SKOS-XL fortalece a interoperabilidade com padrões da web semântica (Linked Data), facilitando integração com sistemas externos como GBIF, SiBBr e iniciativas internacionais de biodiversidade.

---

## [1.4.0] - 2026-01-04

### Adicionado

- **etnoChat** como componente da camada de Apresentação do BioCultDB
  - Interface conversacional para interação em linguagem natural
  - Integração com Model Context Protocol (MCP) para comunicação com IA
  - Processamento de perguntas sobre comunidades, plantas e usos tradicionais
  - Sugestões automáticas de buscas relacionadas
  - Explicações contextualizadas com citação de fontes
  - Acessível via rota `/etnochat` na porta 3003

- **Painel Analítico** como componente da camada de Apresentação do BioCultDB
  - Dashboard interativo para exploração e análise visual dos dados
  - Cartões resumidos: comunidades, referências, plantas, autores
  - Visualizações geográficas: mapas de calor por estado
  - Gráficos interativos: evolução temporal, top 10 plantas
  - Tabelas analíticas: autores produtivos, diversidade botânica
  - Filtros avançados: estado, tipo de comunidade, período
  - Stack: Google Charts, HTMX, Alpine.js, Tailwind CSS
  - Acessível via rota `/painel` na porta 3003

- **Novos diagramas de componentes** para etnoChat e Painel Analítico
  - NLP Service para processamento de linguagem natural
  - MCP Client Service para comunicação com modelos de IA
  - Query Generator para conversão de intenções em queries MongoDB
  - Aggregation Service para pipelines de análise
  - Cache Service para otimização de performance

### Modificado

- **Diagrama de Contexto** atualizado com novos componentes na Apresentação
- **Diagrama de Containers** atualizado com etnoChat e Painel Analítico
- **Diagrama de Componentes** expandido com detalhamento técnico dos novos serviços
- **README.md** atualizado para versão 1.4 com documentação das novas funcionalidades
- Diagrama de integração entre projetos atualizado para mostrar fluxos do etnoChat e Painel

### Contexto da Versão

Esta versão expande significativamente a camada de Apresentação do sistema com duas novas interfaces de acesso aos dados:

1. **etnoChat** democratiza o acesso ao conhecimento etnobotânico permitindo que usuários façam perguntas em linguagem natural, sem necessidade de conhecer sintaxes de busca ou estrutura do banco de dados. A integração com MCP permite respostas contextualizadas e inteligentes.

2. **Painel Analítico** oferece uma visão macro dos dados através de visualizações interativas, permitindo identificar padrões geográficos, temporais e de frequência que seriam difíceis de perceber através de buscas individuais.

Ambos os componentes utilizam a mesma base de dados MongoDB e respeitam o workflow de curadoria, exibindo apenas dados aprovados ao público.

---

## [1.3.0] - 2026-01-04

### Adicionado

- **BioCultTermos** como container implementado na arquitetura
  - Plataforma de gestão terminológica com glossários, vocabulários controlados e tesauros
  - Conformidade com padrão internacional ANSI/NISO Z39.19-2005
  - Relações hierárquicas (BT/NT), equivalência (USE/UF) e associativas (RT)
  - Sistema de notas Z39.19 (escopo, catalogador, histórica, bibliográfica, privada, definição, exemplos)
  - Busca inteligente com Meilisearch
  - Exportação em formatos padrão (SKOS, RDF, Dublin Core, CSV)
  - APIs REST para integração com outros sistemas
  - Autenticação OAuth Google
  - Containerização com Docker e GitHub Actions

- **Semantic Validation Service** no contexto de Curadoria
  - Validação semântica de termos vernaculares via BioCultTermos
  - Normalização automática de nomenclatura popular
  - Desambiguação de termos homônimos
  - Sugestão de correções para termos não encontrados
  - Enriquecimento com relações hierárquicas e associativas

- **Novo ator: Terminólogo**
  - Responsável por gerenciar glossários, vocabulários e tesauros
  - Garante conformidade com padrão ANSI/NISO Z39.19
  - Documenta termos com notas de escopo, definições e exemplos

### Modificado

- **Diagrama de Contexto** atualizado para incluir BioCultTermos como sistema interno implementado
- **Diagrama de Containers** atualizado com BioCultTermos e Semantic Validation Service
- **Diagrama de Componentes** atualizado com detalhamento do Semantic Validation Service
- **README.md** atualizado para versão 1.3 com documentação completa do BioCultTermos
- Diagrama de integração entre projetos atualizado para mostrar fluxos com BioCultTermos
- Tabela de decisões de tecnologia atualizada com BioCultTermos e Semantic Validation Service

### Contexto da Versão

Esta versão introduz o BioCultTermos como **infraestrutura terminológica transversal** que conecta os três contextos arquiteturais. O BioCultTermos resolve o desafio de padronização terminológica no domínio etnobotânico, onde múltiplos nomes vernaculares podem referir-se à mesma espécie ou uso.

A integração permite:
- **Aquisição**: Autocomplete de termos validados e sugestão de sinônimos durante entrada de dados
- **Curadoria**: Validação semântica automática, normalização de termos e desambiguação
- **Apresentação**: Navegação por tesauros estruturados e busca expandida por sinônimos

O BioCultTermos segue os **princípios CARE** para governança de dados indígenas, garantindo rastreabilidade das fontes de termos (bibliográficas ou conhecimento tradicional) e respeito à autoridade das comunidades sobre sua terminologia.

---

## [1.2.0] - 2025-12-28

### Adicionado

- **BioCultDB** como container implementado na arquitetura
  - Interface web com três contextos distintos (Aquisição, Curadoria, Apresentação)
  - Tecnologias: Node.js, Express, MongoDB, HTMX, Alpine.js, Tailwind CSS
  - Banco de dados para conhecimento tradicional secundário (artigos científicos)
  - Implementação concreta dos princípios C.A.R.E.
  - Portas: 3001 (Aquisição), 3002 (Curadoria), 3003 (Apresentação)

- **BioCultPapers** como container implementado na arquitetura
  - Aplicativo desktop Windows (.NET 8, WPF, MVVM)
  - Extração automatizada de metadados de PDFs usando IA
  - Integração com múltiplos provedores de IA (Google Gemini, OpenAI GPT-4o-mini, Anthropic Claude 3.5 Haiku)
  - Integração nativa com MongoDB (Atlas ou local)
  - Processamento de campos obrigatórios (título, autores, ano, abstract) e opcionais (espécies, usos, comunidades)

- Histórico de versões (este arquivo CHANGELOG.md) documentando toda evolução da arquitetura

### Modificado

- **Diagrama de Containers** atualizado para incluir BioCultDB e BioCultPapers como elementos concretos
- **Diagrama de Contexto** refinado para refletir a integração dos novos containers
- **README.md** atualizado para versão 1.2 com referências aos projetos implementados
- Documentação de integração entre containers no contexto de Aquisição

### Contexto da Versão

Esta versão marca a transição de uma arquitetura puramente conceitual para uma arquitetura com implementações concretas. Os projetos BioCultDB e BioCultPapers representam a materialização dos conceitos de aquisição e curadoria de dados etnobotânicos, validando as decisões arquiteturais anteriores e fornecendo casos de uso reais.

---

## [1.1.0] - 2025-01-06

### Adicionado

- **Territory & Authority Service** no contexto de Curadoria
  - Validação territorial de proveniência do conhecimento
  - Integração com Plataforma de Territórios Tradicionais do MPF
  - Validação contra fontes autoritativas configuráveis
  - Enriquecimento de registros com rastreabilidade territorial

- **Validation Service** expandido com estratégia dual
  - Flora e Funga do Brasil como validação primária para flora/fungos
  - Fauna do Brasil como validação primária para fauna
  - GBIF como fallback para ambos os casos
  - Detecção automática de tipo de organismo

- **Outras Fontes Autoritativas** como categoria de sistema externo
  - Padrão extensível para integração com sistemas especializados
  - Suporte a SISGEN, SiBBr, registros comunitários
  - Validação em cascata configurável

### Modificado

- **Diagrama de Containers** com novo serviço Territory & Authority Service
- **Diagrama de Contexto** incluindo Plataforma de Territórios Tradicionais e Outras Fontes Autoritativas
- Fluxo de curadoria atualizado com validação territorial
- Estratégia de validação taxonômica refinada

### Contexto da Versão

Esta versão fortalece a conformidade legal com a Lei 13.123/2015 através da rastreabilidade territorial e proveniência do conhecimento tradicional. A integração com a Plataforma de Territórios Tradicionais do MPF permite associar registros aos territórios de origem, garantindo que comunidades mantenham autoridade sobre seu conhecimento.

---

## [1.0.0] - 2025-01-05

### Versão Inicial

Primeira versão completa da proposta de arquitetura para Sistema de Informações sobre Conhecimento Tradicional Associado à Biodiversidade.

#### Componentes Principais

- **Três Contextos Arquiteturais:**
  - Aquisição: entrada de dados de múltiplas fontes
  - Curadoria: validação e qualificação de dados
  - Apresentação: acesso público e APIs

- **Diagrama C4 Model:**
  - Level 1 (Contexto): Usuários e sistemas externos
  - Level 2 (Containers): Componentes técnicos
  - Level 3 (Componentes): Detalhamento interno

- **Containers Principais:**
  - Frontend Layer: Web Application, Portal Público
  - API Gateway Layer: Roteamento, autenticação, rate limiting
  - Acquisition Services: API, Crawler, ETL, Message Queue
  - Curation Services: API, Validation Service, Notification Service
  - Presentation Services: Public API, Search Service, Export Service
  - Data Layer: MongoDB, Cache (Redis), Object Storage

- **Integrações Externas:**
  - GBIF para validação taxonômica
  - Periódicos científicos para coleta automática
  - Outros sistemas etnobotânicos

- **Architecture Decision Records (ADRs):**
  - ADR-001: Seleção de Banco de Dados (Orientado a Documentos)
  - ADR-002: Padrões de API (REST + GraphQL)
  - ADR-003: Modelo de Dados (Hierárquico e Flexível)

#### Princípios e Conformidade

- **Princípios C.A.R.E.** (Collective Benefit, Authority to Control, Responsibility, Ethics)
- **Conformidade Legal:**
  - Lei 13.123/2015 (Lei da Biodiversidade)
  - Protocolo de Nagoya
  - LGPD (Lei Geral de Proteção de Dados)

#### Integrações com Iniciativas Brasileiras

- **Projeto GEF Entre-Ciências** (MCTI 2025-2029)
- **Rede de Conhecimentos sobre Sociobiodiversidade** (ICMBio/UFSC)
- **Modernização do SISGEN** (RNP-MMA-BID)
- **Useflora** (UFSC)

#### Padrões de Dados

- Darwin Core para ocorrências de espécies
- Plinian Core para descrições de espécies
- Dublin Core Estendido para metadados
- SocioBio Standard para sociobiodiversidade

#### Características Técnicas

- Arquitetura de microserviços
- Message-driven para processamento assíncrono
- API Gateway para roteamento centralizado
- Cache distribuído para performance
- Search service para busca avançada
- Workflow de curadoria com estados
- Autenticação JWT e OAuth 2.0
- Monitoramento e observabilidade (Prometheus, Grafana, OpenTelemetry)

#### Documentação

- README completo com visão geral
- Referências bibliográficas (Referencias.md) em formato ABNT
- Diagramas Mermaid para visualização
- Documentação de fluxos e padrões de integração

---

## Tipos de Mudanças

- `Adicionado` para novas funcionalidades
- `Modificado` para mudanças em funcionalidades existentes
- `Descontinuado` para funcionalidades que serão removidas
- `Removido` para funcionalidades removidas
- `Corrigido` para correções de bugs
- `Segurança` para vulnerabilidades

---

## Links de Versões

- [3.1.0] - 2026-07-11 (versão atual - persistência SQLite com JSON por unidade federada)
- [3.0.0] - 2026-06-08 (arquitetura federada com Pluriverso)
- [2.0.0] - 2026-06-08 (BioCultRelatos e migração do BioCultTermos para SKOS-XL)
- [1.4.0] - 2026-01-04 (etnoChat e Painel Analítico)
- [1.3.0] - 2026-01-04 (integração BioCultTermos)
- [1.2.0] - 2025-12-28
- [1.1.0] - 2025-01-06
- [1.0.0] - 2025-01-05 (versão inicial publicada no Zenodo: https://doi.org/10.5281/zenodo.17714765)
