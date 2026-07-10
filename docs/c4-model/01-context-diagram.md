# C4 Model - Level 1: Diagrama de Contexto

## Visão Geral

O Diagrama de Contexto apresenta a visão de mais alto nível do Sistema de Informações sobre Conhecimento Tradicional, mostrando como ele se relaciona com os usuários e sistemas externos.

**Versão 2.0** - Adicionado BioCultRelatos (aquisição primária) e BioCultTermos migrado para SKOS-XL com integração total ao BioCultDB

## Diagrama

```mermaid
graph TB
    subgraph "Usuários Internos"
        PQ[Pesquisador]
        RC[Representante de<br/>Comunidade Tradicional]
        ADM[Administrador]
        CUR[Curador]
        TERM[Terminólogo]
        COL[Coletor de Campo<br/>Porta-Voz Comunitário]
    end

    subgraph "Sistema de Conhecimento Tradicional"
        SYS[Sistema de Informações<br/>sobre Conhecimento<br/>Tradicional]
        BIOCULTTERMOS[BioCultTermos<br/>Infraestrutura Terminológica<br/>SKOS-XL · ✓ IMPLEMENTADO]
        BIOCULTRELATOS[BioCultRelatos<br/>Aquisição Primária<br/>Em Desenvolvimento]
        ETNOCHAT[etnoChat<br/>Interface Conversacional<br/>✓ IMPLEMENTADO]
        PAINEL[Painel Analítico<br/>Dashboard Interativo<br/>✓ IMPLEMENTADO]
    end

    subgraph "Usuários Externos"
        PUB[Público Geral]
        DEV[Desenvolvedor<br/>Terceiro]
    end

    subgraph "Sistemas Externos"
        FLORA[Flora e Funga<br/>do Brasil]
        FAUNA[Fauna do Brasil]
        GBIF[GBIF<br/>Global Biodiversity<br/>Information Facility]
        JOURNALS[Periódicos<br/>Científicos]
        EXT[Outros Sistemas<br/>Etnobotânicos]
        TERR[Plataforma de<br/>Territórios Tradicionais<br/>MPF]
        AUTH[Outras Fontes<br/>Autoritativas]
    end

    PQ -->|Registra dados secundários e faz curadoria| SYS
    RC -->|Valida conhecimento e controla acesso| SYS
    ADM -->|Gerencia sistema e aprova| SYS
    CUR -->|Valida e enriquece dados| SYS
    TERM -->|Gerencia vocabulários e tesauros SKOS-XL| BIOCULTTERMOS
    COL -->|Registra conhecimento primário com CLPI| BIOCULTRELATOS

    PUB -->|Consulta informações públicas| SYS
    PUB -->|Navega por tesauros| BIOCULTTERMOS
    PUB -->|Faz perguntas em linguagem natural| ETNOCHAT
    PUB -->|Explora visualizações analíticas| PAINEL
    DEV -->|Consome APIs públicas| SYS
    DEV -->|Consome API de termos| BIOCULTTERMOS

    SYS -->|Verifica Flora/Fungos primária| FLORA
    SYS -->|Verifica Fauna primária| FAUNA
    SYS -->|Valida taxonomia fallback| GBIF
    SYS -->|Coleta artigos automaticamente| JOURNALS
    SYS -->|Integra dados| EXT
    SYS -->|Consulta territórios e proveniência| TERR
    SYS -->|Valida contra fontes autoritativas| AUTH
    SYS <-->|Valida e padroniza termos SKOS-XL| BIOCULTTERMOS
    SYS -->|Fornece dados para chat| ETNOCHAT
    SYS -->|Fornece dados para análise| PAINEL
    BIOCULTRELATOS -->|Dados primários curados| SYS

    FLORA -->|Retorna verificação| SYS
    FAUNA -->|Retorna verificação| SYS
    GBIF -->|Retorna validação| SYS
    JOURNALS -->|Fornece metadados| SYS
    EXT -->|Compartilha dados| SYS
    TERR -->|Fornece dados territoriais| SYS
    AUTH -->|Fornece validações| SYS

    style SYS fill:#1168bd,stroke:#0b4884,color:#ffffff
    style BIOCULTTERMOS fill:#28a745,stroke:#1e7e34,color:#ffffff
    style BIOCULTRELATOS fill:#fd7e14,stroke:#dc6502,color:#ffffff
    style ETNOCHAT fill:#28a745,stroke:#1e7e34,color:#ffffff
    style PAINEL fill:#28a745,stroke:#1e7e34,color:#ffffff
    style PQ fill:#08427b,stroke:#052e56,color:#ffffff
    style RC fill:#08427b,stroke:#052e56,color:#ffffff
    style ADM fill:#08427b,stroke:#052e56,color:#ffffff
    style CUR fill:#08427b,stroke:#052e56,color:#ffffff
    style TERM fill:#08427b,stroke:#052e56,color:#ffffff
    style COL fill:#08427b,stroke:#052e56,color:#ffffff
    style PUB fill:#08427b,stroke:#052e56,color:#ffffff
    style DEV fill:#08427b,stroke:#052e56,color:#ffffff
    style FLORA fill:#999999,stroke:#6b6b6b,color:#ffffff
    style FAUNA fill:#999999,stroke:#6b6b6b,color:#ffffff
    style GBIF fill:#999999,stroke:#6b6b6b,color:#ffffff
    style JOURNALS fill:#999999,stroke:#6b6b6b,color:#ffffff
    style EXT fill:#999999,stroke:#6b6b6b,color:#ffffff
    style TERR fill:#aa8844,stroke:#8b6f47,color:#ffffff
    style AUTH fill:#aa8844,stroke:#8b6f47,color:#ffffff
```

