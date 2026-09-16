# Reunião UseFlora — Sofia Zank e Eduardo Dalcin

- **Data:** 2026-09-16, 08:56 (63 min)
- **Participantes:** Sofia Zank (UseFlora, Ponto-Focal indicado), Eduardo Couto Dalcin (gestão da arquitetura)
- **Fonte:** transcrição automática em `docs/reunioes/Sofia Zank e Eduardo Dalcin.txt`
- **Pauta base:** `docs/pautaComunidades/preparacao-reuniao-2026-09-16.md` (itens 5, 6 e 7) + anotações de Sofia

## Overview

Primeira reunião de trabalho com Sofia Zank como Ponto-Focal do UseFlora. A condução foi
invertida em relação à pauta preparada: a reunião começou pelas anotações de Sofia sobre os
documentos do repositório e não terminou essas anotações — os checkboxes de encaminhamento do
documento de preparação ficaram, em grande parte, sem tratamento. Mesmo assim os itens 5
(vídeos: consentimento coletivo × individual), 6 (sagrado) e 7 (detentor não identificado na
fonte) foram discutidos, e três decisões de arquitetura saíram prontas para virar ADR. O único
encaminhamento formal que não avançou é a confirmação por escrito da designação de Sofia como
Ponto-Focal.

## Decisões

Decisões firmadas na conversa. As marcadas **provisória** são default de precaução; as marcadas
**adiada** foram explicitamente reconhecidas e postergadas.

1. **Escopo prioritário: Evidência (fontes secundárias).** A interlocução com o UseFlora prioriza
   Conhecimento Tradicional proveniente de fontes secundárias, porque é o que o UseFlora faz e
   onde o BioCultDB mais avançou. Não é exclusividade: o UseFlora é hoje a **única ponte** entre a
   gestão da arquitetura e as Comunidades Tradicionais, e sempre que houver disponibilidade e
   interesse a ponte também vale para o conhecimento de fontes primárias.
2. **Consentimento coletivo e consentimento individual são camadas distintas.** Quem decide sobre
   o Conhecimento é o coletivo, porque o Conhecimento é coletivo. O indivíduo permanece soberano
   sobre a própria imagem, voz e fala. Consequência operacional firmada: se a comunidade autoriza
   a publicação de um vídeo e uma pessoa não quer aparecer, **sai a pessoa, não sai o vídeo** —
   supressão individual (rosto, voz, trecho), não supressão do registro coletivo. Fundamento
   trazido por Sofia: é a mesma ética do trabalho de campo, em que a autorização da comunidade
   não dispensa o consentimento individual de cada participante, e ninguém é obrigado a
   participar.
3. **Registrar o metadado do sagrado, nunca o conteúdo sagrado.** A arquitetura deve permitir
   afirmar que existe Conhecimento sagrado associado a uma espécie, a um recurso genético ou a um
   registro, **sem registrar qual é esse Conhecimento**. Formulação acordada com exemplo: é
   legítimo registrar que uma planta integra o calendário do ritual sagrado Ouricuri, e ilegítimo
   registrar por quê e como — *mesmo quando o artigo publicado descreve por quê e como*. Sofia:
   a marcação "traz um peso maior" e deixa claro que a ausência de conteúdo não é ausência de
   Conhecimento.
4. **Sagrado ⊃ secreto.** "Sagrado" é a categoria ampla; "secreto" é um nível dentro dela. O
   nível secreto (conhecimento iniciático, restrito a pessoas com qualidades específicas,
   tipicamente ritual de cura) **não é candidato a entrar em banco de dados**: não é compartilhado
   nem dentro da própria comunidade, e quando é compartilhado isso se dá diretamente, pessoa a
   pessoa. Corolário aceito: não se pede esse conhecimento. Existe sagrado não-secreto e
   amplamente divulgado (Sofia citou a jurema-preta, com camada pública ampla e camada sagrada;
   e o uso de espada-de-são-jorge e arruda). A existência de secreto **não-sagrado** ficou aberta
   — Sofia não soube afirmar; Eduardo levantou a hipótese de segredo por relevância econômica.
   A arquitetura deve estar preparada para a matriz sagrado × secreto e para níveis de
   sensibilidade dentro do sagrado, ainda que uma célula da matriz esteja hoje vazia.
5. **Default privado para o que é marcado como sagrado — provisória.** Todo registro identificado
   como sagrado entra como privado até que a comunidade detentora decida o contrário. Critério
   declarado por Eduardo: "pecar pela regra e não pela omissão". Estende-se a toda dúvida de
   classificação: na dúvida, privado até haver decisão. É reversível apenas pela comunidade, no
   sentido de liberar.
