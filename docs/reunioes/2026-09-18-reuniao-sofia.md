# Reunião UseFlora — Sofia Zank e Eduardo Dalcin

- **Data:** 2026-09-18, 10:56 (61 min)
- **Participantes:** Sofia Zank (UseFlora, Ponto-Focal), Eduardo Couto Dalcin (gestão da arquitetura)
- **Fonte:** transcrição automática em `20260918Sofia Zank e Eduardo Dalcin.txt`
- **Pauta base:** continuação das anotações de Sofia sobre `docs/pautaComunidades/pauta-comunidades.md` (Pautas 1 a 4) + articulações institucionais

## Overview

Segunda reunião de trabalho com Sofia Zank como Ponto-Focal, dois dias depois da primeira. A
designação foi formalizada por e-mail de Nivaldo em 17/09, então o único encaminhamento pendente
da reunião anterior está resolvido. A conversa teve três blocos: **articulações institucionais**
(farmacopeia popular, ICMBio/Programa Monitora, projetos GEF com dados primários), **onboarding
no GitHub** — Eduardo demonstrou edição, commit e histórico ao vivo, resolvendo o atrito de
navegação registrado na reunião anterior — e **as Pautas 1 e 2 de consentimento**, que renderam
as decisões de arquitetura. As Pautas 3 e 4 foram consideradas por Sofia como não aplicáveis
diretamente ao UseFlora, com uma ressalva. A reunião terminou no meio-dia por compromisso de
Sofia; as anotações ainda não estão esgotadas.

## Decisões

Decisões firmadas na conversa. As marcadas **provisória** são default de precaução; as marcadas
**adiada** foram explicitamente reconhecidas e postergadas.

1. **O detentor é sempre um coletivo; o indivíduo que compartilha é um campo adicional.** A lei
   brasileira estabelece o Conhecimento Tradicional como coletivo, e é o coletivo que figura como
   detentor. Mas a arquitetura deve prever um campo distinto para **quem compartilhou** — o
   especialista, quando ele quiser aparecer, e na forma como ele quiser. Registrar o especialista
   nunca substitui o vínculo com o coletivo: mesmo uma benzedeira isolada tem de ser vinculada ao
   coletivo das benzedeiras.
2. **Como a pessoa quer ser nomeada é escolha dela, em três opções.** Nome verdadeiro, pseudônimo
   escolhido pela própria pessoa, ou pseudônimo gerado pelo sistema. A escolha é individual e
   soberana, nunca do coletivo. Precedente citado por Sofia: tese sobre benzedeiras que publicou
   o nome de quem autorizou e pseudônimo de quem não autorizou — conduta que ela considerou
   eticamente correta.
3. **O nome verdadeiro pode não existir no banco.** Questão levantada por Eduardo: os elementos do
   coletivo são *sempre* armazenados com nome real e exibidos com pseudônimo conforme o público,
   ou o registro pode conter apenas o pseudônimo? Sofia: **as duas opções precisam existir**. Não
   se sabe ainda o comportamento em campo, e há quem recuse o armazenamento do nome verdadeiro,
   não apenas sua exibição. Consequência: o modelo não pode assumir nome real obrigatório com
   máscara de exibição — tem de admitir registro sem nome real.
4. **A exibição do nome depende do público.** Uma mesma pessoa pode aparecer como "Maria" para um
   grupo e como "benzedeira nº 1" para outro. O nível de exposição é atributo da relação entre
   registro e audiência, não do registro apenas — mesma lógica dos níveis de compartilhamento
   já previstos.
5. **Hierarquia de coletivos com raiz na legislação.** A raiz que define coletivos é a denominação
   legal — as comunidades tradicionais reconhecidas no Decreto nº 8.772/2016 e no Conselho
   Nacional de Povos e Comunidades Tradicionais. Abaixo dela há níveis intermediários quando
   existem (Comunidades Quilombolas → Quilombolas do Vale do Ribeira → Comunidade Quilombola do
   Morro do Fortunato) e podem não existir: a benzedeira Camila e a benzedeira Sueli são
   benzedeiras em comunidades diferentes, sem coletivo organizado entre elas. Nesses casos o único
   nível disponível é a categoria legal, e isso é suficiente — a pessoa é classificada como
   pertencente ao coletivo ainda que não participe de nenhum grupo concreto.
6. **Pertencimento é múltiplo, não exclusivo.** Uma mesma pessoa pode ser benzedeira, raizeira e
   quilombola ao mesmo tempo. A estrutura não é uma árvore de pertencimento único: é relação
   muitos-para-muitos entre pessoa e coletivos.