## Atores

### Usuários Internos (Autenticados)

#### 1. Pesquisador
**Responsabilidades:**
- Registrar dados primários coletados em campo
- Inserir dados secundários extraídos de literatura científica
- Participar do processo de curadoria
- Validar informações taxonômicas

**Necessidades:**
- Interface para entrada estruturada de dados
- Ferramentas de validação em tempo real
- Histórico de contribuições
- Conformidade com protocolos éticos

#### 2. Representante de Comunidade Tradicional
**Responsabilidades:**
- Validar conhecimento tradicional registrado
- Exercer autoridade sobre dados da comunidade
- Aprovar ou rejeitar publicação de informações sensíveis
- Garantir benefício coletivo

**Necessidades:**
- Interface acessível e multilíngue
- Controle granular de permissões
- Transparência sobre uso dos dados
- Mecanismos de consentimento informado

#### 3. Curador
**Responsabilidades:**
- Revisar qualidade dos dados submetidos
- Enriquecer informações com validações externas
- Padronizar nomenclatura e taxonomia
- Aprovar publicação de dados validados

**Necessidades:**
- Dashboard de workflow de curadoria
- Integração com APIs de validação
- Ferramentas de edição colaborativa
- Sistema de notificações

#### 4. Administrador
**Responsabilidades:**
- Gerenciar usuários e permissões
- Configurar robôs de coleta automática
- Monitorar integridade do sistema
- Gerar relatórios e métricas

**Necessidades:**
- Painel administrativo completo
- Logs de auditoria
- Ferramentas de monitoramento
- Controle de configurações

#### 5. Terminólogo
**Responsabilidades:**
- Gerenciar glossários, vocabulários e tesauros no BioCultTermos (padrão SKOS-XL)
- Criar e manter relações hierárquicas (`skos:broader`/`skos:narrower`), rótulos (`skosxl:prefLabel`/`skosxl:altLabel`) e associativas (`skos:related`)
- Documentar conceitos com notas de escopo, definições e exemplos (SKOS)
- Rastrear fontes de termos (bibliográficas, conhecimento tradicional)

**Necessidades:**
- Interface especializada para gestão de esquemas de conceitos SKOS-XL
- Ferramentas de importação/exportação (SKOS-XL/RDF, JSON-LD, Dublin Core, CSV)
- Busca inteligente com Meilisearch
- Suporte multilíngue
- Dashboard de administração terminológica

#### 6. Coletor de Campo / Porta-Voz Comunitário
**Responsabilidades:**
- Registrar conhecimento tradicional diretamente com comunidades tradicionais
- Conduzir protocolo CLPI (Consentimento Livre, Prévio e Informado)
- Inserir dados primários no BioCultRelatos

**Necessidades:**
- Interface para coleta de dados primários com suporte offline
- Fluxo de consentimento integrado (CLPI)
- Suporte multilíngue (português, idiomas indígenas)