6. **Para Evidência, a unidade declara Notice; o Label é da comunidade.** Em registro de Regime
   Enunciativo *Evidência*, a instituição indexadora não pode aplicar o Label de acesso — ele é
   ato da Comunidade Tradicional detentora. O que a unidade pode fazer é declarar um Notice de
   contexto biocultural: "aqui há Conhecimento sagrado" / "aqui há Conhecimento Tradicional
   Associado". Sofia propôs o mecanismo como "aviso", seguindo a lógica do **Local Contexts**
   (transcrito como "lokool contas"); Eduardo o nomeou como Notice/Label de contexto. Isso
   corresponde à distinção já registrada no ADR-015.
7. **Detentor não identificado na fonte: caminho 3 (rótulo).** Entre os três caminhos da pauta 7,
   Sofia escolheu explicitamente o caminho 3: rotular o registro como "existe Conhecimento
   Tradicional Associado; o detentor não está identificado na fonte". A redação do rótulo é
   substantiva, não cosmética — ele afirma que **há detentor e não se sabe quem é**, e nunca que
   não há detentor.
8. **Relatórios de pendências por comunidade entram na arquitetura.** As ferramentas devem emitir,
   periodicamente e por demanda, a lista de registros sobre os quais uma dada comunidade precisa
   decidir. Vale para o BioCultDB (Evidência) e para o BioCultRelatos (Conhecimento de oficinas e
   entrevistas, que entra majoritariamente como privado por default e precisa de confirmação).
   Eduardo registrou que essa exigência não estava prevista e passa a estar.
9. **O BioCultDB precisará de capacidade de Relato.** Se a comunidade pode corrigir, contestar ou
   acrescentar sobre uma Evidência publicada, o que ela produz é Conhecimento — um Relato. Logo o
   BioCultDB terá de permitir Relatos ancorados em artigos já publicados, na forma de correção,
   acréscimo ou comentário. Exemplo construído na reunião: o artigo afirma quatro plantas no
   calendário Ouricuri e a comunidade afirma cinco, ou três.
10. **Pedido de remoção do banco — adiada.** Sofia colocou que, sendo soberanas, comunidades vão
    pedir a retirada de registros do banco com os quais não concordam, para não multiplicar
    informação que consideram errada. Distinção aceita: retira-se do banco, não da publicação —
    o que está publicado continua publicado. Eduardo classificou como "problema mais para
    frente"; fica como pendência nomeada, não como questão resolvida.
11. **Quem classifica é a camada de governança da ferramenta.** Ao questionamento de Sofia sobre
    quem é "a gente" que atribui os rótulos — ela hesitou entre "pesquisadores" e outra instância
    —, ficou que a classificação é ato da camada intermediária de governança, a que gere o
    BioCultDB: não é a camada da arquitetura, nem a das comunidades (que detém a última palavra
    sobre o acesso aos seus dados).
12. **Registro e publicidade da própria reunião.** Esta conversa é documentada no repositório e o
    sumário serve de insumo para Sofia levar as questões às reuniões ampliadas. O repositório é
    aberto a Sofia sem restrição ("pode fuxicar tudo").

## Insights

Pontos que não são decisão de arquitetura, mas mudam como as decisões devem ser tomadas.

- **Governança de dados é continuação da governança do território.** Sofia relatou a fala de um
  indígena (peruano) em seminário da semana anterior: a governança que a comunidade já exerce
  sobre os recursos no território é a mesma que deve reger os dados. Não se projeta uma governança
  nova para dados; estende-se a existente. Tem a mesma estrutura em camadas que a arquitetura já
  usa — princípios gerais inalienáveis no topo, caso a caso na base.
- **Já existe precedente brasileiro de prova de representatividade: a Plataforma de Territórios
  Tradicionais.** As lideranças presentes na oficina citaram-na repetidamente. O mecanismo não
  aceita que alguém se declare representante: exige ata ou carta assinada por várias pessoas. Isso
  responde diretamente à dúvida da arquitetura sobre como verificar representatividade — e a
  resposta é adotar o que as comunidades já construíram, não inventar critério próprio.
- **A dúvida de representatividade não é da arquitetura.** Se a regra interna do coletivo é que
  uma pessoa responde por todos, não cabe à arquitetura questionar. O que cabe é oferecer
  mecanismos de proteção que os próprios coletivos já usam. "Essa discussão não é minha."
- **O papel da governança é expor consequência, não escolher.** Toda decisão de acesso deve chegar
  à comunidade acompanhada do leque de opções técnicas e das consequências de cada uma, positivas
  e negativas. Sem o leque, a discussão fica estéril ("eu não quero" × "eu quero"). Exemplo de
  opção técnica levantado: supressão de rosto e síntese de voz, como no Google Street View.