7. **Autodenominação coexiste com o termo legal.** Coletivos escolhem como querem ser chamados —
   há quem prefira "rezadeira" a "benzedeira" —, e a arquitetura registra essa autodenominação.
   Mas sempre com referência ao nome da legislação, que é o que garante classificação consistente.
8. **A arquitetura adota o princípio das etiquetas, não necessariamente o conjunto internacional.**
   É princípio inalienável que cada registro carregue etiquetas que transmitam licenças de acesso,
   restrições e reconhecimento de autoria, em forma interoperável entre sistemas. A forma de
   implementação — TK Label, BC Label, flag própria, hashtag — fica em aberto, e as opções **não
   são mutuamente excludentes**. O que a arquitetura fixa agora é a necessidade e as
   características exigidas, não o mecanismo.
9. **Etiquetas brasileiras com tabela de correspondência — provisória.** Nada impede rótulos
   próprios, adequados à realidade brasileira, com tabela de correspondência para os rótulos
   internacionais na exportação (GBIF e afins). Critério declarado por Eduardo: não ficar preso a
   padrão internacional a ponto de abdicar do que atende melhor aqui. Fundamento de Sofia: os TK
   Labels foram feitos por um grupo específico de um país, são muito focados nos povos indígenas
   da Nova Zelândia, e a complexidade brasileira não está representada neles.
10. **Adoção prática do Local Contexts — adiada.** Fica postergada para quando o recurso do GEF
    estiver disponível, com reunião a marcar com Keila e o MCTI para alinhar como as duas pontas
    enxergam a aplicação. Fatores: há modelo de negócio pago por trás do cadastro no Local
    Contexts (Eduardo se cadastrou e encontrou cobrança), e não há ainda evidência de uso efetivo
    em bancos de dados.
11. **Etiquetas valem também para acervos biológicos.** Uma exsicata de herbário com Conhecimento
    Tradicional Associado leva o label, e o label viaja com o registro para o GBIF, que saberá não
    expor o que está carimbado como privado. Esse é o ganho concreto de adotar padrão em vez de
    convenção local.
12. **Resumos de reunião ficam separados, um por reunião.** Eduardo decidiu não agregar este
    resumo ao anterior: fica documentado que foram reuniões distintas. A consolidação do impacto
    de todos os resumos sobre a arquitetura é etapa posterior, separada.

## Insights

Pontos que não são decisão de arquitetura, mas mudam como as decisões devem ser tomadas.

- **O protótipo foi o que destravou a discussão de governança em Brasília.** Sofia levou o
  protótipo do UseFlora não para validar interface, mas para tornar concreto o que é um banco de
  dados. O efeito foi maior que o esperado: os Guardiões **perderam o medo**, visualizaram o que
  estava em jogo e a discussão de política de dados que veio depois surpreendeu — eles passaram a
  afirmar que as informações **tinham** de estar ali. Corolário de Eduardo: não se constrói do
  zero perguntando; mostra-se algo — mesmo deliberadamente errado — e pede-se crítica.
- **O medo de nomear tem causa concreta e datada: perseguição religiosa.** Entre as benzedeiras
  que recusaram divulgação do nome, a recusa veio das de religião de matriz africana, que sofrem
  preconceito. Não é preferência abstrata de privacidade: é cálculo de risco de dano. O mesmo
  padrão aparece na recusa de registrar coordenada geográfica, relatada por Daniela em conversas
  anteriores. A arquitetura precisa tratar não-identificação como proteção contra dano, não como
  lacuna de qualidade de dado.
- **A desconfiança é sobre a promessa, não sobre o campo.** Sofia supôs que a maioria não se oporia
  a ter o nome armazenado desde que não se tornasse público. Eduardo apontou o ponto real: a
  objeção existe porque não se confia na promessa de que não se tornará público. Isso desloca a
  questão de modelagem para governança demonstrável.
- **"Coletivo" nem sempre é concreto ou visível.** A categoria legal existe mesmo onde não há
  organização social correspondente. A arquitetura tem de suportar coletivo jurídico sem coletivo
  organizado, sob pena de forçar um nível hierárquico inexistente ou de deixar a pessoa fora de
  qualquer coletivo — o que contradiz a natureza coletiva do Conhecimento.
- **Local Contexts é referência internacional, mas quase não tem uso comprovado.** Sofia encontrou
  a iniciativa citada nos estudos da CDB sobre DSI como mecanismo para vincular Conhecimento
  Tradicional em bancos de dados, e é hoje a referência de como aplicar os princípios. Ao procurar
  uso real, porém, achou **um único caso** — e era um Notice, não um Label, num repositório
  pequeno, que **não propagou** para os agregadores grandes. Adotar por reputação sem verificar
  propagação seria adotar um selo que não atravessa a cadeia.
