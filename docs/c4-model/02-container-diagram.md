# C4 Model - Level 2: Diagrama de Containers

## Visão Geral

O Diagrama de Containers detalha os componentes técnicos que compõem o Sistema de Conhecimento Tradicional. Cada container representa uma aplicação ou serviço que executa de forma independente.

**Versão 1.2** - Atualizado com containers implementados: etnoDB e etnopapers

## Diagrama de Arquitetura

```mermaid
graph TB
    subgraph "Usuários"
        U1[Pesquisadores/<br/>Curadores]
        U2[Comunidades]
        U3[Público/<br/>Desenvolvedores]
    end

    subgraph "Frontend Layer"
        WEB[Web Application<br/>React/Vue.js<br/>Interface Responsiva]
        PORTAL[Portal Público<br/>Next.js/SSR<br/>SEO Otimizado]
    end

    subgraph "API Gateway Layer"
        GATEWAY[API Gateway<br/>Kong/AWS API Gateway<br/>Auth, Rate Limit, Routing]
    end

    subgraph "Containers Implementados"
        ETNODB_ACQ[etnoDB - Aquisição<br/>Node.js/Express/HTMX<br/>Porta 3001<br/>✓ IMPLEMENTADO]
        ETNODB_CUR[etnoDB - Curadoria<br/>Node.js/Express/HTMX<br/>Porta 3002<br/>✓ IMPLEMENTADO]
        ETNODB_PUB[etnoDB - Apresentação<br/>Node.js/Express/HTMX<br/>Porta 3003<br/>✓ IMPLEMENTADO]
        ETNOPAPERS[etnopapers<br/>.NET 8/WPF<br/>Desktop Windows<br/>✓ IMPLEMENTADO]
    end

    subgraph "Contexto: Aquisição"
        ACQ_API[Acquisition API<br/>Node.js/Express<br/>Ingestão de Dados]
        CRAWLER[Web Crawler Service<br/>Python/Scrapy<br/>Coleta Automática]
        ETL[ETL Service<br/>Apache Airflow<br/>Transformação de Dados]
        QUEUE[Message Queue<br/>RabbitMQ/Kafka<br/>Processamento Assíncrono]
    end

    subgraph "Contexto: Curadoria"
        CUR_API[Curation API<br/>Node.js/Express<br/>Workflow de Validação]
        VAL[Validation Service<br/>Python<br/>Validação Taxonômica]
        TERR_VAL[Territory & Authority Service<br/>Python<br/>Validação Territorial e de Proveniência]
        NOTIF[Notification Service<br/>Node.js<br/>Email/Push]
    end

    subgraph "Contexto: Apresentação"
        PUB_API[Public API<br/>GraphQL/REST<br/>Consulta Pública]
        SEARCH[Search Service<br/>Motor de Busca<br/>Busca Avançada]
        EXPORT[Export Service<br/>Node.js<br/>Geração de Arquivos]
    end

    subgraph "Data Layer"
        DB[(Banco de Dados<br/>Orientado a Documentos<br/>Dados Principais)]
        CACHE[(Cache<br/>Cache em Memória<br/>Performance)]
        STORAGE[Object Storage<br/>Armazenamento Distribuído<br/>Arquivos/Imagens]
    end

    subgraph "Sistemas Externos"
        FLORA[Flora e Funga do Brasil API]
        FAUNA[Fauna do Brasil API]
        GBIF[GBIF API]
        JOURNALS[Periódicos]
        TERR[Plataforma de Territórios<br/>Tradicionais API]
        AUTH[Outras Fontes<br/>Autoritativas]
    end

    U1 --> WEB
    U1 --> ETNOPAPERS
    U1 --> ETNODB_ACQ
    U2 --> WEB
    U2 --> ETNODB_CUR
    U3 --> PORTAL
    U3 --> ETNODB_PUB

    WEB --> GATEWAY
    PORTAL --> GATEWAY

    GATEWAY --> ACQ_API
    GATEWAY --> CUR_API
    GATEWAY --> PUB_API

    ETNOPAPERS --> DB
    ETNODB_ACQ --> DB
    ETNODB_CUR --> DB
    ETNODB_PUB --> DB

    ACQ_API --> QUEUE
    ACQ_API --> DB
    CRAWLER --> QUEUE
    ETL --> QUEUE
    QUEUE --> DB

    CUR_API --> DB
    CUR_API --> VAL
    CUR_API --> TERR_VAL
    CUR_API --> NOTIF
    VAL --> FLORA
    VAL --> FAUNA
    VAL --> GBIF
    TERR_VAL --> TERR
    TERR_VAL --> AUTH

    PUB_API --> DB
    PUB_API --> SEARCH
    PUB_API --> CACHE
    EXPORT --> DB

    DB --> SEARCH
    SEARCH --> CACHE

    ACQ_API --> STORAGE
    PUB_API --> STORAGE

    CRAWLER --> JOURNALS

    style WEB fill:#438dd5,stroke:#2e6295,color:#ffffff
    style PORTAL fill:#438dd5,stroke:#2e6295,color:#ffffff
    style GATEWAY fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style ACQ_API fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style CUR_API fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style PUB_API fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style CRAWLER fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style ETL fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style VAL fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style TERR_VAL fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style NOTIF fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style SEARCH fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style EXPORT fill:#85bbf0,stroke:#5d9dd1,color:#000000
    style QUEUE fill:#f4a261,stroke:#d68a4f,color:#000000
    style DB fill:#2ecc71,stroke:#27ae60,color:#ffffff
    style CACHE fill:#2ecc71,stroke:#27ae60,color:#ffffff
    style STORAGE fill:#2ecc71,stroke:#27ae60,color:#ffffff
    style ETNODB_ACQ fill:#28a745,stroke:#1e7e34,color:#ffffff
    style ETNODB_CUR fill:#28a745,stroke:#1e7e34,color:#ffffff
    style ETNODB_PUB fill:#28a745,stroke:#1e7e34,color:#ffffff
    style ETNOPAPERS fill:#28a745,stroke:#1e7e34,color:#ffffff
```

