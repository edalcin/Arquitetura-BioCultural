# Pauta com as comunidades tradicionais — o que a arquitetura precisa ver encaminhado

**O que este documento é.** Não é mais um registro de sessão de trabalho — isso já vive em `docs/proximosPassos.md`. Este é o documento objetivo do Ponto-Focal: o que a Arquitetura BioCultural precisa ver encaminhado com comunidades tradicionais para poder seguir. Foi feito para sair do computador. Quem o recebe precisa conseguir lê-lo inteiro e agir a partir dele, sem precisar abrir mais nada.

**Para quem é.** O leitor principal é o **Ponto-Focal** — a pessoa indicada por uma iniciativa parceira (hoje, o Comitê Gestor do USEFLORA) para conversar com esta arquitetura. A resposta do Ponto-Focal é a **posição da iniciativa que o indicou**: informada, tecnicamente competente, e válida para as perguntas que dizem respeito a como a arquitetura deve se comportar em geral. Ela **nunca** é o consentimento da comunidade detentora sobre um registro concreto — a titularidade do conhecimento tradicional associado é sempre coletiva e da comunidade que o detém (Lei nº 13.123/2015, art. 10, §1º; `governanca/propostaGovernanca.md` §5.1). O Ponto-Focal desenha o campo; nunca preenche o valor dele.

**Onde isto se encaixa na governança.** As três camadas de governança descritas em `governanca/propostaGovernanca.md` §2 são uma **proposta em consulta**, não uma estrutura em funcionamento — o próprio documento se declara "Proposta para consulta". O Comitê Federado que a proposta descreve **não existe ainda**. O único mecanismo de governança em operação real, hoje, é o Ponto-Focal indicado por uma iniciativa parceira; enquanto isso, o pesquisador responsável (Eduardo Dalcin, JBRJ) acumula, na prática, as três camadas que a proposta separa. É por isso que este documento — e não uma ata de comitê — é o instrumento disponível para levar pendências a quem pode falar por uma iniciativa.

> **Nada aqui se decide no computador.** A arquitetura promete que a comunidade é a autoridade sobre o próprio conhecimento. Se as perguntas abaixo forem respondidas no escritório — mesmo com boa intenção, mesmo tecnicamente bem fundamentadas —, a promessa vira texto. São escolhas cuja legitimidade depende de quem responde, não de quão bem sejam justificadas.

---

## A linha divisória

| Decidível daqui | Só decidível fora do computador |
|---|---|
| Nome dos campos, formato do payload, onde o filtro roda | **Como a pessoa que fala quer ser nomeada** |
| Qual padrão técnico adotar (`dwc:Assertion`, PROV-O, ISO 639-3) | **Quais rótulos culturais se aplicam, e a quê** |
| Que o Relato nasce restrito | **Quando ele deixa de ser restrito** |
| Que existe um campo de nível de acesso | **O valor daquele campo, registro a registro** |
| Que há conhecimento que não deve ser digitado | **Qual conhecimento é esse** |

A coluna da esquerda é engenharia, já decidida. A da direita é `propostaGovernanca.md:305` — *"a decisão de camada é da comunidade e é revisável a qualquer tempo; não é atribuição do curador, do mantenedor da instância nem do Comitê Federado"*. Este documento trata inteiramente da coluna da direita, mas ela não é homogênea: uma parte pode ser respondida por um corpo de representação mista informado sobre o assunto (**Pautas de desenho**), outra parte só pode ser respondida pela comunidade detentora daquele registro específico, um de cada vez (**Pautas de consentimento**).

### Como conduzir a conversa, para não repetir o erro que se quer evitar

- **Na língua da comunidade.** CARE R3 e `propostaGovernanca.md` §5.3, campo `consent.language` (`propostaGovernanca.md:330`): consulta conduzida apenas em português não é necessariamente consulta informada.
- **Pelo protocolo da comunidade, se houver.** A Lei nº 13.123/2015, art. 9º, §1º admite **quatro formas** de comprovar o consentimento, **à escolha da comunidade**: termo assinado, registro audiovisual, parecer de órgão oficial, ou adesão na forma de protocolo comunitário próprio. A quarta é a porta de entrada dos protocolos comunitários no direito brasileiro, e é frequentemente a mais adequada — e a menos oferecida, porque a primeira é a mais cômoda para quem coleta.
- **Consentimento é relação, não assinatura.** Escopo, finalidade, prazo, usos permitidos e revogação são registrados como dado, versionados — não como PDF anexado que ninguém relerá.
- **Revogação sem justificativa, a qualquer momento.** Não é concessão: é o desenho.
- **Com retorno.** O que a comunidade recebe de volta, em formato que ela use, é parte da conversa — não uma etapa posterior.