### Usuários Externos (Públicos)

#### 6. Público Geral
**Responsabilidades:**
- Consultar conhecimento tradicional publicado
- Navegar e explorar dados
- Exportar informações em formatos abertos

**Necessidades:**
- Interface intuitiva de busca
- Visualizações interativas
- Acesso sem necessidade de cadastro
- Documentação clara sobre uso ético

#### 7. Desenvolvedor Terceiro
**Responsabilidades:**
- Integrar dados em aplicações externas
- Construir ferramentas complementares
- Contribuir com análises e visualizações

**Necessidades:**
- APIs RESTful bem documentadas
- Chaves de API para rate limiting
- Exemplos de código
- Suporte técnico

## Sistemas Externos

### 1. GBIF (Global Biodiversity Information Facility)
**URL:** https://www.gbif.org/

**Propósito:** Validação de dados taxonômicos

**Integração:**
- API REST para verificação de espécies
- Validação de nomenclatura científica
- Obtenção de dados de distribuição geográfica
- Enriquecimento com informações complementares

**Dados Consumidos:**
- Nome científico da espécie
- Classificação taxonômica
- Status de conservação

### 2. Flora e Funga do Brasil
**URL:** https://floradobrasil.jbrj.gov.br/consulta/

**Propósito:** Verificação primária de nomenclatura científica para plantas, algas e fungos brasileiros

**Integração:**
- API REST para busca de nomenclatura
- Validação contra base de dados oficial brasileira
- Dados de distribuição geográfica
- Informações sobre status de conservação

**Dados Consumidos:**
- Nomes científicos (verificação individual ou em lote)
- Informações taxonômicas completas
- Status de validação

### 3. Fauna do Brasil
**URL:** https://fauna.jbrj.gov.br/

**Propósito:** Verificação primária de nomenclatura científica para fauna brasileira

**Integração:**
- API REST para busca de nomenclatura da fauna
- Validação contra catálogo taxonômico oficial brasileiro
- Dados de distribuição geográfica
- Informações sobre status de conservação

**Dados Consumidos:**
- Nomes científicos de fauna (verificação individual ou em lote)
- Informações taxonômicas completas para animais
- Status de validação

**Estratégia:**
- Para flora/fungos: Flora e Funga do Brasil (validação primária)
- Para fauna: Fauna do Brasil (validação primária)
- Para ambos: GBIF (fallback quando não encontrado nas bases brasileiras)

### 4. Periódicos Científicos
**Exemplos:** Journal of Ethnobiology, Economic Botany, Ethnobotany Research

**Propósito:** Coleta automatizada de artigos relevantes

**Integração:**
- Web scraping ético (respeitando robots.txt)
- APIs de publishers (quando disponíveis)
- RSS feeds
- DOI resolution

**Dados Consumidos:**
- Metadados de publicações
- Resumos (abstracts)
- Referências bibliográficas
- Dados estruturados (quando disponíveis)

### 4. Outros Sistemas Etnobotânicos
**Exemplos:** Bases de dados regionais, repositórios institucionais

**Propósito:** Intercâmbio de dados

**Integração:**
- APIs customizadas
- Protocolos de interoperabilidade (OAI-PMH, GraphQL)
- Exportação/importação em formatos padrão

**Dados Compartilhados:**
- Registros de conhecimento tradicional
- Dados de ocorrência de espécies
- Informações etnobotânicas

### 5. Plataforma de Territórios Tradicionais (MPF)
**URL:** https://territoriostradicionais.mpf.mp.br/

**Propósito:** Sincronização de dados territoriais e proveniência geográfica do conhecimento tradicional

**Integração:**
- API REST para consulta de polígonos territoriais
- Sincronização automática de limites geográficos
- Cruzamento espacial de registros com territórios
- Acesso a dados públicos sobre status de demarcação

**Dados Consumidos:**
- Polígonos geográficos de territórios indígenas e tradicionais
- Metadados sobre povos e comunidades
- Status de demarcação e regularização
- Informações históricas sobre conflitos territoriais

**Utilidade no Sistema:**
- Validar proveniência geográfica do conhecimento
- Associar registros a territórios de origem
- Rastrear conhecimento até sua comunidade detentora
- Conformidade com Lei 13.123/2015 sobre proveniência

