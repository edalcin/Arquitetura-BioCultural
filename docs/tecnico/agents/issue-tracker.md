# Issue tracker: GitHub

Issues and PRDs for this repo live as GitHub issues. Use the `gh` CLI for all operations.

## Conventions

- **Create an issue**: `gh issue create --title "..." --body "..."`. Use a heredoc for multi-line bodies.
- **Read an issue**: `gh issue view <number> --comments`, filtering comments by `jq` and also fetching labels.
- **List issues**: `gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'` with appropriate `--label` and `--state` filters.
- **Comment on an issue**: `gh issue comment <number> --body "..."`
- **Apply / remove labels**: `gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- **Close**: `gh issue close <number> --comment "..."`

Infer the repo from `git remote -v` — `gh` does this automatically when run inside a clone.

## Governance questions (this repo's main use of Issues)

Since 2026-10-03 every open question that needs a person's answer is one Issue: the single place of its state. Readers are non-technical experts in traditional knowledge (Ponto-Focal, communities via the Ponto-Focal). The meeting cycle and the mandatory **Revisão das Issues** live in `docs/Governanca/Arquitetura/README.md`; read it before generating any pauta or impact document. The prompt for each cycle moment (C1–C3, P1–P3, E1–E2, A1) is in `docs/Governanca/Arquitetura/roteiro-de-prompts.md`: never cross the human gate the prompt stops at.

- **Writing.** Portuguese, plain words, `docs/tecnico/CONTEXT.md` vocabulary. Title = the question, no codes. Body follows `.github/ISSUE_TEMPLATE/questao.yml`: O que está em jogo · O que a arquitetura faz hoje · Opções (table with consequences) · Pergunta · **Para fechar esta questão** (what answer, from whom, where) · Origem (full links) · Liga-se a (the only place for `I-xx`, ADR, `⑭` codes). Informes use O que queremos saber · Por que importa · Para fechar · Origem · Liga-se a.
- **Privacy.** Public repo: design, never values — no traditional knowledge, holder names, sensitive places or personal data. Moderate comments that expose them.
- **Labels** (create nothing new without a reason recorded in `docs/Governanca/Arquitetura/metodo-de-evolucao.md`):
  - who answers: `para-ponto-focal`, `para-comunidades`, `para-gestao` (Eduardo; never on a pauta);
  - type: `decisao`, `informe`, `duvida`;
  - status: `aguarda-terceiros`;
  - tipo de fonte: `fonte-primaria` (BioCultRelatos), `fonte-secundaria` (BioCultDB), `fonte-acervos` (BioCultAcervos), `fonte-naturalistas` (BioCultNaturalistas). No fonte label = all sources. Use them to route a question to the governance participant for that source.
- **Milestones.** "Próxima reunião" (renamed "Reunião AAAA-MM-DD" with due date on the meeting day) = pauta candidates: at most 3 `decisao` (four-part structure) plus the **decisões de abertura** (short decisions about how the governance itself works — consent, licence, way of working — one line each in the Abertura) plus informes. No milestone = waiting in the queue (normal for `para-comunidades`).
- **Comments and closing: plain words, no fixed format.** People comment and answer as they would in an e-mail. Whoever closes writes one or two plain sentences: what was decided, and where (meeting of DD/MM, or "here, in this Issue"). No template, no codes in the comment — the link to `I-xx` lives in the meeting's impact document, not in the Issue. Close as *completed*; out of scope = *not planned*, with the reason in a sentence; reopening is normal. Agents read every comment as it is and never ask anyone to rewrite in a format.
- **Translate, both ways.** Read what people write in their own words and carry the meaning into technical documents (quote the original sentence with a link where meaning matters); write back to them in plain words. An ambiguous comment becomes a plain-words question back, never a rule. See `docs/Governanca/Arquitetura/metodo-de-evolucao.md` §3, "A IA traduz, nos dois sentidos".
- **Open channel.** Anyone with a GitHub account may comment or open an Issue, not only governance participants. In every Revisão das Issues, give each comment and each new Issue — whoever wrote it — a destination: new question, merged into an existing one, a document change, or a plain-words reply explaining why nothing changes. Contributions inform decisions; they do not replace the governance's decision or a community's consent.
- **When Issues change.** Create, close or comment only after the meeting summary is validated by the Ponto-Focal (merged PR or explicit "sem correções"). Batch the changes; one Issue per question. An answer given in an Issue between meetings counts as a decision (pending #8) and goes into the next summary's "Decisões entre reuniões".
- **Links in repo files.** GitHub does not autolink `#N` inside `.md` files: write `https://github.com/edalcin/Arquitetura-BioCultural/issues/N`.