---

## Pautas de desenho

Respondem a **"como a arquitetura deve se comportar"**. São decidíveis com um corpo de representação mista e informada — o Comitê Gestor do USEFLORA, misto de academia e comunidades tradicionais, basta para isso. Nenhuma delas pede o valor de um registro específico; todas pedem uma regra geral, e cada uma já opera hoje sob uma **regra interina** que precisa ser confirmada ou corrigida.

### Pauta 5 — Gravações de prática e oficinas coletivas

**O impasse, sem jargão.** Uma oficina, um mutirão, uma roda de conversa gravada em vídeo: várias pessoas aparecem e falam na mesma gravação, e o conhecimento registrado é de todas elas ao mesmo tempo. `docs/architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md` (K8.3) já identificou que cada participante é detentor com direito próprio sobre a própria voz e imagem — mas não decide como o grupo deve funcionar quando as pessoas dentro dele não decidem igual.

**A regra interina, hoje em vigor sem validação:** se um participante pede reserva, **a gravação inteira sai** — não apenas a parte dele. É a leitura mais conservadora possível da regra do "mais restritivo" (K3), aplicada a um eixo novo — entre pessoas, e não entre termo, Relato e registro.

**As perguntas para levar a quem tiver autoridade sobre gravações coletivas:**

1. Quando várias pessoas participam de uma gravação — uma oficina, um mutirão —, quem autoriza: cada pessoa decide sobre a própria imagem e voz, ou o grupo decide junto pela gravação inteira?
2. Se uma pessoa participante mudar de ideia depois de gravado e quiser sair, o que deve acontecer: a gravação é editada para tirar essa pessoa, ou ela sai inteira do ar? *(a regra interina hoje é a segunda opção — está certa?)*
3. Dentro do grupo, quem fala pela gravação como um todo quando é preciso decidir algo que afeta todo mundo — e como essa pessoa é escolhida?
4. O consentimento de cada pessoa sobre a própria imagem é a mesma coisa que o consentimento da comunidade sobre o conhecimento mostrado, ou são duas coisas diferentes, que precisam ser dadas separadamente?

**Estado**

| Consideração do parceiro | Validação com a comunidade afetada |
|---|---|
| Pendente — não é pauta direta do USEFLORA (ver **Iniciativas parceiras**, abaixo), mas ele é hoje o único canal de interlocução por procuração para pendências de gravação de campo nascidas do BioCultRelatos; ninguém a considerou ainda | Pendente — não se aplica ainda; nenhuma iniciativa com gravação de campo (o mestrado de Silveiras, sob o BioCultRelatos) tem interlocução formalizada com esta arquitetura |

---

### Pauta 6 — O que é sagrado, e o que acontece com ele

**O impasse, sem jargão.** Quando um saber é sagrado ou iniciático, duas perguntas diferentes se escondem atrás de uma só resposta técnica: o registro deve sumir por inteiro, ou pode ficar visível que ele existe, sem mostrar o conteúdo? E, mais fundo: quem, dentro de uma comunidade, tem legitimidade para dizer, em nome de todos, que um saber é sagrado?

**A regra interina, hoje em vigor sem validação:** `sacred` equivale a `private` — o registro nunca atravessa o *harvest* da federação, nunca chega ao índice do Pluriverso. `governanca/propostaGovernanca.md` §5.2 já classifica `private` como o nível para "conhecimento iniciático, sagrado ou restrito por gênero". Mas essa equivalência foi **derivada por quem desenha o sistema, não pela comunidade** — está registrada como tal em `docs/contrato-harvest.md` §4.1 e virou a questão H-Q1 da `docs/architecture-decisions/ADR-016-contrato-de-harvest.md`, exatamente para que um corpo com legitimidade a confirme ou a corrija.

**As perguntas para levar a quem tiver autoridade sobre isso:**

1. Quando um saber é sagrado, o registro sobre ele deve desaparecer por completo, ou pode ficar visível que existe algo ali, sem mostrar o conteúdo?
2. Quem, dentro de uma comunidade, tem autoridade para dizer que um saber é sagrado, em nome de todos os outros?
3. Essa classificação pode mudar com o tempo — um saber que hoje é sagrado pode deixar de ser, ou o contrário?

**Por que é pauta de desenho, e não de consentimento:** a pergunta aqui não é "este saber específico é sagrado" — essa é, ela sim, uma pergunta registro a registro, e cabe na Pauta 2, adiante. Esta pauta é anterior: como o **sistema** deve se comportar diante do sagrado, em qualquer comunidade, e isso não depende de nenhum conteúdo específico.

