# ADR-005: Persistência SQLite com JSON por Unidade Federada (v3.1)

## Status

**Aceito** — Julho 2026

## Contexto

A versão 3.0 (ADR-004) redefiniu a arquitetura como explicitamente federada — cada unidade (iniciativa de
fontes secundárias ou comunidade tradicional) soberana sobre seus próprios dados. No entanto, a persistência
ainda pressupunha **MongoDB por membro** (ADR-001, D5 do ADR-004): cada unidade operaria seu próprio servidor
MongoDB, replicando a complexidade operacional de um banco cliente-servidor em cada implantação.

Essa premissa entra em tensão com dois princípios centrais do projeto:

- **Soberania real**: um servidor de banco de dados separado, com seu próprio processo, rede interna e
  administração, é uma peça de infraestrutura adicional que cada comunidade — muitas vezes com recursos
  técnicos e operacionais limitados — precisa manter. Um banco **embutido** (embedded), que é apenas um
  arquivo no disco, entrega a mesma soberania com fricção operacional mínima: copiar o arquivo é o backup;
  não há processo de servidor para monitorar, atualizar ou proteger separadamente.
- **Simplicidade e tamanho de Docker** (diretriz fixa do projeto): um container que também precisa empacotar
  e orquestrar um `mongod` é maior, mais lento para subir e tem mais superfície de configuração/segurança do
  que um container que abre um arquivo local.

Adicionalmente, cada unidade federada (DA1) passou a ser empacotada como **um único container** hospedando
duas ferramentas fortemente integradas (ex.: BioCultDB + BioCultTermos), o que torna natural que elas
compartilhem um único arquivo de banco em vez de dois processos de banco separados.

## Decisão

Adotar **SQLite com JSON (JSON1)** como mecanismo de persistência de cada unidade federada, substituindo o
MongoDB por membro previsto no ADR-001/ADR-004. A decisão se desdobra em oito pontos (DA1–DA8), harmonizados
em todas as ferramentas (BioCultDB, BioCultTermos, BioCultRelatos, BioCultPapers, Pluriverso):

- **DA1 — Um arquivo por unidade, compartilhado pelas ferramentas, um container por unidade.** Cada unidade
  federada (Unidade de Fontes Secundárias = BioCultDB + BioCultTermos; Unidade Comunidade Tradicional =
  BioCultRelatos + BioCultTermos) é empacotada como **um único container** e usa **um único arquivo SQLite**
  (`SQLITE_DB_PATH`, default `/data/unidade.sqlite`), aberto em modo **WAL** (`journal_mode=WAL`,
  `foreign_keys=ON`, `busy_timeout=5000`), permitindo que as múltiplas interfaces/processos da unidade leiam
  e escrevam o mesmo arquivo com escrita serializada. As ferramentas da unidade compartilham o arquivo por
  meio de **tabelas distintas**, nunca de uma tabela comum. BioCultPapers, por ser aplicativo desktop fora de
  container de unidade, não participa deste compartilhamento (ver DA6).
- **DA2 — Modelo de documento JSON por linha (JSON1), colunas geradas para índices.** Cada coleção Mongo vira
  uma tabela no formato `id TEXT PRIMARY KEY, doc TEXT NOT NULL CHECK (json_valid(doc)), created_at TEXT,
  updated_at TEXT`, com consultas via `json_extract`/`json_each`/`json_tree` e índices materializados como
  colunas geradas (`GENERATED ALWAYS AS (json_extract(doc,'$.campo')) VIRTUAL`) mais `CREATE INDEX`.
  Identificadores são strings (UUID v4 ou o `_id` convertido), timestamps são strings ISO-8601.
- **DA4 — FTS5 para busca textual.** Onde havia `$text`/`$regex` no MongoDB, uma tabela virtual **FTS5**
  (`tokenize='unicode61 remove_diacritics 2'`, ranking `bm25()`) sincronizada pela própria aplicação dentro da
  transação de escrita, substitui a busca nativa do Mongo.
- **DA6 — BioCultPapers entrega por arquivo.** Sem sync direto a um banco compartilhado: BioCultPapers
  persiste localmente em SQLite+JSON e **exporta** um arquivo JSON (array de registros), que o BioCultDB
  **importa** via script/rota dedicada.