### 6. Outras Fontes Autoritativas
**Exemplos:** Plataformas especializadas, bases de dados comunitárias, registros públicos

**Propósito:** Validação e enriquecimento complementar de dados

**Integração:**
- APIs variadas dependendo da fonte
- Padrão genérico para novas integrações
- Priorização de validação (cascata configurável)

**Dados Consumidos:**
- Informações sobre conhecimento tradicional
- Validações de nomenclatura especializada
- Dados culturais e etnobotânicos
- Informações comunitárias certificadas

**Estratégia:**
- Permitem extensibilidade do sistema
- Suportam casos de uso específicos por região/comunidade
- Mantêm flexibilidade arquitetural

## Sistemas Internos Implementados

### BioCultTermos - Infraestrutura Terminológica
**GitHub:** [https://github.com/edalcin/BioCultTermos](https://github.com/edalcin/BioCultTermos)

**Propósito:** Preservação e organização do conhecimento etnobotânico através de glossários, vocabulários controlados e tesauros estruturados

**Padrão:** [SKOS-XL](https://www.w3.org/TR/skos-reference/skos-xl.html) (W3C Simple Knowledge Organization System eXtension for Labels) — substituiu o padrão ANSI/NISO Z39.19-2005 a partir da v2.0

**Integração Transversal (Total com BioCultDB):**
O BioCultTermos funciona como infraestrutura terminológica totalmente integrada ao BioCultDB, conectando todos os contextos principais e também o BioCultRelatos:

1. **Aquisição:**
   - Fornece vocabulários controlados (SKOS-XL) para padronização na entrada de dados
   - Autocomplete de termos validados durante o registro no BioCultDB e BioCultRelatos
   - Sugestão de termos relacionados via `skos:related`

2. **Curadoria:**
   - Base para validação semântica de termos vernaculares
   - Normalização de nomenclatura popular via `skosxl:prefLabel` / `skosxl:altLabel`
   - Desambiguação de termos homônimos

3. **Apresentação:**
   - Navegação por tesauros estruturados via `skos:broader` / `skos:narrower`
   - Busca expandida por rótulos alternativos
   - Exportação em formatos padrão (SKOS-XL/RDF, JSON-LD, Dublin Core)

**Funcionalidades Principais:**
- Gestão de conceitos com URIs únicos e suporte multilíngue
- Rótulos preferenciais e alternativos (`skosxl:prefLabel` / `skosxl:altLabel`)
- Relações hierárquicas (`skos:broader` / `skos:narrower`)
- Relações associativas (`skos:related`)
- Sistema de notas SKOS (scopeNote, definition, historyNote, editorialNote, example)
- Gestão de fontes com rastreabilidade (conformidade CARE)
- Busca inteligente com Meilisearch
- APIs REST para integração com BioCultDB e sistemas externos
- Exportação em SKOS-XL/RDF, JSON-LD, Dublin Core, CSV

**Dados Fornecidos:**
- Conceitos com URIs e rótulos reificados (SKOS-XL)
- Definições e notas de escopo
- Relações semânticas entre conceitos
- Fontes e proveniência dos termos
- Estrutura hierárquica de esquemas de conceitos

### BioCultRelatos - Aquisição Primária
**GitHub:** [https://github.com/edalcin/BioCultRelatos](https://github.com/edalcin/BioCultRelatos)

**Propósito:** Aquisição, registro e gestão de conhecimento tradicional associado à biodiversidade proveniente de **fontes primárias** — registrado diretamente junto às comunidades tradicionais

**Status:** Em desenvolvimento (v2.0)

**Diferença em relação ao BioCultDB:**
- **BioCultDB**: fontes secundárias (artigos científicos, livros) — sem necessidade de CLPI
- **BioCultRelatos**: fontes primárias (comunidades, campo) — CLPI obrigatório, validação comunitária

**Integração na Arquitetura:**
- Atua no Contexto de Aquisição, alimentando o mesmo MongoDB do BioCultDB
- Suporte terminológico do BioCultTermos (SKOS-XL)
- Os dados registrados seguem o mesmo workflow de curadoria do BioCultDB, com validação comunitária adicional

## Fluxos Principais

### Fluxo 1: Aquisição de Dados Primários
1. Pesquisador ou Representante autentica no sistema
2. Preenche formulário estruturado de registro
3. Sistema valida dados contra bases brasileiras (Flora e Funga para flora/fungos, Fauna para fauna) com fallback GBIF
4. Dados são armazenados com status "pendente"
5. Curador é notificado para revisão

### Fluxo 2: Aquisição Automática de Dados Secundários
1. Robô monitora periódicos científicos (agendamento)
2. Identifica artigos relevantes por palavras-chave
3. Extrai metadados e resumos
4. Sistema valida informações extraídas
5. Administrador recebe relatório para aprovação
6. Dados aprovados vão para fila de curadoria

### Fluxo 3: Curadoria e Validação
1. Curador acessa dashboard de itens pendentes
2. Revisa dados submetidos
3. Sistema executa validações automáticas:
   - Validação taxonômica (Flora/Fauna do Brasil com fallback GBIF)
   - Validação territorial (cruzamento com Plataforma de Territórios Tradicionais)
   - Validações contra outras fontes autoritativas
4. Curador enriquece e corrige informações
5. Representante de comunidade valida (se aplicável)
6. Curador aprova publicação
7. Dados se tornam públicos com rastreabilidade completa de proveniência

### Fluxo 4: Consulta Pública
1. Usuário público acessa portal
2. Realiza busca por espécie, região, ou uso
3. Sistema retorna resultados validados
4. Usuário visualiza detalhes e relacionamentos
5. Exporta dados em formato aberto (JSON, CSV)

### Fluxo 5: Integração via API
1. Desenvolvedor obtém chave de API
2. Consulta documentação da API
3. Faz requisições HTTP para endpoints públicos
4. Sistema retorna dados em JSON
5. Desenvolvedor integra em aplicação terceira

## Requisitos Não-Funcionais

### Segurança
- Autenticação robusta (OAuth 2.0, JWT)
- Autorização baseada em papéis (RBAC)
- Criptografia de dados sensíveis
- Auditoria completa de acessos

### Performance
- Tempo de resposta < 2s para consultas simples
- Suporte a 1000 requisições/minuto na API pública
- Processamento assíncrono para tarefas pesadas

### Escalabilidade
- Arquitetura horizontal para suportar crescimento
- Cache distribuído para dados públicos
- Fila de mensagens para processamento

### Disponibilidade
- Uptime de 99.5%
- Backup diário com retenção de 30 dias
- Plano de recuperação de desastres

### Conformidade
- LGPD (Lei Geral de Proteção de Dados)
- Lei da Biodiversidade (Lei 13.123/2015)
- Protocolo de Nagoya
- Princípios C.A.R.E.

## Premissas e Restrições

### Premissas
- Acesso à internet para validações externas
- Disponibilidade das APIs Flora e Funga do Brasil, Fauna do Brasil e GBIF
- Colaboração ativa de comunidades tradicionais
- Pesquisadores capacitados para entrada de dados

### Restrições
- Dados sensíveis não podem ser públicos sem autorização
- Sistema deve funcionar com conectividade limitada (offline-first para coleta)
- Multilinguagem essencial (português, inglês, idiomas indígenas)
- Acessibilidade (WCAG 2.1 nível AA)

## Riscos e Mitigações

| Risco | Impacto | Probabilidade | Mitigação |
|-------|---------|---------------|-----------|
| Indisponibilidade de APIs externas | Médio | Baixa | Cache local, validação assíncrona |
| Dados sensíveis vazados | Alto | Baixa | Criptografia, auditoria, controle rígido |
| Baixa adesão de comunidades | Alto | Média | Interface acessível, treinamento, benefícios claros |
| Qualidade dos dados automatizados | Médio | Alta | Workflow de validação obrigatório |

## Decisões de Arquitetura

Decisões detalhadas estão documentadas em [Architecture Decision Records (ADRs)](../architecture-decisions/):

- [ADR-001: Seleção de Banco de Dados](../architecture-decisions/ADR-001-database-selection.md)
- [ADR-002: Padrões de API](../architecture-decisions/ADR-002-api-standards.md)
- [ADR-003: Modelo de Dados](../architecture-decisions/ADR-003-data-model.md)

## Próximos Passos

Para entender como o sistema é dividido internamente, consulte:
- [Diagrama de Containers (Level 2)](02-container-diagram.md) - Detalhamento técnico dos componentes