**Por que se aplica ao USEFLORA:** ao contrário das Pautas 3, 4 e 5, esta não depende de gravação de campo — um saber sagrado pode aparecer também numa fonte secundária, num artigo que descreve um ritual sem ter pedido permissão para isso. Cabe na pauta do ponto-focal do USEFLORA assim que ele for indicado.

**Estado**

| Consideração do parceiro | Validação com a comunidade afetada |
|---|---|
| Pendente — aguardando indicação do ponto-focal do USEFLORA, solicitada em 18/08/2026, prazo sugerido de 2 semanas, em atraso desde 01/09/2026 (`docs/reunioes/reuniao-useflora-2026-08-18.md`) | Pendente — depende de qual comunidade tiver, na prática, um registro classificado como sagrado; nenhum caso concreto identificado ainda |

---

### Pauta 7 — O detentor apagado pela publicação

**O impasse, sem jargão.** Muitos dos registros que chegam pelo BioCultDB vêm de artigos científicos publicados há décadas. Nesses artigos, é comum que o detentor do conhecimento tenha sido registrado pelo autor apenas como "informante, 62 anos" — sem nome, sem comunidade nomeada, sem qualquer caminho de volta até a pessoa ou seu povo. O apagamento já aconteceu antes de a Arquitetura BioCultural existir; a pergunta que sobra é o que a arquitetura faz com o registro dele.

**A base legal, e por que ela não fecha a questão sozinha.** A Lei nº 13.123/2015, art. 2º, III distingue CTA de origem identificável de CTA de **origem não identificável** — "em que não há a possibilidade de vincular a sua origem a, pelo menos, uma população indígena, comunidade tradicional ou agricultor tradicional". `governanca/propostaGovernanca.md` §5.1 já registra que essa é situação **frequente no BioCultDB**. A lei resolve a pergunta jurídica — dispensa consentimento prévio nesse caso (art. 9º, §2º) e exige repartição obrigatoriamente monetária (art. 23) — mas não resolve a pergunta de arquitetura: o que aparece na tela quando alguém abre esse registro.

**Três caminhos, apresentados sem preferência:**

| | O que a arquitetura faz | Quem decide o acesso | Limite honesto |
|---|---|---|---|
| i | Publica como **Evidência**, atribuída ao autor do artigo — é o que o teste de quatro perguntas de K1 (ADR-015) já produz: sem detentor identificável e nomeado como seu (Q1), o regime é `evidencia`. Tecnicamente defensável | A instituição custodiante, só por **Notice** (K4) | Resolve **quem manda no registro**. Não resolve que o conhecimento tinha dono, e o dono foi apagado da fonte — essa segunda parte não é uma pergunta técnica |
| ii | Mantém **restrito**, por não haver quem consinta a publicação | Ninguém — o registro fica represado | Trata uma lacuna documental como se fosse decisão de proteção; pode reter dado que a comunidade, se pudesse ser consultada, publicaria sem problema |
| iii | Trata como **caso próprio**: registro de Evidência com rótulo declarando explicitamente "detentor não identificável na fonte" — mais específico que a *Attribution Incomplete Notice* genérica já prevista em `propostaGovernanca.md` §5.1 | A instituição aplica o rótulo; a comunidade, se um dia se identificar, reclassifica — mesmo mecanismo do estado transitório de `propostaGovernanca.md:271` | Exige um rótulo novo, hoje inexistente no vocabulário adotado |

**O que a decisão (i) resolve, e o que ela deixa em aberto.** Publicar como Evidência do autor resolve a autoridade sobre a classificação de acesso — é exatamente o que o regime enunciativo (K1) foi desenhado para decidir. O que ela **não** resolve é o fato de que o conhecimento **teve** um detentor, e esse detentor foi apagado pela prática científica que produziu a fonte. Essa segunda parte não se resolve por teste de quatro perguntas nem por classificação de regime: é uma pergunta sobre o que a arquitetura deve **fazer** diante de um apagamento que ela não causou, mas que herda ao publicar. Essa é, precisamente, decisão de um corpo com representação comunitária — a arquitetura sozinha não tem legitimidade para decidir se a solução técnica basta.

**O que isso bloqueia, hoje.** Não é hipotético: `docs/proximosPassos.md` §6 registra **29 registros sem `regime`** já em produção no BioCultDB. Esta pauta decide o critério que resolve esses 29 registros — e os que vierem depois.

