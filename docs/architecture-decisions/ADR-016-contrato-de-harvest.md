# ADR-016: Contrato de Harvest da Federação

## Status

**Proposto** — Agosto 2026. Extraído do ponto **K6** da [ADR-015](ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md).

Esta ADR foi separada deliberadamente para poder ser **aceita sozinha**. A ADR-015 decide um ponto
de fundo — quem tem autoridade para classificar acesso — e por isso depende de validação com
comunidades, que é lenta e correta que seja. O contrato de harvest é consequência técnica: define o
formato que o endpoint da federação publica. Mantê-lo dentro da ADR-015 faria o contrato esperar por
uma decisão de outra natureza, e deixaria o [ADR-004](ADR-004-federated-architecture.md) D6 —
**Aceito** — sendo supersedido por texto *Proposto* por tempo indeterminado.

## Contexto

O D6 do ADR-004 define o payload do harvest como `{id, visibility, updated_at, data}`. O booleano
`visibility` não expressa o caso comum desta arquitetura: **registro público que contém um rótulo
`sacred`**, que deve ser publicado com o rótulo suprimido e a supressão declarada — não rebaixado,
não omitido. Sem um campo para dizer *o que foi retido e por decisão de quem*, a regra de
`governanca/propostaGovernanca.md:300` ("campo restringido nunca fica nulo") não tem implementação
possível do lado do consumidor.

A ADR-015 diagnosticou a causa: campo ausente e campo retido são coisas diferentes, e a diferença
depende de quem detém o conhecimento (`regime`) e de qual nível o rotula (`accessLevel`).

## Decisão

### H1 — O payload carrega o nível efetivo e a supressão declarada

O registro do harvest passa a ser:

```json
{
  "id": "<member_id>/<record_id>",
  "regime": "conhecimento | evidencia",
  "accessLevel": "public",
  "informationWithheld": "rótulo em kre suprimido por decisão da comunidade",
  "dataGeneralizations": "coordenada generalizada para 0,1°",
  "culturalLabels": [{ "tipo": "label | notice", "id": "…" }],
  "holderPeople": "…",
  "relatedResources": [ ],
  "updated_at": "…",
  "data": { }
}
```

- `regime` e `accessLevel` substituem o booleano implícito de `visibility`. Continua valendo que **só
  o nível efetivo `public` atravessa o harvest**; o harvest autenticado é extensão futura não
  implementada (ADR-009) e, até existir, nível diferente de `public` é invisível para a federação
  (`propostaGovernanca.md:284`).
- `informationWithheld` e `dataGeneralizations` são os termos Darwin Core homônimos.
- `culturalLabels` carrega identificador, **nunca texto** (ADR-015 K4).

Especificação campo a campo, com tipos, obrigatoriedade e exemplos:
[`docs/contrato-harvest.md`](../contrato-harvest.md), que é **normativo** junto com esta ADR.

### H2 — A redação acontece na fronteira da API

A fronteira é o endpoint de harvest, não a aplicação inteira. O campo restrito é gravado normalmente
e filtrado na saída.

*Redaction at rest* — nunca gravar o campo restrito — foi **rejeitada**: a perda é irreversível
inclusive para a própria comunidade e contradiz o direito de exportação integral de
`propostaGovernanca.md:473`. Risco de bug de filtro é mitigável por teste (H4); perda de dado não é
mitigável por nada.

### H3 — Vínculo entre registros de membros distintos: três tipos de relação, e só três

O array `relatedResources` é subconjunto da tabela `resource-relationship` do DwC-DP. O vocabulário
de `relationshipType` fica **fechado em três valores**, cada um com um caso real na arquitetura:

| Valor | Quando | Exemplo |
|---|---|---|
| `refers to` | O registro **fala sobre** um recurso custodiado por outro membro | Relato Panará sobre a exsicata `jbrj-herbario/rb-00123456` |
| `same as` | Os dois registros descrevem **o mesmo objeto** | Duplicata do mesmo espécime em dois herbários |
| `derived from` | O registro é **derivado** de outro | Versão editada de gravação, transcrição, tradução (K5, K8.3) |

Correção que a extração tornou visível: o exemplo original usava `same as` para o vínculo entre um
Relato e uma exsicata. Está errado — o Relato **não é** a exsicata, ele fala sobre ela. `same as`
afirma identidade e colapsaria os dois no índice do Pluriverso, apagando exatamente a distinção que a
ADR-015 existe para preservar.

