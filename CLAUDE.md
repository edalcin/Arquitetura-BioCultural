## Registro de prompts — primeiro ato de toda sessão

Antes de qualquer outro trabalho, acrescente o prompt do usuário, **literal**, ao arquivo do dia `docs/Pesquisa/IA/prompts/AAAA/AAAA-MM-DD.md`, na seção da sessão atual (crie o arquivo, a seção `## Sessão N` e a linha na tabela de `docs/Pesquisa/IA/registro-de-prompts.md` quando forem novos). Numeração `P-NNNN` contínua entre dias; regras de formato e de omissão no índice. Repita para cada prompt seguinte, inclusive os curtos. O commit do trabalho inclui o registro e a entrada cita o commit. Transparência do uso de IA: `docs/Pesquisa/projetoPesquisa.md` §7.2, item 9.

## Reuniões de governança e Issues

Ao absorver o resumo de uma reunião, gerar impactos ou gerar pauta: siga o ciclo e a **Revisão das Issues** de `docs/Governanca/Arquitetura/README.md` (todas as abertas e as fechadas desde a última reunião, uma a uma, com comentários). Issues e pauta só mudam depois que o Ponto-Focal valida o resumo. Escrita e etiquetas das Issues: `docs/tecnico/agents/issue-tracker.md`. Mudança na forma de trabalhar: nova entrada em `docs/Governanca/Arquitetura/metodo-de-evolucao.md` §5.

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

Rules:
- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).

## Arquitetura v3.1 — Persistência
Persistência = SQLite com JSON (JSON1), **um arquivo por unidade federada** compartilhado pelas ferramentas (tabelas distintas), WAL, `SQLITE_DB_PATH`. Um container por unidade. Sem MongoDB.
Ref.: `docs/tecnico/architecture-decisions/ADR-005-sqlite-json-persistence.md`.

## Agent skills

### Issue tracker

Issues live as GitHub issues, managed via the `gh` CLI. See `docs/tecnico/agents/issue-tracker.md`.

### Domain docs

Single-context layout: glossário em `docs/tecnico/CONTEXT.md`, ADRs em `docs/tecnico/architecture-decisions/`. See `docs/tecnico/agents/domain.md`.

### Estrutura do repositório — onde está a documentação técnica

Raiz só com `README.md`, `LICENSE`, `CLAUDE.md`, `ComecePorAqui/` (entrada para humanos) e `docs/`. Toda a documentação está em `docs/`:

- **`docs/tecnico/`** — tudo o que um agente precisa para trabalhar na arquitetura. Comece por `docs/tecnico/README.md` (índice técnico + descrição completa). Glossário `docs/tecnico/CONTEXT.md`; ADRs `docs/tecnico/architecture-decisions/`; C4 `docs/tecnico/c4-model/`; modelo de dados `docs/tecnico/modelo-de-dados-unificado.md`; contrato de coleta `docs/tecnico/contrato-harvest.md`; rótulos `docs/tecnico/rotulos-skos-xl.md`; impactos consolidados `docs/tecnico/impactos-na-arquitetura.md`; estado e pendências `docs/tecnico/proximosPassos.md`; versões `docs/tecnico/CHANGELOG.md`; convenções de agentes `docs/tecnico/agents/`.
- **`docs/Governanca/`** — governança (proposta, camadas, reuniões em `docs/Governanca/Arquitetura/Reunioes/`, método em `docs/Governanca/Arquitetura/metodo-de-evolucao.md`).
- **`docs/Pesquisa/`** — projeto de pesquisa, referências, `IA/` (uso de IA, registro de prompts).

Mover um arquivo exige corrigir os links nos outros repositórios da federação (BioCultDB, BioCultRelatos, BioCultAcervos, BioCultNaturalistas, BioCultTermos, pluriverso), que apontam para `docs/tecnico/`.
