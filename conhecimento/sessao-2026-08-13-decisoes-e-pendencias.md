# Registro da sessão de 2026-08-13 — Conhecimento × Evidência

**O que esta sessão produziu:** a distinção entre *Conhecimento* e *Evidência* deixou de ser implícita e virou decisão de arquitetura (ADR-015), glossário da federação e texto do README.
**O que esta sessão não produziu, e não podia:** as decisões que só a comunidade pode tomar — reunidas em **[§5](#5-o-que-precisa-ser-conversado-com-a-comunidade)**, a parte deste documento feita para sair do computador.
**Commit:** `fc3ebe2` em `main` — 917 inserções, 8 arquivos.

---

## 1. Resumo em seis linhas

A arquitetura chamava tudo de **Evidência** e organizava por procedência (artigo, campo, acervo, obra de naturalista). Um vídeo de 42 segundos — um homem Panará, ao pé de uma árvore, descrevendo seus usos **na língua Panará** — expôs que essa organização achatava duas coisas diferentes. *Evidência* é a atestação, **por um terceiro**, de que a relação de uma comunidade com a biodiversidade existe. *Conhecimento* é essa relação **enunciada por quem a detém**. A diferença não é de valor nem de veracidade: é de **voz e autoridade** — e o que ela decide, na prática, é **quem pode classificar o nível de acesso** daquele registro. Foi criado o ADR-015 para tornar isso um campo do dado, e não uma convenção que alguém precisa lembrar.

---

## 2. O que foi pedido e o que foi feito

| Pedido | Resposta |
|---|---|
| Excluir `*.mp4` do repositório remoto | `.gitignore` atualizado. Motivação foi tamanho; o efeito é exigido por `propostaGovernanca.md` §5.10 — o único original de gravação de CLPI não pode viver em plataforma de terceiros, e um remoto público é plataforma de terceiros |
| Pesquisar e caracterizar "conhecimento tradicional" na arquitetura | `conhecimento/caracterizacao-do-conhecimento-tradicional.md` — 468 linhas, com o prompt, 10 ambiguidades atuais localizadas por arquivo e linha, fundamentação, ganchos técnicos verificados nas fontes primárias, o caso Panará modelado ponta a ponta |
| "Você concorda que existe diferença e que precisa ser tratada?" | Sim, com uma correção no argumento — §3 |
| Prosseguir para o próximo passo | ADR-015 + glossário + README + CHANGELOG, commitados |
| Explicar o que falta decidir | Este documento |

---

## 3. A correção no argumento

Vale registrar, porque muda o desenho: a distinção **não** é *fato objetivo × afirmação subjetiva*.

Se fosse, seria uma hierarquia epistêmica — conhecimento valendo menos que dado — e reintroduziria por via técnica exatamente o que os princípios C.A.R.E. existem para desfazer. A própria governança do projeto já proíbe isso: `propostaGovernanca.md:415` estabelece que **a validação comunitária pode reverter a curadoria científica**.

O eixo é **deôntico**: quem fala, e quem manda no que foi dito.

> **Evidência não é conhecimento de segunda categoria. É conhecimento com outro dono.**
> Uma obra de 1817 é fonte insubstituível. O naturalista europeu que anotou o uso de uma planta não é o autor daquele conhecimento — é a testemunha que o registrou. É a leitura que `propostaGovernanca.md:400` já faz, com base no art. 45 da Lei 9.610/1998, que ressalva "a proteção legal aos conhecimentos étnicos e tradicionais" mesmo em obra de domínio público.

E uma consequência: **o regime é do registro, não da ferramenta.** Na prática BioCultDB, BioCultAcervos e BioCultNaturalistas são Evidência sempre; o único provedor com os dois regimes é o BioCultRelatos — a nota de campo do pesquisador é Evidência, porque é testemunho dele. Quando uma comunidade narra sobre um item de acervo, esse Relato vive **na unidade dela**, referenciando o item: `Conteúdo Soberano` proíbe que conteúdo de uma unidade atravesse para outra, e gravar o relato da comunidade no SQLite do museu seria soberania invertida. A coexistência das duas narrativas — a lição do Mukurtu em `propostaGovernanca.md:419` — acontece **na federação**, com dois registros vinculados.

---

## 4. O que ficou decidido (ADR-015, status *Proposto*)

| # | Decisão |
|---|---|
| **K1** | Regime Enunciativo (`conhecimento` \| `evidencia`) é **campo do registro**, decidido por um teste de quatro perguntas na aquisição |
| **K2** | A unidade de Conhecimento é o **Relato**: detentor + ato de enunciação + mídia-fonte + classificação de acesso. Mapeia para `dwc:Assertion` do Darwin Core Data Package. Vive sempre na unidade da comunidade detentora |
| **K3** | **Três níveis de rotulagem** — Termo (`skosxl:Label`), Relato, Registro/Mídia. O nível efetivo é o **mais restritivo dos três**, e nunca se herda de cima para baixo |
| **K4** | **Label** (TK/BC) só sobre Conhecimento — a comunidade aplica. **Notice** sobre Evidência — a instituição declara enquanto a comunidade não se manifesta |
| **K5** | Língua do Relato em **ISO 639-3** obrigatória. Transcrição e tradução são entidades **derivadas** e nunca substituem a gravação |
| **K6** | O harvest passa a carregar nível efetivo e supressão declarada. **Supersede o contrato de payload do ADR-004 D6** |
| **K7** | Relato **nasce `restricted`** e só vira público por ato positivo da comunidade. Termo mantém o padrão `public` do vocabulário |

**Por que `Proposto` e não `Aceito`:** o ADR-003, do qual esta decisão depende, está `Proposto — aguardando validação com comunidades`. Marcar `Aceito` seria declarar validado o que ainda não foi conversado.

---

## 5. O que precisa ser conversado com a comunidade

> **Esta é a seção que não se resolve no computador.**
>
> A arquitetura promete que a comunidade é a autoridade sobre o próprio conhecimento. Se as decisões abaixo forem tomadas no escritório — mesmo com boa intenção, mesmo tecnicamente bem fundamentadas —, a promessa vira texto. São escolhas cuja legitimidade **depende de quem responde**, não de quão bem sejam justificadas.

### 5.0 A linha divisória

| Decidível daqui | Só decidível com a comunidade |
|---|---|
| Nome dos campos, formato do payload, onde o filtro roda | **Como a pessoa que fala quer ser nomeada** |
| Qual padrão técnico adotar (`dwc:Assertion`, PROV-O, ISO 639-3) | **Quais rótulos culturais se aplicam, e a quê** |
| Que o Relato nasce restrito | **Quando ele deixa de ser restrito** |
| Que existe um campo de nível de acesso | **O valor daquele campo, registro a registro** |
| Que há conhecimento que não deve ser digitado | **Qual conhecimento é esse** |

A coluna da esquerda é engenharia. A da direita é `propostaGovernanca.md:305` — *"a decisão de camada é da comunidade e é revisável a qualquer tempo; não é atribuição do curador, do mantenedor da instância nem do Comitê Federado"*.

---

### Pauta 1 — Como quem fala quer ser nomeado

**O impasse, sem jargão.** No vídeo, quem fala é uma pessoa. O sistema precisa registrar *alguém* como autor daquele conhecimento. E há duas obrigações que se contradizem:

- **Proteger.** Voz, imagem e etnia juntas são dado pessoal sensível (LGPD, art. 11).
- **Reconhecer.** A pessoa tem direito de ser identificada como detentora do conhecimento (CARE A1; Lei 13.123/2015).

Apagar o nome "para proteger" é o que a ciência fez por um século com informantes indígenas: o conhecimento vira patrimônio da publicação, e quem sabia vira "informante anônimo, 60-70 anos".

**Três caminhos, e quem escolhe:**

| | O sistema guarda | O público vê | Quem decidiu |
|---|---|---|---|
| A | nome real, protegido | "um ancião Panará" | nós |
| B | só o coletivo: "Panará", a aldeia | "Panará" | nós |
| C | pseudônimo escolhido pela pessoa | o pseudônimo | **ela** |

**As perguntas para levar a campo:**

1. Você quer que seu nome apareça junto do que você contou, ou não?
2. Se não quiser o nome, prefere que apareça como quê — o povo, a aldeia, um nome que você escolha?
3. A resposta é a mesma para tudo que você contar, ou muda dependendo do assunto?
4. Se você mudar de ideia daqui a cinco anos, quem podemos procurar?
5. Quando não for uma pessoa, mas o grupo que contou junto — como esse grupo quer ser nomeado?

**Por que não dá para presumir:** a resposta 3 é a que ninguém antecipa. É perfeitamente possível que a mesma pessoa queira ser nomeada num uso alimentar e não queira em nada que toque ritual — e isso não é detalhe de preenchimento, é a estrutura do campo.

---

### Pauta 2 — Quais rótulos culturais se aplicam

Existem **20 TK Labels** e **10 BC Labels** padronizados internacionalmente (Local Contexts), em três famílias: *procedência* (de quem é), *protocolo* (sob que regras circula: sazonal, restrito por gênero, secreto/sagrado) e *permissão* (o que se pode fazer: uso comunitário apenas, sem uso comercial, aberto a colaboração).

**A regra é dura e é o ponto:** instituição **não pode** aplicar Label em nome de comunidade. Enquanto ela não escolhe, a instituição só pode declarar um *Notice* — que significa, literalmente, "há origem indígena aqui, e ela ainda não foi consultada".

**As perguntas:**

1. Este conhecimento tem época certa para ser contado, ou pode ser contado a qualquer tempo?
2. Há coisas aqui que só homens contam, ou só mulheres? Que só certas famílias contam?
3. Pode ser usado em escola? Em pesquisa? Alguém pode ganhar dinheiro com isso?
4. Quem, na comunidade, tem legitimidade para dizer isso em nome de todos — e isso é um cargo, um conselho, uma assembleia?
5. Vocês querem aplicar os rótulos vocês mesmos, num sistema próprio, ou preferem que nós registremos o que vocês disserem?

A pergunta 5 é técnica com consequência política: se a comunidade aplica no Hub do Local Contexts, o rótulo permanece **sob controle dela** e muda no nosso sistema quando ela mudar. Se nós copiarmos para dentro do nosso banco, passamos a controlar uma coisa que é dela.

---

### Pauta 3 — O vídeo Panará, especificamente

Quatro pendências, nenhuma resolvível daqui. Enquanto existirem, o arquivo é `restricted` de fato e não atravessa o harvest.

| # | Pendência | Situação |
|---|---|---|
| 1 | **CLPI** | Pergunta se existe consentimento livre, prévio e informado, aprovação de comitê de ética, autorização FUNAI e cadastro SisGen. **Não há resposta registrada.** Sem isso o registro não é publicável — `visibility: public` é consequência do CLPI, nunca substituto dele |
| 2 | **Consentimento específico para imagem e voz** | Gravar em vídeo aciona três regimes ao mesmo tempo: direito de personalidade (Código Civil, art. 20), dado sensível (LGPD, art. 11 — exige consentimento **específico e destacado**) e forma legal de comprovar o CLPI (Lei 13.123/2015, art. 9º, §1º, II). Um termo genérico não cobre os três |
| 3 | **Transcrição em Panará** | Não existe. Precisa de falante nativo. A tradução para o português é entidade **derivada** — e derivada com perda, porque a língua é constitutiva do conhecimento, não seu veículo (CARE R3) |
| 4 | **Grafia** | O próprio repositório Panará anota que a grafia dos nomes precisa ser verificada com pesquisadores Panará (Sophoa, Sewa). O nome da planta é a informação mínima do relato: grafia não verificada é identidade comprometida |

**Um detalhe que vale contar à comunidade**, porque é sobre eles: o código internacional da língua Panará é `kre`. Até 2007 esse código se chamava oficialmente *"Kreen-Akarore"* — nome vindo de fora, de um termo Kayapó. Um pedido formal de correção (solicitação 2006-019) trocou o nome do registro para **Panará**, o autônimo, que na língua significa "gente". O padrão mundial de línguas foi corrigido porque alguém pediu. É exatamente o que se propõe fazer aqui com o vocabulário.

---

### Pauta 4 — O que não deve ser registrado

A conversa mais importante, e a que um documento técnico tende a omitir.

`propostaGovernanca.md:286`: um nível de acesso `sacred` protege contra acesso indevido **pelo sistema**. Não protege contra a existência do registro — contra cópia de backup, erro de operação, apreensão de equipamento, ou o simples fato de que alguém digitou.

> **Para conhecimento sagrado ou iniciático, a decisão correta pode ser não registrar.**
> Oferecer um campo para o caso não é o mesmo que oferecer a opção de não usar o campo. A plataforma tem obrigação de dizer isso — na consulta prévia, na formação de quem opera, e não só na documentação.

**As perguntas:**

1. Há coisas que vocês preferem que não entrem em computador nenhum?
2. Se entrarem por engano, como vocês querem ser avisados, e o que deve acontecer?
3. Quem, na comunidade, precisa ser consultado antes de qualquer registro novo?

---

### 5.5 Como conduzir, para não repetir o erro que se quer evitar

- **Na língua da comunidade.** `propostaGovernanca.md:396` e CARE R3: consulta conduzida apenas em português não é necessariamente consulta informada. O campo `consent.language` existe para registrar isso.
- **Pelo protocolo da comunidade, se houver.** A Lei 13.123/2015, art. 9º, §1º admite **quatro formas** de comprovar o consentimento, **à escolha da comunidade**: termo assinado, **registro audiovisual**, parecer de órgão oficial, ou **adesão na forma de protocolo comunitário próprio**. A quarta é a porta de entrada dos protocolos comunitários no direito brasileiro, e é frequentemente a mais adequada — e a menos oferecida, porque a primeira é a mais cômoda para quem coleta.
- **Consentimento é relação, não assinatura.** Escopo, finalidade, prazo, usos permitidos e revogação são registrados **como dado**, versionados, e não como PDF anexado que ninguém relerá.
- **Revogação sem justificativa, a qualquer momento.** Não é concessão: é o desenho.
- **Com retorno.** O que a comunidade recebe de volta, em formato que ela use, é parte da conversa — não uma etapa posterior.

---

### 5.6 Roteiro mínimo para levar a campo

Se for para levar uma folha só:

1. Como você quer ser nomeado no que você contou? *(ou: você prefere não ser nomeado?)*
2. Isso que você contou pode ser mostrado para quem? Todo mundo, só pesquisadores, só a comunidade?
3. Tem época certa? Tem restrição de quem pode contar ou ouvir?
4. Pode ser usado em escola? Em pesquisa? Alguém pode ganhar dinheiro?
5. Tem coisa que é melhor não guardar em computador?
6. Quem decide isso pela comunidade — e como essa pessoa ou grupo é escolhido?
7. Se mudarem de ideia, quem procurar, e o que deve acontecer com o que já foi publicado?

---

## 6. O que pode ser decidido sem a comunidade

Separado honestamente do §5. São escolhas de engenharia, reversíveis, com recomendação.

| # | Questão | Recomendação | Reversível? |
|---|---|---|---|
| ③ | Nome do verbete: "Enunciado" ou "Relato"? | **Decidido em 2026-08-13: `Relato`** — ver nota abaixo | Já aplicado |
| ④ | O regime entra no glossário da federação? | **Sim — já aplicado.** Se decide o que atravessa o harvest, é linguagem da federação | Sim |
| ⑤ | Vocabulário controlado de `assertionType` | Adiar. É matéria do Comitê e do BioCultTermos | — |

**Nota sobre ③, para desfazer um mal-entendido.** O `_Avoid_: Relato` escrito no glossário **não descarta a palavra de lugar nenhum**. `grep` confirma que "Relato" não é termo definido em `CONTEXT.md`, no `README.md` nem no ADR-003 — aparece só como prosa corrente (`README.md:20,56`) e como nome próprio de duas coisas que **não mudam**: a unidade hospedeira **BioCultRelatos** e a tabela `relatos` do projeto Panará/JBRJ (`dadosEtnoJBRJ_Panara/relatos.md`, outro repositório, modelo de trabalho de um projeto). O alcance da nota é uma linha só: *no glossário da federação, o verbete da unidade de Conhecimento não se chama "Relato"*. É a mesma convenção que o glossário já usa quando escreve `_Avoid_: Taxonomia` sob *Vocabulário Controlado* — sem que ninguém tenha apagado "taxonomia" do projeto.

O mérito é apertado, e vale registrar os dois lados:

- **A favor de "Relato"**, e foi o que se decidiu — já em uso, português natural, e a unidade que mais produz Conhecimento chama-se BioCultRe*latos*: a coerência é boa. O modelo Panará já define a entidade com precisão: *"a menção de uma planta por um participante (ou grupo) em um contexto específico"*.
- **Contra, e o que se respondeu** — *relato* carrega um traço de terceira pessoa. Aceito: o glossário resolve pela definição, que exige detentor. A objeção original — "um Relato dentro do BioCultAcervos lê-se como erro" — **caiu junto com a correção do caso Acervos**: esse Relato nunca esteve no Acervos, está na unidade da comunidade.

---

## 7. Próximos passos

**Prontos para executar, sem depender de ninguém:**

1. Nota de retificação no **ADR-003**, apontando K1/K2/K5 — texto original preservado abaixo da nota, como o repositório já faz desde o ADR-001.
2. Nota de retificação no **ADR-004 D6**, apontando K6.
3. **Contrato de payload do harvest**, campo a campo, com o teste automatizado que reprova qualquer registro de nível efetivo diferente de `public` atravessando o endpoint.

**Bloqueados nas Pautas 1 e 2 do §5:**

4. Esquema do Relato como tabela — o formato de `relato.detentor` depende da Pauta 1; o de `rotulosCulturais` depende da Pauta 2.

**Bloqueado na Pauta 3:**

5. Piloto do vídeo Panará ponta a ponta, que é o que validaria o modelo inteiro contra um caso real.

Passos 1–3 podem começar agora e não presumem nenhuma resposta da comunidade. É a divisão que respeita o que dá para decidir daqui e o que não dá.

---

## 8. Rastreabilidade

| Artefato | Onde |
|---|---|
| Estudo completo, com fontes e o caso modelado | `conhecimento/caracterizacao-do-conhecimento-tradicional.md` |
| Decisão de arquitetura | `docs/architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md` |
| Glossário da federação | `CONTEXT.md`, seção "Conhecimento e evidência" |
| Governança de acesso, CLPI e rotulagem | `governanca/propostaGovernanca.md` §5.1–§5.10 |
| Rótulos SKOS-XL e `accessLevel` | `BioCultDB/bioculttermos/manual/03-rotulos.md` |
| Commit | `fc3ebe2` — `docs: ADR-015 — regime enunciativo (Conhecimento × Evidência) e rotulagem de acesso` |