- **Empoderamento técnico é pré-requisito de consentimento informado.** Enquanto as comunidades não
  tiverem ferramental e noção de modelagem de dados, de banco e de sistema de informação, não têm
  como decidir confortavelmente entendendo o que estão decidindo. Capacitação não é acessório da
  arquitetura; é condição para que as decisões que ela exige sejam válidas.
- **"Conhecimento tradicional de origem não identificável" é, na prática, uma porta de fuga do
  consentimento.** Sofia foi enfática: a categoria existe na lei e é usada como estratégia
  política para não obter consentimento — e está funcionando, porque cerca de **90% dos registros
  no CGen** (transcrito "CG") entram como conhecimento tradicional não identificado. Para ela,
  não existe Conhecimento Tradicional sem povo identificável, salvo a exceção real do povo
  extinto cujo conhecimento foi registrado no passado. Consequência para a arquitetura: o rótulo
  de detentor não identificado precisa ser lido como lacuna de informação, nunca como ausência de
  titular — do contrário a arquitetura passa a legitimar a mesma estratégia.
- **A lacuna tem causa histórica datada.** Pesquisadores antigos não tinham obrigação de
  identificar detentores em artigo; hoje há obrigação e penalidades. O acervo de fontes
  secundárias herda essa assimetria, e ela não é distribuída ao acaso: concentra-se na literatura
  mais antiga.
- **Autodeclaração de detenção e vínculo com a Evidência são atos diferentes.** Uma comunidade que
  encontra o rótulo pode se declarar detentora daquele Conhecimento sem conseguir vincular-se
  àquele artigo específico — é improvável que lembrem o nome do pesquisador ou o título da
  pesquisa. No caso oposto (exemplo 1 da pauta, Caiçara), em que o artigo identifica povo e local
  com precisão, são igualmente dois atos: (a) atestar identidade — "somos o povo de que este
  artigo fala" — e (b) aplicar o Label de acesso que quiserem, incluindo acrescentar plantas.
  Só a comunidade pode praticar ambos.
- **Nem IA nem curador identificam todo sagrado.** O artigo frequentemente não deixa claro que
  há conteúdo sagrado ou secreto. Portanto o mecanismo de controle comunitário não pode depender
  de marcação prévia: a comunidade tem de poder pedir a marcação ou a ocultação de um registro que
  a arquitetura não sinalizou.
- **O momento em que a comunidade valida é o momento em que ela contribui.** Sofia observou que,
  ao entrar para classificar, os coletivos não só validam — corrigem, qualificam e acrescentam.
  Isso é entrada de dado novo, não curadoria, e é a origem da decisão 9.
- **Os relatórios servem à cascata organizativa já existente.** Um relatório por coletivo pode
  subir para a organização nacional (APIB, transcrito "PIB"), descer para as regionais e chegar
  aos grupos locais. É demanda dos próprios povos: hoje eles não têm controle sobre o que se
  publica a respeito deles.
- **Pendência anterior resolvida por reorganização documental.** A pauta única tratava as quatro
  fontes de conhecimento — primário, secundário, relatos de naturalistas e acervos — de forma
  misturada, e ficou confusa mesmo para o autor. O documento de preparação desta reunião separou
  os regimes, e a separação foi o que tornou a conversa possível.
- **A documentação é, ela mesma, objeto de pesquisa.** A arquitetura é o projeto de pesquisa
  principal de Eduardo no Jardim Botânico, o que delimita institucionalmente o trabalho, e
  **avaliar o uso de IA para produzir e manter essa documentação é parte declarada da pesquisa**.
  Quase toda a documentação nasce de um agente: quando há lacuna, o agente interroga
  exaustivamente (20–25 perguntas por sessão) e cada resposta vira um ADR; as não-respostas viram
  pauta de comunidade.
- **A arquitetura é um conjunto de documentos, e é isso que a torna negociável.** Eduardo explicitou
  o que a arquitetura é, materialmente: documentos que possibilitam construir as ferramentas que a
  suportam — camada de apresentação, camada de negócio e camada de persistência, as mesmas da
  oficina anterior. O que a reunião produz são **regras de negócio**, escritas pelas duas partes,
  com reflexo no banco de dados. Cada interação com o Ponto-Focal gera, portanto, uma lista de
  questões que precisam de decisão para que a arquitetura seja o mais precisa possível.
- **Atrito de onboarding do Ponto-Focal.** Sofia — autodeclarada novata — procurou os documentos de
  governança referenciados e não os encontrou, e evitou explorar o repositório por não saber se
  podia. Repositório aberto não é repositório navegável: falta um ponto de entrada para quem
  chega como Ponto-Focal.