## Pull requests as a triage surface

**PRs as a request surface: no.** _(Set to `yes` if this repo treats external PRs as feature requests; `/triage` reads this flag.)_

When set to `yes`, PRs run through the same labels and states as issues, using the `gh pr` equivalents:

- **Read a PR**: `gh pr view <number> --comments` and `gh pr diff <number>` for the diff.
- **List external PRs for triage**: `gh pr list --state open --json number,title,body,labels,author,authorAssociation,comments` then keep only `authorAssociation` of `CONTRIBUTOR`, `FIRST_TIME_CONTRIBUTOR`, or `NONE` (drop `OWNER`/`MEMBER`/`COLLABORATOR`).
- **Comment / label / close**: `gh pr comment`, `gh pr edit --add-label`/`--remove-label`, `gh pr close`.

GitHub shares one number space across issues and PRs, so a bare `#42` may be either — resolve with `gh pr view 42` and fall back to `gh issue view 42`.

## When a skill says "publish to the issue tracker"

Create a GitHub issue.

## When a skill says "fetch the relevant ticket"

Run `gh issue view <number> --comments`.

## Wayfinding operations

Used by `/wayfinder`. The **map** is a single issue with **child** issues as tickets.

- **Map**: a single issue labelled `wayfinder:map`, holding the Notes / Decisions-so-far / Fog body. `gh issue create --label wayfinder:map`.
- **Child ticket**: an issue linked to the map as a GitHub sub-issue (`gh api --method POST repos/<owner>/<repo>/issues/<map>/sub_issues -F sub_issue_id=<child-db-id>`). Where sub-issues aren't enabled, add the child to a task list in the map body and put `Part of #<map>` at the top of the child body. Once claimed, the ticket is assigned to the driving dev.
- **This repo's map**: #6, "Mapa: questões da governança da arquitetura até o fechamento das regras" (pinned; headings in Portuguese: Destino, Notas, Decisões até agora, Ainda sem forma, Fora do escopo). Its children are the governance questions. **Ticket type is carried by the governance labels, not by `wayfinder:<type>` labels**, to keep the surface plain for non-technical readers: `para-ponto-focal` / `para-comunidades` = HITL, resolved only by that person's or the communities' answer (an agent never answers for them); `para-gestao` = task. `para-gestao` and articulation issues stay outside the map.
- **Blocking**: GitHub's **native issue dependencies** — the canonical, UI-visible representation. Add an edge with `gh api --method POST repos/<owner>/<repo>/issues/<child>/dependencies/blocked_by -F issue_id=<blocker-db-id>`, where `<blocker-db-id>` is the blocker's numeric **database id** (`gh api repos/<owner>/<repo>/issues/<n> --jq .id`, _not_ the `#number` or `node_id`). GitHub reports `issue_dependencies_summary.blocked_by` (open blockers only — the live gate). Where dependencies aren't available, fall back to a `Blocked by: #<n>, #<n>` line at the top of the child body. A ticket is unblocked when every blocker is closed.
- **Frontier query**: list the map's open children (`gh issue list --state open`, scoped to the map's sub-issues / task list), drop any with an open blocker (`issue_dependencies_summary.blocked_by > 0`, or an open issue in the `Blocked by` line) or an assignee; first in map order wins.
- **Claim**: `gh issue edit <n> --add-assignee @me` — the session's first write.
- **Resolve**: a plain-words closing comment (see above), then `gh issue close <n>`, then append a context pointer (gist + link) to the map's "Decisões até agora".
