---
type: Procedimento
description: "Regra de escrita para agentes de IA: a ficha OKF (frontmatter) de todo arquivo .md deste repositório."
---

# OKF: writing rule for agents

This repo is an Open Knowledge Format (OKF) v0.2 bundle. Decision and reasons:
[ADR-020](../architecture-decisions/ADR-020-adocao-do-okf.md). This file is the operational rule.

## Every `.md` has a ficha

Every `.md` in the repo, except `CLAUDE.md`, starts with a ficha (YAML frontmatter) on **line 1**.
A new file is born with it; this includes the daily prompts file (`type: Prompts do dia`).

```yaml
---
type: Guia
description: "Uma frase, em português, que diz o que o documento é e para que serve."
---
```

- **Fields:** `type` and `description`, always. `status` only as below. Nothing else: no `title`,
  `tags`, `resource`, `generated`, `verified`, `sources`, `stale_after`. The CI rejects unknown fields.
- **`type`:** the genre of the document (what it is), never its topic or folder. Use only a value
  listed in `docs/tecnico/okf-base.yaml`; read the one-line comment of each value. No value fits? Add
  one to the manifest in the same commit, with its comment, and say why in the commit message.
- **`description`:** one sentence, in double quotes (a `: ` inside an unquoted value breaks the YAML).
- **`ComecePorAqui/` and `docs/Governanca/`:** only `type` and `description`, in plain Portuguese —
  no jargon, no codes (`I-xx`, `⑭`, ADR numbers).

## `status`

| Where | Rule |
|---|---|
| ADRs | Always. *Proposto* → `draft`; *Aceito*, *Implementado* → `stable`; *Depreciado*, *Substituído* (*Supersedido*), *Rejeitado* → `deprecated`. When the ADR status changes, change the `## Status` section and the `status` field in the same commit. |
| `ComecePorAqui/`, `docs/Governanca/` | Never. |
| Other files | Only `draft` (text under construction) or `deprecated` (replaced text). Omit for `stable`. |

## Do not

- Create `index.md` or `log.md`: they are reserved names with other rules. `README.md` and
  `CHANGELOG.md` are normal concepts with a ficha.
- Rename files to fit OKF: other federation repos link to `docs/tecnico/`.

## Check before commit

```bash
uv tool run --from okflint==0.5.1 okflint validate --manifest docs/tecnico/okf-base.yaml
```

Exit 0 = conformant. Broken-link warnings (images count as broken links) do not fail.