- **Parceria potencial para fontes primárias: a farmacopeia popular.** Jaqueline, presente na
  última oficina em Brasília, integra um movimento com experiência longa e consolidada de registro
  e sistematização da farmacopeia popular, hoje migrando de registro escrito/físico para banco de
  dados. Experiência diretamente aproveitável para o desenho do Conhecimento de fonte primária,
  em especial plantas medicinais. Dado indígena é caso distinto, com complexidade própria — é a
  frente em que Vivi trabalha no BioCultRelatos.

## Pendências e encaminhamentos

- **Formalização da designação do Ponto-Focal** — pendente. Basta um e-mail informal, sem ofício,
  partindo do UseFlora (Nivaldo ficou de enviar; Sofia assumiu encaminhar), declarando que Sofia é
  o Ponto-Focal. Único item da pauta preparada que não avançou.
- **Concluir as anotações de Sofia** — a próxima reunião retoma do ponto em que parou; as
  anotações não foram esgotadas.
- **Camadas de governança: quem decide o quê, em que camada** — questão aberta levantada por
  Sofia. A camada dos dados é exclusivamente das comunidades; as camadas da arquitetura e das
  ferramentas precisam de definição de composição, de mandato, de formação e de manutenção dos
  comitês/conselhos. Hoje a camada de arquitetura é, de fato, esta reunião de duas pessoas.
- **Modelo de metadados de acesso** — flags para: existência de Conhecimento Tradicional
  Associado, sagrado, secreto, nível de sensibilidade dentro do sagrado, detentor não identificado
  na fonte, níveis de compartilhamento (comunidade detentora, comunidade vizinha, MCTI, público).
- **Revisitar a equivalência `privado` = `secreto` no ADR-015** — Eduardo observou que a
  arquitetura hoje trata privado como secreto, e a decisão 4 estabelece que existe sagrado
  não-secreto. A equivalência precisa ser reexaminada.
- **Existe secreto não-sagrado?** — questão em aberto a levar às comunidades; determina se a
  matriz sagrado × secreto tem quatro células ou três.
- **Relatórios de pendências** — especificar geração periódica e por demanda, recorte por
  coletivo, e o fluxo de encaminhamento pela cascata organizativa (nacional → regional → local).
- **Fluxo de correção, qualificação e acréscimo por comunidades** — como o Relato comunitário se
  ancora na Evidência publicada, como é armazenado e como é exibido ao lado da Evidência que
  contesta.
- **Política de remoção de registro do banco a pedido da comunidade** — adiada, mas nomeada.
- **Ponto de entrada de documentação para o Ponto-Focal** — um índice de leitura que leve da
  governança à pauta de comunidades sem exigir exploração do repositório.
- **Próxima reunião** — Sofia agenda: sexta desta semana, ou segunda ou sexta da próxima (estará
  em evento em Brasília e a passagem ainda não foi emitida). Eduardo pediu que não se distancie
  muito, para não perder contexto. Eduardo prepara novo documento de preparação, juntando estas
  pendências às que surgirem.

## Notas de leitura da transcrição

A transcrição é automática e não foi revisada; os nomes próprios saíram corrompidos. Leituras
adotadas neste resumo: "CG" → **CGen**; "PIB" → **APIB**; "lokool contas" → **Local Contexts**;
"clube universo" → **Pluriverso**; "biokult DB" / "bioboat DB" / "bioconte DB" / "iogurte DB" →
**BioCultDB**; "biokult relatos" → **BioCultRelatos**; "use Flora" / "se Flora" → **UseFlora**.
Um exemplo de espécie sagrada citado por Sofia ("o aspa") ficou ininteligível e não foi
transcrito aqui. O "caminho 3" da pauta 7 é referenciado por número na conversa, sem leitura do
enunciado — conferir em `docs/pautaComunidades/pauta-comunidades.md`.

## Links e documentos citados

- Preparação para esta reunião: https://github.com/edalcin/Arquitetura-BioCultural/blob/main/docs/pautaComunidades/preparacao-reuniao-2026-09-16.md
- Pauta de comunidades: https://github.com/edalcin/Arquitetura-BioCultural/blob/main/docs/pautaComunidades/pauta-comunidades.md
- Registro da reunião anterior (2026-08-18): https://github.com/edalcin/Arquitetura-BioCultural/blob/main/docs/reunioes/2026-08-18-reuniao-useflora.md
- Plataforma de Territórios Tradicionais — precedente de prova de representatividade
- Local Contexts — precedente de Notices e Labels
