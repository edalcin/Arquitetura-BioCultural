# ADR-007: Distribuição do Módulo BioCultTermos via Git Submodule Compartilhado

## Status

**Aceito** — Julho 2026

## Contexto

O ADR-004 (D2) estabeleceu, no nível arquitetural, que "cada membro opera sua própria instância do
BioCultTermos com seu `skos:ConceptScheme` soberano". Essa decisão definiu **o quê** (soberania de
vocabulário por membro), mas nunca definiu **como** o código do módulo BioCultTermos deveria ser
tecnicamente distribuído entre as quatro unidades federadas (Fontes Secundárias/BioCultDB, Comunidade
Tradicional/BioCultRelatos, Acervos Históricos e Museológicos/BioCultAcervos, Obras de
Naturalistas/BioCultNaturalistas) — essa lacuna abria espaço para interpretações incompatíveis (fork por
unidade? pacote publicado? cópia manual?).

Duas sessões de implementação real já resolveram essa lacuna de forma consistente, sem que a decisão
tivesse sido elevada ao nível arquitetural:

- **BioCultDB** (`BioCultDB/docs/decisions/ADR-001-integracao-bioculttermos.md`): integração
  implementada e em produção desde 2026-07-13, usando **git submodule**.
- **BioCultRelatos** (`BioCultRelatos/docs/decisions/ADR-001-integracao-bioculttermos.md`): mesmo
  padrão, replicado e documentado, implementação diferida (repositório ainda sem código).

Esta ADR formaliza esse padrão já validado como a decisão arquitetural de referência para **todas** as
unidades federadas, incluindo as duas ainda sem integração documentada (BioCultAcervos,
BioCultNaturalistas), e esclarece uma tensão aparente: como um módulo de **código compartilhado** entre
unidades pode coexistir com o princípio de **soberania** que é central à arquitetura (CARE, ADR-004)?
Resposta curta, desenvolvida abaixo: soberania é sobre **dados**, nunca sobre **código**.

## Decisão

### F1 — Um repositório único, consumido via git submodule por cada unidade hospedeira

O BioCultTermos permanece **um único repositório** (`github.com/edalcin/BioCultTermos`). Cada unidade
federada o inclui como **git submodule** (`<ferramenta-principal>/bioculttermos`), apontando para o
mesmo remoto. Não há fork por unidade — é o mesmo código, com cada unidade fixando (pinando) o commit
que roda em produção via o ponteiro do submodule.

**Alternativas descartadas:**
- *Fork por unidade*: duplica manutenção; uma correção feita em uma unidade nunca chegaria às demais
  sem merge manual entre forks divergentes — pior que o problema que o submodule resolve.
- *Pacote npm publicado e versionado*: adiciona um pipeline de publish/versionamento semântico
  desnecessário para a escala atual do projeto (poucas unidades, um mantenedor) — contradiz a diretriz
  fixa de simplicidade do projeto.
- *Monorepo único (BioCultTermos dentro do mesmo repositório de cada ferramenta, sem submodule)*: exigiria
  copiar/colar o código a cada unidade nova, perdendo qualquer rastreabilidade de que é "o mesmo módulo".

### F2 — Repositório standalone "congelado como produto"

O repositório `BioCultTermos` **não é implantado isoladamente em produção** e **não recebe roadmap
próprio**: ninguém sobe seu `docker-compose.yml` como produto final. Ele existe, a partir de agora,
como o **remoto compartilhado** que os submodules de cada unidade referenciam. Seu `README.md` documenta
o módulo (arquitetura, modelo de dados, padrões SKOS-XL) e aponta para as integrações reais de cada
unidade hospedeira — não descreve mais um produto standalone.

**Consequência:** qualquer decisão de produto (nova feature, mudança de UX) só faz sentido no contexto
de pelo menos uma unidade hospedeira concreta — o módulo em si não tem usuário final direto.

### F3 — Propagação: commit em qualquer unidade, push ao remoto compartilhado, bump onde/quando fizer sentido