- **A demanda por dados primários chega mesmo sem estar no escopo.** Nem o UseFlora nem o JBRJ
  tratam dados primários no GEF. Mas das 16 iniciativas apoiadas, algumas já estão inserindo dados
  primários no SiBBr e, ao ouvirem a discussão do UseFlora, **se preocuparam** — nunca tinham
  parado para pensar no que a disponibilização pode gerar. A demanda começou a chegar, uma a uma,
  para discutir política de dados. Não é escopo formal, mas é pressão real.
- **O BioCultDB tangencia dados primários pela porta do Relato.** Retomando a decisão 9 da reunião
  anterior: um dado vindo de referência bibliográfica que recebe ajuste da comunidade que se
  reconheceu ali deixa de ser apenas Evidência e passa a produzir Relato. Por esse caminho o
  BioCultDB acaba tocando dado primário, independentemente do escopo declarado.
- **A farmacopeia popular tem uma posição invertida sobre registro.** Para as raizeiras e o pessoal
  da medicina tradicional, **registrar conhecimento é proteger** — quanto mais detalhado o
  registro, melhor. É posição diferente da de povos indígenas e povos de terreiro. A arquitetura
  não pode ter um único default de sensibilidade para todos os coletivos, e essa diferença é
  argumento adicional para a decisão de default privado ser revisável pela comunidade.
- **O ICMBio descobriu Conhecimento Tradicional dentro das próprias bases.** O Programa Monitora
  (Rodrigo Jorge) constatou que há Conhecimento Tradicional nas suas bases de dados e quer saber
  como lidar — pauta forte para o próximo ano. É o terceiro ator independente a chegar ao mesmo
  problema.
- **Convergência simultânea é oportunidade de unificação.** Sofia: o tópico ficou quente e as
  pessoas estão se dando conta da importância mais ou menos ao mesmo tempo. Isso favorece uma
  arquitetura unificada em vez de cada iniciativa resolver sozinha — e é exatamente o argumento de
  existência do trabalho.
- **Não há receita internacional, só soluções pontuais.** Peru, Nova Zelândia, Índia, Austrália,
  China: cada um conta a sua solução, e todas são pontuais. No Brasil quer-se muito e pratica-se
  pouco. Escrever governança no papel é possível; a dificuldade é a representatividade de quem
  escreve — o que reforça a necessidade de agregar pessoas à discussão.
- **O onboarding no GitHub foi resolvido por demonstração, não por documento.** Sofia perguntou se
  podia anotar diretamente e se precisava sinalizar o que estava mexendo. Eduardo mostrou ao vivo:
  edição no navegador, commit no lugar de "salvar", histórico de 138 commits, diff por commit,
  autoria registrada e possibilidade de reverter e de discutir cada alteração. O efeito buscado é
  o mesmo do protótipo com os Guardiões: tornar concreto para tirar o medo.

## Pendências e encaminhamentos

- **Designação do Ponto-Focal** — **resolvida**. E-mail de Nivaldo em 17/09/2026.
- **Concluir as anotações de Sofia** — ainda não esgotadas; a próxima reunião retoma do ponto em
  que parou, e só depois se volta ao documento de preparação.
- **Reunião sobre domesticação e manejo** — Nivaldo e Carol querem pauta específica; é pendência
  antiga, originada da confusão entre dois bancos distintos, um de uso e outro de manejo. Ainda
  não entraram em contato com Eduardo; agendamento pelo link de slots.
- **Modelo de dados de identificação do detentor** — especificar: coletivo (obrigatório, com raiz
  na denominação legal), níveis hierárquicos intermediários opcionais, pertencimento múltiplo,
  autodenominação do coletivo, campo do especialista que compartilhou, escolha de nome
  real/pseudônimo próprio/pseudônimo gerado, e nome real opcionalmente ausente do armazenamento.
- **Verificar uso real dos TK/BC Labels** — Sofia encontrou um único caso, e sem propagação para
  agregadores. Levantar se há experiências efetivas antes de decidir adoção. Sofia sinalizou que
  gostaria de apoio de IA nessa busca.
- **Desenhar o conjunto de rótulos adequado à realidade brasileira** — e a tabela de
  correspondência com TK/BC Labels para exportação.
- **Reunião com Keila e MCTI sobre Local Contexts** — quando o recurso do GEF estiver disponível.
- **Conversa com o pessoal da farmacopeia popular (Jaqueline)** — Sofia encaminha. Eles iniciam
  fase piloto no Cerrado e começam a pensar em banco de dados; experiência diretamente aplicável
  ao BioCultRelatos e aos dados de fonte primária.
- **Aproximação com ICMBio / Programa Monitora (Rodrigo Jorge)** — Eduardo manda mensagem prévia
  de apresentação; Sofia sonda no evento em Brasília na semana seguinte. Eventual apresentação da
  arquitetura para eles.
