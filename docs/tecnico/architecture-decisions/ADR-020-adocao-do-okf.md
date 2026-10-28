---
type: Decisão de arquitetura
description: "Adoção do Open Knowledge Format v0.2 em toda a documentação do repositório: ficha mínima, lista fechada de type e validação no CI."
status: stable
---

# ADR-020: Adoção do Open Knowledge Format (OKF) v0.2 na documentação

## Status

**Aceito** — Outubro 2026. Decisões tomadas com a gestão da arquitetura em 28/10/2026 (prompts
P-0027 a P-0032), uma por ticket do mapa
[Adotar o Open Knowledge Format (OKF) v0.2 na documentação](https://github.com/edalcin/Arquitetura-BioCultural/issues/47).
A conversão dos arquivos e a validação no CI ficam no ticket
[OKF: converter os arquivos e ligar a validação no CI](https://github.com/edalcin/Arquitetura-BioCultural/issues/56).

O número 019 está reservado para a ADR "Sagrado como dimensão", ainda bloqueada
([`proximosPassos.md`](../proximosPassos.md)).

## Contexto

A documentação é a arquitetura: 94 arquivos `.md`, lidos por pessoas (pelo GitHub) e por agentes de
IA. Nada nos arquivos diz o que cada um é. Um agente descobre que um texto é ADR, pauta ou resumo de
reunião pela pasta ou pelo nome, e descobre que uma ADR foi substituída só se ler o corpo.

O [Open Knowledge Format](https://github.com/GoogleCloudPlatform/open-knowledge-format) (OKF) v0.2 é
uma especificação aberta para isso: cada `.md` é um **conceito** com uma ficha YAML no topo
(*frontmatter*); só a chave `type` é obrigatória. O conjunto de arquivos é o **bundle**.

Restrições que a adoção respeita:

- O GitHub mostra a ficha como uma **tabela no topo** de todo `.md`, e não há como esconder; campos
  aninhados ficam pesados ([pesquisa](https://github.com/edalcin/Arquitetura-BioCultural/issues/49)).
- Pessoas sem formação técnica leem `ComecePorAqui/` e `docs/Governanca/` no GitHub.
- Outros seis repositórios da federação apontam para `docs/tecnico/`: nenhum arquivo muda de nome.

## Decisão

### O1 — O bundle é o repositório inteiro

- Raiz do bundle = raiz do repositório. Um link que começa com `/` funciona igual no OKF e no GitHub.
- Entra todo `.md` versionado, inclusive `ComecePorAqui/` e os prompts de `docs/Pesquisa/IA/prompts/`.
- Fica fora: `CLAUDE.md` (instrução para o agente, não documento da arquitetura), `.remember/**` e
  `graphify-out/**` (existem só no computador local).
- Versão da especificação: `okf_version: "0.2"`, no manifesto (O7) e nesta ADR. A especificação só
  aceita esse campo num `index.md` da raiz, que não vai existir (O2).

Origem: [OKF: limites do bundle](https://github.com/edalcin/Arquitetura-BioCultural/issues/48).

### O2 — Nenhum nome reservado; `README.md` e `CHANGELOG.md` são conceitos

- Nenhum `index.md` e nenhum `log.md`. O índice é opcional na especificação; quem lê o bundle pode
  montar um.
- Todo `README.md` (inclusive o da raiz) e o `CHANGELOG.md` têm ficha, como qualquer conceito.
- O `CHANGELOG.md` mantém os títulos `## [x.y.z] - AAAA-MM-DD`: como `log.md` reservado, perderia o
  número de versão.
- Se um dia for preciso um `log.md`, ele segue a especificação (títulos `## AAAA-MM-DD`, mais novo
  primeiro, sem ficha).

Origem: [OKF: README.md × index.md e CHANGELOG.md × log.md](https://github.com/edalcin/Arquitetura-BioCultural/issues/51).

### O3 — A ficha tem `type` e `description`, e `status` só quando a regra O5 pede

```yaml
---
type: Decisão de arquitetura
description: "Uma frase que diz o que o documento é e para que serve."
status: draft
---
```

- `type` e `description` são **obrigatórios** em todo conceito. As chaves ficam em inglês, como a
  especificação manda; os valores, em português.
- A ficha começa na **primeira linha** do arquivo. Um `---` em outra linha vira linha horizontal no
  GitHub.
- Não se usam `title` (o título `#` vem logo abaixo da tabela), `tags`, `resource` nem campos
  aninhados. O validador recusa campo fora da lista (O7); campo novo entra por mudança desta ADR e do
  manifesto.
- Em `ComecePorAqui/` e `docs/Governanca/` a ficha tem **só** `type` e `description`, com valores em
  português simples, sem jargão e sem códigos. Um aviso de uma frase no `ComecePorAqui/README.md` e no
  `guia-github.md` explica a tabela.

Origem: [OKF: o frontmatter nos textos para leigos](https://github.com/edalcin/Arquitetura-BioCultural/issues/50);
a recusa de `title` e `tags` fora dessas pastas segue o mesmo motivo (a tabela no topo de todo
arquivo).

### O4 — `type` diz o gênero do documento, numa lista fechada

- O `type` diz **o que o documento é** (ADR, pauta, guia…), não o assunto nem a pasta. Um arquivo
  novo segue o gênero, não a pasta onde está.
- A lista de valores vive **só** no manifesto [`docs/tecnico/okf-base.yaml`](../okf-base.yaml), com
  uma linha de comentário que define cada valor. Esta ADR não copia a lista.
- Valor novo = mudança no manifesto, no mesmo *commit* ou PR que o usa, com o motivo.
- O validador não distingue maiúsculas de minúsculas no `type`; aceito. Sem sinônimos (`aliases`).

Origem: [OKF: vocabulário de valores de type](https://github.com/edalcin/Arquitetura-BioCultural/issues/52).

### O5 — `status`

| Onde | Regra |
|---|---|
| ADRs | Sempre. *Proposto* → `draft`; *Aceito* e *Implementado* → `stable`; *Depreciado*, *Substituído* (*Supersedido*) e *Rejeitado* → `deprecated`. A seção `## Status` do corpo fica (valor em português, data, motivo); a ficha e o corpo mudam no mesmo *commit*. |
| `ComecePorAqui/` e `docs/Governanca/` | Nunca (O3). |
| Demais documentos | Só quando não for `stable`: `draft` para texto em construção, `deprecated` para texto substituído. Sem a chave, o valor é `stable`. |

Origem: [OKF: status, autoria e confiança](https://github.com/edalcin/Arquitetura-BioCultural/issues/53).

### O6 — `generated` e `verified` não são usados

A autoria (IA ou pessoa) já fica no [registro de prompts](../../Pesquisa/IA/registro-de-prompts.md) e
no *commit* que cita o prompt. Um `generated` que um agente esquece de atualizar fica falso sem aviso,
e nenhum validador detecta isso. Volta como esforço novo se a pesquisa
([`projetoPesquisa.md`](../../Pesquisa/projetoPesquisa.md) §7.2, item 9) ou a federação pedir a
autoria no próprio documento.

Origem: [OKF: status, autoria e confiança](https://github.com/edalcin/Arquitetura-BioCultural/issues/53).

### O7 — Validação: `okflint` no CI

- Validador: [`okflint`](https://github.com/mattdav/okflint) (MIT), versão **fixada** em `0.5.1`. Subir
  a versão é um PR próprio, que mostra o que muda.
- Manifesto: `docs/tecnico/okf-base.yaml` (o `okflint` resolve a raiz do bundle a partir da pasta do
  manifesto). Leva `okf_version: "0.2"`, a lista de `type` (O4), os campos `type` e `description`
  obrigatórios, `status` restrito a `draft | stable | deprecated`, as exclusões de O1 e
  `reserved_files` no padrão da especificação (`index.md`, `log.md`).
- Um *workflow* do GitHub Actions roda `okflint validate` em todo *push* ao `main` e em todo PR.
  **Erro** (o *job* falha): falta de ficha ou de `type`; `type`, campo ou valor de `status` fora do
  manifesto. **Aviso** (o *job* passa): links quebrados (o `okflint` conta imagens como link
  quebrado).
- Plano B, só se o `okflint` deixar de existir: um script próprio que confira a ficha e o `type`.

Origem: [OKF: validador — okflint no CI ou script próprio](https://github.com/edalcin/Arquitetura-BioCultural/issues/54)
([pesquisa](https://github.com/edalcin/Arquitetura-BioCultural/blob/research/okf-validador/docs/tecnico/pesquisa/okf-validador.md)).

### O8 — Regra de escrita para agentes

A regra operacional está em [`docs/tecnico/agents/okf.md`](../agents/okf.md); o `CLAUDE.md` aponta para
ela. Todo `.md` novo nasce com a ficha, inclusive o arquivo de prompts de cada dia
(`type: Prompts do dia`).

## Relações

- Mudança de método M-19 em [`metodo-de-evolucao.md`](../../Governanca/Arquitetura/metodo-de-evolucao.md)
  §5. Complementa M-02 (C4 e ADRs): o formato dos documentos, não o conteúdo, muda.
- Não muda nenhuma outra ADR, o modelo de dados nem o contrato de Harvest.

## Consequências

### Positivas

- Um agente sabe o que é cada arquivo, e se uma ADR vale, lendo só a ficha, sem abrir o corpo.
- A lista fechada de `type` torna explícito o gênero de cada documento; um gênero novo é decisão
  visível (um PR no manifesto), não um acidente.
- O CI pega ficha esquecida, `type` inventado e campo com erro de digitação antes de entrar no `main`.

### Negativas

- Todo `.md` mostra uma tabela no topo no GitHub, inclusive os textos para leigos.
  - *Mitigação:* ficha de dois campos em português simples e um aviso nos guias (O3).
- Dependência de um projeto novo, de uma pessoa só, em versão 0.x.
  - *Mitigação:* versão fixada; licença MIT; plano B de script próprio (O7).
- Escrever um documento novo pede mais um passo (a ficha).
  - *Mitigação:* a regra para agentes (O8) e o CI (O7).

## O que esta ADR não decide

- `sources` e notas de rodapé nos documentos de pesquisa (`docs/Pesquisa/`), e `stale_after` em
  documentos que envelhecem (`proximosPassos.md`, pauta): ainda sem forma no mapa.
- A adoção do OKF nos outros repositórios da federação: esforço próprio, se e quando decidido.

## Referências

- [Open Knowledge Format v0.2](https://github.com/GoogleCloudPlatform/open-knowledge-format)
- [`okflint`](https://github.com/mattdav/okflint)
- Pesquisas: [como o GitHub mostra a ficha](https://github.com/edalcin/Arquitetura-BioCultural/blob/research/okf-github-frontmatter/docs/tecnico/pesquisa/okf-github-frontmatter.md),
  [validador](https://github.com/edalcin/Arquitetura-BioCultural/blob/research/okf-validador/docs/tecnico/pesquisa/okf-validador.md)

## Data de Revisão

Quando o `okflint` chegar à versão 1.0 ou parar de ser mantido; quando o mapa decidir `sources` ou
`stale_after`; se outro repositório da federação adotar o OKF.
