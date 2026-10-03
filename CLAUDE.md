## Registro de prompts — primeiro ato de toda sessão

Antes de qualquer outro trabalho, acrescente o prompt do usuário, **literal**, ao fim de `Pesquisa/IA/registro-de-prompts.md` (formato e regras de omissão no cabeçalho do arquivo). Repita para cada prompt seguinte da sessão, inclusive os curtos. O commit do trabalho inclui o registro e a entrada cita o commit. Transparência do uso de IA: `Pesquisa/projetoPesquisa.md` §7.2, item 9.

## Reuniões de governança e Issues

Ao absorver o resumo de uma reunião, gerar impactos ou gerar pauta: siga o ciclo e a **Revisão das Issues** de `Governanca/Arquitetura/README.md` (todas as abertas e as fechadas desde a última reunião, uma a uma, com comentários). Issues e pauta só mudam depois que o Ponto-Focal valida o resumo. Escrita e etiquetas das Issues: `docs/agents/issue-tracker.md`. Mudança na forma de trabalhar: nova entrada em `Governanca/Arquitetura/metodo-de-evolucao.md` §5.

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

Rules:
- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).

## Arquitetura v3.1 — Persistência
Persistência = SQLite com JSON (JSON1), **um arquivo por unidade federada** compartilhado pelas ferramentas (tabelas distintas), WAL, `SQLITE_DB_PATH`. Um container por unidade. Sem MongoDB.
Ref.: Arquitetura-BioCultural/docs/architecture-decisions/ADR-005.

## Agent skills

### Issue tracker

Issues live as GitHub issues, managed via the `gh` CLI. See `docs/agents/issue-tracker.md`.

### Domain docs

Single-context layout: glossário em `docs/CONTEXT.md`, ADRs em `docs/architecture-decisions/`. See `docs/agents/domain.md`.

### Estrutura do repositório

Raiz só com `README.md`, `LICENSE`, `CLAUDE.md`. Humanos: `ComecePorAqui/`, `Governanca/` (camadas e reuniões em `Governanca/Arquitetura/Reunioes/`), `Pesquisa/` (projeto de pesquisa, `IA/`). Técnico: `docs/` — caminhos estáveis, outros repositórios apontam para eles; não mova arquivos de `docs/`.
