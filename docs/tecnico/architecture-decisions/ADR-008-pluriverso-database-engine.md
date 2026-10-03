# ADR-008: Engine de Banco de Dados do Pluriverso

## Status

**Aceito** — Julho 2026

## Contexto

- O Pluriverso é componente novo, ainda sem implementação; será desenvolvido sob os **Parâmetros de
  Desenvolvimento** (`Desenvolvimento.md`): SvelteKit + shadcn-svelte (runtime Node), PWA, imagem Docker
  mínima publicada em `ghcr.io/edalcin/pluriverso`, **arquivo de banco externo ao container via variável de
  ambiente**, container não-root, UUIDv7 onde útil.
- O ADR-005 (DA7) já afirmou, de passagem, que "o Índice do Pluriverso também adota SQLite+JSON". Este ADR
  **consolida e detalha** essa decisão com análise dedicada ao workload específico do Pluriverso, que difere
  de uma unidade-membro.
- Workload do Pluriverso: (a) **índice derivado** agregando os registros públicos de N membros; (b) **busca
  textual** (FTS) + **busca semântica** por expansão de mapeamentos SKOS sobre o conjunto federado; (c) **API
  pública read-heavy** com muitas leituras concorrentes; (d) **escritas periódicas em lote** (harvest) —
  escritor único; (e) tabela `membership_requests` com superfície de escrita pública (ADR-006).
- **Restrição do usuário:** a engine deve rodar **no mesmo container da aplicação** (facilita
  instalar/manter/atualizar) e o **arquivo de dados** deve ser **externo ao container** via env (Parâmetro 3).
- **Requisito multi-instância (ADR-009):** o Pluriverso deve ser trivialmente auto-hospedável por associações
  com recursos técnicos limitados → engine **embutida, sem servidor** reforça a escolha.

## Requisitos

### Funcionais

- Documento JSON flexível
- Busca textual difusa e diacrítico-insensível
- Travessia de mapeamentos SKOS (hierarquia `broader`/`narrower` via CTE recursiva)
- `purge_by_member`
- Filtros por membro/fonte/comunidade/espécie/região

### Não-Funcionais

- Engine embutida no mesmo container
- Arquivo único portável em volume externo (`SQLITE_DB_PATH`)
- Imagem Docker mínima
- Não-root
- Alta concorrência de leitura
- Backup = copiar o arquivo
- Zero administração de servidor de banco

## Opções Consideradas

### Opção 1: SQLite + JSON1 + FTS5 (embutida, `better-sqlite3`) — escolhida

**Prós:**
- Biblioteca no próprio processo (zero servidor)
- Arquivo único portável em volume externo
- Imagem mínima
- WAL → leitores concorrentes ilimitados + 1 escritor (harvest em lote)
- JSON1 (mesmo modelo de documento do ADR-005 DA2)
- FTS5 (mesmo padrão de busca DA4)
- CTE recursiva cobre expansão SKOS
- Alinhado ao padrão de toda a federação (código/operação reaproveitados dos membros)
- Auto-hospedagem trivial (multi-instância)

**Contras:**
- Escritor único serializado — *mitigação*: harvest é escritor único em lote e WAL não bloqueia leitores
- Sem escala horizontal nativa — *mitigação*: escala pelo **número de instâncias** Pluriverso, não pela
  escala vertical de uma; o volume esperado (milhões de linhas / múltiplos GB) está muito abaixo do limite
  prático do SQLite
- Módulo nativo `better-sqlite3` exige toolchain (`python3`/`make`/`g++`) **só no estágio de build** do
  multi-stage Alpine, runtime enxuto

### Opção 2: PostgreSQL no mesmo container (processo `postgres` + app; + `pgvector`) — rejeitada

**Prós:**
- JSONB, full-text `tsvector`, `pgvector` para busca vetorial futura, escala

**Contras:**
- Rodar um servidor de banco + o app no mesmo container é anti-padrão (dois processos/preocupações,
  supervisor, imagem grande, mais superfície de config/segurança)
- Contradiz "menor Docker/simplicidade" (mesma razão que reprovou o MongoDB no ADR-005)
- Persistência não é arquivo único portável (data dir do Postgres)
- Pesado demais para associações (multi-instância)
- Busca vetorial **não é requisito** (busca semântica = expansão SKOS, não embeddings)

### Opção 3: DuckDB (embutida, OLAP) — rejeitada como primária

**Prós:**
- Embutida, colunar, ótima para varreduras analíticas (dashboards)

**Contras:**
- Otimizada para OLAP/leitura analítica, não para índice transacional com updates linha-a-linha e escrita
  concorrente no harvest
- FTS menos maduro
- Modelo de concorrência de escrita mais limitado
- Pode complementar analytics no futuro, não é o índice primário

### Opção 4: Postgres embutido / PGlite (WASM) — rejeitada

**Contras:**
- PGlite é single-connection, experimental, não é servidor concorrente de produção
- `embedded-postgres` empacota binários do servidor (volta ao problema da opção 2)
- Maturidade insuficiente para índice público

