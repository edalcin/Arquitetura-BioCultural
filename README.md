# Arquitetura para um Sistema de Informações sobre Conhecimento Tradicional Associado à Biodiversidade - Versão 3.5

[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.21738427-blue)](https://doi.org/10.5281/zenodo.21738427)
[![Versão](https://img.shields.io/badge/Versão-3.5.0-green)](CHANGELOG.md)
[![Governança](https://img.shields.io/badge/Governança-Proposta%20para%20consulta-B4542F)](governanca/propostaGovernanca.md)

## Visão Geral

Este repositório contém a proposta de arquitetura para um sistema de informações dedicado a registrar e documentar evidências da relação entre comunidades tradicionais e a biodiversidade, provenientes de múltiplas fontes, com respeito pleno e absoluto aos princípios **C.A.R.E.** (Collective Benefit, Authority to Control, Responsibility, Ethics). A versão 3.0 redefine o sistema como uma **arquitetura explicitamente federada**: cada iniciativa ou comunidade é completamente soberana na gestão de seus próprios dados. O **Pluriverso** atua como middleware de federação, provendo acesso integrado ao conjunto de CTAs das entidades federadas. A versão 3.1 aprofunda essa soberania na camada de persistência: cada unidade federada passa a armazenar seus dados em um único arquivo **SQLite com JSON** (JSON1), compartilhado entre as ferramentas da própria unidade, eliminando a dependência de um servidor de banco de dados centralizado. A versão 3.2 amplia as fontes de evidência suportadas de duas para quatro: além de fontes secundárias (artigos científicos) e primárias (registro de campo), a federação passa a acolher acervos históricos/museológicos e obras de naturalistas dos séculos XVII-XIX. A versão 3.3 fixa a engine de persistência do Pluriverso (SQLite embutida, ADR-008) e reconhece o Pluriverso como componente **instanciável em múltiplos escopos** (ADR-009), permitindo, por exemplo, que uma associação de comunidades opere sua própria instância federando apenas os seus membros. A **versão 3.4** acrescenta a camada que faltava: uma **proposta de governança para toda a plataforma**, que nomeia quem decide o quê sobre os dados, as ferramentas e a própria arquitetura.

> "Se os dados não estão fisicamente sob o controle de quem os gerou, a soberania é apenas uma promessa bonita em um termo de consentimento."
>
> — Eduardo Dalcin, em [*Sementes Livres, Solos Próprios: Por que o Conhecimento Tradicional exige uma Arquitetura Federada*](https://eduardo.dalc.in/por-que-o-conhecimento-tradicional-exige-uma-arquitetura-federada/), post que resume e ilustra didaticamente esta proposta de arquitetura federada.


## 🏛️ Novidade da v3.4 — Proposta de Governança

A arquitetura sempre prometeu soberania. A **[Proposta de Governança](governanca/propostaGovernanca.md)** é o documento que diz **como essa promessa é cumprida na prática** — e onde ela ainda não é.

> Arquitetura não é governança: dizer *como* o dado é armazenado não diz *quem decide* o que entra, o que sai, quem pode alterar o código que o processa, e quem responde quando uma comunidade pergunta por que um relato está público sem autorização.

O documento organiza a governança em **três camadas**, cada uma com sua instância de decisão:

| Camada | Quem decide | Sobre o quê |
|---|---|---|
| **Dados** | A comunidade | o que se registra · o que se publica · o que se retira |
| **Ferramentas** | O mantenedor da instância | deploy · versão · backup · segurança |
| **Arquitetura** | O Comitê Federado | ADRs · contrato de harvest · admissão de membros |

[![Três camadas de governança: dados decididos pela comunidade, ferramentas pelo mantenedor da instância, arquitetura pelo Comitê Federado](governanca/governanca-tres-camadas.png)](governanca/propostaGovernanca.md)

**O que o documento traz:**

- Os princípios **C.A.R.E.** sub-princípio a sub-princípio, mapeados ao componente que os implementa — com o **estado real de cada um**, inclusive os vazios
- O **marco legal** brasileiro e internacional artigo por artigo (LGPD, Lei 13.123/2015, Protocolo de Nagoya, Convenção nº 169 da OIT, UNDRIP, CDB)
- A **lacuna dos dados coletivos**: a LGPD protege o titular individual, o CTA tem titularidade coletiva por lei — e os dois regimes não conversam
- **Por que comunidades desconfiam de bancos de dados**, com casos documentados de apropriação indevida (cupuaçu, ayahuasca, jaborandi, espinheira-santa, Hoodia, nim, cúrcuma, quinoa, açaí) e as **sete salvaguardas** desta arquitetura — cada uma com o limite honesto do que ela **não** impede
- **CLPI como ciclo revisável**, não como formulário assinado uma vez
- **Rotulagem cultural** TK/BC Labels, **repartição de benefícios rastreável**, conformidade LGPD e **compromissos negativos** — o que a plataforma nunca fará
- Uma **matriz de decisão** e **catorze lacunas abertas nomeadas**, com responsável e o que falta em cada uma

> **Status: Proposta para consulta.** Não é norma vigente — o documento é submetido à validação das comunidades federadas e do Comitê Federado, e marca `[a implementar]` tudo o que ainda não existe.

📄 **[Ler a Proposta de Governança completa →](governanca/propostaGovernanca.md)**

## 🧬 Modelo de Dados Unificado (UDM)

Toda a arquitetura — e as ferramentas que a implementam — compartilha um único contrato lógico de dados: o **[Modelo de Dados Unificado (UDM)](docs/modelo-de-dados-unificado.md)**. É o documento que consolida, num contrato único e citável, o que hoje está distribuído entre o ADR-003 e suas retificações (ADR-005/008 de persistência; ADR-014/015/016/017 de vocabulário, regime enunciativo, harvest e composição) — e é o **objeto técnico do acordo de cooperação entre o Instituto de Pesquisas Jardim Botânico do Rio de Janeiro (JBRJ) e o USEFLORA**.

**O que o UDM define:**

- Um **documento JSON** autocontido e independente de engine — persistido, na implementação de referência, em SQLite+JSON1 (ADR-005)
- **Regime Enunciativo**, **Relato** e três níveis de rotulagem de acesso (Termo/Relato/Registro), com nível efetivo sempre o mais restritivo
- **Composição multi-espécie**: usos, preparos e artefatos com 1..n plantas e papel por componente (ADR-017)
- Interoperabilidade mapeada com **Darwin Core**, **DwC-DP** e o vocabulário **SKOS-XL** do BioCultTermos
- Um **checklist de conformidade (C1–C10)** pelo qual qualquer ferramenta — interna ou externa à federação — declara aderência ao contrato

📄 **[Ler o Modelo de Dados Unificado completo →](docs/modelo-de-dados-unificado.md)**

---

## Motivação e Justificativa

### O Problema: Conhecimento e Evidências Dispersos e Não Registrados

A relação entre comunidades tradicionais brasileiras e a biodiversidade produziu, ao longo de séculos, um vasto acervo de duas naturezas distintas. De um lado, **conhecimento**: a relação enunciada por quem a detém — na fala dos mais velhos, na demonstração ao pé da árvore, na língua originária, viva na memória das comunidades. De outro, **evidências** dessa relação: o que terceiros registraram sobre ela em artigos científicos, em acervos históricos e museológicos, e nas obras de naturalistas que visitaram o Brasil entre os séculos XVII e XIX. Os dois existem — mas estão dispersos em bibliotecas, museus e bases de dados isoladas, sem uma arquitetura comum que permita registrá-los, relacioná-los e compartilhá-los com o devido respeito à sua origem.

### A Motivação: Registrar e Compartilhar com Respeito Pleno ao C.A.R.E.

A Arquitetura BioCultural nasce da necessidade de **registrar e documentar a relação entre comunidades tradicionais e a biodiversidade**, proveniente de diferentes fontes. O objetivo é ofertar uma arquitetura que permita registrar e compartilhar esse acervo com respeito **pleno e absoluto** aos princípios **C.A.R.E.** (Collective Benefit, Authority to Control, Responsibility, Ethics) — independentemente de a fonte ser um artigo científico, um relato de campo, um item de acervo museológico ou a obra de um naturalista do século XVIII: se o registro descreve o conhecimento ou a prática de uma comunidade tradicional, essa comunidade mantém autoridade sobre como ele é registrado, usado e compartilhado.

### Quatro Fontes

| Tipo de Fonte | Descrição | Regime predominante | Ferramenta(s) |
|---|---|---|---|
| **Fontes primárias** | Registrado diretamente em campo, junto às comunidades (CLPI obrigatório) | **Conhecimento** | [BioCultRelatos](https://github.com/edalcin/BioCultRelatos) |
| **Fontes secundárias** | Artigos científicos publicados | Evidência | [BioCultDB](https://github.com/edalcin/BioCultDB) (inclui Extração por IA) |
| **Acervos históricos e museológicos** | Coleções, registros e documentos preservados em museus e arquivos históricos | Evidência | [BioCultAcervos](https://github.com/edalcin/BioCultAcervos) |
| **Obras de naturalistas** | Relatos e obras de naturalistas em visita ao Brasil nos séculos XVII, XVIII e XIX | Evidência | [BioCultNaturalistas](https://github.com/edalcin/BioCultNaturalistas) |

Cada fonte exige um processo de aquisição e curadoria diferente — mas todas convergem para o mesmo objetivo: um registro rastreável até sua origem e compartilhado sob os princípios C.A.R.E.

> **Regime é do registro, não da ferramenta.** A coluna acima indica o padrão de cada unidade. Na prática, BioCultDB, BioCultAcervos e BioCultNaturalistas são Evidência sempre; o único provedor com os dois regimes é o BioCultRelatos — a nota de campo em que o pesquisador registra o que observou é **Evidência**, porque é testemunho dele, não relato do detentor. Quando uma comunidade narra sobre um item de acervo, esse Relato vive na **unidade dela**, referenciando o item: conteúdo soberano nunca atravessa para a unidade de outro membro. O que distingue os dois regimes é *quem fala* — e o que a distinção decide é **quem pode classificar o acesso** do registro. Ver [ADR-015](docs/architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md) e o estudo em [`conhecimento/`](conhecimento/caracterizacao-do-conhecimento-tradicional.md).

### Imperativo Legal e Ético

Registrar esse acervo com respeito ao C.A.R.E. não é apenas um princípio — é uma obrigação legal:
- **Lei 13.123/2015** (Lei da Biodiversidade): exige consentimento e repartição de benefícios no acesso e uso de conhecimento tradicional associado
- **Protocolo de Nagoya**: exige rastreabilidade de origem e consentimento no acesso a conhecimento tradicional
- **CDB Art. 8(j)**: exige respeito, preservação e manutenção do conhecimento tradicional com aprovação e participação de seus detentores

### Iniciativas Complementares

Esta arquitetura não é a primeira a buscar sistematizar conhecimento tradicional associado à biodiversidade no Brasil. Iniciativas como o Projeto GEF "Entre-Ciências", a Rede de Conhecimentos sobre Sociobiodiversidade (RCS) e a modernização do SISGEN perseguem objetivos convergentes — ver seção "Iniciativas Governamentais e Institucionais Brasileiras" mais abaixo, ou os resumos completos em [docs/iniciativas/](docs/iniciativas/README.md). A Arquitetura BioCultural não busca substituí-las, e sim oferecer um modelo de arquitetura federada, soberano por design, que qualquer iniciativa pode adotar para registrar e compartilhar suas evidências com respeito ao C.A.R.E.

---

## Objetivos

- **Registrar** evidências da relação entre comunidades tradicionais e a biodiversidade, provenientes de fontes secundárias, primárias, acervos históricos/museológicos e obras de naturalistas
- **Documentar** a proveniência de cada evidência, com rastreabilidade completa até sua fonte original
- **Compartilhar** essas evidências com pesquisadores, comunidades e público geral, com respeito pleno e absoluto aos princípios C.A.R.E.
- **Federar** múltiplas ferramentas e fontes sob uma arquitetura comum, sem centralizar dados nem comprometer a soberania de nenhuma comunidade ou iniciativa

---

## Arquitetura do Sistema — Versão 3.5 (Federada)

A versão 3.5 mantém o sistema organizado como uma **federação de entidades soberanas**, conectadas pelo **Pluriverso**, acolhendo quatro tipos de fonte de evidência. Cada membro da federação mantém sua própria infraestrutura de dados — um único arquivo SQLite compartilhado entre suas ferramentas — e vocabulários. O Pluriverso coleta periodicamente os registros públicos de cada membro e os disponibiliza via API unificada. A v3.4 acrescentou a [camada de governança](governanca/propostaGovernanca.md) que define quem decide sobre cada uma dessas peças; a v3.5 absorve o **BioCultPapers** pelo **BioCultDB** ([ADR-011](docs/architecture-decisions/ADR-011-absorcao-biocultpapers.md)) — a extração de dados por IA deixa de ser aplicativo desktop separado e passa a ser a funcionalidade **Extração por IA**, nativa do contexto de Aquisição.

![Arquitetura BioCultural — versão 3.5, visão geral federada](docs/images/arquitetura-biocultural.png)

> **Leitura recomendada:** o artigo do blog [*Arquitetando — Biodiversidade, Dados e Metadados*](https://eduardo.dalc.in/arquitetando/) explica, de forma didática e ilustrada, toda esta arquitetura federada — as quatro fontes de evidência, a soberania via SQLite+JSON, o papel do Pluriverso e a aposta na repartição de benefícios rastreável.

### Princípios da Federação

- **Soberania total**: cada unidade controla seu próprio SQLite (arquivo), compartilhado entre suas ferramentas, e define o que é público
- **Harvest periódico**: Pluriverso coleta registros `visibility: public` via endpoint REST de cada membro — dado nunca é acessado sem publicação explícita
- **Harmonização semântica**: Pluriverso mantém mapeamentos SKOS-XL (`skos:exactMatch`, `skos:closeMatch`) entre os vocabulários de diferentes membros
- **Saída reversível**: membro que deixa a federação tem seus dados removidos imediatamente do índice central (purge by member)
- **Governança comunitária**: comitê com representantes de cada membro toma decisões sobre admissão, contrato de publicação e mapeamentos — detalhada na [Proposta de Governança](governanca/propostaGovernanca.md)

### Tipos de Membros da Federação

| Tipo | Componentes | Fonte de Dados |
|------|-------------|----------------|
| Iniciativa de Fontes Secundárias | BioCultDB (inclui Extração por IA) + BioCultTermos + SQLite+JSON (um por unidade, 1 container) | Literatura científica (artigos, PDFs) |
| Comunidade Tradicional | BioCultRelatos + BioCultTermos + SQLite+JSON (um por unidade, 1 container) | Registro primário direto (CLPI obrigatório) |
| Acervos Históricos e Museológicos | BioCultAcervos + BioCultTermos + SQLite+JSON (um por unidade, 1 container) | Coleções, registros e documentos de acervos e museus |
| Obras de Naturalistas (séc. XVII–XIX) | BioCultNaturalistas + BioCultTermos + SQLite+JSON (um por unidade, 1 container) | Relatos e obras de naturalistas em visita ao Brasil |

**Legenda:**
- Cada membro opera de forma completamente independente
- Membro expõe endpoint REST paginado para harvest pelo Pluriverso
- Linha `harvest REST` representa coleta periódica (não tempo real)

### Múltiplas Instâncias do Pluriverso

Uma **associação de comunidades tradicionais** que opera vários `BioCultRelatos` pode querer uma **instância
própria do Pluriverso** para federar/acessar apenas os dados das suas comunidades, sem depender do
Pluriverso público global. O ADR-009 generaliza o Pluriverso de singleton para **componente instanciável em
múltiplos escopos**:

- Cada instância = **1 container + 1 arquivo SQLite próprio** (ADR-008)
- **Membership e `member_id` escopados por instância** — sem registro global de identidade entre instâncias
- **Um mesmo membro pode ser coletado por várias instâncias** simultaneamente (harvest é só leitura pública)
- **Sem hierarquia** entre instâncias — cada uma tem seu próprio Comitê Federado
- **Harvest público agora**; harvest autenticado para registros `restricted` é extensão futura documentada,
  não implementada

![Pluriverso — múltiplas instâncias: associação com índice privado, índice público global, sem hierarquia](docs/images/pluriverso-multi-instancia.png)

Detalhes completos em [ADR-009](docs/architecture-decisions/ADR-009-pluriverso-multi-instance-topology.md);
engine de persistência de cada instância em [ADR-008](docs/architecture-decisions/ADR-008-pluriverso-database-engine.md).

## Projetos Implementados

Esta arquitetura possui implementações concretas que materializam os conceitos propostos:

### BioCultDB - Banco de Dados de Conhecimento Tradicional de Fontes Secundárias

[![GitHub](https://img.shields.io/badge/GitHub-BioCultDB-181717?logo=github)](https://github.com/edalcin/BioCultDB)

Interface web para gerenciamento de conhecimento tradicional secundário extraído de artigos científicos. Implementa os três contextos arquiteturais principais:

**Características:**

- **Três Interfaces Especializadas:**
  - **Aquisição** (porta 3001): Entrada de dados por pesquisadores
  - **Curadoria** (porta 3002): Validação e aprovação de registros
  - **Apresentação** (porta 3003): Consulta pública com busca avançada
- **Stack Tecnológico:** Node.js, Express, SQLite (JSON, better-sqlite3), HTMX, Alpine.js, Tailwind CSS
- **Estrutura de Dados:** Hierárquica (Referência → Comunidade → Planta → Uso)
- **Workflow C.A.R.E.:** Implementação de status (pendente/aprovado/rejeitado)
- **29 Classificações de Comunidades:** Conforme [Decreto nº 8.750, de 9 de maio 2016](https://www.planalto.gov.br/ccivil_03/_Ato2015-2018/2016/Decreto/D8750.htm)

#### etnoChat - Interface Conversacional com IA

Componente da camada de Apresentação que permite interação com o banco de dados através de linguagem natural.

**Funcionalidades:**
- Formulação de perguntas em linguagem natural sobre comunidades e plantas
- Sugestões automáticas de buscas e relacionamentos entre dados
- Explicações contextualizadas sobre registros etnobotânicos
- Integração com MCP (Model Context Protocol) para comunicação com modelos de IA

**Acesso:** Rota `/etnochat` na porta 3003

#### Painel Analítico - Dashboard Interativo

Componente da camada de Apresentação para exploração e análise visual dos dados etnobotânicos.

**Funcionalidades:**
- **Cartões Resumidos:** Total de comunidades, referências aprovadas, plantas únicas e autores
- **Visualizações Geográficas:** Mapas de calor com distribuição por estado
- **Gráficos Interativos:**
  - Evolução temporal de publicações (gráfico de área)
  - Top 10 plantas mais citadas (gráfico de barras)
- **Tabelas Analíticas:**
  - Autores mais produtivos
  - Comunidades com maior diversidade botânica
  - Referências mais abrangentes
- **Filtros Avançados:** Estado, tipo de comunidade e período de publicação

**Stack:** Google Charts, HTMX, Alpine.js, Tailwind CSS

**Acesso:** Rota `/painel` na porta 3003

#### Extração por IA - Aquisição via IA

Funcionalidade da camada de **Aquisição** do BioCultDB para extração automatizada de metadados de artigos científicos em PDF usando inteligência artificial. Absorve a funcionalidade antes oferecida pelo aplicativo desktop **BioCultPapers**, hoje congelado ([ADR-011](docs/architecture-decisions/ADR-011-absorcao-biocultpapers.md)).

**Funcionalidades:**
- Upload do PDF diretamente pelo navegador — o arquivo nunca sai do navegador do usuário
- Texto extraído do PDF é enviado ao provedor de IA configurado:
  - Google Gemini (15 req/min, gratuito)
  - OpenAI GPT
  - Anthropic Claude
- Resultado da extração vira uma **Evidência** com status "pendente", que entra no mesmo fluxo de Curadoria de qualquer outra evidência — sem entrega por arquivo, sem aplicativo separado
- **Dados Extraídos:**
  - Obrigatórios: Título, autores, ano, abstract
  - Opcionais: Espécies (nomes vernaculares e científicos), usos, comunidades, localização

**Acesso:** Rota de Aquisição (porta 3001)

### BioCultTermos - Plataforma de Gestão Terminológica

[![GitHub](https://img.shields.io/badge/GitHub-BioCultTermos-181717?logo=github)](https://github.com/edalcin/BioCultTermos)

Plataforma digital para preservação e organização do conhecimento etnobotânico através de um sistema estruturado de glossários, vocabulários controlados e tesauros, seguindo o padrão **[SKOS-XL](https://www.w3.org/TR/skos-reference/skos-xl.html)** (W3C Simple Knowledge Organization System eXtension for Labels). É o **módulo de vocabulário controlado da federação**, embutido via **git submodule** em cada unidade federada (BioCultDB, BioCultRelatos, BioCultAcervos, BioCultNaturalistas) — não é exclusivo de nenhuma delas. O repositório standalone está congelado como produto: toda evolução de código ocorre a partir das unidades hospedeiras (ver [ADR-007](docs/architecture-decisions/ADR-007-shared-bioculttermos-module.md)).

**Propósito:**

Documentar termos e conhecimentos de comunidades tradicionais brasileiras sobre plantas e animais, garantindo reconhecimento cultural, padronização terminológica e justiça na distribuição de benefícios. O padrão SKOS-XL viabiliza interoperabilidade com padrões de dados abertos (Linked Data, RDF) e integração com iniciativas como GBIF, SiBBr e Wikidata.

Os rótulos SKOS-XL que a arquitetura propõe e usa — tipos (`prefLabel`/`altLabel`/`hiddenLabel`),
metadados (idioma ISO 639-3, `accessLevel` CARE, proveniência), regras e exemplos de estudos de
caso reais — estão consolidados na referência central
**[docs/rotulos-skos-xl.md](docs/rotulos-skos-xl.md)**.

**Características:**

- **Gestão de Conceitos (SKOS-XL):**
  - Criação com identificadores únicos (URIs) e suporte multilíngue
  - Rótulos preferenciais e alternativos (`skosxl:prefLabel` / `skosxl:altLabel`)
  - Relações hierárquicas (`skos:broader` / `skos:narrower`)
  - Relações associativas (`skos:related`)
  - Desambiguação de termos idênticos
  - Polihierarquia (múltiplos conceitos mais amplos)

- **Sistema de Notas (SKOS):**
  - Notas de escopo (`skos:scopeNote`) e definições (`skos:definition`)
  - Notas históricas (`skos:historyNote`) e editoriais (`skos:editorialNote`)
  - Exemplos de uso (`skos:example`)

- **Gestão de Fontes:**
  - Rastreabilidade de origens (bibliográficas, conhecimento tradicional)
  - Conformidade com princípios CARE para governança de dados indígenas

- **Recursos Técnicos:**
  - **Exportação:** SKOS-XL/RDF, JSON-LD, Dublin Core, CSV
  - **APIs:** REST para integração com a ferramenta principal de cada unidade hospedeira e sistemas externos
  - **Containerização:** Docker com GitHub Actions

**Integração na Arquitetura:**

O BioCultTermos funciona como **infraestrutura terminológica** embutida via git submodule em cada uma das quatro unidades federadas — um único repositório de código, consumido de forma independente por cada unidade, que mantém soberania total sobre seus próprios dados (arquivo SQLite/`ConceptScheme` nunca compartilhado entre unidades). Detalhes do mecanismo de distribuição e propagação de código entre unidades em [ADR-007](docs/architecture-decisions/ADR-007-shared-bioculttermos-module.md).

Nos três contextos de cada ferramenta principal:

1. **Aquisição:** Fornece vocabulários controlados (SKOS-XL) para padronização na entrada de dados, autocomplete de termos validados
2. **Curadoria:** Oferece base para validação semântica, normalização de nomenclatura vernacular e desambiguação de termos
3. **Apresentação:** Permite navegação por tesauros estruturados e busca expandida por sinônimos e termos relacionados

**Status por unidade hospedeira:** BioCultDB — implementado, em produção; BioCultRelatos, BioCultAcervos, BioCultNaturalistas — padrão definido e documentado (`docs/decisions/ADR-001-integracao-bioculttermos.md` + `integracao.md` de cada repositório), implementação pendente.

### BioCultRelatos - Plataforma de Registros de Conhecimento Tradicional Primário

[![GitHub](https://img.shields.io/badge/GitHub-BioCultRelatos-181717?logo=github)](https://github.com/edalcin/BioCultRelatos)

Plataforma para aquisição, registro e gestão de dados de conhecimento tradicional associado à biodiversidade provenientes de **fontes primárias** — registrado diretamente junto às comunidades tradicionais. Complementa o **BioCultDB**, que é dedicado a fontes secundárias (artigos científicos, livros).

**Diferença fundamental em relação ao BioCultDB:**

| | BioCultDB | BioCultRelatos |
|---|---|---|
| **Fonte** | Secundária (artigos, livros) | Primária (comunidades, campo) |
| **Origem dos dados** | Literatura científica | Registro direto com detentores |
| **Consentimento** | Não aplicável | CLPI obrigatório |
| **Curadoria** | Validação bibliográfica | Validação comunitária |

**Propósito:**

Registrar diretamente o conhecimento tradicional sobre biodiversidade das comunidades tradicionais brasileiras, com todos os protocolos éticos e legais requeridos (Consentimento Livre, Prévio e Informado — CLPI, conforme Lei 13.123/2015). Este projeto está em fase inicial de desenvolvimento.

**Integração na Arquitetura:**

Na arquitetura federada, o BioCultRelatos é o componente central de uma **Comunidade Tradicional** membro da federação. Cada comunidade opera sua própria instância do BioCultRelatos com seu próprio SQLite soberano (compartilhado com o BioCultTermos da comunidade). O BioCultTermos da comunidade fornece suporte terminológico local. Os dados marcados como `visibility: public` (após CLPI) são coletados periodicamente pelo Pluriverso via endpoint REST.

### BioCultAcervos - Registro de Evidências em Acervos Históricos e Museológicos

[![GitHub](https://img.shields.io/badge/GitHub-BioCultAcervos-181717?logo=github)](https://github.com/edalcin/BioCultAcervos)

Plataforma dedicada ao registro de evidências da relação entre comunidades tradicionais e a biodiversidade preservadas em **acervos históricos e museológicos** — coleções, registros e documentos que atestam essa relação ao longo do tempo, complementando as fontes secundárias (artigos) e primárias (campo).

**Propósito:**

Sistematizar e tornar rastreável o conhecimento tradicional associado à biodiversidade documentado em acervos de museus, arquivos e coleções históricas, com o mesmo rigor de proveniência e respeito aos princípios C.A.R.E. aplicado às demais fontes da arquitetura.

**Integração na Arquitetura:**

Na arquitetura federada, o BioCultAcervos é o componente central de um novo tipo de membro — **Acervos Históricos e Museológicos** — seguindo o mesmo padrão dos demais membros: container próprio, arquivo SQLite+JSON compartilhado com uma instância soberana do BioCultTermos, e endpoint de harvest REST para o Pluriverso. **Projeto em fase inicial (apenas repositório e documentação).**

### BioCultNaturalistas - Registro de Evidências em Obras de Naturalistas (séc. XVII-XIX)

[![GitHub](https://img.shields.io/badge/GitHub-BioCultNaturalistas-181717?logo=github)](https://github.com/edalcin/BioCultNaturalistas)

Plataforma dedicada ao registro de evidências da relação entre comunidades tradicionais e a biodiversidade presentes em **obras e relatórios de naturalistas** que visitaram o Brasil nos séculos XVII, XVIII e XIX — uma fonte histórica rica e ainda pouco sistematizada sobre o conhecimento tradicional da época.

**Propósito:**

Extrair e sistematizar evidências de conhecimento tradicional associado à biodiversidade registradas em obras históricas de naturalistas, preservando a rastreabilidade até a obra original e respeitando os princípios C.A.R.E. na forma como esse conhecimento histórico é atribuído e compartilhado.

**Integração na Arquitetura:**

Projeto com **planejamento de implementação completo**: modelo de dados (cinco entidades — Naturalista, Viagem, Obra, Táxon, Evidência), contextos e portas, contrato de vocabulário com o BioCultTermos e roadmap de 7 fases já documentados e aceitos (ver [BioCultNaturalistas/README.md](https://github.com/edalcin/BioCultNaturalistas)). **Implementação de código ainda não iniciada.**

### Pluriverso - Middleware de Federação

[![GitHub](https://img.shields.io/badge/GitHub-pluriverso-181717?logo=github)](https://github.com/edalcin/pluriverso)

Middleware que conecta todos os membros da federação — sem gerenciar seus dados. Implementa o harvest periódico via REST, mantém o índice central dos registros públicos e a camada de mapeamento semântico SKOS-XL entre os vocabulários de diferentes membros, expondo uma API pública unificada para pesquisadores e aplicações.

**Responsabilidades:**

- **Harvest periódico**: coleta registros `visibility: public` de cada membro via endpoint REST paginado
- **Índice central**: cópia derivada dos dados públicos (SQLite+JSON + FTS5), nunca a fonte de verdade
- **Mapeamento semântico**: `skos:exactMatch`/`skos:closeMatch`/`skos:broadMatch` entre `ConceptScheme`s de membros diferentes
- **API pública unificada**: busca textual e semântica, filtros por membro/fonte/comunidade/espécie/região, atribuição de origem (`member_id`)
- **Governança**: suporta o Comitê Federado nas decisões sobre admissão, contrato de publicação e mapeamentos

**Integração na Arquitetura:**

Na arquitetura federada, o Pluriverso é o único componente com visão de todos os membros do seu próprio escopo — mas nunca acessa dados além do que cada membro publica explicitamente. A engine de persistência é SQLite embutida (índice SQLite+JSON+FTS5, arquivo único via `SQLITE_DB_PATH`, [ADR-008](docs/architecture-decisions/ADR-008-pluriverso-database-engine.md)), e o Pluriverso pode ser instanciado em múltiplos escopos ([ADR-009](docs/architecture-decisions/ADR-009-pluriverso-multi-instance-topology.md)). Projeto com **planejamento de implementação completo**: stack e framework, API pública REST, contrato de harvest, modelo de dados SQLite, autenticação e segurança do Comitê, busca semântica SKOS, arquitetura C4 e roadmap de 7 fases já documentados e aceitos (ver [pluriverso/docs/](https://github.com/edalcin/pluriverso/tree/main/docs)). **Implementação de código ainda não iniciada.**

### Integração Federada entre Projetos

![Integração federada entre projetos: unidades federadas com SQLite+JSON próprio, harvest REST e Pluriverso](docs/images/integracao-federada.png)

O fluxo federado funciona assim:

1. **BioCultDB** (Aquisição/Curadoria/Apresentação) gerencia dados secundários — inclui Extração por IA de PDFs pelo navegador ([ADR-011](docs/architecture-decisions/ADR-011-absorcao-biocultpapers.md)); publica registros aprovados no endpoint de harvest
2. **BioCultRelatos** registra conhecimento primário diretamente de comunidades (CLPI obrigatório); publica registros consentidos no endpoint de harvest
3. **BioCultTermos** (instância por membro) fornece vocabulários SKOS-XL soberanos; Pluriverso mantém mapeamentos entre instâncias
4. **Pluriverso** coleta periodicamente via REST, indexa registros públicos e disponibiliza via API unificada
5. Usuário acessa o conjunto federado de CTAs pelo Pluriverso sem interagir diretamente com cada membro

> Acervos históricos/museológicos (BioCultAcervos) e obras de naturalistas (BioCultNaturalistas) seguirão o mesmo padrão de publicação e harvest, uma vez implementados — ver "Projetos Implementados" acima.

---

## Metodologia e Tecnologias

A documentação arquitetural segue o **[C4 Model](https://c4model.com/)** (Context, Container, Component, Code), e a camada de persistência adota bancos orientados a documentos (SQLite+JSON). Detalhes completos — níveis do C4 Model, contextos de Aquisição/Curadoria/Apresentação, comparação de abordagens de banco de dados e integrações externas potenciais — estão em **[docs/metodologia-e-tecnologias.md](docs/metodologia-e-tecnologias.md)**.

## Princípios Orientadores

### C.A.R.E. Principles

- **Collective Benefit**: Os dados devem beneficiar as comunidades que os originaram
- **Authority to Control**: Comunidades mantêm autoridade sobre seus conhecimentos
- **Responsibility**: Responsabilidade ética no manejo dos dados
- **Ethics**: Respeito às práticas éticas e culturais

### Legislação

O sistema respeita:
- Lei da Biodiversidade (Lei 13.123/2015)
- Protocolo de Nagoya
- Legislações locais sobre conhecimento tradicional

## Estrutura da Documentação

Este repositório está organizado da seguinte forma:

```
Arquitetura-BioCultural/
├── README.md (este arquivo)
├── CONTEXT.md                          ← glossário da federação
├── conhecimento/
│   └── caracterizacao-do-conhecimento-tradicional.md   ← Conhecimento × Evidência
├── governanca/
│   ├── propostaGovernanca.md          ← documento principal de governança
│   ├── planoPropostaGovernanca.md
│   ├── governanca-tres-camadas.svg/.png
│   ├── governanca-camadas-acesso.svg/.png
│   ├── governanca-ciclo-clpi.svg/.png
│   └── governanca-reparticao.svg/.png
└── docs/
    ├── metodologia-e-tecnologias.md
    ├── contrato-harvest.md
    ├── rotulos-skos-xl.md          ← referência central dos rótulos SKOS-XL
    ├── modelo-de-dados-unificado.md← UDM — objeto do acordo JBRJ ↔ USEFLORA
    ├── PrincipiosCAREnaPratica.md
    ├── v3.1-migration-progress.md
    ├── architecture-decisions/     ← ADR-001 … ADR-015
    ├── c4-model/                   ← diagramas C4: contexto, containers, componentes
    ├── diagrams/                   ← fontes .excalidraw + exports + notas de integração
    ├── images/                     ← diagramas da arquitetura (.png/.svg) + legacy/ + blog/ + etno/
    ├── agents/                     ← convenções para agentes de codificação
    ├── apresentacoes/              ← slides
    └── iniciativas/                ← iniciativas governamentais/institucionais correlatas
```

### Navegação da Documentação

1. **[Proposta de Governança](governanca/propostaGovernanca.md)** — **documento principal da v3.4**: governança dos dados, das ferramentas e da arquitetura — princípios C.A.R.E., marco legal, salvaguardas contra o mau uso, CLPI como processo, rotulagem cultural, repartição rastreável, matriz de decisão e lacunas abertas
2. **[Diagrama de Contexto](docs/c4-model/01-context-diagram.md)** - Visão de alto nível do sistema e seus usuários
3. **[Diagrama de Containers](docs/c4-model/02-container-diagram.md)** - Componentes principais e suas tecnologias
4. **[Diagrama de Componentes](docs/c4-model/03-component-diagram.md)** - Detalhamento interno de cada contexto
5. **[Decisões Arquiteturais](docs/architecture-decisions/)** - ADRs documentando escolhas técnicas
6. **[Metodologia e Tecnologias](docs/metodologia-e-tecnologias.md)** - C4 Model, contextos de Aquisição/Curadoria/Apresentação e tecnologias avaliadas
7. **[Plano de elaboração da proposta de governança](governanca/planoPropostaGovernanca.md)** - Registro do planejamento, fontes e critérios de verificação que originaram o documento de governança
8. **[Caracterização do Conhecimento Tradicional](conhecimento/caracterizacao-do-conhecimento-tradicional.md)** — estudo que distingue **Conhecimento** (a relação enunciada por quem a detém) de **Evidência** (a atestação por terceiros de que ela existe), e as consequências para a rotulagem SKOS-XL de nível de acesso; base do [ADR-015](docs/architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md)
9. **[Contrato de Harvest](docs/contrato-harvest.md)** — o payload da federação campo a campo: `regime`, nível efetivo de acesso, supressão declarada (`informationWithheld` / `dataGeneralizations`), rótulos culturais e vínculo entre registros de membros distintos. Decorre de K6 do [ADR-015](docs/architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md) e supersede o payload do ADR-004 D6
10. **[Rótulos SKOS-XL — Referência Central](docs/rotulos-skos-xl.md)** — todos os rótulos SKOS-XL que a arquitetura suporta, com descrição, regras e exemplos das curadorias reais (campanha "Tipos de Usos de Plantas"); normativo para as quatro unidades federadas e o Pluriverso
11. **[ADR-017 — Composição Multi-Espécie](docs/architecture-decisions/ADR-017-composicao-multiespecie.md)** — a demanda de que usos, preparos e artefatos compostos por mais de uma planta (o Daime: jagube *Banisteriopsis caapi* + rainha *Psychotria viridis*) sejam representáveis em todas as ferramentas, com papel por componente e classificação de acesso sobre a combinação
12. **[Modelo de Dados Unificado (UDM)](docs/modelo-de-dados-unificado.md)** — o contrato lógico de dados de toda a arquitetura num documento único: princípios, entidades, documento canônico JSON, obrigatoriedade de campos, interoperabilidade (Darwin Core/DwC-DP, SKOS-XL) e checklist de conformidade; **objeto do acordo de cooperação técnica entre o JBRJ e o USEFLORA**



---

## Integração com Referências e Iniciativas

### Arquitetura Inspirada em NIKMAS

A proposta de arquitetura incorpora lições aprendidas do projeto **NIKMAS (National Indigenous Knowledge Management System)** da África do Sul, especialmente:

- **Modelo de Dados Dual**: Preservação simultânea de artefatos originais (gravações audiovisuais, fotos) e estruturas de metadados formais para proteção legal
- **Arquitetura Distribuída**: Nó central com Pontos de Presença (PoPs) regionais para captura descentralizada e sincronização seletiva respeitando confidencialidade
- **Segurança Multi-Camadas**: Controle de acesso baseado em políticas (XACML) para proteção de conhecimento sensível
- **Catálogo de Detentores**: Base de dados de indivíduos e comunidades detentores de conhecimento com rastreamento de proveniência
- **Curadoria Estruturada**: Interface dedicada para especialistas validarem e anotarem dados

### Acesso via Comunicações Móveis

Reconhecendo que muitas comunidades tradicionais em áreas remotas têm acesso móvel limitado mas penetrante, a arquitetura prevê:

- **Aplicações Mobile Offline-First**: Captura de dados sem necessidade de conexão permanente
- **Integração SMS/USSD**: Acesso a informações via mensagens de texto para regiões com infraestrutura móvel limitada
- **WhatsApp Integration**: Suporte a plataforma popular para comunicação e consultas
- **Apps Comunitárias**: Desenvolvimento de aplicativos customizados para diferentes contextos culturais

Esta abordagem segue exemplos bem-sucedidos como **CyberTracker** e **MAPEO**, que demonstram o potencial de tecnologias móveis para empoderamento comunitário em monitoramento participativo.

### Validação e Certificação de Dados

O sistema implementa um **workflow robusto de validação** em múltiplas etapas:

1. **Validação Estrutural**: Verificação automática de conformidade com padrões de dados 
2. **Validação Taxonômica**: Integração com bases brasileiras (Flora e Funga para flora/fungos, Fauna para fauna) com fallback para GBIF API quando não encontrado nas bases brasileiras
3. **Validação Semântica**: Integração com vocabulários existentes
4. **Curadoria Especializada**: Revisão por especialistas de domínio (botânicos, etnobólogos, farmacêuticos tradicionais)
5. **Validação Comunitária**: Participação de detentores de conhecimento na certificação de dados antes de publicação
6. **Rastreabilidade Completa**: Logs de auditoria de todas as mudanças e validações

### Aquisição de Dados Primários

Para coleta ética e consentida de dados diretamente das comunidades:

- **Processo CLPI (Consentimento Livre, Prévio e Informado)**: Implementação de protocolo completo baseado em Lei 13.123/2015
- **Registro Comunitário**: Interface para comunidades registrarem autonomamente seu próprio conhecimento
- **Acordos Eletrônicos**: Armazenamento e rastreamento de acordos de compartilhamento de benefícios
- **Documentação Audiovisual**: Suporte a preservação de conhecimento em múltiplas formas (áudio, vídeo, foto, texto)

### Integração com Plataforma de Territórios Tradicionais do MPF

A arquitetura está projetada para **integração bidirecional** com a [Plataforma de Territórios Tradicionais](https://territoriostradicionais.mpf.mp.br/) do Ministério Público Federal:

- **Sincronização de Polígonos Territoriais**: Importação automática de limites geográficos de territórios indígenas e tradicionais
- **Cruzamento Espacial**: Associação de registros de conhecimento com territórios de origem
- **Rastreabilidade Geográfica**: Visualização interativa de onde conhecimentos são praticados
- **Dados Públicos do MPF**: Acesso a informações sobre status de demarcação, conflitos e historicamente de ocupação
- **API de Integração**: Endpoints REST para consulta e sincronização de dados territoriais

Esta integração fortalece:
- Rastreabilidade de conhecimento até sua origem territorial
- Suporte a processos de demarcação e regularização
- Monitoramento de ameaças a territórios que guardam conhecimento tradicional
- Conformidade com Lei 13.123/2015 sobre proveniência geográfica

### Padrões de Dados Abertos

A arquitetura adota e contribui para padrões de dados abertos reconhecidos:

- **Darwin Core**: Para ocorrências de espécies e dados de biodiversidade
- **Dublin Core Estendido**: Para metadados ricos e flexíveis
- **SocioBio Standard**: Padrão específico para dados de sociobiodiversidade brasileira (ver [projeto SocioBio no GitHub](https://github.com/sibbr/sociobio))

### Interoperabilidade com Sistemas Nacionais

Integração planejada com principais sistemas brasileiros:

- **SiBBr** (Sistema de Informação sobre Biodiversidade Brasileira): Nó brasileiro do GBIF
- **SisGen** (Sistema Nacional de Gestão do Patrimônio Genético): Rastreamento de acesso e repartição de benefícios
- **CNPq**: Integração com dados de pesquisadores e grupos de pesquisa
- **GBIF Global**: Contribuição de dados brasileiros para rede global de biodiversidade

---

## Iniciativas Relacionadas e Complementares

Esta arquitetura integra projetos implementados e dialoga com iniciativas em desenvolvimento:

### Projetos da Arquitetura (Implementados)
- **[BioCultDB](https://github.com/edalcin/BioCultDB)** - Interface web com três contextos (Aquisição, Curadoria, Apresentação) para conhecimento tradicional de fontes secundárias, incluindo Extração por IA de PDFs ([ADR-011](docs/architecture-decisions/ADR-011-absorcao-biocultpapers.md)); membro de referência da federação
- **[BioCultTermos](https://github.com/edalcin/BioCultTermos)** - Infraestrutura terminológica SKOS-XL; cada membro da federação opera sua própria instância soberana

### Projetos em Desenvolvimento
- **[BioCultRelatos](https://github.com/edalcin/BioCultRelatos)** - Plataforma para aquisição de dados primários (CLPI) diretamente de comunidades tradicionais; componente central de cada comunidade membro
- **[BioCultAcervos](https://github.com/edalcin/BioCultAcervos)** - Registro de evidências de conhecimento tradicional preservadas em acervos históricos e museológicos; novo tipo de membro da federação
- **[BioCultNaturalistas](https://github.com/edalcin/BioCultNaturalistas)** - Registro de evidências de conhecimento tradicional em obras de naturalistas em visita ao Brasil (séc. XVII-XIX); novo tipo de membro da federação; planejamento de implementação completo (modelo de dados, contextos e roadmap documentados)
- **[Pluriverso](https://github.com/edalcin/pluriverso)** - Middleware de federação; harvest periódico, índice central, mapeamentos semânticos SKOS e API pública unificada; planejamento de implementação completo (stack, API, modelo de dados, C4 e roadmap documentados)

### Iniciativas Governamentais e Institucionais Brasileiras (Complementares)

O Brasil possui outras iniciativas de peso dedicadas à sistematização de conhecimento tradicional associado à biodiversidade — não concorrentes, e sim parte do mesmo esforço nacional:
- **[Projeto GEF "Entre-Ciências"](https://www.thegef.org/projects-operations/projects/11269)** (2025-2029, MCTI) — fortalecimento de PIPCTAFs para gestão de dados de sociobiodiversidade via SiBBr
- **Rede de Conhecimentos sobre Sociobiodiversidade (RCS)** (ICMBio/CNPT + UFSC) — integração de bases dispersas com protocolos comunitários e CLPI
- **Modernização do SISGEN** (RNP-MMA-BID) — interoperabilidade do patrimônio genético e CTA via IPT, com padrões FAIR e CARE

Resumos completos de cada iniciativa em [docs/iniciativas/](docs/iniciativas/README.md). A Arquitetura BioCultural não busca substituir essas iniciativas, e sim oferecer um modelo de arquitetura federada, soberano por design, que pode inspirar ou ser adotado por qualquer uma delas.

### Dados da Sociobiodiversidade
- **[Useflora](https://github.com/nperoni/Useflora)** - Banco de dados etnobotânicos com registro comunitário onde comunidades definem níveis de acesso

### Padrões de Dados
- **[SocioBio](https://github.com/sibbr/sociobio)** - Padrão de dados para sociobiodiversidade brasileira, desenvolvido pelo SiBBr
- **[CESP SiBBr 2024](https://github.com/sibbr/cesp-sibbr-2024)** - Iniciativa de ciência aberta e interoperabilidade do Sistema de Informação sobre Biodiversidade Brasileira

### Vocabulários e Terminologia
- **[EtnoVocab](https://github.com/edalcin/etnovocab)** - Vocabulário controlado para termos etnobotânicos e etnobiológicos
- **[EtnoVector](https://github.com/edalcin/etnovector)** - Vetorização e representação semântica de conceitos etnobotânicos

### Estruturas de Dados e Documentação
- **[Estrutura de Dados Etnobotânicos](https://github.com/edalcin/Estrutura-de-Dados-Etnobotanicos)** - Modelos e esquemas para armazenamento de informações etnobotânicas

Estes projetos complementares fornecem:
- Implementações concretas da arquitetura (BioCultDB)
- Padrões de dados interoperáveis
- Vocabulários controlados para melhorar a qualidade dos dados
- Exemplos práticos de implementação
- Recursos para curadoria e validação de informações etnobotânicas

---

## Referências

Para a lista completa de referências bibliográficas organizadas segundo a norma **ABNT NBR 6023:2018** (padrão brasileiro), consulte [Referencias.md](Referencias.md).

Essa documentação incorpora referências a:
- Legislação brasileira e internacional relevante (Lei 13.123/2015, Protocolo de Nagoia, Convenção 169 OIT)
- Padrões de dados abertos (Darwin Core, Plinian Core, Dublin Core, SocioBio)
- Arquitetura de sistemas (NIKMAS, Fedora, OAIS)
- Governança de dados (FAIR, CARE)
- Tecnologias móveis (CyberTracker, MAPEO)
- Etnobiologia e conhecimento tradicional
- Iniciativas brasileiras práticas (GEF Entre-Ciências, SISGEN, Useflor@, RCS)
- Data sovereignty e consentimento livre, prévio e informado (CLPI)

### Artigos e Publicações Relacionadas (APA)

Dalcin, E. (2024, 2 de junho). Preservação do conhecimento tradicional sobre o uso das plantas – pensando "fora da caixinha". *Biodiversidade, Dados e Metadados*. https://eduardo.dalc.in/conhecimento-tradicional/

Dalcin, E. (2025, 28 de janeiro). Negligenciando a preservação do conhecimento tradicional. *Biodiversidade, Dados e Metadados*. https://eduardo.dalc.in/negligenciando-a-preservacao-do-conhecimento-tradicional/

Dalcin, E. (2025, 24 de fevereiro). A planta e a espécie. *Biodiversidade, Dados e Metadados*. https://eduardo.dalc.in/a-planta-e-a-especie/

Dalcin, E. (2025, 25 de dezembro). Modelo para dados secundários de conhecimento tradicional – o dilema entre a elegância e a praticidade. *Biodiversidade, Dados e Metadados*. https://eduardo.dalc.in/modelo-para-dados-secundarios/

Dalcin, E. (2026, 5 de julho). Sementes livres, solos próprios: por que o conhecimento tradicional exige uma arquitetura federada. *Biodiversidade, Dados e Metadados*. https://eduardo.dalc.in/por-que-o-conhecimento-tradicional-exige-uma-arquitetura-federada/

Dalcin, E. (2026, 29 de julho). Arquitetando: biodiversidade, dados e metadados. *Biodiversidade, Dados e Metadados*. https://eduardo.dalc.in/arquitetando/

Pankararu, C. J., Teixidor-Toneu, I., Odonne, G., Asante, F., Bandeira, S. O., Barrera-Bello, Á. M., Benitez-Capistros, F. J., Dahdouh-Guebas, F., Dalcin, E., Dennehy-Carr, Z. H., Diallo, K., Drouet-Cruz, H. T., Fonseca-Kruel, V. S., Gallois, S., Gnansounou, S. C., Hamza, A. J., Hugé, J., Jordan, F. M., Kalle, R., ... Hanazaki, N. (2026). A global biodiversity use data infrastructure acknowledging indigenous and local knowledge. *npj Biodiversity*, *5*, Article 7. https://doi.org/10.1038/s44185-026-00121-0

Zank, S., Julião, C. G., de Lima, A. S., da Silva, M. T., Levis, C., Hanazaki, N., & Peroni, N. (2025). Ethnobiology! Until when will the colonialist legacy be reinforced? *Journal of Ethnobiology and Ethnomedicine*, *21*, Article 1. https://doi.org/10.1186/s13002-024-00750-4

---

## Histórico de Versões

Para acompanhar a evolução completa desta arquitetura, consulte o [CHANGELOG.md](CHANGELOG.md) que documenta todas as versões e mudanças significativas desde a versão 1.0.0 inicial até a versão 3.5.0 (absorção do BioCultPapers pelo BioCultDB, sobre a base federada com governança proposta, Pluriverso instanciável e persistência SQLite+JSON por unidade).

---

## Citação

Se você usar esta proposta de arquitetura em seu trabalho, por favor cite como:

**APA:**
```
Dalcin, E. (2026). Arquitetura para um Sistema de Informações sobre Conhecimento Tradicional Associado à Biodiversidade - Versão 3.4 (Version v3.4) [Software documentation]. Zenodo. https://doi.org/10.5281/zenodo.21738427
```

**BibTeX:**
```bibtex
@software{dalcin2026,
  author = {Dalcin, Eduardo},
  title = {Arquitetura para um Sistema de Informações sobre Conhecimento Tradicional Associado à Biodiversidade - Versão 3.4},
  version = {v3.4},
  year = {2026},
  publisher = {Zenodo},
  doi = {10.5281/zenodo.21738427},
  url = {https://doi.org/10.5281/zenodo.21738427}
}
```

**DOI:** [10.5281/zenodo.21738427](https://doi.org/10.5281/zenodo.21738427)

---

## Contribuindo

Este é um projeto em fase de proposta. Contribuições e sugestões são bem-vindas através de issues e pull requests.

## Licença

A definir — considerando licenças que respeitem os princípios C.A.R.E. e protejam adequadamente o conhecimento tradicional. A [Proposta de Governança, §6.4](governanca/propostaGovernanca.md#64-licenciamento-de-código-dados-e-conteúdo) apresenta uma proposta concreta para fechar esta lacuna: **código** em licença permissiva OSI, **documentação** em CC BY 4.0 e **dados de CTA fora de licença aberta** — regidos por consentimento com escopo, prazo e revogação, porque licença aberta é irrevogável e o CLPI não pode ser.

## Contato

Para mais informações sobre este projeto, entre em contato através das issues deste repositório.

---

## Agradecimentos

A formulação desta proposta técnica e a consolidação de sua visão ética e conceitual não seriam possíveis sem os diálogos, provocações e insights preciosos de parceiros fundamentais. Registro meu profundo agradecimento à Viviane Fonseca, do Jardim Botânico do Rio de Janeiro (JBRJ); ao Lucas Zelesco, da Fundação Nacional dos Povos Indígenas (FUNAI); A Luisa Ridolph e Camila Dantas. alunas da pós-graduação da ENBT/JBRJ; e aos membros do Comitê Gestor Useflora, cuja dedicação à salvaguarda da sociobiodiversidade e ao respeito às comunidades tradicionais inspirou cada linha de código e de arquitetura deste projeto.