Uma mudança de código nasce **dentro do submodule de alguma unidade** (ex.:
`BioCultRelatos/bioculttermos/`), é commitada e pushada para o remoto compartilhado do BioCultTermos, e
fica disponível para as demais unidades incorporarem fazendo bump do ponteiro do seu próprio submodule —
quando cada uma decidir. Não é propagação automática nem hierárquica (nenhuma unidade é "a fonte"); é o
mecanismo padrão de git submodule aplicado a N consumidores do mesmo remoto.

**Alternativas descartadas:**
- *Propagação automática (CI dispara bump em todas as unidades a cada push)*: acopla o ciclo de deploy
  de todas as unidades a qualquer commit no módulo compartilhado — uma unidade em produção não deveria
  receber uma mudança não testada por ela só porque outra unidade fez push.
- *Uma unidade "canônica" da qual as demais sempre puxam*: recria uma hierarquia/dependência entre
  unidades que a arquitetura federada explicitamente evita (nenhum membro deve depender do ciclo de vida
  de outro).

### F4 — Soberania é de dados, nunca de código

O módulo de código é **intencionalmente o mesmo** em todas as unidades. O que a arquitetura protege como
soberano (D2 do ADR-004, princípios CARE) é o **arquivo SQLite de cada unidade** — o `ConceptScheme`, os
rótulos SKOS-XL e as tabelas `etnotermos_*` de uma unidade nunca são lidos, escritos ou visíveis por
outra unidade. Compartilhar o binário/código do módulo não compromete essa soberania: uma comunidade que
roda BioCultRelatos + BioCultTermos não expõe seu vocabulário a nenhuma outra unidade só por rodar o
mesmo código que o BioCultDB — o isolamento é por processo, container e arquivo, não por divergência de
código-fonte.

### F5 — Funcionalidade específica de unidade precisa ser generalizada antes de entrar no módulo compartilhado

Qualquer comportamento hardcoded para uma unidade específica dentro do BioCultTermos bloqueia as demais
unidades de usar o módulo corretamente quando fizerem bump do submodule. Bloqueio real já identificado e
documentado (`BioCultRelatos/docs/decisions/ADR-001-integracao-bioculttermos.md` §6): o
`AcquisitionService` lê a tabela `biocultdb_records` com uma lista de campos monitorados fixa no código —
funciona hoje apenas para o BioCultDB. **Decisão**: tabela-fonte e campos monitorados devem se tornar
configuráveis (env var ou arquivo de config) antes de qualquer unidade além do BioCultDB entrar em
produção com BioCultTermos integrado. Textos de UI que mencionam "BioCultDB" explicitamente também
precisam generalizar para linguagem genérica ("a ferramenta principal desta unidade").

**Consequência:** este é trabalho de código real no repositório compartilhado, pré-requisito bloqueante
documentado em cada ADR-001 local (BioCultRelatos, BioCultAcervos, BioCultNaturalistas) — não escopo
desta ADR, que é só arquitetural/documental.

### F6 — Cada unidade hospedeira documenta sua própria integração localmente

Toda unidade que integra o BioCultTermos mantém, no seu próprio repositório, um par de documentos:
`docs/decisions/ADR-001-integracao-bioculttermos.md` (decisão operacional adaptada às particularidades
da unidade) e `integracao.md` (checklist de implementação). Todos replicam a mesma estrutura, herdando os
pontos F1–F5 desta ADR sem reinterpretação, e adaptando só o que é genuinamente específico da unidade
(cardinalidade, nome de arquivo SQLite, portas da ferramenta principal, convenção de nome de container).
Esta ADR-007 é a decisão arquitetural de origem que todos eles referenciam.

## Consequências

### Positivas
- Correções e features feitas a partir de qualquer unidade propagam-se a todas as demais sem duplicação
  de código nem merge manual entre forks.
- Nenhuma infraestrutura nova: git submodule é mecanismo nativo, zero custo operacional adicional —
  alinhado à diretriz fixa do projeto de simplicidade e tamanho de Docker.