### Opção 5: MongoDB / qualquer banco cliente-servidor por instância — rejeitada

**Contras:**
- Já reprovado para toda a federação no ADR-005; as mesmas razões (tamanho de Docker, servidor a
  administrar) são amplificadas pelo requisito multi-instância

## Decisão

Adotar **SQLite (JSON1 + FTS5, WAL)** embutida via `better-sqlite3` como engine do índice do Pluriverso, com
um arquivo único portável num volume externo apontado por `SQLITE_DB_PATH`. A decisão se desdobra em seis
pontos (DB1–DB6):

- **DB1 — SQLite embutida como engine do índice do Pluriverso**, via `better-sqlite3` (stack Node/SvelteKit
  dos Parâmetros de Desenvolvimento). A engine é biblioteca linkada no processo da aplicação, **dentro do
  mesmo container** — sem servidor de banco separado.
- **DB2 — Um arquivo único, externo ao container, via `SQLITE_DB_PATH`** (default `/data/pluriverso.sqlite`),
  montado como volume. WAL: `journal_mode=WAL`, `foreign_keys=ON`, `busy_timeout=5000` (mesmos pragmas do
  ADR-005 DA1). Isto **reconcilia** as duas restrições: engine no mesmo container (biblioteca) + arquivo
  externo (volume). `SQLITE_DB_PATH` é a materialização do `DB_PATH` do Parâmetro 3, com o mesmo nome usado
  no resto da federação (ADR-005).
- **DB3 — Documento JSON por linha (JSON1) + colunas geradas** (idêntico ao ADR-005 DA2): tabelas
  `id TEXT PRIMARY KEY, doc TEXT NOT NULL CHECK(json_valid(doc)), created_at TEXT, updated_at TEXT`; índices
  materializados como `GENERATED ALWAYS AS (json_extract(doc,'$.campo')) VIRTUAL` + `CREATE INDEX`.
  `member_id`/`record_id` originais **preservados** (transparência de origem, ADR-004); identificadores
  internos próprios em **UUIDv7** (Parâmetro 3); timestamps ISO-8601.
- **DB4 — Busca textual via FTS5** (idêntico ao ADR-005 DA4): `tokenize='unicode61 remove_diacritics 2'`,
  ranking `bm25()`, sincronizada na transação de escrita do harvest.
- **DB5 — Busca semântica via mapeamentos SKOS-XL no próprio SQLite**: tabela de mapeamentos
  (`skos:exactMatch|closeMatch|broadMatch|narrowMatch`) consultada com CTE recursiva para expansão de
  consulta. **Sem** banco de grafo nem banco vetorial dedicado (busca semântica = expansão SKOS, não
  embeddings). *Extensão futura opcional, fora de escopo:* `sqlite-vec` se busca por embedding vier a ser
  desejada.
- **DB6 — Reaproveitamento do padrão da federação**: o índice do Pluriverso segue o mesmo padrão de
  persistência/busca das unidades-membro (ADR-005), reduzindo divergência de código/operação. Biblioteca de
  acesso: `better-sqlite3`.

## Consequências

### Positivas

- Embutido/portável, Docker mínimo, auto-hospedável, reuso de código da federação, backup = copiar arquivo

### Negativas

- Escritor único / sem escala horizontal
- Módulo nativo exige toolchain no build

### Mitigações

- Escritor único é aceitável: harvest é lote e WAL não bloqueia leitores; escala é obtida pelo **número de
  instâncias** Pluriverso (ver ADR-009), não pela escala vertical de uma
- Toolchain de build isolado no estágio de build de uma imagem Alpine multi-stage; runtime final enxuto

## Relações

- **Consolida e especializa o ADR-005 (DA7)** — não o supersede; detalha engine, pragmas, modelo de dados e
  a análise comparativa específica do Pluriverso.
- **É pré-requisito de infraestrutura do ADR-009** (multi-instância): engine sem servidor viabiliza N
  instâncias auto-hospedadas.
- **Não altera o contrato de harvest REST (ADR-004/D6, ADR-006)** — a persistência interna é transparente à
  federação.

## Referências

- [ADR-005: Persistência SQLite com JSON por Unidade Federada (v3.1)](ADR-005-sqlite-json-persistence.md)
- [ADR-004: Arquitetura Federada v3.0](ADR-004-federated-architecture.md)
- [ADR-009: Topologia Multi-Instância do Pluriverso](ADR-009-pluriverso-multi-instance-topology.md)
- `Desenvolvimento.md` (Parâmetros de Desenvolvimento)
- [SQLite JSON1 Extension](https://www.sqlite.org/json1.html)
- [SQLite FTS5 Extension](https://www.sqlite.org/fts5.html)
- [better-sqlite3](https://github.com/WiseLibs/better-sqlite3)

## Data de Revisão

Após a primeira implementação de código do Pluriverso e a primeira coleta em produção.