**Estado**

| Consideração do parceiro | Validação com a comunidade afetada |
|---|---|
| **Prioritária.** Pendente — mesma indicação do ponto-focal do USEFLORA (Pauta 6); esta é a pauta que ele pode responder de imediato, por não depender de gravação de campo nem de conteúdo específico de nenhuma comunidade — é exatamente o cenário de fontes secundárias em que o USEFLORA trabalha | Pendente — de quem: a comunidade de origem do detentor apagado é, por definição do caso, desconhecida; se identificada posteriormente, esta pauta deve ser reaberta com ela diretamente |

---

## Pautas de consentimento

Respondem ao **valor** de um registro específico. **Só a comunidade detentora responde, registro a registro; nenhum interlocutor fecha por atacado** — nem o Ponto-Focal de uma iniciativa parceira, nem um corpo de representação mista, por mais legítimo que seja para as pautas de desenho acima.

O ponto fica mais claro mostrado do que dito. Nenhuma linha abaixo foi preenchida com "USEFLORA":

| Iniciativa / unidade | Com quem (comunidade detentora) | Situação |
|---|---|---|
| BioCultRelatos — mestrado de Luisa Ridolph Tostes Braga, Silveiras (SP) | *(vazio)* | A comunidade de Silveiras entra pelo mestrado, sob aprovação da CONEP (Resolução CNS 466/2012) e submissão ao SisGen (`docs/projetoPesquisa.md` §7.3) — não há, hoje, um ponto-focal comunitário indicado para responder por ela nestas pautas |
| Pluriverso | *(vazio)* | Nenhum membro real existe na federação ainda (`docs/proximosPassos.md` §6); não há comunidade a quem perguntar |
| USEFLORA | *(vazio — não preencher)* | O Comitê Gestor do USEFLORA não é a comunidade detentora de nenhum registro concreto tratado aqui; serve apenas como interlocução provisória e por procuração (ver **Iniciativas parceiras**) |

### Pauta 1 — Como quem fala quer ser nomeado

**O impasse, sem jargão.** Em todo Relato, quem fala é uma pessoa. O sistema precisa registrar *alguém* como autor daquele conhecimento. E há duas obrigações que se contradizem:

- **Proteger.** Voz, imagem e etnia juntas são dado pessoal sensível (LGPD, art. 11).
- **Reconhecer.** A pessoa tem direito de ser identificada como detentora do conhecimento (CARE A1; Lei 13.123/2015).

Apagar o nome "para proteger" é o que a ciência fez por um século com informantes indígenas: o conhecimento vira patrimônio da publicação, e quem sabia vira "informante anônimo, 60-70 anos" — é literalmente o caso que a Pauta 7 herda quando isso já aconteceu no passado.

**Três caminhos, e quem escolhe:**

| | O sistema guarda | O público vê | Quem decidiu |
|---|---|---|---|
| A | nome real, protegido | "um detentor da comunidade" | nós |
| B | só o coletivo: o nome da comunidade | o nome da comunidade | nós |
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

### Pauta 3 — Consentimento para imagem e voz em gravação

Toda gravação feita em campo — oficina, demonstração de preparo, entrevista registrada em áudio ou vídeo — aciona duas pendências que não se resolvem com o termo de consentimento genérico do CLPI.

| # | Pendência | Situação |
|---|---|---|
| 1 | **Consentimento específico para imagem e voz** | Gravar em áudio ou vídeo aciona três regimes ao mesmo tempo: direito de personalidade (Código Civil, art. 20), dado sensível (LGPD, art. 11 — exige consentimento **específico e destacado**) e forma legal de comprovar o CLPI (Lei 13.123/2015, art. 9º, §1º, II). Um termo genérico não cobre os três |
| 2 | **Transcrição em língua originária** | Exige falante nativo. A tradução para o português é entidade **derivada** — e derivada com perda, porque a língua é constitutiva do conhecimento, não seu veículo (CARE R3) |

**A pergunta para levar a campo:** antes de qualquer gravação, qual das quatro formas do art. 9º, §1º da Lei 13.123/2015 (ver **Como conduzir a conversa**, acima) a comunidade prefere para comprovar o consentimento?

---

### Pauta 4 — O que não deve ser registrado

A conversa mais importante, e a que um documento técnico tende a omitir.

`propostaGovernanca.md:286`: um nível de acesso protege contra acesso indevido **pelo sistema**. Não protege contra a existência do registro — contra cópia de backup, erro de operação, apreensão de equipamento, ou o simples fato de que alguém digitou.