Vocabulário fechado porque interoperabilidade entre membros exige acordo prévio: um membro que emita
um quarto valor emite dado que o Pluriverso não sabe interpretar. Ampliação é ato do Comitê Federado,
com o caso de uso que a motivou.

### H4 — Condição de aceitação do endpoint

Obrigatória em cada unidade que implementar o endpoint; sem ela o endpoint não é aceito.

Teste automatizado que **falhe** se qualquer registro com nível efetivo diferente de `public`
atravessar o endpoint, cobrindo os dez cenários de `docs/contrato-harvest.md` §7 — inclusive os três
que costumam faltar: registro `public` de regime `conhecimento` sem CLPI válido; mudança de nível de
`public` para `restricted`, que precisa desaparecer da coleta seguinte; e gravação coletiva com um
participante `restricted`.

## Relações

- **Supersede o contrato de payload do [ADR-004](ADR-004-federated-architecture.md) D6.** Permanece
  integralmente válido o restante do D6: paginação obrigatória, `updated_since`, identificador
  estável `member_id` + `record_id`, e o endpoint como única dependência técnica do membro.
- **Depende conceitualmente da [ADR-015](ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md)** K1
  (`regime`), K3 (nível efetivo), K4 (Label/Notice), K7 (padrão por nível) e K8.3 (enunciação
  coletiva). Depende dos **conceitos**, não do status: se a ADR-015 for alterada na validação com
  comunidades, o que muda aqui é o conteúdo dos campos, não a forma do contrato.
- **Retifica o [ADR-006](ADR-006-federation-membership-protocol.md) E3** — o probe de admissão confere
  `member_id`, `id`, `regime` e `accessLevel`; `visibility` deixa de ser conferido. Probe como sinal,
  nunca gate.
- **Normativo em conjunto com** [`docs/contrato-harvest.md`](../contrato-harvest.md).

## Consequências

### Positivas

- O contrato de harvest pode ser aceito e implementado sem esperar a validação com comunidades.
- O conflito de status *Aceito* × *Proposto* sobre o ADR-004 D6 deixa de ser indefinido: passa a ter
  um documento próprio, com ciclo de aceitação próprio.
- Uma classe inteira de vazamento deixa de ser possível: rótulo sagrado dentro de registro público.

### Negativas

- Mais um ADR para manter em coerência com a ADR-015. *Mitigação:* esta ADR não redefine nenhum
  conceito; referencia K1, K3, K4, K7 e K8.3 em vez de reescrevê-los.
- O Pluriverso passa a interpretar nível efetivo em vez de filtrar um booleano. *Aceito:* é o
  requisito que originou a ADR-015.

## O que esta ADR não decide

| # | Questão | Situação |
|---|---|---|
| **H-Q1** | `sacred` (nível de Termo) equivale a `private` no cálculo do nível efetivo? | **Aberta.** Regra derivada de K3, nunca escrita na ADR-015. O que é sagrado quem diz é a comunidade, e a equivalência pode estar tecnicamente certa e semanticamente errada. Levada à reunião com as lideranças. **Regra interina, conservadora:** trata-se como `private` — nunca atravessa |
| **H-Q2** | Formato do detentor individual em `holderPeople` | Depende da Q3 da ADR-015, que só se resolve perguntando à pessoa. O campo do detentor individual não entra no payload enquanto não fechar |
| **H-Q3** | Conteúdo de `data` | Definido pelo Comitê Federado, como no ADR-004 D6. Esta ADR especifica a envoltória e as regras de acesso, não o esquema do conteúdo |

## Referências

- [ADR-015](ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md) — K1, K3, K4, K6 (origem), K7, K8.3
- [ADR-004](ADR-004-federated-architecture.md) — D1, D4, D6
- [`docs/contrato-harvest.md`](../contrato-harvest.md) — especificação campo a campo
- Darwin Core, `informationWithheld` e `dataGeneralizations` — <https://dwc.tdwg.org/terms/>
- DwC-DP, tabela `resource-relationship` — <https://github.com/gbif/dwc-dp/tree/master/dwc-dp/table-schemas>
- `governanca/propostaGovernanca.md` §5.2, §5.4, §5.5

## Data de Revisão

Revisitar quando (a) H-Q1 for respondida pelas lideranças ou pelo Comitê; (b) a primeira unidade
implementar o endpoint e a condição de aceitação de H4 revelar cenário faltante; ou (c) o Comitê
precisar de um quarto valor de `relationshipType`.