- Separação clara entre soberania de dados (protegida, por unidade) e compartilhamento de código
  (deliberado, entre unidades) resolve a tensão conceitual que motivou esta ADR.

### Negativas
- Propagação é manual (bump de submodule por unidade) — pode haver defasagem entre unidades rodando
  versões diferentes do módulo por período indefinido.
  - *Mitigação*: aceitável dado o estágio atual (poucas unidades, um mantenedor); cada unidade escolhe
    quando fazer bump, sem urgência forçada — revisitar se o número de unidades crescer a ponto de
    defasagem virar risco real de suporte.
- Funcionalidade não generalizada (F5) bloqueia novas unidades até ser corrigida no módulo compartilhado.
  - *Mitigação*: já documentado como pré-requisito bloqueante explícito em cada ADR-001 local; trabalho
    de código único no repositório compartilhado, não repetido por unidade.

## Relações

- Formaliza, ao nível arquitetural, o padrão de implementação já decidido localmente em
  `BioCultDB/docs/decisions/ADR-001-integracao-bioculttermos.md` e
  `BioCultRelatos/docs/decisions/ADR-001-integracao-bioculttermos.md`.
- Estende o mesmo padrão a `BioCultAcervos/docs/decisions/ADR-001-integracao-bioculttermos.md` e
  `BioCultNaturalistas/docs/decisions/ADR-001-integracao-bioculttermos.md`.
- Complementa **D2** do ADR-004 (Arquitetura Federada) — não a substitui; D2 permanece a decisão de que
  cada membro é soberano sobre seu vocabulário, esta ADR só formaliza o mecanismo técnico de
  distribuição do código que implementa essa soberania sem duplicá-lo.
- Usa o padrão de persistência do ADR-005 (SQLite+JSON) como base do isolamento de dados por unidade.

## Referências

- [ADR-004: Arquitetura Federada v3.0](ADR-004-federated-architecture.md)
- [ADR-005: Persistência SQLite com JSON por Unidade Federada (v3.1)](ADR-005-sqlite-json-persistence.md)
- `BioCultDB/integracao.md` e `BioCultDB/docs/decisions/ADR-001-integracao-bioculttermos.md`
- `BioCultRelatos/integracao.md` e `BioCultRelatos/docs/decisions/ADR-001-integracao-bioculttermos.md`
- `BioCultAcervos/integracao.md` e `BioCultAcervos/docs/decisions/ADR-001-integracao-bioculttermos.md`
- `BioCultNaturalistas/integracao.md` e `BioCultNaturalistas/docs/decisions/ADR-001-integracao-bioculttermos.md`
- [Git Submodules — documentação oficial](https://git-scm.com/book/en/v2/Git-Tools-Submodules)

## Data de Revisão

Revisar quando (a) o `AcquisitionService` for generalizado no repositório BioCultTermos, e/ou (b) a
primeira unidade além do BioCultDB entrar em produção com BioCultTermos integrado.

## Atualização — 2026-07-22: F2 aplicado no repositório

F2 ("repositório standalone congelado como produto") era, até esta data, só uma declaração de intenção:
o repositório `BioCultTermos` ainda continha `docker/etnotermos.Dockerfile`, `docker/docker-compose.yml`
e um workflow de CI (`docker-build.yml`) que publicava `ghcr.io/edalcin/bioculttermos:latest` a cada push
em `main` — nada impedia, na prática, alguém subir esse `docker-compose.yml` isoladamente. Removidos
nesta data (commit `3d7d878` em `BioCultTermos`): os dois arquivos Docker, o workflow de CI, e os
scripts/documentação que instruíam rodá-los standalone (`docker/create-admin-user.js`,
`docs/deployment.md` e `docs/instalacao-unraid.md` marcados como histórico). O repositório não tem mais
capacidade técnica de gerar uma imagem Docker própria — só é consumível via submodule por uma unidade
hospedeira, que mantém seu próprio `Dockerfile.unidade`.
