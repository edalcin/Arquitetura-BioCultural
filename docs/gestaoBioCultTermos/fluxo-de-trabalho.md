# Fluxo de Trabalho — Código do BioCultTermos

Runbook operacional. O *porquê* de cada regra está em
[BioCultTermosEstrategia.md](BioCultTermosEstrategia.md) e no
[ADR-012](../architecture-decisions/ADR-012-manutencao-codigo-bioculttermos.md).

**Regra única, se você só ler uma linha:** edite dentro de `<hospedeiro>/bioculttermos/`, nunca num
clone isolado do BioCultTermos.

---

## 0. Uma vez por máquina

Sem isto, todos os erros clássicos de submodule estão habilitados por omissão.

```bash
git config --global push.recurseSubmodules on-demand
git config --global submodule.recurse true
git config --global status.submoduleSummary true
git config --global diff.submodule log
```

| Configuração | Modo de falha que deixa de existir |
|---|---|
| `push.recurseSubmodules = on-demand` | Bumpar o ponteiro para um commit nunca publicado — o CI busca um SHA inexistente e a build quebra (bug real, ADR-010) |
| `submodule.recurse = true` | `git pull` no hospedeiro deixar a Cópia de Trabalho parada na versão antiga |
| `status.submoduleSummary = true` | `git status` esconder mudanças do módulo atrás de um `modified: bioculttermos (new commits)` mudo |
| `diff.submodule = log` | `git diff` mostrar dois SHAs opacos em vez da lista de commits |

Confira:

```bash
git config --global --get-regexp "submodule|recurseSubmodules"
```

## 0b. Uma vez por Unidade Hospedeira

No `.gitmodules` versionado do hospedeiro:

```ini
[submodule "bioculttermos"]
    path = bioculttermos
    url = https://github.com/edalcin/BioCultTermos.git
    branch = main
```

Sem `branch`, `git submodule update --remote` não tem alvo declarado e cada unidade pode adotar um
alvo diferente.

---

## 1. Alterar o código do BioCultTermos

Escolha o hospedeiro pela regra: **aquele em que o problema se reproduz ou a funcionalidade se
exercita**. Se a mudança é transversal e não se prende a nenhuma unidade, use o BioCultDB — é a única
em produção.

```bash
HOST=BioCultDB          # ou BioCultRelatos / BioCultNaturalistas / BioCultAcervos

# 1. Sincronize a Cópia de Trabalho ANTES de editar
git -C D:/git/$HOST/bioculttermos pull --ff-only
```

> `--ff-only` é deliberado. Se aquela Cópia de Trabalho tiver commits locais esquecidos, ele **falha em
> voz alta** em vez de fabricar um merge silencioso. Se falhar: resolva o commit esquecido antes de
> tocar em qualquer coisa.

```bash
# 2. Edite dentro de bioculttermos/ e teste na unidade real
cd D:/git/$HOST
docker compose -f docker/docker-compose.unidade.yml up --build

# 3. Commit DENTRO do submodule
git -C bioculttermos add -A
git -C bioculttermos commit -m "fix(acquisition): ..."

# 4. Registre no CHANGELOG central do módulo (obrigatório, ADR-010)
#    bioculttermos/CHANGELOG.md — o quê, e a partir de qual unidade

# 5. Aponte o hospedeiro para a nova versão e publique tudo de uma vez
git add bioculttermos
git commit -m "chore(bioculttermos): adota <resumo>"
git push          # publica módulo e ponteiro juntos, graças a push.recurseSubmodules
```

### Antes do passo 3, verifique

- [ ] A mudança é **segura para as quatro unidades**? Nenhum nome de tabela, campo ou conceito
      específico de um hospedeiro entrou no código do módulo (ADR-012 G4/G5).
- [ ] Nenhum texto de UI menciona "BioCultDB" ou outra unidade pelo nome (ADR-007 F5).
- [ ] Não é Conteúdo Soberano disfarçado de código — termos curados pertencem ao SQLite da unidade,
      não ao repositório.

---

## 2. Levar a mudança às demais unidades

Obrigatório (ADR-012 G4), no seu tempo. Para cada hospedeiro que ainda não adotou:

```bash
HOST=BioCultRelatos

cd D:/git/$HOST
git submodule update --remote --merge bioculttermos    # traz o topo de main
git add bioculttermos
git commit -m "chore(bioculttermos): zera Atraso de Módulo"
git push
```

Depois disso, valide o build daquela unidade (SHA do submodule + `BUILD_INFO`, ADR-010) antes de
considerar a adoção concluída. A validação da correção pertence à unidade que a adota — não à unidade
em que ela foi escrita.

---

## 3. Ver o Atraso de Módulo das quatro unidades

```powershell
pwsh D:/git/Arquitetura-BioCultural/bin/termos-status.ps1
```

Somente leitura, sem dependência além de `git`. Reporta, por unidade: Versão Adotada, atraso em
commits contra o remoto, alterações não publicadas na Cópia de Trabalho, e se a rede de proteção do
git está ligada na máquina.

Rode antes de começar a editar e depois de publicar.

---

## Sintomas e causas

| Sintoma | Causa provável | Ação |
|---|---|---|
| `pull --ff-only` recusa | Commit local esquecido naquela Cópia de Trabalho | `git -C <host>/bioculttermos log origin/main..HEAD` e publique-o antes de tudo |
| CI da unidade não acha o SHA do submodule | Ponteiro bumpado sem publicar o commit do módulo | `push.recurseSubmodules` não estava ligado — ligue (§0) e republique |
| `git status` limpo mas o container roda código velho | `submodule.recurse` desligado; a Cópia de Trabalho não desceu no `pull` | Ligue (§0), depois `git submodule update --remote --merge` |
| Duas unidades em versões diferentes | Estado normal e temporário: Atraso de Módulo | §2 para zerar. Se durar mais de um ciclo, é dívida, não atraso |
| Você encontrou um clone do BioCultTermos fora de um hospedeiro | Cópia proibida (ADR-012 G2) | Salve o não publicado, transplante para uma Cópia de Trabalho, apague o clone |

## O que nunca fazer

- **Clonar o BioCultTermos isoladamente.** Não roda, não testa, só envelhece.
- **`git submodule update` sem `--merge`/`--rebase`** com intenção de editar: deixa a Cópia de Trabalho
  em detached HEAD, e o commit que você fizer lá não pertence a branch nenhuma.
- **Commitar o ponteiro do hospedeiro sem publicar o commit do módulo.** Quebra o CI de todas as
  unidades que puxarem depois.
- **Adicionar comportamento específico de uma unidade ao módulo.** Generalize antes (ADR-007 F5,
  ADR-012 G5) ou não entre.
- **Curar termos esperando que propaguem.** Conteúdo Soberano nunca atravessa unidades — só o código.
