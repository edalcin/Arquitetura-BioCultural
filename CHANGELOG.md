# Histórico de Versões - Arquitetura do Sistema de Conhecimento Tradicional

Todas as mudanças significativas nesta proposta de arquitetura serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/), e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/).

---

## [1.2.0] - 2025-12-28

### Adicionado

- **etnoDB** como container implementado na arquitetura
  - Interface web com três contextos distintos (Aquisição, Curadoria, Apresentação)
  - Tecnologias: Node.js, Express, MongoDB, HTMX, Alpine.js, Tailwind CSS
  - Banco de dados para conhecimento tradicional secundário (artigos científicos)
  - Implementação concreta dos princípios C.A.R.E.
  - Portas: 3001 (Aquisição), 3002 (Curadoria), 3003 (Apresentação)

- **etnopapers** como container implementado na arquitetura
  - Aplicativo desktop Windows (.NET 8, WPF, MVVM)
  - Extração automatizada de metadados de PDFs usando IA
  - Integração com múltiplos provedores de IA (Google Gemini, OpenAI GPT-4o-mini, Anthropic Claude 3.5 Haiku)
  - Integração nativa com MongoDB (Atlas ou local)
  - Processamento de campos obrigatórios (título, autores, ano, abstract) e opcionais (espécies, usos, comunidades)

- Histórico de versões (este arquivo CHANGELOG.md) documentando toda evolução da arquitetura

### Modificado

- **Diagrama de Containers** atualizado para incluir etnoDB e etnopapers como elementos concretos
- **Diagrama de Contexto** refinado para refletir a integração dos novos containers
- **README.md** atualizado para versão 1.2 com referências aos projetos implementados
- Documentação de integração entre containers no contexto de Aquisição

### Contexto da Versão

Esta versão marca a transição de uma arquitetura puramente conceitual para uma arquitetura com implementações concretas. Os projetos etnoDB e etnopapers representam a materialização dos conceitos de aquisição e curadoria de dados etnobotânicos, validando as decisões arquiteturais anteriores e fornecendo casos de uso reais.

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

- [1.2.0] - 2025-12-28 (versão atual)
- [1.1.0] - 2025-01-06
- [1.0.0] - 2025-01-05 (versão inicial publicada no Zenodo: https://doi.org/10.5281/zenodo.17714765)