- **Mecanismo de pedido de ocultação ou retirada de registro** — Sofia reafirmou a necessidade ao
  tratar da Pauta 4; confirma a pendência nomeada na reunião anterior (decisão 10 daquele
  registro), ainda adiada.
- **Atualizar a pauta de comunidades** — o que já foi decidido sobre sagrado e correlatos deve
  gerar uma nova versão da pauta, depois de fechadas as demais discussões.
- **Consolidar o impacto dos resumos sobre a arquitetura** — Eduardo fará um confronto entre os
  resumos de reunião e os documentos de arquitetura, como etapa separada, mais adiante.
- **Revisão do resumo anterior por Sofia** — pedida explicitamente; Eduardo já fez uma revisão
  cuidadosa e ajustes no texto gerado.
- **Próxima reunião** — após o retorno de Sofia de Brasília, na semana seguinte. Sofia agenda.

## Pontos de atenção

O que exige ação ou verificação fora do fluxo normal das pendências.

- **A decisão 3 contradiz um pressuposto implícito do modelo de dados.** Até aqui a arquitetura
  admitia nome real armazenado com máscara de exibição. A decisão firmada é mais forte: o nome
  real pode **não existir** no banco. Isso afeta o desenho da entidade pessoa — o campo deixa de
  ser obrigatório com controle de visibilidade e passa a ser opcional na própria persistência.
- **As decisões 5, 6 e 7 são material direto de ADR.** Hierarquia com raiz na denominação legal,
  pertencimento múltiplo e autodenominação coexistindo com o termo legal formam um único bloco de
  modelagem. O caso que quebra uma árvore simples é o coletivo jurídico sem coletivo organizado
  (a benzedeira isolada): não há nível intermediário a preencher, e forçá-lo produz dado falso.
- **Estado das pendências herdadas.** A formalização do Ponto-Focal está resolvida; a política de
  retirada de registro do banco a pedido da comunidade continua adiada, coerente com o registro
  de 2026-09-16.
- **Leituras incertas da transcrição precisam de conferência.** "zípora" foi lido como UseFlora,
  sem certeza, e o nome ininteligível no trâmite de contratação ("pinhuma") não foi resolvido.
  Conferir antes de citar estes trechos em outro documento.

## Notas de leitura da transcrição

A transcrição é automática e não foi revisada; nomes próprios e siglas saíram corrompidos.
Leituras adotadas neste resumo: "Jeff" → **GEF**; "cbbr" / "Civic BR" → **SiBBr**; "mibiu" /
"semibiu" / "semi build" / "cmb" / "icmbinho" → **ICMBio**; "dibfil" / "drible" / "Gibson" →
**GBIF**; "logo ou contas" / "loco contas" → **Local Contexts**; "tcaleibol" → **TK Label**;
"leigos" / "labos" / "lei bolar" → **labels**; "8772" → **Decreto nº 8.772/2016**; "docinho" →
**Dalcin**; "use Flora" → **UseFlora**; "biokult DB" / "bioconte DB" → **BioCultDB**; "biokult
relatos" → **BioCultRelatos**; "zípora" → **UseFlora** (incerto); "branco de Dalton dados" →
**banco de dados**. "Serra da coxixola", "Dona Maria", "seu João" e "Dona Joaquina" são exemplos
inventados na conversa, não referências reais. O trâmite de contratação citado envolve uma
fundação, o IEB e a UFSC; um dos nomes ("pinhuma") ficou ininteligível. "Vick" é a pessoa que
desenvolveu o protótipo do UseFlora e hoje está sem contrato.

## Links e documentos citados

- Registro da reunião anterior (2026-09-16): https://github.com/edalcin/Arquitetura-BioCultural/blob/main/docs/reunioes/2026-09-16-reuniao-sofia.md
- Pauta de comunidades (Pautas 1 a 4): https://github.com/edalcin/Arquitetura-BioCultural/blob/main/docs/pautaComunidades/pauta-comunidades.md
- Preparação da reunião de 2026-09-16: https://github.com/edalcin/Arquitetura-BioCultural/blob/main/docs/pautaComunidades/preparacao-reuniao-2026-09-16.md
- Local Contexts: https://localcontexts.org/ — TK Labels e BC Labels, com modelo de negócio pago e uso efetivo não comprovado
- Decreto nº 8.772/2016 e Conselho Nacional de Povos e Comunidades Tradicionais — raiz de classificação dos coletivos
- SiBBr — destino de dados primários de iniciativas apoiadas pelo GEF
- Programa Monitora / ICMBio — Conhecimento Tradicional identificado em bases próprias
