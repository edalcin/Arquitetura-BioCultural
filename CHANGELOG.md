# Histórico de Versões - Arquitetura do Sistema de Conhecimento Tradicional

Todas as mudanças significativas nesta proposta de arquitetura serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/), e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

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