> **Para conhecimento sagrado ou iniciático, a decisão correta pode ser não registrar.**
> Oferecer um campo para o caso não é o mesmo que oferecer a opção de não usar o campo. A plataforma tem obrigação de dizer isso — na consulta prévia, na formação de quem opera, e não só na documentação.

**As perguntas:**

1. Há coisas que vocês preferem que não entrem em computador nenhum?
2. Se entrarem por engano, como vocês querem ser avisados, e o que deve acontecer?
3. Quem, na comunidade, precisa ser consultado antes de qualquer registro novo?

---

## Iniciativas parceiras

### USEFLORA

**Estado do ponto-focal.** Solicitado em reunião de **18/08/2026**, prazo sugerido de **2 semanas** (até 01/09/2026). **Em atraso** — hoje é 2026-09-03. Fonte: `docs/reunioes/reuniao-useflora-2026-08-18.md`.

**O que foi combinado.** Que a arquitetura, ao ser desenhada, gera pendências que só membros de comunidades tradicionais podem sanar — não a academia, não o pesquisador que a mantém — e que a indicação de um ponto-focal pelo Comitê Gestor misto do USEFLORA existe precisamente para abrir esse canal. Ver `docs/reunioes/reuniao-useflora-2026-08-18.md`.

**Pautas que se aplicam.** Pauta 6 (o sagrado) e Pauta 7 (o detentor apagado pela publicação, **prioritária**) — nenhuma das duas depende de gravação de campo nem de conteúdo específico de uma comunidade determinada.

**Pautas que não se aplicam.** As Pautas 3, 4 e 5 **não são a pauta do USEFLORA**: ele trabalha com fontes secundárias — artigos já publicados —, não com gravação de campo. Levá-las a ele seria desperdiçar a conversa. As Pautas 1 e 2 são de consentimento — nenhum interlocutor as fecha por atacado, USEFLORA incluído (ver tabela do vazio, acima).

**Interlocução provisória e por procuração.** Enquanto não há canal aberto com as comunidades do BioCultRelatos (mestrado de Silveiras) e do Pluriverso, o USEFLORA serve, **provisoriamente e por procuração**, como interlocução para as pendências de desenho que nascem também dali — a Pauta 5 é o exemplo mais direto, e é justamente por vir de gravação de campo que ela não é dele. Isso é insumo de desenho para esta arquitetura, nunca consentimento das comunidades afetadas.

### Mestrado de Silveiras, SP — BioCultRelatos

Mestrado de Luisa Ridolph Tostes Braga, PPG em Botânica da ENBT/JBRJ, sob aprovação da CONEP (Resolução CNS 466/2012) e submissão ao SisGen (`docs/projetoPesquisa.md` §7.3).

Ponto-focal: `[não verificado]` — ainda não solicitado.
Pautas aplicáveis: `[a preencher quando houver interlocução]`.

### Mestrado de obras históricas e exsicatas — BioCultNaturalistas

Mestrado de Camila Nascimento Dantas, PPG em Botânica da ENBT/JBRJ (`docs/projetoPesquisa.md` §7.3).

Ponto-focal: `[não verificado]` — ainda não solicitado.
Pautas aplicáveis: `[a preencher quando houver interlocução]`.

### GEF MCTI "Entre-Ciências"

Componente 03, produto 3.2.3, consumidor de dados harmonizados via Pluriverso (`docs/projetoPesquisa.md` §7.3).

Ponto-focal: `[não verificado]` — ainda não solicitado.
Pautas aplicáveis: `[a preencher quando houver interlocução]`.

---

## Roteiro mínimo para levar a campo

Se for para levar uma folha só:

1. Como você quer ser nomeado no que você contou? *(ou: você prefere não ser nomeado?)*
2. Isso que você contou pode ser mostrado para quem? Todo mundo, só pesquisadores, só a comunidade?
3. Tem época certa? Tem restrição de quem pode contar ou ouvir?
4. Pode ser usado em escola? Em pesquisa? Alguém pode ganhar dinheiro?
5. Tem coisa que é melhor não guardar em computador nenhum?
6. Se for uma gravação em grupo, quem decide pela gravação inteira — cada um pela própria parte, ou o grupo junto? E se alguém mudar de ideia depois, o que deve acontecer com o que já foi gravado?
7. Se algo for sagrado, o registro deve desaparecer por completo, ou pode ficar visível que ele existe, sem mostrar o conteúdo?
8. Quem decide isso pela comunidade — e como essa pessoa ou grupo é escolhido?
9. Se mudarem de ideia, quem procurar, e o que deve acontecer com o que já foi publicado?