- **DA7 — Índice do Pluriverso também SQLite+JSON; contrato de harvest REST inalterado.** O Índice Central do
  Pluriverso adota o mesmo padrão de persistência (DA2) e busca (DA4). A mudança de persistência interna de
  cada unidade é **transparente** ao protocolo de harvest REST paginado definido no ADR-004 (D6), que
  permanece idêntico.
- **DA8 — etnoChat via DSL de filtro restrita, nunca SQL cru do LLM.** A feature de consulta em linguagem
  natural do BioCultDB deixa de fazer o LLM gerar sintaxe MongoDB e passa a fazer o LLM emitir um **JSON de
  filtro restrito** (whitelist de campos + operadores `eq|contains|in|gte|lte`), traduzido pela aplicação em
  **SQL parametrizado read-only** sobre `json_extract`. O LLM nunca produz SQL executado diretamente —
  elimina a superfície de injeção que existiria ao permitir isso.

Bibliotecas de acesso: `better-sqlite3` para os componentes Node.js (BioCultDB, BioCultTermos);
`Microsoft.Data.Sqlite` para o componente .NET (BioCultPapers).

## Consequências

### Positivas

- **Soberania reforçada**: o banco de cada unidade é um arquivo único e portável — backup é copiar o
  arquivo, migração é mover o arquivo, sem processo de servidor a administrar.
- **Docker menor e mais simples**: nenhuma unidade precisa mais empacotar ou orquestrar um servidor de banco
  separado; o container da unidade só abre um arquivo local, reduzindo tamanho de imagem, tempo de start e
  superfície de configuração/segurança — alinhado à diretriz fixa do projeto de priorizar simplicidade e
  tamanho de Docker.
- **Integração forte por unidade**: as ferramentas que compõem uma unidade (ex.: BioCultDB e BioCultTermos)
  compartilham o mesmo arquivo, permitindo que uma leia dados da outra (ex.: `AcquisitionService`) sem
  depender de rede, autenticação de banco ou disponibilidade de um serviço externo.

### Negativas

- **Escrita serializada por arquivo**: SQLite permite um único escritor por vez mesmo em WAL, o que limita
  a taxa de escrita concorrente comparado a um servidor multi-processo como o MongoDB.
  - *Mitigação*: modo WAL (leitores não bloqueiam escritores) e `busy_timeout` absorvem a contenção; o
    volume de escrita esperado por unidade (poucas dezenas de operações por minuto) está muito abaixo do
    limite prático de um único arquivo SQLite.
- **Sem escala horizontal nativa**: um arquivo SQLite não replica nem particiona automaticamente entre
  múltiplos nós, ao contrário de um cluster MongoDB.
  - *Mitigação*: aceitável no contexto da arquitetura — cada unidade federada é pequena, independente e
    soberana por definição (DA1); escala é obtida horizontalmente pelo número de unidades na federação, não
    pela escala vertical de uma unidade individual.

## Relações

- Esta decisão **supersede o ADR-001** (Abordagem de Armazenamento de Dados), que recomendava um banco
  orientado a documentos com implementação em MongoDB. O modelo conceitual de documento JSON do ADR-001
  permanece válido; a implementação concreta muda de MongoDB (cliente-servidor) para SQLite+JSON (embutido).
- Esta decisão **supersede a decisão D5 do ADR-004** ("Posição do MongoDB: Pertence à Iniciativa #1"), que
  previa cada unidade operando seu próprio servidor MongoDB. As demais decisões do ADR-004 (D1–D4, D6, D7 —
  modelo de harvest, governança federada, remoção de membros, protocolo de publicação REST, exclusividade do
  BioCultPapers) permanecem inalteradas; apenas a camada de persistência interna de cada unidade muda.

## Referências

- [ADR-001: Abordagem de Armazenamento de Dados](ADR-001-database-selection.md)
- [ADR-004: Arquitetura Federada v3.0](ADR-004-federated-architecture.md)
- [SQLite JSON1 Extension](https://www.sqlite.org/json1.html)
- [SQLite FTS5 Extension](https://www.sqlite.org/fts5.html)
- [better-sqlite3](https://github.com/WiseLibs/better-sqlite3)
- [Microsoft.Data.Sqlite](https://learn.microsoft.com/dotnet/standard/data/sqlite/)

## Data de Revisão

Revisar após conclusão da migração de código e dados em todas as ferramentas (BioCultDB, BioCultTermos,
BioCultPapers) e da primeira unidade empacotada em container único (estimado: segundo semestre de 2026).
