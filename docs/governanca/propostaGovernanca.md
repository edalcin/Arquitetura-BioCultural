# Proposta de Governança — Arquitetura BioCultural

> **Status: Proposta para consulta** — submetida à validação das comunidades tradicionais federadas e do Comitê Federado. Não é norma vigente: nenhuma seção desta proposta afirma que a plataforma já cumpre o que ainda não existe — mecanismos pendentes são marcados `[a implementar]`, com o repositório responsável.

**Versão de referência:** Arquitetura BioCultural v3.4
**Data:** 1º de agosto de 2026
**Autor:** Eduardo Dalcin

Esta proposta nomeia, para os dados, as ferramentas e a arquitetura da [Arquitetura BioCultural](../README.md), quem decide o quê, com que processo, e o que acontece quando uma decisão muda — fundamentada nos princípios **C.A.R.E.**, no marco legal brasileiro e internacional de acesso a conhecimento tradicional associado, e em literatura e precedentes institucionais verificados.

## Sumário

1. [Por que uma proposta de governança](#1-por-que-uma-proposta-de-governança)
2. [Escopo: três camadas de governança](#2-escopo-três-camadas-de-governança)
3. [Fundamentos éticos e legais](#3-fundamentos-éticos-e-legais)
4. [O receio legítimo: por que comunidades desconfiam de bancos de dados](#4-o-receio-legítimo-por-que-comunidades-desconfiam-de-bancos-de-dados)
5. [Governança dos dados e informações](#5-governança-dos-dados-e-informações)
6. [Governança das ferramentas](#6-governança-das-ferramentas)
7. [Governança da arquitetura](#7-governança-da-arquitetura)
8. [Implementação: do documento à prática](#8-implementação-do-documento-à-prática)
9. [Referências Bibliográficas](#9-referências-bibliográficas)

---

## 1. Por que uma proposta de governança

A Arquitetura BioCultural nasce comprometida com os princípios **C.A.R.E.** — *Collective Benefit* (Benefício Coletivo), *Authority to Control* (Autoridade para Controlar), *Responsibility* (Responsabilidade), *Ethics* (Ética) (CARROLL et al., 2020) — e já traduz parte desse compromisso em decisões técnicas: cada unidade federada é soberana sobre seu próprio arquivo SQLite+JSON (ADR-005), o Pluriverso só coleta o que é explicitamente marcado `visibility: public` (ADR-004, decisão D6), e a saída da federação é reversível por `purge_by_member` (ADR-004, decisões D3/D4).

Essas decisões resolvem a camada técnica. Mas arquitetura não é governança: dizer *como* o dado é armazenado não diz *quem decide* o que entra, o que sai, quem pode alterar o código que processa esse dado, e quem responde quando uma comunidade pergunta por que um relato está público sem autorização explícita. Três lacunas concretas, já identificadas nos próprios artefatos deste repositório, tornam esta proposta necessária agora, não depois:

- O modelo de dados que estrutura consentimento e visibilidade (ADR-003) está formalmente em status **"Proposto — aguardando validação com comunidades e pesquisadores"** — o campo que mais depende de legitimidade comunitária ainda não foi validado por nenhuma comunidade.
- O protocolo de admissão de novos membros da federação (ADR-006) tem um bloqueador não resolvido: a **autenticação da decisão do Comitê Federado (E4)** — hoje não há mecanismo técnico que garanta que uma decisão de admissão ou remoção reflete a deliberação do comitê, e não a ação isolada de quem tem acesso ao sistema.
- A licença do próprio projeto está, no README, declarada como **"A definir — considerando licenças que respeitem os princípios C.A.R.E."** — uma arquitetura que promete soberania de dados sem uma licença definida deixa em aberto a primeira pergunta que uma comunidade tradicional faria: sob quais termos meu conhecimento pode circular?

Esta proposta não substitui nenhuma decisão arquitetural existente — ela nomeia, para cada uma dessas lacunas e para o restante do sistema, **quem decide, com que processo, e o que acontece quando a decisão muda**. Apoia-se em três corpos de referência: os princípios CARE e o padrão **OCAP®** (*Ownership, Control, Access, Possession* — FIRST NATIONS INFORMATION GOVERNANCE CENTRE, s.d.) como fundamento ético; o marco legal brasileiro e internacional (Lei 13.123/2015, LGPD, Protocolo de Nagoya, Convenção nº 169 da OIT) como fundamento normativo; e o precedente institucional mais próximo do domínio desta arquitetura — o *Indigenous Data Governance Task Group* do GBIF, criado em 28 de julho de 2025 sob liderança de Lydia J. Jennings, com o objetivo declarado de tornar o Darwin Core compatível com CARE (GLOBAL BIODIVERSITY INFORMATION FACILITY, 2025) — como evidência de que essas exigências não são exclusividade desta proposta, mas uma tendência já em curso na infraestrutura internacional de dados de biodiversidade.

O restante do documento está organizado em três camadas de governança — dados, ferramentas, arquitetura — detalhadas na próxima seção, seguidas dos fundamentos éticos e legais (§3), do receio legítimo das comunidades e das salvaguardas desta arquitetura contra o mau uso (§4), do núcleo da proposta sobre governança de dados (§5), da governança das ferramentas (§6) e da arquitetura (§7), e de um plano honesto de implementação que nomeia o que ainda falta (§8).

## 2. Escopo: três camadas de governança

A palavra "governança" nesta proposta cobre três decisões de natureza distinta, que não podem ser resolvidas pelo mesmo processo nem pela mesma pessoa:

**Governança dos dados** — o que se registra, o que se publica, o que se retira. Decidida pela **comunidade** (ou, no caso de fontes secundárias, acervos e obras de naturalistas, pela curadoria informada pela fonte e, quando aplicável, pela comunidade de origem do conhecimento registrado). Mecanismos: CLPI (§5.3), rotulagem cultural (§5.5), revogação (§5.4). Nenhuma decisão técnica ou de produto sobrepõe esta camada: o mantenedor de uma instância não publica um registro que a comunidade marcou `private`, e o Comitê Federado não decide, para um registro específico, se ele deve ser público.

**Governança das ferramentas** — deploy, versão, backup, segurança de cada unidade federada. Decidida pelo **mantenedor da instância** — a pessoa, equipe ou instituição que opera o container e o arquivo SQLite+JSON de uma unidade específica (BioCultDB, BioCultRelatos, BioCultAcervos, BioCultNaturalistas, ou uma instância do Pluriverso). Mecanismos: ciclo de releases (§6.2), segurança operacional (§6.3), licenciamento de código (§6.4).

**Governança da arquitetura** — ADRs, contrato de harvest, admissão e remoção de membros da federação. Decidida pelo **Comitê Federado** (ADR-004, decisão D3), por consenso ou maioria qualificada, com um comitê próprio para cada instância do Pluriverso quando há múltiplas instâncias soberanas (ADR-009). Mecanismos: processo de ADR (§7.1), matriz de decisão (§7.2).

As três camadas formam uma hierarquia de **habilitação, não de subordinação**: a camada de arquitetura habilita a existência técnica das camadas abaixo — é o Comitê que aprova, por exemplo, a criação de um novo valor de `visibility` — mas não decide *pelas* comunidades ou pelos mantenedores dentro do espaço que essas camadas já controlam.

Três princípios atravessam as três camadas e resumem o compromisso desta proposta:

- **Soberania** — o dado mora com quem o gerou. Cada unidade federada mantém seu próprio arquivo SQLite+JSON (ADR-005); nenhuma camada de governança superior tem acesso direto ao dado de uma unidade além do que essa unidade publica explicitamente.
- **Consentimento** — sem CLPI, o registro não entra. Aplica-se com o mesmo rigor às quatro fontes de evidência da arquitetura, com o processo de consentimento apropriado a cada uma (§5.3).
- **Reversibilidade** — toda decisão de publicação pode ser desfeita. `purge_by_member` remove um membro inteiro do índice federado (ADR-004, decisão D4); o mesmo princípio se aplica a um único registro cuja `visibility` deixa de ser `public`.

![Três camadas de governança empilhadas: no topo, governança da arquitetura, decidida pelo Comitê Federado; no meio, governança das ferramentas, decidida pelo mantenedor da instância; na base, governança dos dados, decidida pela comunidade. Setas tracejadas indicam que cada camada superior habilita a inferior sem decidir por ela. No rodapé, três princípios: soberania, consentimento e reversibilidade.](governanca-tres-camadas.png)

*As três camadas de governança e a relação entre elas: a camada superior habilita a inferior, e nunca decide por ela.*

> **Nota de estado — 2026-09-03.** As três camadas descritas nesta seção são **proposta em consulta**, não estrutura existente. O **Comitê Federado não está constituído**: é vocabulário desta proposta e do glossário da federação (`CONTEXT.md`), sem corpo, sem membros e sem processo decisório definido — o bloqueador E4 descrito em §6.1 é uma das razões. Hoje as três camadas estão acumuladas em uma pessoa, o pesquisador proponente, e a arquitetura é conduzida como projeto de pesquisa (`docs/projetoPesquisa.md`).
>
> O único mecanismo de governança **em operação real** é outro, e nasceu de baixo: cada iniciativa parceira designa um **Ponto-Focal** (verbete em `CONTEXT.md`) que recebe as pendências que dependem de consideração humana, sistematiza demandas e as encaminha ao corpo que decide dentro daquela iniciativa. Foi assim que a interlocução começou a existir — pela necessidade prática de resolver pendências que a arquitetura não pode resolver sozinha, antes e independentemente da estrutura formal proposta acima. O primeiro pedido de indicação foi feito ao Comitê Gestor do USEFLORA em 18/08/2026 (`docs/reunioes/reuniao-useflora-2026-08-18.md`); a indicação ainda não ocorreu.
>
> O que o Ponto-Focal **não** é: titular. Sua resposta é a posição da iniciativa que o designou, e nunca o consentimento da comunidade detentora sobre um registro concreto — que é coletivo (§5.1, Lei nº 13.123/2015, art. 10, §1º) e se dá registro a registro. A pauta que separa uma coisa da outra vive em `docs/conhecimento/pauta-comunidades.md`, em duas seções: pautas de desenho, decidíveis com um corpo de representação mista, e pautas de consentimento, que nenhum interlocutor fecha por atacado.

## 3. Fundamentos éticos e legais

### 3.1 Os princípios C.A.R.E. e a tensão com FAIR

Os princípios CARE foram redigidos em workshop presencial em Gaborone, Botsuana, em 8 de novembro de 2018, co-organizado por Stephanie Russo Carroll e Maui Hudson junto ao *International Indigenous Data Sovereignty Interest Group* da Research Data Alliance, e publicados em 2020 (CARROLL et al., 2020). Não são uma norma técnica redigida por um comitê de padronização: são o resultado de deliberação indígena coletiva, e é assim que esta proposta os trata.

Os quatro princípios, na formulação oficial (CARROLL et al., 2020; GLOBAL INDIGENOUS DATA ALLIANCE, 2019):

- **C — *Collective Benefit* (Benefício Coletivo):** os ecossistemas de dados devem ser desenhados e funcionar de maneira a permitir que os povos indígenas obtenham benefício a partir dos dados. Sub-princípios: desenvolvimento e inovação inclusivos (C1), governança melhorada e engajamento (C2), resultados equitativos (C3).
- **A — *Authority to Control* (Autoridade para Controlar):** os direitos e interesses dos povos indígenas sobre os dados indígenas devem ser reconhecidos, e sua autoridade para controlar esses dados deve ser fortalecida. Sub-princípios: reconhecimento de direitos e interesses, incluindo o consentimento livre, prévio e informado coletivo e individual (A1); dados para a governança (A2); governança dos dados, isto é, o direito de determinar como povos, terras, territórios, recursos e conhecimentos são representados nos dados (A3).
- **R — *Responsibility* (Responsabilidade):** quem trabalha com dados indígenas tem a responsabilidade de demonstrar como esses dados são usados em favor da autodeterminação e do benefício coletivo. Sub-princípios: relações positivas e continuadas (R1), ampliação da capacidade das próprias comunidades de governar seus dados (R2), respeito e incorporação de línguas e cosmovisões indígenas (R3).
- **E — *Ethics* (Ética):** os direitos e o bem-estar dos povos indígenas devem ser a preocupação primária em todas as etapas do ciclo de vida do dado. Sub-princípios: minimizar danos e maximizar benefícios (E1), justiça diante de desequilíbrios históricos e estruturais de poder (E2), consideração das implicações éticas de usos futuros (E3).

> O enunciado literal dos doze sub-princípios usado nesta proposta foi conferido em reproduções secundárias mutuamente idênticas do *one-pager* oficial da GIDA, não no PDF original. Antes da publicação definitiva deste documento, o PDF deve ser baixado, conferido e **auto-hospedado** neste repositório — a página oficial `gida-global.org/care` retornou HTTP 404 em julho de 2026, e uma proposta de governança não deveria depender de um link que já caiu uma vez (§8.1).

CARE **complementa**, não substitui, os princípios FAIR — *Findable, Accessible, Interoperable, Reusable* (WILKINSON et al., 2016). O FAIR descreve propriedades técnicas do dado; não diz nada sobre quem tem autoridade sobre ele, nem sobre a assimetria histórica entre quem coleta e quem é coletado. Essa omissão não é neutra quando o objeto é conhecimento tradicional: "acessível" e "reutilizável" sem autoridade comunitária é exatamente a condição que permitiu os casos descritos em §4.1. Daí a heurística consolidada na literatura — *tão aberto quanto possível, tão fechado quanto necessário*, com a decisão sobre onde fica essa linha pertencendo à comunidade, não ao pesquisador nem à plataforma (CARROLL et al., 2021; JENNINGS et al., 2023).

CARE também se apoia em um padrão anterior: o **OCAP®** — *Ownership, Control, Access, Possession* — formulado em 1998 no Canadá e mantido pelo First Nations Information Governance Centre (FIRST NATIONS INFORMATION GOVERNANCE CENTRE, s.d.). O OCAP® é relevante aqui por um motivo específico: ele separa **titularidade** (*ownership*) de **posse** (*possession*), tratando a posse física dos dados como mecanismo distinto e verificável. A Arquitetura BioCultural implementa *Possession* de forma quase exemplar — um container e um arquivo SQLite+JSON por unidade federada (ADR-005) — mas ainda não distingue formalmente titularidade de posse no modelo de dados; a distinção é retomada em §5.1.

A tensão FAIR × CARE atravessa esta arquitetura de forma concreta, porque suas quatro fontes de evidência não têm o mesmo perfil de risco. O BioCultDB trabalha sobre literatura científica já publicada, com vocação FAIR; o BioCultRelatos registra conhecimento diretamente com detentores vivos, com vocação CARE; BioCultAcervos e BioCultNaturalistas lidam com material histórico sobre comunidades que nunca foram consultadas. A federação sem centralização já resolve estruturalmente boa parte dessa tensão — cada perfil de risco fica em sua própria unidade soberana, com sua própria política de publicação. O que falta é declarar a regra que ordena as duas famílias de princípios quando elas colidem, e esta proposta a declara: **quando houver conflito entre uma exigência FAIR e uma exigência CARE sobre o mesmo registro, CARE prevalece.** Na prática, isso significa que nenhum ganho de interoperabilidade, indexação ou completude justifica publicar um registro que a comunidade de origem não autorizou.

A tabela abaixo mapeia cada sub-princípio ao mecanismo que o implementaria, ao componente concreto da arquitetura, e ao estado real desse componente hoje. É deliberadamente honesta quanto aos vazios: os itens marcados **Gap** são retomados como lacunas nomeadas em §8.1.

Registre-se, quanto à produção nacional: a literatura brasileira sobre CARE está concentrada em Ciência da Informação, com foco em plano de gestão de dados de pesquisa (TORINO et al., 2024), e não foi localizada produção equivalente em periódicos brasileiros de etnobiologia ou biodiversidade. O cruzamento entre CARE e o regime brasileiro de acesso ao patrimônio genético permanece, portanto, um território pouco sistematizado — o que aumenta a responsabilidade desta proposta em ser precisa quanto ao que afirma.

| Sub-princípio | Mecanismo | Componente da arquitetura | Estado |
|---|---|---|---|
| C1 — desenvolvimento inclusivo | Exportação em formato aberto e reusável pela própria comunidade | Endpoint de harvest de cada unidade (ADR-004, D6); exportação SQLite/JSON (ADR-005) | Parcial — a infraestrutura existe, mas nenhum canal preferencial garante reuso facilitado pela comunidade de origem |
| C2 — governança e engajamento | Relatório de uso devolvido às unidades-fonte | Nenhum hoje | **Gap** — o Pluriverso não registra nem devolve "quem consultou o quê, para quê" (§5.9) |
| C3 — resultados equitativos | Repartição de benefícios formal | Fora do escopo técnico atual | **Gap** — exige mecanismo de governança articulado com o CGen, não apenas código (§5.9) |
| A1 — direitos e CLPI | Consentimento como pré-condição de publicação | `community.consent` (ADR-003); CLPI obrigatório antes de `visibility: public` (ADR-004, D6) | Atendido em desenho; **gap de granularidade** — o consentimento é binário, sem escopo, prazo nem revogação estruturados (§5.3) |
| A2 — dados para a governança | Soberania de infraestrutura (posse física) | 1 container + 1 SQLite+JSON por unidade (ADR-005) | Bem atendido — é o núcleo do desenho federado (ADR-004) |
| A3 — governança da representação | Vocabulário soberano definido pela comunidade | BioCultTermos, `ConceptScheme` por unidade (ADR-007) | Bem atendido no princípio; **gap** — sem rótulos culturais multivalorados (TK/BC Labels) além de `visibility` (§5.5, §5.8) |
| R1 — relações positivas | Governança por comitê representativo | Comitê Federado (ADR-004, D3), por instância (ADR-009) | Parcial — não há protocolo declarado de relacionamento continuado pós-adesão (§6.1) |
| R2 — ampliação de capacidade | SDK de referência para reduzir a barreira técnica de adesão | Previsto no ADR-004, não implementado | **Gap** já reconhecido internamente (§8.1) |
| R3 — línguas e cosmovisões | Rótulos multilíngues por conceito | SKOS-XL no BioCultTermos (ADR-007) | Potencial técnico atendido; **gap de política** — nada exige rótulo em língua indígena como prática padrão (§5.8) |
| E1 — minimizar danos | Avaliação de dano antes da publicação | Campo `visibility`; harvest só de `public` (ADR-004, D6) | Parcial — o mecanismo existe, o processo de avaliação não está documentado (§5.2) |
| E2 — justiça | Revogação e saída reversível | `purge_by_member` (ADR-004, D4) | Muito bem atendido — reversibilidade total, sem carência |
| E3 — uso futuro | Reavaliação periódica do consentimento | `member_id` estável e escopado por instância (ADR-009) | Parcial — a proveniência é robusta, mas o consentimento é tratado como perpétuo (§5.3, §5.4) |

### 3.2 Marco legal brasileiro

Nenhuma das exigências desta proposta é invenção do projeto: quase todas já são obrigação legal. Esta seção reúne os dispositivos que incidem diretamente sobre uma plataforma que registra conhecimento tradicional associado (CTA), com o artigo exato de cada um.

**Lei nº 13.123/2015 (Lei da Biodiversidade)** — é o regime específico do CTA:

- **Art. 2º, III** distingue CTA de **origem não identificável** ("conhecimento tradicional associado em que não há a possibilidade de vincular a sua origem a, pelo menos, uma população indígena, comunidade tradicional ou agricultor tradicional") do CTA de origem identificável, por exclusão. A distinção é operacional para esta arquitetura: o BioCultDB frequentemente lida com o primeiro caso, o BioCultRelatos produz, por definição, o segundo (§5.1).
- **Art. 9º, *caput*** condiciona o acesso ao CTA de origem identificável à obtenção do consentimento prévio informado. O **§1º** lista quatro formas de comprovação, **à escolha da comunidade**: I — termo de consentimento prévio assinado; II — registro audiovisual do consentimento; III — parecer do órgão oficial competente; IV — adesão na forma prevista em protocolo comunitário. O inciso IV é a ponte jurídica direta entre a lei brasileira e o direito costumeiro reconhecido pelo Protocolo de Nagoya (§3.3), e se materializa no campo `consent.protocolReference` proposto em §5.3. O **§2º** dispensa consentimento para CTA de origem não identificável.
- **Art. 10, §1º** determina que "qualquer conhecimento tradicional associado ao patrimônio genético será considerado de natureza coletiva, ainda que apenas um indivíduo de população indígena ou de comunidade tradicional o detenha". É a base da titularidade coletiva presumida — e o eixo do argumento de §3.4.
- **Arts. 3º e 12** condicionam o acesso a cadastro, autorização ou notificação no **SisGen**; **arts. 19 a 22** definem as modalidades monetária e não monetária de repartição de benefícios, com a monetária fixada em **1% da receita líquida anual** (art. 20), redutível a até **0,1%** por acordo setorial (art. 21).
- **Art. 27** tipifica as sanções administrativas, com multa de R$ 1.000 a R$ 100.000 para pessoa natural e de R$ 10.000 a R$ 10.000.000 para pessoa jurídica (§5º).

**Decreto nº 8.772/2016** regulamenta a Lei nº 13.123/2015 — alterado pelo **Decreto nº 10.844/2021** (segregação dos cadastros de pesquisa sem finalidade econômica) e pelo **Decreto nº 13.014/2026**. Seu **art. 83** tipifica, como infração administrativa autônoma, "acessar conhecimento tradicional associado de origem identificável sem a obtenção do consentimento prévio informado, ou em desacordo com este". Não confundir com o **Decreto nº 8.750/2016**, que institui o **Conselho Nacional dos Povos e Comunidades Tradicionais (CNPCT)** e é a fonte correta das 29 classificações de comunidades já usadas no BioCultDB — os dois decretos são de maio de 2016 e têm papéis inteiramente distintos.

**Lei nº 13.709/2018 (LGPD)** — incide sobre os dados pessoais que inevitavelmente acompanham o registro do conhecimento:

- **Art. 5º, II** define dado pessoal sensível, incluindo "origem racial ou étnica" e "convicção religiosa". **Art. 11, §1º** estende a proteção a "qualquer tratamento de dados pessoais que revele dados pessoais sensíveis". A consequência para esta arquitetura é direta e frequentemente subestimada: **um relato que identifique o povo ou a comunidade do detentor revela dado sensível mesmo sem existir um campo "etnia"**. A ficha de proveniência inteira do BioCultRelatos é dado sensível, não apenas um de seus campos (§5.11).
- **Art. 11, I** exige, para dado sensível, consentimento "específico e destacado, para finalidades específicas" — o que impede tratar o CLPI como cláusula embutida em um termo genérico de uso.
- **Art. 7º, §4º** dispensa consentimento para dados "tornados manifestamente públicos pelo titular". **Essa dispensa não se aplica aqui**: quem publica um registro na federação é a plataforma, por decisão da comunidade, não o titular individual tornando público o próprio dado. Marcar `visibility: public` nunca substitui o CLPI (§5.3).
- **Art. 6º** fixa os dez princípios de tratamento (finalidade, adequação, necessidade, livre acesso, qualidade, transparência, segurança, prevenção, não discriminação, responsabilização); **art. 9º** exige informar ao titular finalidade, forma, duração, identificação do controlador, uso compartilhado e seus direitos; **art. 18** enumera os nove direitos do titular, incluindo eliminação e revogação do consentimento; **arts. 33 a 36** disciplinam a transferência internacional; **arts. 37 e 38** exigem registro das operações e Relatório de Impacto à Proteção de Dados (RIPD); **art. 41** exige a designação de encarregado; **arts. 46 a 49** exigem segurança desde a concepção, sigilo e comunicação de incidentes. O detalhamento operacional de cada um está em §5.11.

**Marco constitucional e de patrimônio cultural** — **CF/88, art. 231, *caput*** reconhece aos povos indígenas "sua organização social, costumes, línguas, crenças e tradições, e os direitos originários sobre as terras que tradicionalmente ocupam", o que faz da geolocalização precisa de território tradicional um dado de alta criticidade (§5.2). **Art. 215, §1º** e **art. 216, I–II** fundamentam a própria finalidade desta arquitetura, ao incluir "os modos de criar, fazer e viver" no patrimônio cultural brasileiro e ao prever o registro como forma de proteção — instrumentalizado pelo **Decreto nº 3.551/2000**, que cria o Livro de Registro dos Saberes do IPHAN, o instrumento estatal conceitualmente mais próximo do que o BioCultRelatos faz. **A Emenda Constitucional nº 115/2022** inseriu o inciso LXXIX no art. 5º, elevando a proteção de dados pessoais a direito fundamental — mantendo, porém, o desenho centrado na pessoa natural (§3.4).

**Definição de comunidade tradicional** — o **Decreto nº 6.040/2007, art. 3º, I** define povos e comunidades tradicionais como "grupos culturalmente diferenciados e que se reconhecem como tais, que possuem formas próprias de organização social, que ocupam e usam territórios e recursos naturais como condição para sua reprodução cultural, social, religiosa, ancestral e econômica". O critério é a **autoidentificação**, e é ele que deve reger a admissão de uma comunidade como membro da federação — não uma lista fechada nem a validação de terceiros (§6.1).

**Direitos de personalidade e obra histórica** — o **Código Civil, art. 20** condiciona a divulgação de escritos, a transmissão da palavra e o uso da imagem à autorização da pessoa, o que se soma à LGPD e à Lei 13.123/2015 no tríplice regime do registro audiovisual (§5.3). A **Lei nº 9.610/1998, arts. 41, 43 e 45** define o domínio público patrimonial após 70 anos — relevante para o BioCultNaturalistas, com a ressalva decisiva de que o art. 45 preserva expressamente "a proteção legal aos conhecimentos étnicos e tradicionais": a obra do naturalista pode estar em domínio público sem que o conhecimento coletivo nela registrado tenha entrado (§5.6).

A única referência doutrinária brasileira localizada que cruza LGPD e povos indígenas analisa a adequação da FUNAI à lei e conclui por descompasso estrutural, com risco elevado a dados sensíveis de população indígena (PRESTES; PREVE; BONA, 2024) — evidência de que a distância entre a norma e a prática institucional, no Brasil, não é hipotética.

### 3.3 Marco internacional

**CDB, art. 8(j)** (promulgada no Brasil pelo Decreto nº 2.519/1998) obriga a "respeitar, preservar e manter o conhecimento, as inovações e as práticas das comunidades locais e populações indígenas" e a promover sua aplicação "com a aprovação e a participação dos detentores", encorajando a repartição justa e equitativa dos benefícios. É a origem normativa de todo o restante.

**Protocolo de Nagoya** (promulgado pelo Decreto nº 11.865/2023) — **art. 5(5)** estende expressamente o dever de repartição de benefícios ao conhecimento tradicional associado a recursos genéticos; **art. 7** exige que esse conhecimento seja acessado "com o consentimento prévio e informado ou aprovação e envolvimento" das comunidades detentoras — a fórmula "aprovação e envolvimento" é mais exigente que uma assinatura pontual e sustenta o desenho de CLPI como processo contínuo (§5.3). O **art. 12** é o dispositivo mais diretamente operacional para esta arquitetura: obriga as Partes a considerar o **direito costumeiro, os protocolos comunitários e os procedimentos das próprias comunidades**, e a apoiar o desenvolvimento, pelas comunidades, de protocolos comunitários de acesso e repartição, requisitos mínimos para termos mutuamente acordados e cláusulas contratuais-modelo (CBD SECRETARIAT, 2011).

**Convenção nº 169 da OIT** (promulgada pelo Decreto nº 5.051/2004, consolidado pelo Decreto nº 10.088/2019) — **art. 6º(1)(a)** obriga a consultar os povos interessados "mediante procedimentos apropriados e, particularmente, através de suas instituições representativas", sempre que previstas medidas suscetíveis de afetá-los diretamente; **art. 7º(1)** reconhece o direito de escolher as próprias prioridades de desenvolvimento. Para esta proposta, a consequência é que **mudanças estruturais no contrato de harvest ou na governança da federação exigem consulta formal às comunidades federadas** — não apenas deliberação do Comitê (§7.2).

**UNDRIP, art. 31(1)** (ORGANIZAÇÃO DAS NAÇÕES UNIDAS, 2007) é o único instrumento internacional que fala em **controle**, e não apenas em consentimento, sobre patrimônio cultural, conhecimento tradicional, recursos genéticos e conhecimento das propriedades da fauna e da flora. É a base para o direito de a comunidade editar ou retirar seu registro a qualquer tempo, e não apenas aprová-lo uma vez (§5.4).

**OMPI** — em 24 de maio de 2024, em Genebra, foi adotado por consenso o **WIPO Treaty on Intellectual Property, Genetic Resources and Associated Traditional Knowledge**, primeiro tratado da OMPI a tratar da interface entre propriedade intelectual, recursos genéticos e conhecimento tradicional associado, com núcleo na exigência de divulgação de origem em pedidos de patente (WORLD INTELLECTUAL PROPERTY ORGANIZATION, 2024). Registre-se, porque a confusão é comum: **não se trata do "Tratado de Riad"** — o Riyadh Design Law Treaty, adotado em 22 de novembro de 2024, versa sobre desenho industrial e nada tem a ver com recursos genéticos ou conhecimento tradicional.

O **TIRFAA** (promulgado pelo Decreto nº 6.476/2008) tem incidência limitada e apenas eventual: só importa se a plataforma vier a registrar variedades tradicionais ou crioulas de cultivo, quando então seus "Direitos do Agricultor" passam a se somar ao regime da Lei nº 13.123/2015.

### 3.4 A lacuna dos dados coletivos: onde a LGPD não alcança o CTA

Há uma incompatibilidade estrutural entre os dois regimes que incidem sobre um registro de conhecimento tradicional, e ela não se resolve por interpretação. Vale nomeá-la com precisão, porque é dela que decorre boa parte do desenho proposto em §5.

De um lado, a **LGPD é construída sobre o titular individual**. O art. 5º, V define titular como "pessoa natural a quem se referem os dados pessoais"; o art. 17 reforça que "toda pessoa natural tem assegurada a titularidade de seus dados pessoais". Não existe, na lei, categoria jurídica de dado de titularidade coletiva: uma comunidade, um povo ou um coletivo tradicional simplesmente não é titular no sentido da LGPD.

De outro, a **Lei nº 13.123/2015 presume o oposto**. Seu art. 10, §1º determina que "qualquer conhecimento tradicional associado ao patrimônio genético será considerado de natureza coletiva, ainda que apenas um indivíduo de população indígena ou de comunidade tradicional o detenha".

Os dois regimes não conversam porque regulam objetos diferentes: a Lei nº 13.123/2015 regula o **conhecimento**; a LGPD regula os **dados pessoais** que acompanham o registro desse conhecimento — o nome, a voz, a imagem, a aldeia, a etnia do detentor. Um único relato de campo é, ao mesmo tempo, os dois objetos. E não há norma que diga o que prevalece quando o detentor individual autoriza e a comunidade não, ou o contrário.

A LGPD oferece apenas **coletivização processual**, não titularidade coletiva substantiva: o art. 42, §3º permite que ações de reparação por danos coletivos "sejam exercidas coletivamente em juízo". Uma comunidade pode, portanto, processar coletivamente pelo dano — mas não *decidir* coletivamente sobre o dado, nos termos da LGPD. A EC 115/2022, ao elevar a proteção de dados a direito fundamental (CF, art. 5º, LXXIX), manteve intacto o desenho individual, o que confirma que a lacuna é estrutural, e não omissão pontual corrigível por interpretação extensiva.

A consequência prática é séria: **o consentimento individual do art. 7º ou do art. 11 da LGPD não substitui o CLPI coletivo** exigido pelo art. 9º da Lei nº 13.123/2015, pelo art. 6º da Convenção nº 169 da OIT e pelo art. 7º do Protocolo de Nagoya. Uma plataforma que colete apenas a assinatura do detentor que prestou o relato terá cumprido a LGPD e violado o regime do CTA — e terá feito exatamente o que a literatura de pesquisa extrativa descreve como tratamento do detentor como "informante" e não como parte de um coletivo (JENNINGS et al., 2023).

Esta arquitetura não pode resolver a lacuna legislativa, mas pode não ser derrotada por ela. A cobertura se dá por desenho, em três mecanismos que já existem ou são propostos adiante:

1. **Soberania do arquivo** — o dado permanece no SQLite+JSON da unidade da própria comunidade (ADR-005). Não há repositório central de onde o dado possa ser tratado sem o conhecimento de quem o gerou; a posse física antecede e sustenta a discussão sobre titularidade (OCAP®, §5.1).
2. **`visibility` decidida coletivamente** — a decisão de publicar não é do detentor individual nem do pesquisador, mas do órgão de decisão coletiva que a própria comunidade indicar em seu protocolo (§5.2, §6.1). É a tradução operacional do art. 10, §1º da Lei nº 13.123/2015 dentro do modelo de dados.
3. **Revogação com purge** — a decisão coletiva pode ser desfeita a qualquer tempo, com remoção imediata do índice federado por `purge_by_member` (ADR-004, D4) ou por mudança de `visibility` de um registro individual. É o que aproxima a plataforma do **controle** exigido pelo art. 31 da UNDRIP, e não apenas do consentimento.

Nenhum desses mecanismos cria titularidade coletiva onde a lei não a reconhece. O que eles fazem é garantir que, na ausência de amparo legislativo, a decisão de fato permaneça com o coletivo — e que a plataforma não se beneficie da lacuna.

## 4. O receio legítimo: por que comunidades desconfiam de bancos de dados

Quando uma liderança pergunta "e se esses dados forem usados contra nós?", ela não está levantando uma hipótese. Está descrevendo um padrão histórico documentado, com números de patente, decisões de escritórios de propriedade intelectual e décadas de exploração sem retorno. Uma proposta de governança que trate esse receio como resistência a ser vencida por comunicação já começou errada. Esta seção faz o contrário: apresenta o histórico, expõe o dilema real que ele cria para qualquer iniciativa de documentação, e nomeia — com seus limites — o que esta arquitetura efetivamente faz a respeito.

### 4.1 O que já aconteceu

Os casos abaixo têm número de patente ou marca e desfecho verificável. Não são exemplos ilustrativos: são o repertório que qualquer comunidade tradicional brasileira conhece, em primeira ou segunda mão, quando decide se confia ou não em um banco de dados.

| Caso | O que aconteceu | Desfecho | Lição para a governança de dados |
|---|---|---|---|
| **Cupuaçu** (*Theobroma grandiflorum*) — Brasil/Japão | Em 1998 a empresa japonesa Asahi Foods registrou "Cupuaçu" como marca no Japão, na UE e nos EUA, e tentou patentear o processo do "cupulate", já desenvolvido pela Embrapa | Em 2004 o Japan Patent Office cancelou o registro por se tratar de nome comum de fruta; as patentes de processo caíram por falta de novidade (CÂMARA DOS DEPUTADOS; SENADO FEDERAL, s.d.) | Nome vernacular e origem geográfica são ativos disputáveis. Um vocabulário controlado público de nomes e origens (BioCultTermos) funciona como *prior art* monitorável — este é um caso em que **publicar protege** |
| **Ayahuasca** (*Banisteriopsis caapi*) — EUA/Amazônia | Em 1986 Loren Miller obteve a Plant Patent US PP5.751 sobre uma variedade cultivada e usada ritualmente há séculos por povos amazônicos; COICA e CIEL contestaram | O USPTO cancelou a patente em 1999 por falta de novidade, reinstituiu-a em 2001 por vício processual na reexaminação, e ela expirou naturalmente em 2003 (CENTER FOR INTERNATIONAL ENVIRONMENTAL LAW, s.d.; UNITED STATES PATENT AND TRADEMARK OFFICE, s.d.) | O sistema de patentes não sabe tratar conhecimento oral e ritual como estado da técnica. E o inverso do caso anterior: **conhecimento ritual não deveria ser publicado para se defender** — a defesa aqui veio de mobilização política, não de banco de dados (§5.2) |
| **Jaborandi / pilocarpina** (*Pilocarpus microphyllus*) — Maranhão | Desde 1968 a Merck manteve monopólio de compra das folhas e, a partir de 1989, domesticou a espécie diante do esgotamento do extrativismo, sem repartição de benefícios com os "folheiros" | Décadas de assimetria; apenas recentemente cooperativas buscam repactuar o extrativismo com renda justa (SCIELO BRASIL, s.d.) | Exploração **legal** e ausência de repartição convivem sem conflito. Sem rastro documentado do vínculo entre o conhecimento e seu uso comercial, não há como sequer formular a reivindicação (§5.9) |
| **Espinheira-santa** (*Maytenus ilicifolia*) — Brasil/Japão | Pesquisa pública brasileira dos anos 1970–80 validou cientificamente o uso tradicional para gastrite e úlcera, tornando os dados públicos; em 1997 a japonesa Nippon Mektron depositou a patente EP0776666 sobre formulações baseadas nessas propriedades | Patente depositada a partir de dados científicos abertos brasileiros (UNIVERSIDADE FEDERAL DE SANTA CATARINA; EPAGRI-SC, s.d.) | O caso central deste documento: **ciência aberta sem governança vira insumo de patente estrangeira**. Publicar validação científica de CTA sem proteção associada não é neutro (§4.2) |
| **Hoodia gordonii** — povo San, África do Sul | Nos anos 1990 o CSIR isolou e patenteou o composto P57, usado tradicionalmente pelos San para suprimir fome e sede, licenciando-o à Phytopharm e depois à Pfizer, sem consentimento prévio nem repartição | Após pressão pública, em 2003 CSIR e South African San Council firmaram acordo com royalties e criaram o San Hoodia Benefit-Sharing Trust; a Pfizer depois abandonou o desenvolvimento comercial (CBD SECRETARIAT, s.d.) | Repartição negociada *a posteriori* é possível, mas chega tarde e depende de mobilização internacional. O CLPI *ex ante* não é formalidade: é o único momento em que a comunidade negocia com poder (§5.3) |
| **Nim** (*Azadirachta indica*) — Índia/UE | Em 1994 o EPO concedeu a patente EP0436257 ao USDA e à W.R. Grace sobre fungicida derivado do óleo de nim, propriedade usada há milênios na Ayurveda | Revogada em 2000 pela Divisão de Oposição do EPO, decisão confirmada em recurso em 2005 (EUROPEAN PATENT OFFICE, 2000) | Provar *prior art* de conhecimento não documentado em formato "padrão-patente" é caro e lento — foi este caso que catalisou a criação da TKDL indiana (§4.2) |
| **Cúrcuma** (*Curcuma longa*) — Índia/EUA | Em 1995 o USPTO concedeu a patente US 5.401.504 sobre o uso da cúrcuma em cicatrização de feridas a pesquisadores da Universidade do Mississippi | O CSIR indiano apresentou 32 evidências, incluindo textos sânscritos antigos, e todas as seis reivindicações foram revogadas em 1997 (UNITED STATES PATENT AND TRADEMARK OFFICE, s.d.; WORLD INTELLECTUAL PROPERTY ORGANIZATION, s.d.) | Reverter é tecnicamente possível, mas exige esforço documental que a maioria das comunidades não tem. Metadados desde a origem reduzem esse custo (§5.6) |
| **Quinoa "Apelawa"** — Bolívia/EUA | Em 1994 pesquisadores da Colorado State University obtiveram a patente US 5.304.718 sobre citoplasma macho-estéril de variedade boliviana usada há milênios, cobrindo qualquer híbrido derivado | Abandonada em 1998 sob pressão internacional articulada por ANAPQUI e ETC Group; em 2011 a Bolívia legislou sobre soberania de variedades tradicionais (ETC GROUP, s.d.) | Material e conhecimento cedidos livremente por agricultores tradicionais podem ser usados **contra os próprios cedentes**. Cessão sem termo registrado é risco, não gentileza (§5.3) |
| **Açaí** (*Euterpe oleracea*) — Brasil/Japão | Em 2003 a japonesa K.K. Eyela Corporation registrou a marca "açaí" no Japão, criando barreira comercial para exportadores brasileiros | Revogada em 2007 após mobilização diplomática junto ao Japan Patent Office (CÂMARA DOS DEPUTADOS; SENADO FEDERAL, s.d.; FUNDAÇÃO DE AMPARO À PESQUISA DO ESTADO DE SÃO PAULO, s.d.) | O padrão do cupuaçu se repetiu cinco anos depois. Biosquatting de nomes é recorrente, e exige monitoramento contínuo — não é um problema resolvido |

Dois casos frequentemente citados no debate brasileiro — kava e andiroba/copaíba — **não** aparecem na tabela como casos nominais: a literatura descreve o padrão de apropriação com consistência, mas não foi possível verificar número de patente e desfecho específicos com o mesmo rigor dos demais. Ficam registrados aqui como padrão documentado, não como caso com desfecho nominal.

O que os casos têm em comum é mais instrutivo que cada um isoladamente. Em todos, o conhecimento era coletivo, antigo e conhecido — e ainda assim foi tratado como novidade por um sistema que só reconhece o que está escrito no formato que ele espera. Em nenhum deles a comunidade de origem foi consultada antes. Na maioria, a reversão dependeu de mobilização internacional cara e demorada, e mesmo quando houve reversão, ela restaurou o estado anterior sem gerar qualquer benefício para a comunidade. Essa assimetria é o que a literatura chama de **colonialismo de dados**: a extração da experiência de vida humana como matéria-prima, normalizada sob discursos de conexão e progresso (COULDRY; MEJIAS, 2019). E é também o que a etnobiologia brasileira tem nomeado criticamente ao questionar por quanto tempo o legado colonialista da disciplina seguirá sendo reforçado (ZANK et al., 2025).

### 4.2 O dilema da documentação: registrar protege ou expõe?

O caso do nim e o da cúrcuma levaram a Índia a criar, em 2001, a **Traditional Knowledge Digital Library (TKDL)** — a digitalização do conhecimento médico tradicional (Ayurveda, Unani, Siddha) em formato compatível com a Classificação Internacional de Patentes, para que examinadores de patentes em qualquer país possam identificar *prior art* rapidamente (WORLD INTELLECTUAL PROPERTY ORGANIZATION, s.d.). É a estratégia da **documentação defensiva**, e ela tem resultados: diversos pedidos de patente sobre fórmulas tradicionais foram retirados ou cancelados a partir da base.

A crítica à documentação defensiva, porém, é substantiva e não pode ser tratada como ressalva:

- **Paradoxo do acesso fechado.** A TKDL é de acesso restrito. Protege o conhecimento de apropriação por terceiros, mas não dá à comunidade controle positivo sobre ele — apenas o congela como *prior art*.
- **Descontextualização.** Digitalizar para fins de exame de patente extrai o conhecimento de seu contexto cultural e comunal, e pode servir mais a uma agenda de patrimônio cultural nacional do que aos detentores específicos daquele saber.
- **Exclusão do oral.** Conhecimento mantido oralmente por comunidades menores é difícil de registrar no formato padronizado — segue vulnerável mesmo com a base existindo.
- **Falácia da proteção defensiva.** Impedir patentes ruins não é o mesmo que dar à comunidade o direito positivo de controlar, licenciar ou obter benefício do próprio conhecimento.
- **Risco de facilitar a bioprospecção.** Uma base de CTA, ainda que criada com boa intenção, pode funcionar como mapa para bioprospectores: localiza espécies e usos promissores rapidamente, sem obrigação legal de retorno.

Os casos de §4.1 sustentam os dois lados ao mesmo tempo. No cupuaçu e no açaí, o nome era público e a publicidade ajudou a derrubar a marca. Na espinheira-santa, a publicação científica aberta foi precisamente o insumo da patente estrangeira. Na ayahuasca, o conhecimento era ritual — e o problema nunca foi falta de documentação.

O ponto de fundo é que abertura não é uma propriedade neutra do dado: decidir o que "quer ser livre" é uma decisão política sobre sistemas de conhecimento, e tratá-la como escolha técnica já é tomar partido (CHRISTEN, 2012).

A conclusão que esta proposta extrai daí é que **não existe resposta única, e por isso a resposta não pode ser da plataforma**. A Arquitetura BioCultural não é um registro defensivo público universal, e não pretende ser: é um **registro soberano com publicação seletiva**. A diferença é operacional, não retórica:

- O que se registra e o que se publica são **decisões separadas**. Registrar no BioCultRelatos não implica publicar; `visibility: public` é um ato explícito e distinto (§5.2).
- A decisão de publicar é da comunidade, e é **sempre uma decisão de repartição de risco** — não um padrão do sistema. Cada `visibility: public` significa que alguém pesou o risco de exposição contra o benefício de existir como *prior art* rastreável, e decidiu.
- A decisão é **revisável**. Diferentemente de uma publicação científica, marcar um registro como público na federação é reversível (§5.4).

Há um corolário desconfortável que esta proposta assume explicitamente: **há conhecimento que não deve ser digitado**. Conhecimento sagrado, iniciático ou restrito por gênero pode ser mais bem protegido pela não existência do registro do que por qualquer camada de acesso. Uma plataforma honesta precisa dizer isso na documentação e no treinamento de quem opera a aquisição, e não apenas oferecer um valor de campo para o caso (§5.2).

### 4.3 As sete salvaguardas desta arquitetura contra o mau uso

Cada salvaguarda abaixo aponta um mecanismo concreto — não uma intenção — e declara o que ela **não** impede. A lista de limites é tão importante quanto a de proteções: uma comunidade decide com base no que o sistema realmente faz.

**1. O dado não sai do território digital da comunidade.**
*Mecanismo:* cada unidade federada mantém seu próprio arquivo SQLite+JSON, em seu próprio container, sob controle de quem a opera (ADR-005). O Pluriverso nunca acessa o banco de um membro — apenas consome o endpoint REST que o membro expõe (ADR-004, D6). É a implementação de *Possession* do OCAP® (FIRST NATIONS INFORMATION GOVERNANCE CENTRE, s.d.).
*Limite:* soberania sobre o arquivo pressupõe capacidade de operá-lo. Uma comunidade sem infraestrutura, energia estável ou apoio técnico pode ter de hospedar sua unidade em terceiros — e aí a posse física é de quem hospeda, não de quem decide. Isso é um problema real de capacitação, não resolvido por arquitetura (§6.5).

**2. Publicar é ato explícito, não padrão.**
*Mecanismo:* nenhum registro é coletado pelo Pluriverso sem estar marcado `visibility: public`, e o valor padrão nunca é público (ADR-003; ADR-004, D6). O harvest é *pull* sobre o que o membro expõe, não *push* de tudo o que existe.
*Limite:* protege contra vazamento por omissão, não contra decisão mal informada. Se a comunidade marcar como público um registro cujo risco não foi bem avaliado, o sistema obedece. Daí a exigência de processo documentado de avaliação de dano antes da publicação (§5.2), hoje inexistente.

**3. O índice é derivado e descartável.**
*Mecanismo:* o índice do Pluriverso é explicitamente uma cópia derivada, nunca a fonte da verdade; `purge_by_member(member_id)` remove imediatamente todos os registros e mapeamentos de um membro (ADR-004, D4).
*Limite:* o purge alcança o índice desta instância do Pluriverso. Não alcança cópias já baixadas por terceiros, nem outras instâncias do Pluriverso que tenham coletado o mesmo membro (ADR-009), nem *caches* de buscadores. Reversibilidade é uma propriedade do índice, não do mundo.

**4. Campo oculto por decisão comunitária.**
*Mecanismo:* `permissions.hiddenFields` permite ocultar campos específicos mesmo em registros públicos — tipicamente `location.coordinates`, `community.name` e `source.primary.informants` (ADR-003). A generalização geográfica em degraus segue prática já consolidada em biodiversidade (CHAPMAN, 2020), detalhada em §5.2.
*Limite:* ocultar campo não impede reidentificação por cruzamento. Táxon raro, uso específico e município já podem, juntos, apontar para uma única comunidade. Ocultação é redução de risco, não anonimização — e a LGPD, art. 11, §1º trata como sensível qualquer tratamento que *revele* dado sensível, inclusive por associação (§3.2).

**5. Rotulagem cultural legível por humano e por máquina.**
*Mecanismo:* TK Labels e BC Labels do Local Contexts, aplicados pela própria comunidade, declaram protocolo cultural no próprio registro — de atribuição a restrição por gênero, sazonalidade ou caráter sagrado (ANDERSON; HUDSON, 2020; LOCAL CONTEXTS, s.d.). O caminho tem precedente institucional: é o que o GBIF está pilotando desde 2025 com três comunidades reais (GLOBAL BIODIVERSITY INFORMATION FACILITY, 2025). Detalhamento em §5.5. `[a implementar em BioCultRelatos, BioCultAcervos e BioCultTermos]`
*Limite:* rótulo **não é licença** e não é instrumento coercitivo. Expressa expectativa cultural; não obriga juridicamente quem já tem o dado. Seu valor é tornar a violação visível e demonstrável, não impossível.

**6. Rastro de uso como prova para repartição.**
*Mecanismo:* log de auditoria *append-only* de consultas e downloads, citação com `member_id` e DOI, finalidade declarada — desenhados como evidência auditável e exportável (§5.9). `[a implementar no Pluriverso]`
*Limite:* o log prova uso **através da plataforma**. Não prova uso a partir de cópia obtida por outro caminho, e não gera, por si, obrigação de repartir — quem reparte é o usuário, sob a Lei nº 13.123/2015, arts. 19 a 22, e o que a plataforma oferece é a evidência que hoje falta para reivindicar.

**7. Direito de sair sem negociar.**
*Mecanismo:* a saída da federação não depende de aprovação do Comitê, de aviso prévio nem de negociação: o membro sai e seus dados são removidos do índice (ADR-004, D4). O `member_id` nunca é reciclado (ADR-006), preservando a rastreabilidade histórica sem reatribuir identidade.
*Limite:* sair remove do índice, mas não desfaz o que foi feito enquanto se estava dentro. Publicações que citaram os dados permanecem publicadas; conjuntos exportados continuam existindo. A saída é uma garantia de futuro, não uma máquina do tempo.

Nenhuma dessas sete salvaguardas impede que um dado já público seja usado indevidamente. Não há arquitetura que faça isso. O que elas fazem, em conjunto, é diferente e mais modesto: garantem que **a decisão de expor tenha sido tomada por quem tem legitimidade para tomá-la**, que a origem permaneça rastreável, e que a violação seja demonstrável — que é, precisamente, o que faltou em todos os casos de §4.1.

## 5. Governança dos dados e informações

Esta é a camada central da proposta. As seções seguintes tratam de quem é titular do dado, como se classifica sua sensibilidade, como o consentimento é obtido e mantido, como o dado é rotulado, atribuído, curado, preservado e — quando for o caso — retirado.

Uma convenção de escrita, para evitar ambiguidade: os campos citados seguem a grafia exata do ADR-003. O caminho completo do controle de acesso é `permissions.visibility`; ao longo do texto, a forma abreviada `visibility: public` é usada quando o contexto já é o de controle de acesso, seguindo o uso consolidado no README e no ADR-004.

### 5.1 Titularidade: de quem é o dado

A pergunta "de quem é este dado?" tem, para conhecimento tradicional, uma resposta que o direito de dados brasileiro não sabe dar (§3.4) e que esta proposta precisa dar mesmo assim.

**A comunidade é a titular coletiva do conhecimento.** É o que determina a Lei nº 13.123/2015, art. 10, §1º: o CTA é de natureza coletiva ainda que apenas um indivíduo o detenha. A consequência operacional é que o detentor que prestou o relato **não pode, sozinho, autorizar a publicação** — ele consente com o próprio registro (voz, imagem, dados pessoais, sob o Código Civil, art. 20 e a LGPD, art. 11), mas a decisão sobre o conhecimento pertence ao coletivo, na forma que o protocolo da própria comunidade definir (§5.3, §6.1).

**O pesquisador é custodiante, não proprietário.** Quem coleta, digita, estrutura e cura o registro exerce guarda técnica sobre ele — nada além disso. No modelo de dados, `source.primary.collectedBy` identifica quem coletou; esse campo é rastro de responsabilidade, não título de propriedade. A distinção não é retórica: ela determina que o pesquisador não pode publicar, licenciar, exportar em lote nem levar consigo os registros ao mudar de instituição sem decisão da comunidade titular.

**Titularidade e posse são coisas distintas.** O padrão OCAP® separa *Ownership* de *Possession* justamente porque uma comunidade pode ser titular de um conhecimento cujo arquivo está fisicamente sob controle de outra pessoa (FIRST NATIONS INFORMATION GOVERNANCE CENTRE, s.d.). Esta arquitetura implementa a posse de forma exemplar — um container e um arquivo SQLite+JSON por unidade (ADR-005) — mas **não distingue formalmente os dois conceitos no modelo de dados**: hoje, quem opera a unidade e quem detém o conhecimento são presumidos como a mesma parte. Quando não são (comunidade cuja unidade é hospedada por uma universidade parceira, por exemplo), a distinção precisa estar escrita em algum lugar, e o lugar natural é o próprio registro. Fica nomeado como lacuna em §8.1.

**CTA de origem não identificável.** A Lei nº 13.123/2015, art. 2º, III define o caso em que não há possibilidade de vincular a origem a pelo menos uma população indígena, comunidade tradicional ou agricultor tradicional — situação frequente no BioCultDB, que trabalha sobre literatura em que o uso é descrito sem atribuição, e no BioCultNaturalistas, em que a obra do século XVIII raramente nomeia quem ensinou. O art. 9º, §2º dispensa consentimento prévio nesses casos, e o art. 23 determina que a repartição de benefícios seja obrigatoriamente monetária.

A tentação técnica, nesses casos, é deixar `community` vazio e seguir adiante. Esta proposta rejeita essa saída, porque ela transforma uma falha de documentação histórica em aparente ausência de origem — que é exatamente o mecanismo pelo qual conhecimento coletivo vira "conhecimento de ninguém" e, em seguida, "conhecimento de quem patenteou". A regra proposta é:

- `community` fica nulo apenas quando a origem é **de fato** não identificável nos termos do art. 2º, III — não quando é meramente desconhecida pelo digitador;
- o registro recebe explicitamente o rótulo de **atribuição incompleta** (a *Attribution Incomplete Notice* do Local Contexts, §5.5), que declara que existe origem indígena ou tradicional não determinada, em vez de silenciar sobre ela;
- o campo `permissions.attribution` recebe a melhor atribuição disponível — povo, região, obra ou período — mesmo quando insuficiente para identificar uma comunidade específica;
- a atribuição incompleta é **estado transitório, não permanente**: se uma comunidade se identificar posteriormente como origem daquele conhecimento, o registro é atualizado e passa a reger-se pelo regime de origem identificável, incluindo CLPI para permanecer publicado.

### 5.2 Classificação de sensibilidade e camadas de acesso

O ADR-003 define quatro valores para `permissions.visibility`. Eles são a espinha dorsal do controle de acesso, mas são valores técnicos: precisam de critério cultural para serem aplicáveis por quem decide. O mapeamento proposto:

| `permissions.visibility` | Quem acessa | Critério cultural correspondente | Sai no harvest? |
|---|---|---|---|
| `public` | Qualquer pessoa | Conhecimento cotidiano, de circulação já ampla na própria comunidade e sem restrição de transmissão | **Sim** |
| `restricted` | Usuário autenticado e autorizado (`permissions.restrictions.allowedRoles` / `allowedUsers`) | Conhecimento especializado — de curandeiros, parteiras, mestres de ofício — cuja transmissão a comunidade condiciona a quem o receberá | Não |
| `community-only` | Somente membros da comunidade associada (`permissions.restrictions.allowedCommunities`) | Conhecimento interno, de circulação restrita ao próprio grupo | Não |
| `private` | Somente criador e administradores | Conhecimento iniciático, sagrado ou restrito por gênero | Não |

Duas observações sobre a tabela. Primeira: **`restricted` não é coletado pelo Pluriverso hoje** — o harvest autenticado é extensão futura documentada e não implementada (ADR-009). Um registro `restricted` é, na prática, invisível para a federação; isso é intencional e deve permanecer assim até que o Comitê aprove explicitamente o mecanismo (§7.2). Segunda: o campo `uses[].culturalContext.restrictions` já existe no ADR-003 e recebe, em texto livre, restrições como "uso exclusivo por mulheres da comunidade" — ele complementa, mas não substitui, a decisão de `visibility`, e ganha expressão legível por máquina com os rótulos culturais de §5.5.

**Há conhecimento que não deve ser digitado.** Esta é a regra mais importante desta seção e a mais fácil de omitir num documento técnico. Um valor `private` protege contra acesso indevido pelo sistema; não protege contra a existência do registro — contra cópia de backup, contra erro de operação, contra apreensão de equipamento, contra o simples fato de que alguém digitou. Para conhecimento sagrado ou iniciático, a decisão correta pode ser **não registrar**, e a plataforma tem obrigação de dizer isso: na documentação de aquisição, na formação de quem opera o BioCultRelatos e na conversa de consulta prévia. Oferecer um valor de campo para o caso não é o mesmo que oferecer a opção de não usar o campo.

**Generalização geográfica.** Coordenada exata de coleta pode expor local de ocorrência de espécie ameaçada, roça, sítio sagrado ou a própria aldeia — e território tradicional é bem constitucionalmente protegido (CF, art. 231). A prática consolidada em biodiversidade não é ocultar, é **generalizar em degraus**, e existe documento normativo do GBIF com dez princípios e quatro categorias de sensibilidade (CHAPMAN, 2020):

| Categoria | Tratamento da coordenada | `location.precision` correspondente (ADR-003) |
|---|---|---|
| 1 | Não liberar a localização | `withheld` |
| 2 | Generalizar para 0,1° (≈ 10 km) | `region-only` |
| 3 | Generalizar para 0,01° (≈ 1 km) | `approximate` |
| 4 | Generalizar para 0,001° (≈ 100 m) | `approximate` |

Três princípios do documento do GBIF são adotados aqui como regra:

- **Generalizar, nunca randomizar.** Deslocar a coordenada para um ponto falso destrói a validade científica do dado e induz o usuário ao erro; reduzir a precisão preserva a verdade do que se afirma.
- **Campo restringido nunca fica nulo ou vazio.** É substituído por texto explicativo, para que o usuário saiba que existe informação retida e por quê — e não conclua que o dado não foi coletado. Em termos padrão, isso se expressa com `dwc:informationWithheld` (o que foi retido) e `dwc:dataGeneralizations` (o que foi generalizado), ambos mapeáveis 1:1 para o JSON do registro e já parte do Darwin Core (BIODIVERSITY INFORMATION STANDARDS, s.d.). `[a implementar no modelo de dados]`
- **Toda sensibilidade tem data de revisão obrigatória.** Uma restrição imposta em 2026 por um motivo específico não deve sobreviver por inércia a 2040. O ADR-003 hoje **não** tem campo para isso; a proposta é `permissions.restrictions.reviewDate`. `[a implementar em BioCultRelatos e no ADR-003]`

**Ocultação de campo** (`permissions.hiddenFields`) é o mecanismo complementar: mesmo em registro público, campos específicos podem ser suprimidos — o ADR-003 exemplifica com `location.coordinates`, `community.name` e `source.primary.informants`. Vale repetir o limite já declarado em §4.3: ocultar não anonimiza. Táxon raro, uso específico e município podem, em conjunto, identificar uma única comunidade — e a LGPD, art. 11, §1º alcança qualquer tratamento que *revele* dado sensível, ainda que por associação.

**A decisão de camada é da comunidade e é revisável a qualquer tempo.** Não é atribuição do curador, do mantenedor da instância nem do Comitê Federado. E não é definitiva: o mesmo registro pode ser público hoje e `community-only` no ano que vem, sem que a comunidade precise justificar a mudança a ninguém (§5.4).

![Quatro camadas de acesso empilhadas, cada uma com um selo indicando se atravessa o harvest: public (sai no harvest), restricted, community-only e private/sigiloso (não saem). À direita, painel com os campos ocultados por permissions.hiddenFields: location.coordinates, community.name e source.primary.informants, com as regras de nunca deixar campo vazio, generalizar em vez de randomizar e fixar data de revisão.](governanca-camadas-acesso.png)

*As quatro camadas de acesso e o que atravessa o harvest. Apenas registros `public` chegam ao índice do Pluriverso; os campos ocultados valem mesmo dentro de um registro público.*

### 5.3 CLPI como processo contínuo, não como formulário

O Consentimento Livre, Prévio e Informado é tratado, na maior parte dos sistemas, como um PDF assinado e arquivado. Essa prática satisfaz uma auditoria superficial e falha em tudo o mais: não diz para quê se consentiu, por quanto tempo, para quais usos, quem tinha legitimidade para consentir, nem o que acontece quando a comunidade muda de ideia.

**O que a lei exige.** A Lei nº 13.123/2015, art. 9º, §1º admite **quatro formas de comprovação, à escolha da comunidade**: (I) termo de consentimento prévio assinado; (II) registro audiovisual do consentimento; (III) parecer do órgão oficial competente; (IV) adesão na forma prevista em protocolo comunitário. A plataforma deve implementar as quatro como opções estruturadas — e não apenas a primeira, que é a mais conveniente para quem coleta e frequentemente a menos adequada para quem consente. O inciso IV é especialmente relevante: é a porta de entrada, no direito brasileiro, dos protocolos comunitários reconhecidos pelo art. 12 do Protocolo de Nagoya, e vários já existem e estão publicados — Wajãpi (INSTITUTO SOCIOAMBIENTAL; INSTITUTO IEPÉ, 2014), Munduruku e Juruna/Yudjá (MINISTÉRIO PÚBLICO FEDERAL, s.d.), Krenak (CENTRO DE DOCUMENTAÇÃO ELOY FERREIRA DA SILVA, 2017) e os territórios quilombolas do Vale do Ribeira (COMISSÃO PRÓ-ÍNDIO DE SÃO PAULO, s.d.), entre outros.

**O tríplice regime do registro audiovisual.** Gravar o consentimento em vídeo é, simultaneamente: exercício de direito de personalidade (Código Civil, art. 20 — imagem e palavra), tratamento de dado pessoal sensível (LGPD, art. 11, porque voz e imagem associadas a etnia são dado sensível) e forma legal de comprovação do consentimento prévio (Lei nº 13.123/2015, art. 9º, §1º, II). Um único termo de CLPI precisa cobrir as três bases, e o consentimento para a gravação precisa ser **específico e destacado** (LGPD, art. 11, I) — não é válido reduzir o vídeo a "prova de CPI" e tratar como implícita a autorização de uso de imagem.

**Marcar como público não substitui consentir.** Registre-se explicitamente, porque o equívoco é comum: a dispensa de consentimento do art. 7º, §4º da LGPD, para dados "tornados manifestamente públicos pelo titular", **não se aplica** à publicação na federação. Quem publica é a plataforma, por decisão da comunidade; o titular individual não tornou público o próprio dado. `visibility: public` é consequência do CLPI, nunca substituto dele.

**O que existe hoje e o que falta.** O ADR-003 já prevê `community.consent` com cinco campos: `obtained`, `date`, `type` (com valor `free_prior_informed`), `document` e `authorizedBy`. É um ponto de partida sólido — e insuficiente, porque descreve um evento e não uma relação. As extensões propostas, todas `[a implementar em BioCultRelatos e no ADR-003]`:

| Campo proposto | O que registra | Por que é necessário |
|---|---|---|
| `consent.scope` | O que exatamente foi consentido — este registro, este conjunto, este projeto de pesquisa | Sem escopo, um consentimento dado para um trabalho específico é reaproveitado indefinidamente |
| `consent.purpose` | Finalidade declarada do registro e da publicação | LGPD, art. 6º, I e art. 9º, I exigem finalidade específica e informada |
| `consent.permittedUses[]` | Lista controlada de usos autorizados (pesquisa acadêmica, educação, uso comunitário, vedado uso comercial) | Torna verificável, e não presumido, o que o usuário pode fazer |
| `consent.expiresAt` | Prazo de validade do consentimento | CARE E3 e a exigência de reavaliação periódica; consentimento não é perpétuo por padrão |
| `consent.protocolReference` | Referência ao protocolo comunitário sob o qual o consentimento foi dado | Materializa o art. 9º, §1º, IV da Lei nº 13.123/2015 e o art. 12 do Protocolo de Nagoya |
| `consent.language` | Língua em que a consulta foi conduzida | CARE R3; consulta conduzida apenas em português não é necessariamente informada |
| `consent.revokedAt` | Data da revogação, quando houver | LGPD, art. 18, IX; sem esse campo, revogação vira exclusão de linha e perde o rastro |

**Consentimento é revisável, e o modelo precisa refletir isso.** A literatura de *dynamic consent* modela o consentimento como relação digital revisável e bidirecional, e não como assinatura única (KAYE et al., 2015). A adoção aqui é do princípio, não da infraestrutura: nada de portal dedicado de consentimento — o que se propõe é registrar o consentimento como **log *append-only* versionado por registro**, reaproveitando o mesmo mecanismo de auditoria imutável já necessário por outras razões (§6.3). Cada alteração de escopo, prazo ou revogação vira uma nova entrada; nenhuma apaga a anterior. Assim, a pergunta "sob quais termos este registro estava publicado em março de 2027?" tem resposta verificável.

![Ciclo de sete etapas do CLPI, em sentido horário: consulta prévia, acordo de registro, registro do relato, validação comunitária, classificação de acesso, publicação seletiva e auditoria e retorno. Uma seta tracejada retorna da etapa 7 à etapa 2, rotulada revisão periódica. Do centro do ciclo sai uma seta de revogação, com purge_by_member e remoção do índice, apontando para um bloco em que o dado sai da federação e do índice derivado.](governanca-ciclo-clpi.png)

*O CLPI como ciclo: a auditoria realimenta o acordo de registro, e a revogação pode interromper o ciclo a qualquer momento, sem justificativa.*

### 5.4 Ciclo de vida do dado: da consulta prévia à revogação

O CLPI, assim entendido, deixa de ser uma etapa e passa a ser o eixo de um ciclo. Sete estágios, cada um com responsável, artefato gerado e critério explícito de passagem para o próximo:

| # | Estágio | Responsável | Artefato gerado | Critério de passagem |
|---|---|---|---|---|
| 1 | **Consulta prévia** — apresentação da proposta à comunidade, no seu tempo e pelo seu protocolo | Comunidade + pesquisador | Registro da consulta; referência ao protocolo comunitário aplicável | A comunidade decide, por sua própria instância de decisão, se aceita discutir o registro |
| 2 | **Acordo de registro** — escopo, finalidade, prazo, usos permitidos, forma de comprovação escolhida | Instância de decisão da comunidade | `community.consent` completo, com `scope`, `purpose`, `permittedUses[]`, `expiresAt`, `protocolReference` | Consentimento obtido em uma das quatro formas do art. 9º, §1º |
| 3 | **Registro do relato** | Detentor + pesquisador (custodiante) | Registro no BioCultRelatos, com proveniência e mídia associada | Registro completo nos campos obrigatórios do ADR-003 |
| 4 | **Validação comunitária** | Representante indicado pela comunidade | `uses[].verifiedByCommunity: true` | A comunidade confirma que o registro descreve corretamente seu conhecimento (§5.7) |
| 5 | **Classificação de acesso** | Instância de decisão da comunidade | `permissions.visibility`, `hiddenFields`, `location.precision`, rótulos culturais | Camada definida e justificada; data de revisão fixada |
| 6 | **Publicação seletiva** | Automática, a partir da classificação | Registro exposto no endpoint de harvest, se `public` | Nenhum registro sem CLPI válido atravessa o harvest |
| 7 | **Auditoria e retorno** | Mantenedor da instância + Pluriverso | Relatório de uso devolvido à comunidade; log de acesso | Retorno efetivo à comunidade, em formato acessível (§5.9, §5.10) |

Duas saídas do ciclo, que não são exceções mas parte do desenho:

- **Revisão periódica** — do estágio 7 o fluxo retorna ao estágio 2, não ao 1. O consentimento é reavaliado à luz do uso efetivo: o que foi consultado, por quem, para quê. É a operacionalização de CARE E3 e do prazo de `consent.expiresAt`.
- **Revogação** — a qualquer momento, de qualquer estágio, sem necessidade de justificativa. Efeitos: `consent.revokedAt` é preenchido, `permissions.visibility` deixa de ser `public`, e o registro é removido do índice federado — por mudança de visibilidade ou, no caso de saída integral do membro, por `purge_by_member` (ADR-004, D4). O que a revogação **não** alcança está declarado em §4.3, salvaguardas 3 e 7.

A diferença entre este ciclo e o modelo usual está no estágio 2: prazo, finalidade e uso permitido são registrados **como dado**, consultáveis e verificáveis por máquina — não como PDF anexado que ninguém relerá.

### 5.5 Rotulagem cultural: TK/BC Labels e Notices

Os quatro valores de `permissions.visibility` respondem "quem pode ver". Não respondem "sob que protocolo cultural este conhecimento circula" — se é sazonal, se é de um clã específico, se sua transmissão é restrita por gênero, se a comunidade aceita colaboração ou veda uso comercial. Essa camada existe, é padronizada internacionalmente e é aplicada pela própria comunidade: são os **TK Labels** e **BC Labels** da iniciativa Local Contexts (ANDERSON; HUDSON, 2020; LOCAL CONTEXTS, s.d.).

**TK Labels** — 20 rótulos, em três categorias: *Provenance* (TK Attribution, TK Clan, TK Family, TK Multiple Communities, TK Community Voice, TK Creative), *Protocol* (TK Verified, TK Non-Verified, TK Seasonal, TK Women General, TK Men General, TK Men Restricted, TK Women Restricted, TK Culturally Sensitive, TK Secret/Sacred) e *Permission* (TK Open to Commercialization, TK Non-Commercial, TK Community Use Only, TK Outreach, TK Open to Collaboration).

**BC Labels** — 10 rótulos, concebidos para dados derivados de recursos genéticos e coleções biológicas, também em três categorias: *Provenance* (BC Provenance, BC Multiple Communities, BC Clan), *Protocol* (BC Consent Verified, BC Consent Non-Verified) e *Permission* (BC Research Use, BC Open to Collaboration, BC Open to Commercialization, BC Outreach, BC Non-Commercial). Registre-se, para quem for à fonte: o artigo que descreve a iniciativa relata **seis** BC Labels (ANDERSON; HUDSON, 2020); o conjunto cresceu para dez desde então, e a lista vigente é a do site oficial.

**Notices** — são o instrumento para o caso em que a comunidade **ainda não** aplicou um Label, e existem justamente porque instituições não indígenas não podem aplicar Labels em nome de terceiros. Doze notices em três categorias: *Engagement* (Open to Collaborate), *Disclosure* (Attribution Incomplete, TK Notice, BC Notice) e *Collections Care* (Authorization, Belonging, Caring, Gender Aware, Leave Undisturbed, Safety, Viewing, Withholding), estas últimas desenvolvidas com o National Museum of the American Indian. O texto das Notices não pode ser alterado.

A aplicação proposta nesta arquitetura, por tipo de membro:

- **BioCultRelatos** — a comunidade aplica **Labels**, porque é ela a autoridade. Mapeamento natural com campos existentes: `uses[].culturalContext.seasonality` conversa com *TK Seasonal*; `uses[].culturalContext.restrictions` com os rótulos de gênero e com *TK Culturally Sensitive*; `uses[].verifiedByCommunity` com *TK Verified* / *BC Consent Verified*.
- **BioCultAcervos** e **BioCultNaturalistas** — aplicam **Notices**, não Labels: são acervos sobre comunidades que nunca foram consultadas. *Attribution Incomplete* declara origem indígena não determinada (§5.1); *Open to Collaborate* sinaliza disposição institucional de ser procurado pela comunidade de origem. Se e quando a comunidade se manifestar, a Notice cede lugar ao Label que ela escolher.
- **BioCultDB** — Notices quando a literatura permita inferir origem comunitária sem atribuição formal.
- **BioCultTermos** — rótulos em nível de conceito e de `skosxl:Label`, tratados em §5.8.

**Rótulo não é licença, e os dois campos nunca se fundem.** `permissions.license` (ADR-003) é instrumento de direito autoral — Creative Commons e equivalentes regem cópia, distribuição e obra derivada. Um TK Label expressa **protocolo cultural**, que na maior parte dos casos não é matéria de direito autoral: não há prazo, não há titular individual, não há obra fixada. Foi exatamente essa lacuna que motivou a criação dos Labels. Fundir os dois campos produziria o pior dos mundos — uma expectativa cultural sem força jurídica apresentada como licença, e uma licença que promete o que não pode cumprir. Ficam separados: `permissions.license` para o regime autoral, um campo próprio de rótulos culturais para o protocolo. `[a implementar no ADR-003]`

O caminho tem precedente institucional recente e direto: em 28 de julho de 2025 o GBIF instituiu um *Task Group on Indigenous Data Governance*, presidido por Lydia J. Jennings, cujo segundo eixo é justamente pilotar TK/BC Labels sobre registros de ocorrência com três comunidades reais — Sarayaku (Equador), Te Whakatōhea (Nova Zelândia) e Te Pu Atiti'a (Polinésia Francesa) — com o objetivo declarado de tornar o Darwin Core compatível com CARE (GLOBAL BIODIVERSITY INFORMATION FACILITY, 2025). Esta proposta não está inventando um mecanismo: está adotando um que a principal infraestrutura mundial de dados de biodiversidade já está testando.

### 5.6 Proveniência, atribuição e o direito de ser citado

Proveniência é o que separa um registro de conhecimento tradicional de um dado solto: é a cadeia que liga a afirmação "esta planta é usada assim" a quem afirmou, quando, onde, sob qual consentimento e com base em qual fonte. Sem ela, não há como verificar, corrigir, atribuir nem repartir.

**Cadeia mínima por fonte de evidência:**

| Fonte | Cadeia de proveniência exigida |
|---|---|
| **Fontes secundárias** (BioCultDB, inclui Extração por IA) | `source.secondary` com referência completa, DOI/ISBN, página; identificação de quem extraiu (`extractedBy`) e por qual método (`extractionMethod`) — extração automatizada por IA precisa ser declarada como tal, não apresentada como leitura humana |
| **Fontes primárias** (BioCultRelatos) | `source.primary` com método de coleta, data, quem coletou, informantes (com `anonymized` quando for o caso) e aprovação ética (`ethicsApproval`), somados ao bloco `community.consent` (§5.3) |
| **Acervos** (BioCultAcervos) | Identificação da instituição custodiante, número de tombo ou registro, data de entrada no acervo e, quando conhecida, a cadeia de aquisição — inclusive quando ela é problemática |
| **Naturalistas** (BioCultNaturalistas) | Obra, edição, página, autor, viagem e data; quando a obra nomeia quem prestou a informação, esse nome é parte da proveniência e não deve ser descartado como detalhe |

O vocabulário de proveniência adotado é o do **PROV-O** do W3C — as noções de entidade, atividade e agente, e as relações `wasGeneratedBy`, `wasAttributedTo`, `wasDerivedFrom` (W3C, 2013). Adota-se o vocabulário pela disciplina semântica que ele impõe, **não** a pilha RDF: a proveniência é modelada como JSON dentro do próprio registro SQLite, coerente com a stack decidida no ADR-005, sem *triple store* nem SPARQL.

**Atribuição de comunidade e de língua.** O campo `permissions.attribution` do ADR-003 já existe e deve ser preenchido com a comunidade titular, não apenas com o pesquisador. A ele soma-se a atribuição linguística: `community.language` para a língua da comunidade, e a língua efetiva de cada rótulo e descrição — o ADR-003 já estrutura descrições com `language`. Como muitas línguas indígenas brasileiras não têm código ISO 639-1 ou 639-2, a recomendação é adotar **ISO 639-3** onde houver código, e registrar o glotônimo por extenso onde não houver. É a tradução operacional de CARE R3.

**Citação como obrigação, não como cortesia.** Todo registro exposto pela API do Pluriverso carrega `member_id` — identificador estável, escopado por instância e nunca reciclado (ADR-006, ADR-009). A proposta é que a citação de qualquer conjunto de dados obtido pela federação inclua obrigatoriamente: a comunidade ou instituição de origem, o `member_id`, e o DOI do conjunto quando houver. A cunhagem de DOI para lotes exportados é `[a implementar no Pluriverso]` e tem duplo efeito: torna a citação verificável e cria o rastro sem o qual não há como demonstrar uso para fins de repartição (§5.9). O direito de ser citado é, aqui, a forma mínima de benefício não monetário — e a única que a plataforma pode garantir por conta própria.

**O caso dos naturalistas.** Uma obra de 1817 está em domínio público quanto aos direitos patrimoniais do seu autor (Lei nº 9.610/1998, arts. 41 e 43). Isso **não** dissolve a autoria coletiva do conhecimento nela registrado — e a própria lei o diz: o art. 45 ressalva expressamente "a proteção legal aos conhecimentos étnicos e tradicionais" ao tratar do domínio público. Em termos práticos: o naturalista europeu que anotou o uso de uma planta não é o autor daquele conhecimento; é a testemunha que o registrou. O BioCultNaturalistas deve, portanto, tratar a obra como fonte e a comunidade como origem, ainda que a obra não a nomeie — caso em que se aplica o regime de atribuição incompleta de §5.1, e não a conclusão de que se trata de conhecimento sem dono.

### 5.7 Curadoria e validação comunitária

O README já descreve seis níveis de validação. Como fluxo de governança — e não apenas como pipeline técnico — eles se ordenam assim, cada um com quem o executa e o que ele pode ou não decidir:

| # | Nível | Quem executa | O que decide | O que **não** pode decidir |
|---|---|---|---|---|
| 1 | **Estrutural** | Automático | Conformidade do registro com o modelo de dados (ADR-003) | Nada sobre conteúdo ou publicação |
| 2 | **Taxonômica** | Automático, com bases brasileiras (Flora e Funga, Fauna) e *fallback* GBIF | Correspondência do nome científico | Que o nome vernacular está "errado" — nome vernacular não se valida contra base taxonômica |
| 3 | **Semântica** | Automático + curador, via BioCultTermos | Vinculação a conceitos do vocabulário | Substituir o termo da comunidade por um termo "padrão" |
| 4 | **Especializada** | Curador de domínio (botânico, etnobiólogo, farmacêutico) | Consistência técnica e alertas de segurança (`uses[].safety`) | Contestar a existência ou o sentido do uso relatado |
| 5 | **Comunitária** | Representante indicado pela comunidade | Se o registro descreve corretamente o conhecimento; `uses[].verifiedByCommunity` | — |
| 6 | **Auditoria** | Automático, *append-only* | Rastro de todas as alterações e validações | Nada; apenas registra |

**A validação comunitária é a última palavra e pode reverter a curadoria científica.** Se o curador especializado considera improvável um uso relatado e a comunidade confirma que é assim que se faz, o registro permanece como a comunidade o descreve — e a divergência, se relevante, é registrada como anotação, não como correção. O inverso — curadoria científica sobrepondo-se à validação comunitária — seria a reintrodução, por via técnica, exatamente da hierarquia epistêmica que CARE existe para desfazer (CARROLL et al., 2020; ZANK et al., 2025).

Há uma exceção estreita e declarada: **alerta de segurança**. Se o registro descreve preparo que pode causar dano (planta tóxica, dose, interação), o curador pode e deve acrescentar a informação em `uses[].safety`, sem alterar nem invalidar o relato. Acrescentar advertência não é contestar conhecimento.

Duas narrativas sobre o mesmo objeto podem coexistir. É a lição do Mukurtu CMS, cujo conceito de *Community Records* permite que registros comunitários e institucionais convivam sobre o mesmo item, sem que a narrativa da instituição sobrescreva a da comunidade (MUKURTU CMS, s.d.). Aplicado aqui: quando o BioCultAcervos registra a ficha catalográfica de um museu e a comunidade de origem descreve o mesmo objeto de outra forma, as duas descrições coexistem no registro — não se resolve a divergência por votação nem por antiguidade do acervo.

### 5.8 Vocabulários sensíveis no BioCultTermos

O BioCultTermos adota SKOS-XL, em que rótulos são recursos de primeira classe (`skosxl:Label`) e não literais soltos — o que permite anexar metadados ao próprio rótulo, e não apenas ao conceito (W3C, s.d.; ADR-007). Essa propriedade, adotada originalmente por razões de modelagem, é o que torna possível governar sensibilidade em nível de termo.

**Três anotações por rótulo sensível**, propostas como prática obrigatória `[a implementar em BioCultTermos]`:

- **Língua de origem** — código ISO 639-3 quando existir, glotônimo por extenso quando não (§5.6). Um rótulo em língua indígena sem identificação de língua é um dado incompleto, não um detalhe de metadado.
- **Comunidade ou território de origem** — qual povo usa aquele termo. Sem isso, o vocabulário federado homogeneíza o que deveria diferenciar.
- **Nível de restrição** — se o rótulo em si é restrito, independentemente do conceito. Um mesmo conceito botânico pode ter um rótulo público em português e um rótulo restrito na língua da comunidade, quando o nome na língua carrega informação ritual.

A prática de fundo é tratar termos indígenas como **coisas, não *strings***: cada rótulo carrega sua própria autoridade e história, e a hierarquia do vocabulário deve refletir a classificação da comunidade de origem em vez de impor uma taxonomia ocidental sobre ela (CHRISTEN, 2015).

**O risco do mapeamento semântico entre instâncias.** O Pluriverso mantém mapeamentos `skos:exactMatch`, `skos:closeMatch` e `skos:broadMatch` entre `ConceptScheme`s de membros diferentes (ADR-004, D2). Esse mecanismo, que existe para harmonizar vocabulários, é também um vetor de vazamento: se um conceito público de um membro recebe `skos:exactMatch` para um conceito de outro membro cujos registros são restritos, o mapeamento revela a existência, o rótulo e a associação semântica de um termo que a comunidade não publicou. O dado não vaza, mas o vocabulário — que é conhecimento — vaza.

A regra proposta é direta: **mapeamento semântico só entre conceitos cujos registros de origem são públicos.** Conceito associado exclusivamente a registros `restricted`, `community-only` ou `private` não entra na camada de mapeamento do Pluriverso, nem como origem nem como destino. E, como corolário, a criação de um mapeamento que envolva conceitos de dois membros distintos é decisão que exige anuência dos dois — está na matriz de decisão de §7.2.

### 5.9 Repartição de benefícios rastreável

A Lei nº 13.123/2015 define duas modalidades de repartição. A **monetária** corresponde a 1% da receita líquida anual obtida com a exploração econômica (art. 20), redutível a até 0,1% mediante acordo setorial (art. 21), com recolhimento ao Fundo Nacional para a Repartição de Benefícios. A **não monetária** (art. 19) inclui projetos de conservação e proteção do conhecimento, transferência de tecnologia, disponibilização em domínio público, licenciamento livre de ônus, capacitação de recursos humanos e distribuição gratuita de produtos em programas sociais. Para CTA de origem não identificável a repartição é obrigatoriamente monetária (art. 23); para o identificável, é negociada diretamente entre usuário e provedor (art. 24).

**A plataforma não reparte benefícios — ela produz a evidência sem a qual não há como reivindicá-los.** A distinção é essencial e delimita honestamente o escopo:

| O que a plataforma **pode** provar | O que a plataforma **não** pode provar |
|---|---|
| Que determinado registro foi consultado, quando e por qual conta autenticada | Que o conhecimento consultado foi efetivamente usado em pesquisa ou produto |
| Que um conjunto foi exportado, com DOI e data | Uso a partir de cópia obtida fora da plataforma |
| Qual finalidade o usuário declarou ao acessar | Se a finalidade declarada corresponde à real |
| Que existe consentimento válido, com escopo e prazo, para aquele registro | Que o usuário cumpriu os termos do consentimento |
| A cadeia de proveniência até a comunidade de origem (§5.6) | Quanto valor econômico foi gerado |

Os mecanismos necessários são convencionais e não exigem tecnologia nova: log de acesso e download em nível de aplicação, DOI para conjuntos exportados, campo de finalidade declarada, e o `member_id` já presente em cada registro. Ficam `[a implementar no Pluriverso]`. Registre-se o que foi **descartado**: qualquer esquema de rastreio baseado em *blockchain* ou token — nenhuma das plataformas de referência em governança de CTA o utiliza, e logs relacionais *append-only* com citação por DOI satisfazem a mesma necessidade evidencial a uma fração da complexidade operacional, coerente com a diretriz de simplicidade do projeto.

**Relação com o SisGen.** Acesso a patrimônio genético ou a CTA para fins de pesquisa e desenvolvimento tecnológico exige cadastro no SisGen (Lei nº 13.123/2015, arts. 3º e 12). A plataforma não substitui nem intermedeia esse cadastro, mas deve oferecer campo para registrar o número de cadastro associado a consultas com finalidade de P&D, e deixar claro na interface de acesso que a obrigação existe. `[a implementar no Pluriverso]`

**Prestação de contas anual do uso.** Propõe-se que cada instância do Pluriverso produza, uma vez por ano, um relatório por membro: quantos registros seus foram consultados, por quantas contas distintas, com quais finalidades declaradas, e quais conjuntos exportados citaram seus dados. O relatório vai para o membro, não para o público. É a única forma de dar conteúdo concreto ao sub-princípio C2 do CARE, hoje um vazio completo (§3.1), e o que transforma o log de uso em instrumento de justiça em vez de instrumento de vigilância — a diferença está em para quem o relatório é devolvido.

![Fluxo de repartição de benefícios em três colunas ligadas por setas tracejadas: origem, com registro de proveniência completa (member_id, comunidade de origem, DOI do conjunto); uso, em que todo acesso deixa rastro (log de consulta e download, citação com DOI, finalidade declarada), marcado como a implementar no Pluriverso; e retorno, com benefício monetário (Lei 13.123/2015, FNRB, acordo de repartição) e não monetário (coautoria, capacitação, infraestrutura, devolução dos dados).](governanca-reparticao.png)

*Da origem ao retorno: o log de uso é o elo que hoje falta para que a repartição de benefícios seja demonstrável em vez de prometida.*

**O vácuo regulatório.** O regime de repartição de benefícios foi desenhado para material genético físico. A digitalização — sequências, dados, informação — corroeu o mecanismo bilateral, e a resposta multilateral em construção é o **Cali Fund**, criado pela Decisão CBD/COP/DEC/16/2 na COP16 em Cali, em 2 de novembro de 2024, e lançado em 25 de fevereiro de 2025 (CBD SECRETARIAT, 2024). Avaliações da efetividade do Protocolo de Nagoya apontam sucesso institucional acompanhado de falhas operacionais recorrentes, com comunidades locais e indígenas frequentemente marginalizadas nas negociações de repartição, apesar de serem as detentoras primárias do conhecimento (GENRESJ, s.d.).

Uma plataforma **de dados sobre CTA** — não de material genético — está exatamente nesse vácuo: é plausível que a legislação vigente não cubra integralmente o caso. A posição desta proposta é não esperar que cubra, e também não improvisar: os logs de uso são desenhados como **evidência auditável e exportável**, compatível com mecanismos multilaterais que venham a se consolidar, sem que a plataforma opere qualquer fundo, intermedeie pagamento ou se apresente como instância de repartição. Produzir a prova é o que ela pode fazer; distribuir benefício não é atribuição sua.

### 5.10 Preservação digital e retorno do dado à comunidade

A motivação para preservar não é abstrata. Estudo com os Tsimane', na Amazônia boliviana, mediu a transmissão de conhecimento etnobotânico por via vertical (dos pais) e **oblíqua** (de gerações mais velhas que não os pais), encontrando associação **maior na transmissão oblíqua** (REYES-GARCÍA et al., 2009). A implicação prática para esta arquitetura é dupla: prioridade a relatos de anciãos, e tratamento da transmissão oblíqua como via de **revitalização**, não apenas de registro — o dado devolvido à comunidade em formato utilizável pode alimentar o aprendizado comunitário que a integração ao mercado tem erodido.

**Backup soberano.** O ADR-005 tem uma consequência afortunada: backup é copiar um arquivo. Nenhuma ferramenta nova é necessária. A adição recomendada é rotina de backup **cifrado** para cópias fora do host, preservando confidencialidade sem reintroduzir a complexidade de um servidor dedicado (§6.3). A chave de cifra pertence à comunidade, não ao mantenedor da infraestrutura — se essas partes forem distintas, isso precisa estar escrito no acordo de hospedagem (§5.1).

**Formatos legíveis em trinta anos.** Toda a pilha de persistência é deliberadamente durável: SQLite (formato documentado, com compromisso público de estabilidade de longo prazo), JSON, SKOS/RDF para vocabulários, e mídia em formatos abertos **sem DRM**. A regra decorrente é que nenhum componente da federação pode adotar formato proprietário ou dependente de serviço externo para armazenar o dado primário — o que exclui, por exemplo, manter o único original de uma gravação de CLPI em plataforma de vídeo de terceiros.

**Exportação integral, a qualquer momento, pela própria comunidade.** Não como funcionalidade administrativa acessível ao mantenedor, mas como direito exercível pela comunidade titular: exportar tudo — registros, mídia, vocabulário, histórico de consentimento — em formato aberto, sem intermediação e sem justificativa. É simultaneamente exigência da LGPD (art. 18, V, portabilidade) e condição para que a soberania seja real: quem não pode levar seus dados embora não os controla.

**Repatriação digital não é restituição.** BioCultAcervos e BioCultNaturalistas lidam, por definição, com material sobre comunidades que nunca consentiram — coletado sob condições que hoje seriam inaceitáveis, custodiado por instituições que raramente consultaram quem de direito. A literatura arquivística debate se a devolução digital é restituição ou substituto conveniente da devolução física e legal do original (CHRISTEN; ANDERSON, 2019). Esta proposta não resolve esse debate e não finge resolvê-lo: **dar acesso por API a uma digitalização não devolve o objeto, não repara a aquisição e não substitui a decisão institucional sobre repatriação.** O que a plataforma pode fazer é menor e ainda assim útil — tornar visível o que existe, sinalizar com Notices que há interesse indígena não confirmado (§5.5), e criar o canal pelo qual a comunidade pode se manifestar. Apresentar isso como solução do problema histórico seria desonesto.

### 5.11 Conformidade LGPD na prática

A LGPD incide sobre esta plataforma de forma mais intensa do que sobre a maior parte dos sistemas de biodiversidade, porque a ficha de proveniência de um relato é, integralmente, dado pessoal sensível (§3.2). A tabela mapeia exigência, implementação e localização.

| Exigência (artigo) | O que a plataforma implementa | Onde |
|---|---|---|
| Base legal para dado sensível (art. 7º e art. 11, I) | Consentimento específico e destacado, obtido em uma das quatro formas do art. 9º, §1º da Lei nº 13.123/2015; nunca cláusula embutida em termo genérico | `community.consent` + extensões de §5.3 (BioCultRelatos) |
| Dado sensível por associação (art. 11, §1º) | Toda a ficha de proveniência étnico-territorial tratada como sensível — não apenas um campo | `community.*`, `location.*`, `source.primary.informants` |
| Informação ao titular (art. 9º, I–VII) | Termo de CLPI contendo os sete elementos, em linguagem acessível e, quando aplicável, na língua da comunidade | Fluxo de CLPI (BioCultRelatos) `[a implementar]` |
| Princípios de tratamento (art. 6º) | Necessidade aplicada na coleta: não registrar CPF, RG ou dado pessoal desnecessário do relator; apenas o mínimo para identificar a comunidade e viabilizar repartição | Modelo de dados (ADR-003) |
| Direitos do titular (art. 18) | Confirmação, acesso, correção, eliminação, portabilidade (§5.10) e revogação do consentimento | `consent.revokedAt`, exportação integral, `purge_by_member` |
| Propagação da revogação (art. 18, VI e IX) | Revogação na unidade soberana deve refletir-se no índice federado em prazo razoável — hoje isso depende do próximo ciclo de harvest, o que é insuficiente: propõe-se notificação ativa de revogação do membro ao Pluriverso | `[a implementar no contrato de harvest — ADR-004, D6]` |
| Encarregado (art. 41) | **Um encarregado por controlador**: cada membro da federação designa e publica o seu; cada instância do Pluriverso designa o seu. **Não há encarregado único global** — seria incompatível com a soberania de cada unidade e com o fato de que o Pluriverso não controla os dados dos membros | §6.1 |
| Registro de operações e RIPD (arts. 37 e 38) | RIPD produzido desde o desenho, e não apenas quando exigido pela ANPD, documentando explicitamente o risco a comunidades tradicionais como grupo vulnerável | `[a implementar]` — lacuna nomeada em §8.1 |
| Segurança (arts. 46–49) | Segurança desde a concepção, cifra em repouso quando houver registros `private`, plano de resposta a incidente, dever de sigilo estendido a todo interveniente | §6.3 |
| Transferência internacional (arts. 33–36) | Instância hospedada fora do Brasil ou acesso por instituição estrangeira exige base legal explícita do art. 33 — em regra, o consentimento específico e destacado do inciso VIII, informando o caráter internacional | §6.1, §7.2 |
| Ação coletiva (art. 42, §3º) | Reconhecida como via disponível à comunidade; não substitui titularidade coletiva (§3.4) | — |

Um esclarecimento de papéis, porque ele determina responsabilidade jurídica: **cada membro da federação é controlador dos dados que registra**; o Pluriverso é controlador do índice derivado que mantém, e não do dado de origem. Essa separação é consequência direta do desenho federado e precisa estar declarada no contrato de adesão à federação — sem ela, um incidente em uma unidade contamina juridicamente todas as demais.

### 5.12 O que a plataforma nunca fará

Compromissos negativos são mais verificáveis que promessas. Esta lista é curta, literal e destinada a ser citada:

1. **Nunca vender dados de conhecimento tradicional**, em qualquer forma, agregada ou não.
2. **Nunca ceder a base a terceiros** — instituição, empresa ou governo — sem decisão da comunidade titular de cada registro envolvido.
3. **Nunca treinar modelo comercial com registros restritos.** Dado publicamente acessível não implica consentimento para treinamento de modelos: **acesso não é autoridade** — o mesmo argumento que a literatura de genômica opôs ao acesso irrestrito a dados sobre povos indígenas (HUDSON et al., 2020). O Pluriverso prevê busca semântica, e o compromisso é registrado *antes* de qualquer implementação com IA ou *embeddings* sobre dados federados — se houver uso de modelos sobre registros públicos, ele será declarado, limitado à finalidade da busca, e sujeito a *opt-out* por membro. Não há literatura peer-reviewed específica sobre CARE e IA generativa que permita citar mais que o princípio; ele é afirmado aqui como compromisso, não como conclusão de terceiros.
4. **Nunca coletar registros `restricted`** sem harvest autenticado previamente aprovado pelo Comitê Federado e aceito pelo membro (§7.2).
5. **Nunca reciclar `member_id`** (ADR-006, E5) — identidade de origem não é reatribuída, mesmo após saída da federação.
6. **Nunca publicar registro sem CLPI válido**, e nunca tratar `visibility: public` como substituto de consentimento (§5.3).
7. **Nunca exigir justificativa para revogação ou saída** (§4.3, salvaguarda 7).
8. **Nunca aplicar TK ou BC Labels em nome de uma comunidade** — rótulo aplicado por terceiro é Notice, por definição (§5.5).
9. **Nunca fazer trafegar por provedor externo de IA conteúdo de registro cujo nível efetivo de acesso seja diferente de `public`.** O compromisso alcança qualquer etapa automatizada — extração de metadados, sumarização, geração de *embeddings*, busca conversacional — e vale tanto para o conteúdo do registro quanto para o texto do prompt que o carrega. Decorre de (3) e o torna verificável: o item 3 proíbe o treinamento; este proíbe o **envio**, que é o que de fato acontece a cada chamada. A verificação é por auditoria dos prompts e do ponto do fluxo em que o envio ocorre, e o resultado deve ser declarado por cada unidade que use IA. Levantado em reunião com o Comitê Gestor do USEFLORA em 18/08/2026 (`docs/reunioes/reuniao-useflora-2026-08-18.md`); o BioCultDB opera extração por IA em produção hoje ([ADR-011](../docs/architecture-decisions/ADR-011-absorcao-biocultpapers.md)), e a auditoria correspondente está registrada como pendência em `BioCultDB/docs/proximosPassos.md`.

## 6. Governança das ferramentas

### 6.1 Instâncias de decisão e papéis

| Papel | Quem é | Decide | Não decide |
|---|---|---|---|
| **Instância de decisão da comunidade** — assembleia, conselho de detentores ou órgão que o protocolo comunitário indicar | Definida pela própria comunidade, conforme seu protocolo | O que se registra, o que se publica, o que se retira; a quem se concede acesso `restricted` | Assuntos técnicos de operação da instância |
| **Mantenedor da instância** | Pessoa, equipe ou instituição que opera o container e o arquivo SQLite+JSON | Deploy, versão, backup, segurança operacional, disponibilidade | Conteúdo, visibilidade ou publicação de qualquer registro |
| **Curador** | Especialista de domínio, indicado pelo membro | Validação técnica dos níveis 1 a 4 (§5.7); alertas de segurança | Reverter validação comunitária |
| **Representante de validação comunitária** | Indicado pela comunidade | `uses[].verifiedByCommunity`; correção de descrição de conhecimento | — |
| **Encarregado de proteção de dados (LGPD, art. 41)** | Designado por cada controlador — um por membro, um por instância do Pluriverso | Atendimento a titulares e à ANPD; orientação interna | Publicação ou retirada de registros |
| **Comitê Federado** | Representantes de cada membro da instância do Pluriverso (ADR-004, D3) | Admissão e remoção de membros, contrato de harvest, mapeamentos entre membros, evolução do modelo comum | Conteúdo de qualquer registro; operação de qualquer unidade |

O critério de admissão de uma comunidade como membro é a **autoidentificação**, nos termos do Decreto nº 6.040/2007, art. 3º, I — não uma lista fechada de segmentos nem validação por terceiros. As 29 classificações do Decreto nº 8.750/2016, já usadas no BioCultDB, servem para caracterizar, não para autorizar.

O protocolo de inscrição já está definido (ADR-006): todo pedido nasce em `pending` e só o Comitê o move para `active` ou `rejected`, com motivo obrigatório em caso de recusa (E2); a `care_declaration` é campo obrigatório do pedido; o probe técnico automático é **sinal para o Comitê, nunca gate automático** (E3); e o `member_id` nunca é reciclado (E5).

**O bloqueador aberto.** A autenticação da decisão do Comitê — item **E4** do ADR-006 — está explicitamente fora do escopo daquele ADR e **não resolvida**. Hoje, nada garante tecnicamente que um `PATCH` que ativa ou recusa um pedido reflita deliberação do Comitê, e não a ação isolada de quem tem acesso ao sistema. É o bloqueador mais sério desta camada de governança: sem ele, o Comitê Federado é uma figura documental. O próprio ADR-006 registra que isso **bloqueia deploy em produção da fila de inscrição**. Retomado em §8.1.

Falta também, e o ADR-006 o reconhece, o **protocolo escrito do próprio Comitê**: quórum, forma de convocação, o que exige consenso e o que admite maioria qualificada, prazo de resposta, e forma de publicação das decisões. Modelos maduros existem e podem ser adaptados sem serem copiados — os seis princípios do Te Mana Raraunga na Nova Zelândia (TE MANA RARAUNGA, s.d.) e o arranjo institucional do OCAP® no Canadá (FIRST NATIONS INFORMATION GOVERNANCE CENTRE, s.d.) são os mais próximos em intenção; a literatura de soberania de dados indígenas oferece o enquadramento (KUKUTAI; TAYLOR, 2016).

### 6.2 Ciclo de vida do código e das versões

Três instrumentos, já em uso neste repositório, formam o ciclo: **SemVer** para versão, **CHANGELOG** para histórico legível, **ADR** para decisão com contexto e consequência. A regra de governança que os liga: *mudança que altera o contrato entre membros — modelo de dados, endpoint de harvest, semântica de campo — exige ADR aceito antes da implementação, não depois.*

O **BioCultTermos** tem ciclo próprio, definido no ADR-007: é submodule git compartilhado, com repositório standalone congelado como produto, e evolução ocorrendo a partir das unidades hospedeiras. A consequência de governança é específica e precisa ser dita: uma alteração no BioCultTermos feita por uma unidade **propaga-se potencialmente a todas as outras**. Alterações no módulo compartilhado que afetem estrutura de vocabulário ou semântica de campo devem ser comunicadas às demais unidades hospedeiras antes de propagadas, e a atualização do submodule é decisão de cada mantenedor — nunca automática.

Nenhuma atualização de código pode alterar `permissions.visibility` de registros existentes. Migração que precise tocar visibilidade exige decisão da comunidade titular, registro por registro — nunca migração em lote com valor padrão.

### 6.3 Segurança como requisito de governança

Segurança aqui não é higiene de infraestrutura: é condição de possibilidade do consentimento. Um CLPI obtido corretamente e um vazamento subsequente produzem o mesmo resultado prático para a comunidade.

A referência normativa adotada é o **OWASP** — Top 10:2025 como mapa de risco e ASVS 5.0 como checklist de verificação, com **Nível 1 mínimo para todas as unidades** e **Nível 2 para BioCultRelatos**, por tratar dado sensível e CLPI (OWASP FOUNDATION, 2025a, 2025b). São padrões de verificação, não bibliotecas: custo zero de *footprint* de Docker, coerente com a diretriz de simplicidade.

Requisitos mínimos, por unidade:

- **HTTPS obrigatório** em todo endpoint exposto — já exigido pelo probe do ADR-006 (E3).
- **Proteção anti-SSRF** no Pluriverso: bloqueio de IP privado, *loopback* e *link-local* ao fazer requisição para URL fornecida por terceiro não autenticado (ADR-006, E3). É o único ponto do sistema em que se faz requisição de saída para endereço arbitrário, e por isso o mais sensível.
- **Controle de acesso** verificado no servidor a cada requisição, nunca inferido pela interface (OWASP A01).
- **Rate limit** nos endpoints públicos de harvest e de busca.
- **Log de auditoria *append-only***: tabela somente-inserção, sem permissão de `UPDATE` ou `DELETE` no nível da conexão, opcionalmente encadeada por hash. É disciplina de SQL sobre a mesma tabela JSON1 já em uso (ADR-005), e serve simultaneamente à auditoria de curadoria (§5.7), ao versionamento de consentimento (§5.3) e ao rastro de uso (§5.9). Ficam **descartadas** plataformas de SIEM ou agregação dedicada de log, desproporcionais à escala e ao tamanho de Docker do projeto.
- **Cifra em repouso** obrigatória em unidade que armazene registros `private`, e nos backups externos (§5.10). O caminho técnico compatível com a stack é o fork `better-sqlite3-multiple-ciphers`, que mantém a API do driver já adotado no ADR-005. Registre-se uma ressalva de verificação: há relatos consistentes de que esse fork **não gera arquivos binariamente compatíveis** com o SQLCipher oficial (ZETETIC, s.d.), mas isso não foi confirmado em fonte oficial de nenhum dos dois projetos — antes de qualquer plano de migração, o teste de compatibilidade precisa ser feito, não presumido.
- **Plano de resposta a incidente** com comunicação à ANPD e aos titulares (LGPD, art. 48) e — acréscimo que a lei não exige mas o CARE sim — **comunicação à comunidade titular em linguagem acessível**, não apenas o aviso formal.

### 6.4 Licenciamento de código, dados e conteúdo

O README declara a licença do projeto como "a definir". A proposta é resolver a lacuna com **três regimes distintos**, porque tratar código, documentação e conhecimento tradicional sob a mesma licença é o erro que produz tanto exposição quanto imobilismo:

| Camada | Licença proposta | Razão |
|---|---|---|
| **Código** (todas as ferramentas) | Licença permissiva aprovada pela OSI — MIT ou Apache-2.0 | Adoção sem atrito por qualquer comunidade ou instituição; a Apache-2.0 acrescenta cláusula expressa de patentes, útil dado o histórico de §4.1 |
| **Documentação e ADRs** | CC BY 4.0 | Reuso e tradução livres, com atribuição — inclusive tradução para línguas indígenas |
| **Dados de CTA** | **Fora de licença aberta.** Regidos por `community.consent` (escopo, prazo, usos permitidos), rótulos culturais (§5.5) e `permissions.license` apenas quando houver obra autoral envolvida | Licença aberta é irrevogável e universal — exatamente o oposto do que o CLPI exige. Um CC BY em registro de CTA anularia na prática a revogabilidade prometida em §5.4 |
| **Vocabulários** (BioCultTermos) | Definido por instância, com padrão sugerido CC BY 4.0 apenas para conceitos de registros públicos | Interoperabilidade sem arrastar termos sensíveis (§5.8) |

A afirmação central desta seção, e a que resolve a lacuna do README: **dados de conhecimento tradicional associado não recebem licença aberta.** Não por falta de compromisso com abertura, mas porque licença aberta é um instrumento juridicamente irrevogável, e o regime que o CTA exige — consentimento com escopo, prazo e revogação — é incompatível com irrevogabilidade. O que circula sob licença aberta é o código que processa o dado e a documentação que explica o sistema; o dado circula sob consentimento.

### 6.5 Sustentabilidade e continuidade

A ameaça mais concreta a uma federação de unidades soberanas não é técnica: é o fim do financiamento e o desaparecimento de mantenedores. As respostas propostas são deliberadamente modestas, porque promessas de perenidade que dependem de recursos futuros não são governança:

- **Custo mínimo por unidade é requisito de projeto, não otimização.** Um container e um arquivo é o que torna possível que uma associação mantenha sua unidade com orçamento próprio depois que o projeto que a financiou terminar.
- **Nenhum componente é indispensável para os demais.** Se o Pluriverso sair do ar, cada unidade continua funcionando integralmente — perde-se a busca federada, não o dado. A recíproca não é verdadeira, e é assim que deve ser.
- **Sucessão declarada.** Cada membro deve indicar, no cadastro de adesão, o que acontece com sua unidade se o mantenedor cessar a operação: quem assume, ou se o dado é exportado e devolvido à comunidade e a unidade encerrada. Sem essa declaração, a extinção silenciosa é o desfecho padrão. `[a implementar em ADR-006 — campo no cadastro de membro]`
- **Capacitação como repartição não monetária.** Formação técnica local é modalidade prevista na Lei nº 13.123/2015, art. 19, e é também a única forma de a soberania de infraestrutura ser real em vez de nominal (§4.3, salvaguarda 1). É o sub-princípio R2 do CARE, hoje um gap declarado (§3.1).

## 7. Governança da arquitetura

### 7.1 Como a arquitetura evolui

O ADR é o instrumento de governança da arquitetura, e não apenas documentação técnica. As regras propostas para o processo:

- **Quem propõe:** qualquer membro da federação, por meio de seu representante no Comitê, ou o mantenedor de qualquer componente.
- **Quem aceita:** o Comitê Federado, por consenso ou maioria qualificada (ADR-004, D3). ADR que afete o contrato entre membros não é aceito por decisão de um mantenedor.
- **Quando exige consulta prévia às comunidades:** sempre que a mudança for suscetível de afetar diretamente as comunidades federadas — o que decorre do art. 6º(1)(a) da Convenção nº 169 da OIT, não de uma escolha de processo. Mudança no contrato de harvest, no modelo de consentimento ou nas regras de visibilidade está nessa categoria.
- **Quando revisar:** todo ADR carrega data de revisão. O ADR-003 ainda está **"Proposto"** e prevê revisão após piloto com três comunidades; o ADR-004 prevê revisão após a primeira coleta efetiva. Um ADR proposto que permanece proposto indefinidamente é uma decisão tomada sem ter sido decidida — e o ADR-003, por reger consentimento e visibilidade, é o caso mais crítico (§8.1).
- **Como se supera um ADR:** por outro ADR que o declare superado, com o motivo — como o ADR-005 fez com a decisão D5 do ADR-004. Nunca por edição silenciosa do texto original.

### 7.2 Quem decide o quê

| Decisão | Quem decide | Quem é consultado | Quem pode vetar |
|---|---|---|---|
| Publicar um registro (`visibility: public`) | Instância de decisão da comunidade titular | Curador (parecer técnico); detentor do relato | A comunidade titular; o detentor, quanto aos seus próprios dados pessoais |
| Ocultar campo ou reduzir precisão geográfica | Instância de decisão da comunidade titular | Curador | A comunidade titular |
| Revogar consentimento / retirar registro | Comunidade titular — **sem necessidade de justificativa** | Ninguém | Ninguém |
| Aceitar novo membro na federação | Comitê Federado (ADR-006, E2) | Membros atuais; resultado do probe técnico como sinal (E3) | Comitê, com motivo obrigatório registrado |
| Remover membro da federação | Comitê Federado | Membro afetado | Comitê |
| Saída voluntária da federação | O próprio membro | Ninguém | Ninguém — a saída não se nega (ADR-004, D4) |
| Alterar o contrato de harvest (ADR-004, D6) | Comitê Federado | **Consulta formal a todas as comunidades federadas** (OIT 169, art. 6º) | Qualquer membro cujo endpoint seja afetado |
| Criar mapeamento SKOS entre membros | Comitê Federado | Os dois membros envolvidos | Qualquer um dos dois membros envolvidos |
| Alterar o modelo de dados comum (ADR-003) | Comitê Federado, via ADR | Todas as comunidades federadas; mantenedores | Comitê |
| Liberar harvest autenticado para `restricted` | Comitê Federado, via ADR | **Consulta formal a todas as comunidades federadas** | Qualquer membro; e cada membro decide individualmente se adere, mesmo se aprovado |
| Resolver E4 (autenticação da decisão do Comitê) | Comitê Federado + mantenedor do Pluriverso | Membros | Comitê |
| Hospedar instância fora do Brasil | Mantenedor da instância | Comunidades cujos dados serão hospedados; encarregado (LGPD, arts. 33–36) | Comunidade titular dos dados afetados |

Duas assimetrias na tabela são deliberadas e resumem a proposta: **para publicar, é preciso decisão positiva; para retirar, basta a vontade de quem tem legitimidade.** E o veto de uma comunidade sobre seus próprios dados não é revisável por nenhuma instância superior — não há recurso ao Comitê contra a decisão de uma comunidade sobre seu próprio conhecimento.

### 7.3 Interoperabilidade com iniciativas nacionais

A Arquitetura BioCultural não pretende substituir as iniciativas nacionais em curso, e a governança da interoperabilidade precisa refletir isso:

- **SisGen** — sistema de cadastro obrigatório, não de publicação. A interoperabilidade desejável é de referência: registrar o número de cadastro associado a consultas com finalidade de P&D (§5.9), não exportar registros de CTA para o SisGen.
- **SiBBr / GBIF** — publicação de dados de ocorrência é possível **apenas** para registros públicos e **sempre** com os termos de restrição preenchidos: `dwc:informationWithheld`, `dwc:dataGeneralizations`, `dcterms:accessRights` (§5.2). Exportar CTA sensível para rede de dados abertos sem esses termos é o erro que esta proposta inteira existe para evitar.
- **GEF Entre-Ciências** (MCTI, 2025–2029) e **Rede de Conhecimentos sobre Sociobiodiversidade** (ICMBio/CNPT e UFSC) — convergentes em objetivo e em modelo de protocolo comunitário; a interoperabilidade natural é de vocabulário e de protocolo de consentimento, não de base de dados unificada.
- **Modernização do SISGEN** (RNP, MMA e BID) — declara adesão a FAIR e CARE; é o interlocutor mais direto para a discussão de rótulos culturais em infraestrutura nacional.

O enquadramento internacional dessa discussão já está posto: uma infraestrutura global de dados de uso da biodiversidade que reconheça conhecimento indígena e local exige, antes de padrões técnicos, arranjos de governança que reconheçam autoridade (PANKARARU et al., 2026). E o precedente institucional imediato continua sendo o piloto de TK/BC Labels do GBIF (GLOBAL BIODIVERSITY INFORMATION FACILITY, 2025), cujo resultado deve orientar a implementação de §5.5 em vez de ser antecipado por ela.

## 8. Implementação: do documento à prática

### 8.1 Lacunas abertas nesta proposta

Nomeadas, com responsável e o que falta. Nenhuma delas é hipotética: todas foram identificadas nos artefatos do próprio repositório ou no cotejo com a norma.

| # | Lacuna | Responsável | O que falta |
|---|---|---|---|
| 1 | **Autenticação da decisão do Comitê Federado** (ADR-006, E4) | Comitê + mantenedor do Pluriverso | Mecanismo definido e implementado. **Bloqueia** o deploy em produção da fila de inscrição |
| 2 | **ADR-003 ainda "Proposto"**, sem validação comunitária | Comitê + comunidades piloto | Piloto com três comunidades e passagem do ADR a "Aceito" |
| 3 | **Protocolo escrito do Comitê Federado** | Comitê | Quórum, convocação, o que exige consenso, prazos, publicação das decisões |
| 4 | **Licença do projeto indefinida** | Autor + Comitê | Adotar os três regimes de §6.4 e refletir no README e nos repositórios |
| 5 | **Log de uso e evidência para repartição** | Pluriverso | Log de consulta/download, finalidade declarada, DOI de conjunto, relatório anual por membro |
| 6 | **Extensões de consentimento** (`scope`, `purpose`, `permittedUses[]`, `expiresAt`, `protocolReference`, `language`, `revokedAt`) | BioCultRelatos + ADR-003 | Campos no modelo e no fluxo de CLPI |
| 7 | **Rótulos culturais TK/BC** | BioCultRelatos, BioCultAcervos, BioCultTermos + ADR-003 | Campo próprio, distinto de `permissions.license`, e interface de aplicação pela comunidade |
| 8 | **Data de revisão de sensibilidade** (`permissions.restrictions.reviewDate`) | ADR-003 | Campo e rotina de alerta |
| 9 | **Propagação ativa de revogação ao índice** | Contrato de harvest (ADR-004, D6) | Notificação do membro ao Pluriverso, em vez de aguardar o próximo ciclo |
| 10 | **Harvest autenticado para `restricted`** | Comitê + Pluriverso | Não existe; permanece proibido até decisão (§5.12, item 4) |
| 11 | **RIPD** (LGPD, arts. 37–38) | Cada controlador | Relatório de impacto, com comunidades tradicionais como grupo vulnerável |
| 12 | **Distinção formal entre titularidade e posse** | ADR-003 | Campo que separe comunidade titular de operador da unidade quando forem partes distintas |
| 13 | **SDK de referência para adesão** | Pluriverso | Reduz a barreira técnica de implementar o endpoint de harvest (CARE R2) |
| 14 | **Auto-hospedagem dos documentos normativos citados** | Este repositório | Cópia local do *one-pager* da GIDA e demais fontes normativas — a página oficial já retornou HTTP 404 uma vez (§3.1) |

### 8.2 Sequência de adoção sugerida

Quatro passos, em ordem de dependência — não de conveniência:

1. **Fundação de governança** (não exige código): adotar as licenças de §6.4; escrever o protocolo do Comitê Federado; resolver E4. Sem esses três, qualquer implementação seguinte carece de instância legítima que a autorize.
2. **Consentimento como dado**: implementar as extensões de `community.consent` (§5.3) e o log *append-only* de consentimento; produzir o RIPD. É o que torna o CLPI verificável em vez de declarado.
3. **Piloto com três comunidades**: validar o ADR-003 em campo, aplicar rótulos culturais, exercitar o ciclo completo de §5.4 — inclusive uma revogação de teste, deliberada, para verificar que o purge funciona ponta a ponta antes que alguém precise dele de verdade.
4. **Evidência de uso**: log de consulta e download, DOI de conjunto, primeiro relatório anual por membro (§5.9). Só faz sentido quando há uso real a registrar.

### 8.3 Indicadores de governança

Cinco indicadores, escolhidos por serem verificáveis a partir dos próprios dados e por medirem governança, não volume:

| Indicador | Como se mede | Por que importa |
|---|---|---|
| Registros com CLPI completo | Proporção de registros com `community.consent` preenchido em todos os campos, incluindo escopo e prazo | Distingue consentimento registrado de consentimento apenas declarado |
| Registros com rótulo cultural | Percentual de registros com ao menos um TK ou BC Label aplicado pela comunidade | Mede autoridade exercida, não apenas concedida |
| Tempo de resposta a pedido de revogação | Mediana entre o pedido e a remoção efetiva do índice federado | É a métrica que a comunidade sentirá primeiro se algo estiver errado |
| Retornos de dados a comunidades | Número de exportações e relatórios anuais efetivamente entregues às comunidades de origem | Mede CARE C2 e R1, hoje um gap completo (§3.1) |
| Decisões do Comitê publicadas | Número de decisões com motivo registrado e publicado, sobre o total de decisões tomadas | Governança que não se publica não é auditável |

Nenhum desses indicadores mede quantidade de registros. É deliberado: uma federação com poucos registros bem consentidos, rotulados e devolvidos cumpre esta proposta; uma com muitos registros sem consentimento verificável a viola, por mais completa que pareça.

## 9. Referências Bibliográficas

Formatadas segundo a **ABNT NBR 6023:2018**, mesma convenção de [`Referencias.md`](../Referencias.md). Duas observações sobre o critério de inclusão:

- **Legislação e instrumentos internacionais** são citados no corpo pelo nome da norma e pelo artigo exato (ex.: "LGPD, art. 11, §1º"), conforme a prática da área, e listados na primeira seção abaixo. Os demais itens são citados no corpo no formato `(AUTOR, ano)`.
- **Nada entra sem verificação.** Referências que a pesquisa de base não conseguiu confirmar em fonte primária foram descartadas, e com elas as afirmações que delas dependiam. Em particular, não são citados: o Acórdão nº 1.384/2022 do TCU (referido apenas indiretamente por Prestes, Preve e Bona, 2024), a norma IEEE 2890-2025, o artigo de Wynberg e Foster sobre o caso Hoodia, e casos de apropriação sem número de patente e desfecho verificáveis (kava, andiroba e copaíba), tratados em §4.1 como padrão documentado na literatura e não como caso nominal.

### 9.1 Legislação Brasileira

BRASIL. **Constituição da República Federativa do Brasil de 1988**. Art. 5º, LXXIX (redação dada pela Emenda Constitucional nº 115, de 2022); arts. 215, 216 e 231. Brasília, 1988. Disponível em: https://www.planalto.gov.br/ccivil_03/constituicao/constituicaocompilado.htm

BRASIL. **Decreto nº 2.519, de 16 de março de 1998**. Promulga a Convenção sobre Diversidade Biológica, assinada no Rio de Janeiro em 5 de junho de 1992. *Diário Oficial da União*, Brasília, 1998.

BRASIL. **Lei nº 9.610, de 19 de fevereiro de 1998**. Altera, atualiza e consolida a legislação sobre direitos autorais. *Diário Oficial da União*, Brasília, 1998. Disponível em: https://www.planalto.gov.br/ccivil_03/leis/l9610.htm

BRASIL. **Decreto nº 3.551, de 4 de agosto de 2000**. Institui o Registro de Bens Culturais de Natureza Imaterial e cria o Programa Nacional do Patrimônio Imaterial. *Diário Oficial da União*, Brasília, 2000. Disponível em: https://www.planalto.gov.br/ccivil_03/decreto/d3551.htm

BRASIL. **Lei nº 10.406, de 10 de janeiro de 2002** (Código Civil). Art. 20. *Diário Oficial da União*, Brasília, 2002. Disponível em: https://www.planalto.gov.br/ccivil_03/leis/2002/l10406compilada.htm

BRASIL. **Decreto nº 5.051, de 19 de abril de 2004**. Promulga a Convenção nº 169 da Organização Internacional do Trabalho sobre Povos Indígenas e Tribais. Consolidado, com as demais convenções da OIT ratificadas pelo Brasil, pelo Decreto nº 10.088, de 5 de novembro de 2019. *Diário Oficial da União*, Brasília, 2004.

BRASIL. **Decreto nº 6.040, de 7 de fevereiro de 2007**. Institui a Política Nacional de Desenvolvimento Sustentável dos Povos e Comunidades Tradicionais. *Diário Oficial da União*, Brasília, 2007. Disponível em: https://www.planalto.gov.br/ccivil_03/_ato2007-2010/2007/decreto/d6040.htm

BRASIL. **Decreto nº 6.476, de 5 de junho de 2008**. Promulga o Tratado Internacional sobre Recursos Fitogenéticos para a Alimentação e a Agricultura, aprovado pelo Decreto Legislativo nº 70, de 19 de abril de 2006. *Diário Oficial da União*, Brasília, 2008.

BRASIL. **Lei nº 13.123, de 20 de maio de 2015**. Regulamenta o acesso ao patrimônio genético, a proteção e o acesso ao conhecimento tradicional associado e a repartição de benefícios. *Diário Oficial da União*, Brasília, 2015. Disponível em: https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2015/lei/l13123.htm

BRASIL. **Decreto nº 8.750, de 9 de maio de 2016**. Institui o Conselho Nacional dos Povos e Comunidades Tradicionais. *Diário Oficial da União*, Brasília, 2016. Disponível em: https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2016/decreto/d8750.htm

BRASIL. **Decreto nº 8.772, de 11 de maio de 2016**. Regulamenta a Lei nº 13.123, de 20 de maio de 2015. *Diário Oficial da União*, Brasília, 2016. Disponível em: https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2016/decreto/d8772.htm

BRASIL. **Lei nº 13.709, de 14 de agosto de 2018** (Lei Geral de Proteção de Dados Pessoais). *Diário Oficial da União*, Brasília, 2018. Disponível em: https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm

BRASIL. **Decreto nº 10.844, de 25 de outubro de 2021**. Altera o Decreto nº 8.772, de 11 de maio de 2016, para segregar cadastros de pesquisa sem finalidade econômica. *Diário Oficial da União*, Brasília, 2021.

BRASIL. **Decreto nº 11.865, de 28 de dezembro de 2023**. Promulga o Protocolo de Nagoia sobre Acesso a Recursos Genéticos e Repartição Justa e Equitativa de Benefícios Advindos de sua Utilização à Convenção sobre Diversidade Biológica. *Diário Oficial da União*, Brasília, 2023. Disponível em: https://www.planalto.gov.br/ccivil_03/_ato2023-2026/2023/decreto/d11865.htm

BRASIL. **Decreto nº 13.014, de 2026**. Altera o Decreto nº 8.772, de 11 de maio de 2016; institui o termo de associação para instituições estrangeiras sem colaboração científica e cria a Aliança das Instituições Públicas Nacionais de Pesquisa Científica e Tecnológica pela Biodiversidade. *Diário Oficial da União*, Brasília, 2026.

### 9.2 Convenções e Protocolos Internacionais

CBD SECRETARIAT — CONVENTION ON BIOLOGICAL DIVERSITY SECRETARIAT. **Nagoya Protocol on Access to Genetic Resources and the Fair and Equitable Sharing of Benefits Arising from their Utilization to the Convention on Biological Diversity: Text and Annex**. Montreal: CBD Secretariat, 2011. Disponível em: https://www.cbd.int/abs/doc/protocol/nagoya-protocol-en.pdf

CBD SECRETARIAT — CONVENTION ON BIOLOGICAL DIVERSITY SECRETARIAT. **Decision CBD/COP/DEC/16/2 — Digital sequence information on genetic resources** (institui o Cali Fund). COP16, Cali, Colômbia, 2 nov. 2024. Disponível em: https://www.cbd.int/

CBD SECRETARIAT — CONVENTION ON BIOLOGICAL DIVERSITY SECRETARIAT. **Documentação sobre o acordo de repartição de benefícios Hoodia/CSIR/San (2003) no contexto do regime de acesso e repartição de benefícios da CDB**. Disponível em: https://www.cbd.int/

INTERNATIONAL LABOUR ORGANIZATION. **Indigenous and Tribal Peoples Convention, 1989 (No. 169)**. Arts. 6 e 7. Genebra: ILO, 1989.

ORGANIZAÇÃO DAS NAÇÕES UNIDAS. **United Nations Declaration on the Rights of Indigenous Peoples (UNDRIP)**. Art. 31. Nova York: ONU, 2007. Resolução A/RES/61/295.

WORLD INTELLECTUAL PROPERTY ORGANIZATION. **Treaty on Intellectual Property, Genetic Resources and Associated Traditional Knowledge**. Adotado em Genebra em 24 de maio de 2024. Disponível em: https://www.wipo.int/

WORLD INTELLECTUAL PROPERTY ORGANIZATION. **Documentação sobre a Traditional Knowledge Digital Library (TKDL) da Índia e sobre casos de biopirataria (nim, cúrcuma, ayahuasca)**. Disponível em: https://www.wipo.int/

### 9.3 Governança de Dados e Princípios

CARROLL, S. R.; GARBA, I.; FIGUEROA-RODRÍGUEZ, O. L.; HOLBROOK, J.; LOVETT, R.; MATERECHERA, S.; PARSONS, M.; RASEROKA, K.; RODRIGUEZ-LONEBEAR, D.; ROWE, R.; SARA, R.; WALKER, J. D.; ANDERSON, J.; HUDSON, M. The CARE Principles for Indigenous Data Governance. *Data Science Journal*, v. 19, n. 1, art. 43, 2020. DOI: https://doi.org/10.5334/dsj-2020-043

CARROLL, S. R.; HERCZOG, E.; HUDSON, M.; RUSSELL, K.; STALL, S. Operationalizing the CARE and FAIR Principles for Indigenous data futures. *Scientific Data*, v. 8, art. 108, 2021. DOI: https://doi.org/10.1038/s41597-021-00892-0

COULDRY, N.; MEJIAS, U. A. Data colonialism: rethinking big data's relation to the contemporary subject. *Television & New Media*, v. 20, n. 4, p. 336-349, 2019. DOI: https://doi.org/10.1177/1527476418796632

FIRST NATIONS INFORMATION GOVERNANCE CENTRE. **The First Nations Principles of OCAP®**. Ottawa: FNIGC. Princípios formulados em 1998 pelo National Steering Committee da Assembly of First Nations; sob gestão do FNIGC desde 2010. Disponível em: https://fnigc.ca/ocap-training/

GLOBAL INDIGENOUS DATA ALLIANCE. **CARE Principles for Indigenous Data Governance** (one-pager oficial). GIDA, 17 out. 2019. Disponível em: https://www.gida-global.org/s/CAREPrinciples_OnePagersFINAL_Oct_17_2019.pdf. Cópia arquivada da página oficial, que retornou HTTP 404 em julho de 2026: https://web.archive.org/web/20240102104445/https://www.gida-global.org/care

HUDSON, M.; GARRISON, N. A.; STERLING, R.; CARON, N. R.; FOX, K.; YRACHETA, J.; ANDERSON, J.; WILCOX, P.; ARBOUR, L.; BROWN, A.; TAUALII, M.; KUKUTAI, T.; HARING, R.; TE AIKA, B.; BAYNAM, G. S.; DEARDEN, P. K.; CHAGNÉ, D.; MALHI, R. S.; GARBA, I.; TIFFIN, N.; BOLNICK, D.; STOTT, M.; ROLLESTON, A. K.; BALLANTYNE, L. L.; LOVETT, R.; DAVID-CHAVEZ, D.; MARTINEZ, A.; SPORLE, A.; WALTER, M.; READING, J.; CARROLL, S. R. Rights, interests and expectations: Indigenous perspectives on unrestricted access to genomic data. *Nature Reviews Genetics*, v. 21, n. 6, p. 377-384, 2020. DOI: https://doi.org/10.1038/s41576-020-0228-x

JENNINGS, L.; ANDERSON, T.; MARTINEZ, A.; STERLING, R.; DAVID-CHAVEZ, D.; GARBA, I.; HUDSON, M.; GARRISON, N. A.; CARROLL, S. R. Applying the 'CARE Principles for Indigenous Data Governance' to ecology and biodiversity research. *Nature Ecology & Evolution*, v. 7, n. 10, p. 1547-1551, 2023. DOI: https://doi.org/10.1038/s41559-023-02161-2

KUKUTAI, T.; TAYLOR, J. (eds.). **Indigenous Data Sovereignty: Toward an Agenda**. Canberra: ANU Press, 2016. (CAEPR Research Monograph, n. 38). DOI: https://doi.org/10.22459/CAEPR38.11.2016

PRESTES, F. P.; PREVE, D. R.; BONA, M. T. de. Controles de proteção de dados pessoais dos povos indígenas implementados na FUNAI. *JURIS — Revista da Faculdade de Direito* (Universidade Federal do Rio Grande), v. 34, n. 1, 2024. DOI: https://doi.org/10.14295/juris.v34i1.17613

TE MANA RARAUNGA — MĀORI DATA SOVEREIGNTY NETWORK. **Principles of Māori Data Sovereignty**. Disponível em: https://www.temanararaunga.maori.nz/

TORINO, E.; VIDOTTI, A. L. G.; CONEGLIAN, C. S.; VIDOTTI, S. A. B. G. Princípios CARE para a governança de dados de povos indígenas: fundamentos legais e casos práticos. *Tendências da Pesquisa Brasileira em Ciência da Informação*, v. 17, 2024.

WILKINSON, M. D.; DUMONTIER, M.; AALBERSBERG, I. J. et al. The FAIR Guiding Principles for scientific data management and stewardship. *Scientific Data*, v. 3, art. 160018, 2016. DOI: https://doi.org/10.1038/sdata.2016.18

### 9.4 Etnobiologia, Conhecimento Tradicional e Casos Documentados

ANDERSON, J.; HUDSON, M. The Biocultural Labels Initiative: Supporting Indigenous rights in data derived from genetic resources. *Biodiversity Information Science and Standards*, v. 4, art. e59230, 2020. DOI: https://doi.org/10.3897/biss.4.59230

CÂMARA DOS DEPUTADOS; SENADO FEDERAL. **Documentação legislativa sobre os casos de biosquatting do cupuaçu e do açaí e sobre listas de monitoramento de nomes de espécies nativas**. Brasília. Disponível em: https://www.camara.leg.br/ ; https://www12.senado.leg.br/

CENTER FOR INTERNATIONAL ENVIRONMENTAL LAW. **Documentação sobre o caso da patente de ayahuasca ("Da Vine", Plant Patent US PP5.751) e a oposição da COICA**. Disponível em: https://www.ciel.org/

CENTRO DE DOCUMENTAÇÃO ELOY FERREIRA DA SILVA. **Protocolo de Consulta Prévia do Povo Krenak**, ago. 2017. Disponível em: https://cedefes.org.br/

CHRISTEN, K. Does Information Really Want to be Free? Indigenous Knowledge Systems and the Question of Openness. *International Journal of Communication*, v. 6, p. 2870-2893, 2012. Disponível em: https://ijoc.org/

CHRISTEN, K. Tribal Archives, Traditional Knowledge, and Local Contexts: Why the 's' Matters. *Journal of Western Archives*, v. 6, n. 1, art. 3, 2015. DOI: https://doi.org/10.26077/78d5-47cf

CHRISTEN, K.; ANDERSON, J. Toward slow archives. *Archival Science*, v. 19, n. 2, p. 87-116, 2019. DOI: https://doi.org/10.1007/s10502-019-09307-x

COMISSÃO PRÓ-ÍNDIO DE SÃO PAULO. **Protocolo de Consulta Prévia dos Territórios Quilombolas do Vale do Ribeira**. Disponível em: https://cpisp.org.br/

ETC GROUP. **Documentação sobre a patente de quinoa "Apelawa" (US 5.304.718) e a mobilização da ANAPQUI**. Disponível em: https://www.etcgroup.org/

EUROPEAN PATENT OFFICE. **Revogação da patente EP0436257 (nim, *Azadirachta indica*)**, 2000; decisão confirmada em recurso em 2005. Disponível em: https://www.epo.org/

FUNDAÇÃO DE AMPARO À PESQUISA DO ESTADO DE SÃO PAULO. **Reportagens e análises sobre biopirataria, cupuaçu, açaí e andiroba/copaíba no contexto da Lei nº 13.123/2015**. *Pesquisa FAPESP*. Disponível em: https://revistapesquisa.fapesp.br/

GENETIC RESOURCES, TRADITIONAL KNOWLEDGE AND TECHNOLOGY BULLETIN (GenResJ). **Avaliações sobre a efetividade do Protocolo de Nagoya**. Disponível em: https://www.genresj.org/

INSTITUTO SOCIOAMBIENTAL; INSTITUTO IEPÉ. **Protocolo de Consulta e Consentimento do Povo Wajãpi**, 2014. Disponível em: https://www.socioambiental.org/ ; https://institutoiepe.org.br/

MINISTÉRIO PÚBLICO FEDERAL. **Documentação sobre protocolos de consulta prévia de povos indígenas na Amazônia (Munduruku, Juruna/Yudjá) e fundamentação na Convenção nº 169 da OIT**. Disponível em: https://www.mpf.mp.br/

PANKARARU, C. J.; TEIXIDOR-TONEU, I.; ODONNE, G.; ASANTE, F.; BANDEIRA, S. O.; BARRERA-BELLO, Á. M.; BENITEZ-CAPISTROS, F. J.; DAHDOUH-GUEBAS, F.; DALCIN, E.; DENNEHY-CARR, Z. H.; DIALLO, K.; DROUET-CRUZ, H. T.; FONSECA-KRUEL, V. S.; GALLOIS, S.; GNANSOUNOU, S. C.; HAMZA, A. J.; HUGÉ, J.; JORDAN, F. M.; KALLE, R. et al.; HANAZAKI, N. A global biodiversity use data infrastructure acknowledging indigenous and local knowledge. *npj Biodiversity*, v. 5, art. 7, 2026. DOI: https://doi.org/10.1038/s44185-026-00121-0

REYES-GARCÍA, V.; BROESCH, J.; CALVET-MIR, L.; FUENTES-PELÁEZ, N.; MCDADE, T. W.; PARSA, S.; TANNER, S.; HUANCA, T.; LEONARD, W. R.; MARTÍNEZ-RODRÍGUEZ, M. R.; TAPS BOLIVIAN STUDY TEAM. Cultural transmission of ethnobotanical knowledge and skills: an empirical analysis from an Amerindian society. *Evolution and Human Behavior*, v. 30, n. 4, p. 274-285, 2009. DOI: https://doi.org/10.1016/j.evolhumbehav.2009.02.001

SCIELO BRASIL. **Artigos sobre o caso do jaborandi/pilocarpina (Merck, Maranhão) e a ausência histórica de repartição de benefícios com os coletores tradicionais**. Disponível em: https://www.scielo.br/

UNITED STATES PATENT AND TRADEMARK OFFICE. **Revogação da patente US 5.401.504 (cúrcuma), 1997; histórico da Plant Patent PP5.751 ("Da Vine"/ayahuasca) e da patente US 5.304.718 (quinoa "Apelawa")**. Disponível em: https://www.uspto.gov/

UNIVERSIDADE FEDERAL DE SANTA CATARINA; EPAGRI-SC. **Documentação sobre o caso da espinheira-santa (*Maytenus ilicifolia*) e a patente EP0776666 da Nippon Mektron, 1997**.

ZANK, S.; JULIÃO, C. G.; DE LIMA, A. S.; DA SILVA, M. T.; LEVIS, C.; HANAZAKI, N.; PERONI, N. Ethnobiology! Until when will the colonialist legacy be reinforced? *Journal of Ethnobiology and Ethnomedicine*, v. 21, art. 1, 2025. DOI: https://doi.org/10.1186/s13002-024-00750-4

### 9.5 Padrões e Ferramentas

BIODIVERSITY INFORMATION STANDARDS (TDWG). **Darwin Core Quick Reference Guide** (termos `informationWithheld`, `dataGeneralizations`, `accessRights`, `license`). Disponível em: https://dwc.tdwg.org/terms/

CHAPMAN, A. D. **Current Best Practices for Generalizing Sensitive Species Occurrence Data**. Copenhagen: GBIF Secretariat, 2020. DOI: https://doi.org/10.15468/doc-5jp4-5g10

GLOBAL BIODIVERSITY INFORMATION FACILITY. **Open data for people and purpose: GBIF establishes task group on Indigenous data governance**, 28 jul. 2025. Disponível em: https://www.gbif.org/news/1Ke3Gk2USgdIW5OgDlBIKY/open-data-for-people-and-purpose-gbif-establishes-task-group-on-indigenous-data-governance

KAYE, J.; WHITLEY, E. A.; LUND, D.; MORRISON, M.; TEARE, H.; MELHAM, K. Dynamic consent: a patient interface for twenty-first century research networks. *European Journal of Human Genetics*, v. 23, n. 2, p. 141-146, 2015. DOI: https://doi.org/10.1038/ejhg.2014.71

LOCAL CONTEXTS. **TK Labels, BC Labels e Notices**. Disponível em: https://localcontexts.org/labels/traditional-knowledge-labels/ ; https://localcontexts.org/labels/biocultural-labels/ ; https://localcontexts.org/notices/about-the-notices/

MUKURTU CMS. Disponível em: https://mukurtu.org/

OWASP FOUNDATION. **OWASP Top Ten Web Application Security Risks**, edição 2025a. Disponível em: https://owasp.org/Top10/2025/

OWASP FOUNDATION. **OWASP Application Security Verification Standard (ASVS) 5.0.0**, 2025b. Disponível em: https://github.com/OWASP/ASVS

W3C. **PROV-O: The PROV Ontology**. W3C Recommendation, 30 abr. 2013. Disponível em: https://www.w3.org/TR/2013/REC-prov-o-20130430/

W3C. **SKOS Simple Knowledge Organization System Extension for Labels (SKOS-XL)**. Disponível em: https://www.w3.org/TR/skos-reference/skos-xl.html

ZETETIC, LLC. **SQLCipher**. Disponível em: https://www.zetetic.net/sqlcipher/
