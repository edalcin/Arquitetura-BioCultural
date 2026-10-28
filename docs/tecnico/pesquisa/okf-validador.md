# Pesquisa — validador do OKF: `okflint` no CI ou script próprio

> Resolve o ticket [#54](https://github.com/edalcin/Arquitetura-BioCultural/issues/54) do mapa
> [#47](https://github.com/edalcin/Arquitetura-BioCultural/issues/47) (adotar o Open Knowledge Format v0.2).
> Pesquisa de 28/10/2026. Li o código-fonte e a documentação do `okflint` e **rodei** a versão 0.5.1 numa
> cópia temporária dos `.md` deste repositório (nada foi alterado no repositório).

## 0. Como ler

- Cada fato sobre o `okflint` vem do repositório dele ([mattdav/okflint](https://github.com/mattdav/okflint)),
  do PyPI ou de um teste que rodei; a fonte está ao lado.
- **[teste]** = rodei e vi o resultado. **[não verificado]** = não consegui confirmar numa fonte primária
  nem rodando. **[inferência]** = conclusão minha.
- "Bundle" = a pasta cujos `.md` seguem o OKF. Onde ela começa e termina é decisão dos tickets
  [#48](https://github.com/edalcin/Arquitetura-BioCultural/issues/48) e
  [#51](https://github.com/edalcin/Arquitetura-BioCultural/issues/51); aqui uso um bundle de teste.

## 1. Resumo para quem decide

1. **Use o `okflint` no CI, com a versão fixada.** Ele faz de graça o que exigiríamos (o `type` do
   vocabulário fechado, datas e valores de `status` controlados) e mais as regras do próprio OKF.
2. **O que deve travar o *merge*:** o comando `okflint validate` (sai com código 1 se houver erro de
   OKF ou do nosso perfil). Os avisos (links quebrados, regras opcionais) **não** travam.
3. O script próprio em Python (25 linhas, só biblioteca padrão) **só confere o `type`**. Serve de
   plano B se o `okflint` sumir; não substitui.
4. Limites a conhecer antes de ligar: projeto novo e de uma pessoa só (0.x, beta), exige Python 3.12+,
   não distingue maiúsculas de minúsculas no `type`, e acusa imagens como "link quebrado" (só aviso).

## 2. Maturidade, licença e manutenção

| Item | O que encontrei | Fonte |
| --- | --- | --- |
| Licença | MIT | [`pyproject.toml`](https://raw.githubusercontent.com/mattdav/okflint/main/pyproject.toml), API do GitHub |
| Versão atual | 0.5.1, de 23/10/2026; classificação "Development Status :: 4 - Beta" | `pyproject.toml`, [PyPI](https://pypi.org/project/okflint/) |
| Idade | repositório criado em 27/06/2026; 11 versões em 4 meses (de 0.1.0 a 0.5.1) | API do GitHub (releases), PyPI |
| Atividade | último *push* em 23/10/2026; CI do próprio projeto passando; 0 *issues* abertas | API do GitHub |
| Quem mantém | 1 autor (Matthieu Daviaud) e 1 colaborador a mais; 10 estrelas, 2 *forks* | API do GitHub (`contributors`, repositório) |
| Versionamento | `major_version_zero = true`: antes da 1.0, qualquer versão pode mudar regras | `pyproject.toml` (`[tool.commitizen]`) |
| Dependências | só `pyyaml` e `beartype`; Python 3.12 ou mais novo | `pyproject.toml`, PyPI |
| Testes | `pytest` com cobertura mínima de 85% exigida | `pyproject.toml` (`fail_under = 85`) |
| Alinhamento | cita a especificação OKF do Google (`GoogleCloudPlatform/knowledge-catalog/okf/SPEC.md`) e implementa a v0.2 | [README](https://github.com/mattdav/okflint), [`config/RULES.md`](https://raw.githubusercontent.com/mattdav/okflint/main/config/RULES.md) |

**[inferência]** É jovem e depende de uma pessoa. O risco real não é a licença (MIT, podemos copiar
ou manter uma cópia), e sim uma versão nova mudar uma regra e quebrar o CI sem ninguém ter mexido nos
documentos. Fixar a versão (`okflint==0.5.1`) resolve isso.

## 3. O que ele confere (regras)

O `okflint` separa três níveis ([`RULES.md`](https://raw.githubusercontent.com/mattdav/okflint/main/config/RULES.md)):

| Nível | Quem manda | Efeito no código de saída | Regras principais |
| --- | --- | --- | --- |
| **Núcleo OKF** | a especificação | erro, sai 1 | `F001` sem frontmatter; `F002` sem `type`; `R001` `index.md` com frontmatter; `R002` data fora de AAAA-MM-DD em `log.md`; `F003` a `F005` (campos da v0.2) |
| **Perfil** | o nosso manifesto | erro, sai 1 | `F101` `type` fora do vocabulário; `F102` campo obrigatório ausente; `F105` valor fora do vocabulário (ex.: `status`); `F106` grafia de alias; `S102` data fora de AAAA-MM-DD |
| **Higiene** | mais rígido que o OKF | aviso, sai 0 (cada uma pode virar `error`) | `L001`–`L003` links; `S202` sugestão de dividir arquivo; `R201` falta de `index.md`/`log.md`; `F201` campo desconhecido; `S203`–`S210` formas do v0.2 (`status`, `generated`, `verified`, `stale_after`) |

Sai 0 sem erros, 1 com erro de conformidade, 2 se o manifesto for inválido
([README](https://github.com/mattdav/okflint), seção `validate`). Há também `--json` para saída
legível por máquina e `validate-manifest` para checar só o manifesto.

## 4. O manifesto `okf-base.yaml` responde ao que precisamos?

Fontes: [`manifest.example.yaml`](https://raw.githubusercontent.com/mattdav/okflint/main/example/manifest.example.yaml),
[`manifest.py`](https://raw.githubusercontent.com/mattdav/okflint/main/src/okflint/manifest.py),
[`scanner.py`](https://raw.githubusercontent.com/mattdav/okflint/main/src/okflint/scanner.py) e meus testes.

| Pergunta | Resposta |
| --- | --- |
| Dá para **fechar o vocabulário de `type`**? | **Sim.** Cada chave de `profile.types` é um `type` permitido; qualquer outro dá `F101` (erro). **[teste]** `type: Glossario` → `F101`. |
| Dá para exigir campos por tipo? | Sim: `required` e `optional` por tipo; `F102` se faltar. Com `hygiene.unknown_fields: error`, campo fora da lista também trava (`F201`). **[teste]** `tag:` no lugar de `tags:` → `F201`. |
| Dá para controlar valores (ex.: `status`)? | Sim: `status_values: [draft, stable, deprecated]` dentro do tipo (vale para qualquer campo: `<campo>_values`). **[teste]** `status: wip` → `F105`. Declarar `status_values` desliga o aviso `S203` do vocabulário padrão do OKF. |
| Dá para **ignorar caminhos** (`README.md` etc.)? | **Sim**, por `base.roots[].exclude_patterns`, padrões `fnmatch` relativos à raiz. **[teste]** com `README.md`, `*/README.md`, `CHANGELOG.md`, `CLAUDE.md` e `docs/Pesquisa/IA/prompts/*`, nenhum deles foi cobrado. Atenção: em `fnmatch`, `*` também casa `/` e `**` não é especial; o `README.md` da raiz exige o padrão `README.md` além de `*/README.md`. |
| O que acontece com um `.md` que não é `index.md` nem `log.md` e **não** foi ignorado? | `F001` (sem frontmatter). **[teste]** Na cópia, 73 arquivos sem frontmatter deram 73 erros `F001`; depois de eu pôr `type: Reference` em todos, 0 erros. |
| Dá para chamar o `README.md` de arquivo reservado (como o `index.md`)? | Sim, o manifesto aceita `base.reserved_files.index: "README.md"`. Aí o `README.md` não precisa de frontmatter, e **com** frontmatter dá `R001`. **[teste]** Interessa ao ticket #51. |
| Links para arquivo ignorado contam como quebrados? | Não. **[teste]** `[a](README.md)`, `[b](/docs/tecnico/CHANGELOG.md)` e `[c](../../README.md)` passaram. |

### Limites que achei

- **`type` não distingue maiúsculas.** **[teste]** `type: reference` passou sem aviso contra `Reference`
  declarado (o código compara em minúsculas: [`validate.py`](https://raw.githubusercontent.com/mattdav/okflint/main/src/okflint/validate.py),
  função que resolve o tipo, "exact match → case-insensitive → aliases"). Quem quiser grafia exata precisa
  do script próprio.
- **Imagens viram "link quebrado".** **[teste]** `governanca-tres-camadas.png` etc. deram `L002`, porque o
  índice só conhece `.md`. Por isso `broken_links` deve ficar em `warn` (ou `off`), nunca `error`.
- `base.reserved_files` (com `index` e `log`) é **obrigatório** no manifesto, mesmo que a gente não use
  esses arquivos ([`manifest.py`](https://raw.githubusercontent.com/mattdav/okflint/main/src/okflint/manifest.py)).
- Sem opção de ignorar uma regra num arquivo só: só por exclusão do arquivo inteiro. **[não verificado]**
  em todo o código; não achei no manifesto nem no `RULES.md`.

## 5. Instalação e uso no GitHub Actions

- **Tamanho:** instalar numa venv nova ocupou **5,9 MB** (`okflint`, `pyyaml`, `beartype`). **[teste]**
- **Velocidade:** `uv tool run okflint validate` em cerca de 80 arquivos `.md` levou cerca de 0,3 s com o pacote
  já em cache. **[teste]**
- **Python:** exige 3.12+. O CI do próprio `okflint` usa `actions/setup-python@v5` com 3.12 em
  `ubuntu-24.04` ([`ci.yml`](https://raw.githubusercontent.com/mattdav/okflint/main/.github/workflows/ci.yml)).
- **Receita da documentação dele** (README, "CI GitHub Actions integration"): `pip install okflint` e
  `okflint validate --manifest <manifesto> <pasta>`.
- Este repositório **ainda não tem** `.github/workflows/` (só `ISSUE_TEMPLATE`), conferido em
  `origin/main` em 28/10/2026.

Fluxo mínimo que recomendo (**não rodei no GitHub Actions**; testei os mesmos comandos localmente no
Windows com `uv tool run`):

```yaml
name: OKF
on:
  pull_request:
  push:
    branches: [main]
jobs:
  okf:
    runs-on: ubuntu-24.04
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: "3.12"
      - run: pip install okflint==0.5.1
      - run: okflint validate --manifest okf-base.yaml
```

Para o *merge* ficar de fato bloqueado, o GitHub precisa de uma regra de proteção do `main` que marque
esse *job* como verificação obrigatória. **[não verificado]** nas páginas do GitHub; é configuração do
repositório, não do `okflint`.

## 6. A alternativa: script próprio (biblioteca padrão)

Escrevi um protótipo de 25 linhas (só `re` e `pathlib`) e rodei na mesma cópia **[teste]**. Ele acusou
corretamente: arquivo sem frontmatter, `type` ausente, `type` fora do vocabulário e `reference` em
minúsculas (que o `okflint` deixou passar).

O que ele **não** faz, e o `okflint` faz:

| Regra | Script próprio | `okflint` |
| --- | --- | --- |
| `type` ausente / fora do vocabulário | sim (grafia exata) | sim (sem distinguir maiúsculas) |
| frontmatter ausente | sim | sim |
| campos obrigatórios por tipo, campo desconhecido | não | sim (`F102`, `F201`) |
| valores controlados (`status`) | não | sim (`F105`) |
| datas AAAA-MM-DD, datas impossíveis | não | sim (`S102`) |
| `index.md` sem frontmatter; `log.md` com datas ISO | não | sim (`R001`, `R002`) |
| YAML com listas e aninhados (`tags: [a, b]`, `sources:`, `generated:`) | **não lê**: só `chave: valor` simples | sim (usa `pyyaml`) |
| formas do v0.2 (`generated`, `sources`, `verified`, `stale_after`) | não | sim (`F003`, `F004`, `S204`–`S210`) |
| links entre documentos | não | sim, como aviso |

Ler YAML de verdade sem `pyyaml` não cabe na biblioteca padrão. Se o script precisar entender o
frontmatter do OKF v0.2 (que usa listas e blocos aninhados), ele passa a depender de `pyyaml` e
vira, na prática, um `okflint` pior. **[inferência]**

## 7. Recomendação

1. **Adotar o `okflint` no CI**, fixado em `okflint==0.5.1`, atualizando a versão de propósito (um PR
   que sobe o número e mostra se algo mudou).
2. **O que trava o *merge*** (`okflint validate` com saída diferente de 0):
   - núcleo do OKF: frontmatter presente, `type` não vazio, `index.md` sem frontmatter, `log.md` com
     datas ISO;
   - perfil nosso: `type` dentro do vocabulário fechado (ticket #52), campos obrigatórios por tipo,
     `status` dentro dos valores (ticket #53), datas em AAAA-MM-DD.
3. **O que só avisa** (não trava): `broken_links: warn` (por causa das imagens e do "…"),
   `okf_v02_shapes: warn` (padrão), `split_candidates: off`, `stale_content: off`.
4. **`unknown_fields`:** comece em `warn` e passe a `error` quando os tipos estiverem estáveis.
   Em `error` ele pega erros de digitação (`tag:`), mas trava o *merge* a cada campo novo que o
   manifesto ainda não conhece. **[inferência]**
5. **Manifesto:** `exclude_patterns` para `CLAUDE.md`, `CHANGELOG.md`, `docs/Pesquisa/IA/prompts/*`
   e (conforme #48/#51) os `README.md`; ou `reserved_files.index: "README.md"` se o #51 decidir que
   `README.md` faz o papel de `index.md`.
6. **Plano B de 25 linhas:** guardar o script próprio só se quisermos grafia exata do `type`
   (maiúsculas), único ponto em que ele fica à frente. Não vale um arquivo a mais enquanto o `okflint`
   resolver.

## 8. O que não consegui confirmar

- Execução no GitHub Actions de verdade (só rodei localmente, no Windows).
- Que o `main` possa exigir esta verificação (configuração do GitHub, fora do `okflint`).
- Existência de um jeito de silenciar uma regra num arquivo só.
- Estabilidade das regras entre versões 0.x: só li o início do `CHANGELOG.md` (0.5.1 e 0.5.0, que
  listam correções e uma regra nova, `S210`); não li as versões anteriores.