## Containers Detalhados

### Containers Implementados (Versão 1.2)

Esta seção documenta os containers que já foram implementados e estão em produção/desenvolvimento ativo.

#### etnoDB - Sistema de Conhecimento Tradicional Secundário
**GitHub:** [https://github.com/edalcin/etnoDB](https://github.com/edalcin/etnoDB)

Interface web completa para gerenciamento de conhecimento tradicional extraído de artigos científicos, implementando os três contextos arquiteturais de forma integrada.

##### etnoDB - Aquisição (Porta 3001)
**Tecnologia:** Node.js, Express, HTMX, Alpine.js, Tailwind CSS, EJS, MongoDB

**Responsabilidades:**
- Entrada manual de dados secundários por pesquisadores
- Formulários hierárquicos (Referência → Comunidade → Planta → Uso)
- Validação estrutural de dados
- Armazenamento com status "pendente" para curadoria

**Características Técnicas:**
- Interface responsiva mobile-first (320px a 1920px+)
- Server-side rendering com EJS
- Interatividade com HTMX e Alpine.js
- Validação de entrada contra injeção NoSQL e XSS
- 29 classificações de comunidades tradicionais (Decreto nº 11.481/2023)

**Endpoints Principais:**
```
GET    /                     - Formulário de entrada
POST   /submit               - Criar novo registro
GET    /references           - Listar referências
```

##### etnoDB - Curadoria (Porta 3002)
**Tecnologia:** Node.js, Express, HTMX, Alpine.js, Tailwind CSS, EJS, MongoDB

**Responsabilidades:**
- Interface editorial para revisão de registros
- Workflow de aprovação/rejeição (princípios C.A.R.E.)
- Validação por representantes de comunidades
- Controle de qualidade dos dados

**Características Técnicas:**
- Acesso restrito (futuro: autenticação JWT)
- Dashboard de registros pendentes
- Edição colaborativa de registros
- Rastreamento de mudanças de status

**Estados de Workflow:**
- `pending` - Aguardando revisão
- `approved` - Aprovado para publicação
- `rejected` - Rejeitado (dados insuficientes)

**Endpoints Principais:**
```
GET    /                     - Dashboard de curadoria
GET    /pending              - Listar registros pendentes
POST   /approve/:id          - Aprovar registro
POST   /reject/:id           - Rejeitar registro
PUT    /edit/:id             - Editar registro
```

##### etnoDB - Apresentação (Porta 3003)
**Tecnologia:** Node.js, Express, HTMX, Alpine.js, Tailwind CSS, EJS, MongoDB

**Responsabilidades:**
- Consulta pública de dados aprovados
- Busca full-text em todos os campos
- Filtros avançados (comunidade, localização, espécie)
- Apresentação responsiva dos resultados

**Características Técnicas:**
- Interface Google-like de busca
- Busca em texto completo (título, abstract, nomes científicos, vernaculares)
- Filtros por tipo de comunidade, estado, município
- SEO otimizado para indexação
- Sem necessidade de autenticação

**Endpoints Principais:**
```
GET    /                     - Interface de busca
GET    /search?q={query}     - Executar busca
GET    /reference/:id        - Detalhes de referência
```

**Estrutura de Dados Hierárquica:**
```json
{
  "reference": {
    "title": "...",
    "authors": "...",
    "year": 2025,
    "doi": "...",
    "abstract": "...",
    "status": "approved",
    "communities": [
      {
        "name": "Comunidade Quilombola X",
        "type": "quilombola",
        "country": "Brasil",
        "state": "BA",
        "municipality": "Salvador",
        "plants": [
          {
            "scientific_name": "Manihot esculenta",
            "vernacular_names": ["mandioca", "aipim"],
            "uses": [
              {
                "type": "Alimentação",
                "description": "Raíz utilizada para fazer farinha"
              }
            ]
          }
        ]
      }
    ]
  }
}
```

#### etnopapers - Extração Automatizada com IA
**GitHub:** [https://github.com/edalcin/etnopapers](https://github.com/edalcin/etnopapers)

Aplicativo desktop Windows para extração automatizada de metadados de artigos científicos em PDF usando inteligência artificial.

**Tecnologia:** .NET 8, WPF, MVVM, C#

**Responsabilidades:**
- Processamento de PDFs de artigos científicos
- Extração de metadados via IA (Google Gemini, OpenAI GPT-4o-mini, Anthropic Claude 3.5 Haiku)
- Inserção direta no MongoDB
- Interface desktop para pesquisadores

**Características Técnicas:**
- Arquitetura MVVM para separação de concerns
- Integração com múltiplos provedores de IA:
  - Google Gemini (gratuito, 15 req/min)
  - OpenAI GPT-4o-mini
  - Anthropic Claude 3.5 Haiku
- Armazenamento local em JSON (backup)
- Sincronização direta com MongoDB (Atlas ou local)
- Performance: 50% mais rápido que soluções locais (OLLAMA)
- PDFs descartados pós-processamento (privacidade)

**Dados Extraídos:**

*Obrigatórios:*
- Título normalizado
- Autores (formato APA)
- Ano de publicação
- Abstract (traduzido para português brasileiro)

*Opcionais:*
- Espécies (nomes vernaculares e científicos)
- Tipos de uso
- Informações de comunidades
- Dados geográficos (país, estado, município)
- Metodologia

**Workflow de Integração:**
```
1. Pesquisador seleciona PDF no etnopapers
2. IA extrai metadados estruturados
3. Dados salvos em MongoDB com status "pending"
4. Pesquisador revisa no etnoDB-Aquisição (porta 3001)
5. Curador valida no etnoDB-Curadoria (porta 3002)
6. Dados aprovados aparecem no etnoDB-Apresentação (porta 3003)
```

**Requisitos:**
- Windows 10 ou superior
- Conexão com internet (APIs de IA)
- Chave de API de provedor (Gemini/OpenAI/Anthropic)
- Acesso a MongoDB (Atlas ou local)

**Formato de Saída (MongoDB):**
```json
{
  "title": "Ethnobotanical study of...",
  "authors": "Silva, J.; Santos, M.",
  "year": 2025,
  "abstract_pt": "Estudo etnobotânico sobre...",
  "species": [
    {
      "scientific_name": "Manihot esculenta",
      "vernacular_names": ["mandioca"],
      "uses": ["alimentação"]
    }
  ],
  "communities": [...],
  "location": {
    "country": "Brasil",
    "state": "AM",
    "municipality": "Manaus"
  },
  "status": "pending",
  "source": "etnodb - gemini",
  "createdAt": "2025-12-28T10:30:00Z",
  "updatedAt": "2025-12-28T10:30:00Z"
}
```

---

### Frontend Layer

#### 1. Web Application (Interface Interna)
**Tecnologia:** React.js ou Vue.js com TypeScript

**Responsabilidades:**
- Interface para pesquisadores registrarem dados
- Dashboard de curadoria
- Painel administrativo
- Gestão de permissões

**Características Técnicas:**
- SPA (Single Page Application)
- Estado gerenciado com Redux/Vuex/Pinia
- Comunicação via REST/GraphQL
- Autenticação JWT
- Suporte offline (PWA)

**Endpoints Consumidos:**
- `POST /api/acquisition/records` - Criar registros
- `GET /api/curation/pending` - Listar itens pendentes
- `PUT /api/curation/records/:id` - Atualizar registro
- `POST /api/curation/approve/:id` - Aprovar publicação

**Dependências:**
- API Gateway
- Authentication Service

#### 2. Portal Público
**Tecnologia:** Next.js (React SSR) ou Nuxt.js (Vue SSR)

**Responsabilidades:**
- Consulta pública de dados validados
- Visualizações interativas
- Sistema de busca
- Exportação de dados

**Características Técnicas:**
- Server-Side Rendering (SEO)
- Static Site Generation para páginas estáticas
- Infinite scroll para listagens
- Mapas interativos (Leaflet/Mapbox)
- Gráficos (D3.js/Chart.js)

**Endpoints Consumidos:**
- `GET /api/public/search` - Busca geral
- `GET /api/public/species/:id` - Detalhes de espécie
- `GET /api/public/regions` - Dados por região
- `POST /api/public/export` - Exportar dados

### API Gateway Layer

#### API Gateway
**Tecnologia:** Kong, AWS API Gateway, ou Express Gateway

**Responsabilidades:**
- Roteamento centralizado
- Autenticação e autorização
- Rate limiting
- CORS
- Logging e monitoring
- Cache de respostas

**Características Técnicas:**
- Proxy reverso
- Load balancing
- Circuit breaker
- Request/response transformation
- Analytics

**Configurações:**
- Rate limit: 1000 req/min para autenticados, 100 req/min para públicos
- Timeout: 30s para APIs, 5min para exports
- Retry policy: 3 tentativas com backoff exponencial

### Contexto: Aquisição

#### 3. Acquisition API
**Tecnologia:** Node.js com Express ou Fastify

**Responsabilidades:**
- Receber dados de múltiplas fontes
- Validar estrutura de dados (JSON Schema)
- Enfileirar para processamento
- Fornecer feedback ao submissor

**Endpoints:**
```
POST   /api/acquisition/records              - Criar registro
POST   /api/acquisition/bulk                 - Criar múltiplos registros
GET    /api/acquisition/status/:id           - Status do processamento
POST   /api/acquisition/validate             - Validar antes de enviar
GET    /api/acquisition/sources              - Listar fontes integradas
```

**Validações:**
- Schema validation (Joi/Yup)
- Deduplicação básica
- Verificação de campos obrigatórios

#### 4. Web Crawler Service
**Tecnologia:** Python com Scrapy ou Beautiful Soup

**Responsabilidades:**
- Monitorar periódicos científicos
- Extrair metadados de artigos
- Identificar artigos relevantes
- Respeitar robots.txt e rate limits

**Características Técnicas:**
- Agendamento via cron jobs
- User-agent identificável
- Delay entre requisições
- Armazenamento de estado (último crawl)

**Fontes Monitoradas:**
- Journal of Ethnobiology
- Economic Botany
- Journal of Ethnopharmacology
- PubMed (via API)
- SciELO

**Saída:**
```json
{
  "source": "journal_name",
  "title": "Article title",
  "authors": ["Author 1", "Author 2"],
  "abstract": "...",
  "doi": "10.xxxx/xxxxx",
  "keywords": ["ethnobotany", "traditional knowledge"],
  "published_date": "2025-01-15"
}
```

#### 5. ETL Service
**Tecnologia:** Apache Airflow ou Prefect

**Responsabilidades:**
- Transformar dados de diferentes formatos
- Normalizar estruturas
- Executar validações complexas
- Carregar no banco principal

**DAGs (Directed Acyclic Graphs):**
1. **Daily Crawl Pipeline**
   - Extract: Crawler coleta dados
   - Transform: Normalização e validação
   - Load: Inserção no DB com status "pendente"

2. **Bulk Import Pipeline**
   - Extract: Leitura de arquivos (CSV, Excel, JSON)
   - Transform: Mapeamento para schema padrão
   - Load: Validação e inserção

3. **Integration Pipeline**
   - Extract: Consumo de APIs externas
   - Transform: Conversão de formato
   - Load: Merge com dados existentes

#### 6. Message Queue
**Tecnologia:** RabbitMQ ou Apache Kafka

**Responsabilidades:**
- Desacoplar serviços
- Garantir processamento assíncrono
- Retry automático em caso de falha
- Dead letter queue para erros

**Filas:**
- `acquisition.new` - Novos registros
- `acquisition.validation` - Validação pendente
- `curation.notify` - Notificações para curadores
- `export.generate` - Geração de exports

### Contexto: Curadoria

#### 7. Curation API
**Tecnologia:** Node.js com Express

**Responsabilidades:**
- Gerenciar workflow de curadoria
- Atribuir tarefas a curadores
- Controlar versões de registros
- Aprovar/rejeitar publicações

**Endpoints:**
```
GET    /api/curation/dashboard              - Dashboard do curador
GET    /api/curation/pending                - Itens pendentes
GET    /api/curation/records/:id            - Detalhes do registro
PUT    /api/curation/records/:id            - Atualizar registro
POST   /api/curation/records/:id/validate   - Validar taxonomia
POST   /api/curation/records/:id/approve    - Aprovar
POST   /api/curation/records/:id/reject     - Rejeitar
GET    /api/curation/records/:id/history    - Histórico de alterações
POST   /api/curation/records/:id/assign     - Atribuir a curador
```

**Estados de Workflow:**
```
Pendente → Em Revisão → Em Validação → Aprovado → Publicado
                    ↓
                Rejeitado
```

#### 8. Validation Service
**Tecnologia:** Python com Flask ou FastAPI

**Responsabilidades:**
- Validar nomes científicos via Flora e Funga do Brasil para flora/fungos (primária)
- Validar nomes científicos via Fauna do Brasil para fauna (primária)
- Verificar nomenclatura via GBIF (fallback para ambas)
- Enriquecer com dados taxonômicos
- Sugerir correções

**Endpoints:**
```
POST   /api/validation/taxonomy             - Validar taxonomia
POST   /api/validation/names                - Verificar nomenclatura
POST   /api/validation/batch                - Validação em lote
GET    /api/validation/suggestions/:name    - Sugestões de correção
```

**Integração Externa:**
```python
# Flora e Funga do Brasil (primária para flora/fungos)
GET https://floradobrasil.jbrj.gov.br/api/v1/search?name={scientific_name}

# Fauna do Brasil (primária para fauna)
GET https://fauna.jbrj.gov.br/api/v1/search?name={scientific_name}

# GBIF Species Match (fallback para ambas)
GET https://api.gbif.org/v1/species/match?name={scientific_name}
```

**Estratégia de Validação:**
1. Detectar tipo de organismo (flora, fauna, ou ambíguo)
2. Para flora/fungos: tentar Flora e Funga do Brasil primeiro
3. Para fauna: tentar Fauna do Brasil primeiro
4. Se não encontrado em base brasileira, fallback para GBIF
5. Retorna dados taxonômicos enriquecidos com source informado

**Response Enrichment:**
```json
{
  "original_name": "Manihot esculenta",
  "matched_name": "Manihot esculenta Crantz",
  "status": "ACCEPTED",
  "confidence": 95,
  "taxon_key": 5290063,
  "kingdom": "Plantae",
  "family": "Euphorbiaceae",
  "common_names": ["Cassava", "Mandioca"]
}
```

#### 9. Territory & Authority Service
**Tecnologia:** Python com Flask ou FastAPI

**Responsabilidades:**
- Validar proveniência territorial de registros
- Consultar dados da Plataforma de Territórios Tradicionais
- Validar contra outras fontes autoritativas
- Enriquecer registros com informações territoriais
- Rastrear conformidade com Lei 13.123/2015

**Endpoints:**
```
POST   /api/validation/territory            - Validar território
GET    /api/validation/territory/:id        - Detalhes de território
POST   /api/validation/authority            - Validar contra fontes
POST   /api/validation/provenance           - Validar proveniência
GET    /api/validation/communities/:id      - Dados de comunidade
```

**Integração Externa:**
```python
# Plataforma de Territórios Tradicionais
GET https://territoriostradicionais.mpf.mp.br/api/v1/territories?region={region}
GET https://territoriostradicionais.mpf.mp.br/api/v1/territories/{id}

# Outras Fontes Autoritativas (genérica)
GET https://[source]/api/authority/validate?data={encoded_data}
```

**Estratégia de Validação:**
1. Extrair coordenadas/região do registro
2. Consultar Plataforma de Territórios Tradicionais
3. Verificar correspondência com polígonos territoriais
4. Validar contra fontes autoritativas configuradas
5. Retorna dados enriquecidos com rastreabilidade territorial

**Response Enrichment:**
```json
{
  "territory_match": {
    "found": true,
    "territory_id": "IND_001",
    "name": "Terra Indígena Yanomami",
    "people": "Yanomami",
    "demarcation_status": "demarcated",
    "area_hectares": 9664975,
    "state": "AM"
  },
  "authority_validations": [
    {
      "source": "SISGEN",
      "status": "registered",
      "reference_id": "SIS-2025-00123"
    }
  ],
  "legal_compliance": {
    "lei_13123": true,
    "nagoya_protocol": true
  }
}
```

#### 10. Notification Service
**Tecnologia:** Node.js

**Responsabilidades:**
- Enviar emails
- Push notifications
- Notificações in-app
- Logs de notificações

**Canais:**
- Email (SendGrid/AWS SES)
- Push (Firebase Cloud Messaging)
- WebSocket (real-time updates)

**Tipos de Notificação:**
- Novo item para curadoria
- Registro aprovado/rejeitado
- Comentário em registro
- Atribuição de tarefa
- Alertas de validação territorial

### Contexto: Apresentação

#### 11. Public API
**Tecnologia:** Node.js com GraphQL (Apollo Server) ou REST

**Responsabilidades:**
- Fornecer dados públicos
- Suportar consultas complexas
- Cache agressivo
- Documentação automática (Swagger/GraphQL Playground)

**GraphQL Schema (exemplo):**
```graphql
type Species {
  id: ID!
  scientificName: String!
  commonNames: [String!]!
  family: String
  uses: [TraditionalUse!]!
  regions: [Region!]!
  images: [Image!]
}

type TraditionalUse {
  description: String!
  community: String
  source: Source!
  verified: Boolean!
}

type Query {
  species(id: ID!): Species
  searchSpecies(name: String, family: String, region: String): [Species!]!
  speciesByUse(use: String!): [Species!]!
}
```

**REST Endpoints (alternativo):**
```
GET    /api/public/species                  - Listar espécies
GET    /api/public/species/:id              - Detalhes
GET    /api/public/search?q={query}         - Busca geral
GET    /api/public/uses                     - Listar usos tradicionais
GET    /api/public/regions                  - Listar regiões
GET    /api/public/stats                    - Estatísticas gerais
```

#### 12. Search Service
**Tecnologia:** Motor de busca especializado (ex: full-text search)

**Responsabilidades:**
- Indexação de documentos
- Busca full-text
- Faceted search
- Autocomplete
- Relevância ajustada

**Índices:**
- `species` - Dados de espécies
- `uses` - Usos tradicionais
- `communities` - Comunidades (dados públicos)
- `publications` - Publicações científicas

**Query Example:**
```json
{
  "query": {
    "multi_match": {
      "query": "mandioca uso medicinal",
      "fields": ["scientific_name^3", "common_names^2", "uses.description"]
    }
  },
  "aggs": {
    "families": {
      "terms": {"field": "family"}
    },
    "regions": {
      "terms": {"field": "regions"}
    }
  }
}
```

#### 13. Export Service
**Tecnologia:** Node.js

**Responsabilidades:**
- Gerar arquivos para download
- Suportar múltiplos formatos (CSV, JSON, Excel)
- Gerar relatórios PDF
- Limitar tamanho de exports

**Endpoints:**
```
POST   /api/export/species                  - Exportar espécies filtradas
POST   /api/export/uses                     - Exportar usos
GET    /api/export/status/:id               - Status da exportação
GET    /api/export/download/:id             - Download do arquivo
```

**Formatos Suportados:**
- CSV (para planilhas)
- JSON (para desenvolvedores)
- Excel (para pesquisadores)
- PDF (relatórios formatados)
- Darwin Core Archive (interoperabilidade)

### Data Layer

#### Banco de Dados Orientado a Documentos
**Escolha:** Documentado em [ADR-001](../architecture-decisions/ADR-001-database-selection.md)

**Coleções/Tabelas Principais:**
- `records` - Registros de conhecimento tradicional
- `species` - Dados de espécies (cache de GBIF)
- `users` - Usuários do sistema
- `audit_logs` - Logs de auditoria
- `permissions` - Controle de acesso

**Características:**
- Replicação para alta disponibilidade
- Sharding para escalabilidade
- Backups automáticos diários
- Índices otimizados para queries comuns

#### Cache (Redis)
**Uso:**
- Cache de sessões
- Cache de queries frequentes (TTL: 1h)
- Rate limiting
- Lock distribuído

**Estruturas:**
- Strings: sessões, locks
- Hashes: objetos cached
- Sets: rate limiting por IP
- Sorted Sets: leaderboards, estatísticas

#### Object Storage (S3/MinIO)
**Conteúdo:**
- Imagens de plantas
- PDFs de artigos
- Arquivos de export gerados
- Backups de banco de dados

**Organização:**
```
/images/
  /species/{species_id}/{image_hash}.jpg
/documents/
  /publications/{doi}.pdf
/exports/
  /{user_id}/{export_id}.{format}
/backups/
  /database/{date}.tar.gz
```

## Comunicação Entre Containers

### Síncrona (HTTP/REST/GraphQL)
- Frontend ↔ API Gateway
- API Gateway ↔ APIs (Acquisition, Curation, Public)
- APIs ↔ Database/Cache

### Assíncrona (Message Queue)
- Acquisition API → Queue → ETL Service
- Crawler → Queue → Acquisition API
- Curation API → Queue → Notification Service

### Event-Driven
- Database Change Streams → Search Service (indexação em tempo real)
- Approval Event → Notification Service
- Export Request → Export Service

## Segurança

### Autenticação
- JWT tokens (access + refresh)
- OAuth 2.0 para integração externa
- API Keys para desenvolvedores

### Autorização
- RBAC (Role-Based Access Control)
- Atributos: Admin, Curator, Researcher, Community Representative

### Criptografia
- TLS 1.3 para comunicação
- Criptografia at-rest para dados sensíveis
- Hashing de senhas (bcrypt)

## Monitoramento e Observabilidade

### Logging
- Estruturado (JSON)
- Agregação centralizada (ELK Stack ou Grafana Loki)
- Níveis: DEBUG, INFO, WARN, ERROR

### Métricas
- Prometheus para coleta
- Grafana para visualização
- Alertas via Alertmanager

**Métricas-chave:**
- Taxa de requisições por endpoint
- Tempo de resposta (p50, p95, p99)
- Taxa de erros
- Uso de recursos (CPU, memória)

### Tracing
- OpenTelemetry
- Jaeger ou Zipkin para visualização
- Trace completo de requisições entre serviços

## Deployment

### Containerização
- Docker para todos os serviços
- Docker Compose para desenvolvimento local
- Kubernetes para produção

### CI/CD
- GitHub Actions ou GitLab CI
- Testes automatizados (unit, integration, e2e)
- Deploy automático em ambientes de staging
- Deploy manual em produção (com aprovação)

### Ambientes
- **Development:** Local com docker-compose
- **Staging:** Kubernetes cluster (réplica de produção)
- **Production:** Kubernetes cluster com alta disponibilidade

## Escalabilidade

### Horizontal Scaling
- Containers stateless podem escalar horizontalmente
- Load balancer distribui tráfego

**Prioridade de Scaling:**
1. Public API (alta demanda)
2. Search Service (queries complexas)
3. Acquisition API (picos de ingestão)

### Vertical Scaling
- Database pode iniciar com escala vertical
- Cache geralmente requer mais memória

## Decisões de Tecnologia

| Container | Tecnologia Escolhida | Alternativas Consideradas | Justificativa |
|-----------|---------------------|--------------------------|---------------|
| Web App | React | Vue, Angular | Ecossistema maduro, performance |
| Public Portal | Next.js | Nuxt, Gatsby | SSR + SSG, SEO excelente |
| APIs | Node.js/Express | Python/FastAPI, Go | Ecossistema JS unificado |
| Crawler | Python/Scrapy | Node.js/Puppeteer | Maturidade para scraping |
| Validation Service | Python/FastAPI | Node.js, Go | Especializado em ML/validação |
| Territory & Authority Service | Python/FastAPI | Node.js, Go | Processamento geoespacial, APIs |
| Database | Orientado a Documentos | SQL, Multi-Modal | Flexibilidade de schema |
| Search | Motor de Busca | Múltiplas opções | Poder de indexação e consultas |
| Queue | RabbitMQ | Kafka, Redis Streams | Simplicidade, confiabilidade |
| Cache | Redis | Memcached | Estruturas de dados ricas |

## Próximos Passos

Para entender o detalhamento interno de cada contexto:
- [Diagrama de Componentes (Level 3)](03-component-diagram.md)
