# Contrato de Harvest — payload da federação

## Status

**Proposto** — Agosto 2026. Normativo em conjunto com a
[ADR-016](architecture-decisions/ADR-016-contrato-de-harvest.md), e vigente quando ela for aceita.

Este documento especifica, campo a campo, o contrato que a ADR-016 define em esqueleto e que
**supersede o payload do [ADR-004](architecture-decisions/ADR-004-federated-architecture.md) D6**.
Permanece integralmente válido o restante do D6: paginação obrigatória, filtro `updated_since`,
identificador estável `member_id` + `record_id`, e o endpoint como única dependência técnica do
membro em relação à federação.

A ADR-016 nasceu do ponto **K6** da [ADR-015](architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md)
e foi extraída dela para não depender da validação com comunidades. Os conceitos que este contrato
usa — `regime` (K1), nível efetivo (K3), Label/Notice (K4), padrão por nível (K7) e enunciação
coletiva (K8.3) — continuam definidos na ADR-015.

Onde este documento encontrou uma lacuna, ela está marcada como **pendência** em §8, nunca resolvida
por conveniência de escrita.

---

## 1. Endpoint

Inalterado em relação ao ADR-004 D6.

```
GET /api/federation/records
  ?page=<int>          # paginação, obrigatório
  &size=<int>          # registros por página (máx. 500)
  &updated_since=<ISO 8601>  # coleta incremental, opcional
```

Sem autenticação. O harvest autenticado é extensão futura não implementada (ADR-009); enquanto não
existir, nível efetivo diferente de `public` é simplesmente invisível para a federação
(`governanca/propostaGovernanca.md:284`).

## 2. Envoltória da resposta

Inalterada.

| Campo | Obrigatório | Tipo | Regra |
|---|---|---|---|
| `member_id` | sim | string | Identificador do membro na federação, estável ao longo da vida do membro |
| `total` | sim | int | Total de registros que atendem à consulta, não o tamanho da página |
| `page` | sim | int | Página corrente, base 1 |
| `records` | sim | array | Objetos de §3. Array vazio é resposta válida |

## 3. Registro

O objeto de `records[]`. `visibility` **desaparece** do contrato: era um booleano disfarçado e não
expressa supressão parcial. Em seu lugar entram `regime` e `accessLevel`.

| Campo | Obrigatório | Tipo | Origem | Regra |
|---|---|---|---|---|
| `id` | sim | string | ADR-004 D6 | `<member_id>/<record_id>`. Estável: o mesmo registro reaparece com o mesmo `id` em toda coleta futura. Nunca reaproveitado após exclusão |
| `regime` | sim | enum | K1 | `conhecimento` \| `evidencia`. Do registro, nunca derivado do `member_id`. O consumidor não precisa saber que tipo de membro produziu o registro para interpretá-lo |
| `accessLevel` | sim | enum | K3 | Nível **efetivo** já resolvido pelo membro (§4). No harvest não autenticado o único valor possível é `public` — o campo é explícito mesmo assim, para que a chegada do harvest autenticado não mude o formato |
| `informationWithheld` | condicional | string | `dwc:informationWithheld` | **Obrigatório sempre que algo foi suprimido.** Texto legível dizendo *o que* foi retido e *por decisão de quem*. Campo restringido nunca fica nulo (`propostaGovernanca.md:300`) |
| `dataGeneralizations` | condicional | string | `dwc:dataGeneralizations` | Obrigatório sempre que algum valor foi generalizado em vez de removido. Diz o quê e com que granularidade. Generalizar, nunca randomizar |
| `culturalLabels` | não | array | K4 | §5 |
| `holderPeople` | condicional | string | K2, K8.3, `bioculttermos/manual/03-rotulos.md` | Coletivo detentor. **Obrigatório quando `regime: conhecimento`**; ausente ou de preenchimento parcial em `evidencia` com atribuição incompleta (Q4 de K1). Vale igualmente para Relato de **enunciação coletiva** — oficina, mutirão, roda de conversa —, em que o detentor é o grupo e cada participante identificável tem direito próprio sobre voz e imagem. Formato do detentor individual: **pendência ①**, §8 |
| `relatedResources` | não | array | DwC-DP | §6 |
| `updated_at` | sim | ISO 8601 | ADR-004 D6 | Instante da última alteração que o consumidor precisa ver. Muda quando muda a supressão, mesmo que o conteúdo não mude — senão a coleta incremental não propaga uma restrição nova |
| `data` | sim | objeto | ADR-004 D6 | Campos definidos pelo Comitê Federado, já redigidos (§4). Nunca contém campo suprimido, nem com valor nulo, nem com chave presente e vazia |

Campo ausente e campo retido são coisas diferentes, e essa diferença é o requisito que originou a
ADR-015: **ausente** significa que o membro não tem o dado; **retido** significa que o membro tem e
não publica, e nesse caso `informationWithheld` diz por quê.

## 4. Nível efetivo e redação

### 4.1 A regra

Nível efetivo = **o mais restritivo** entre os três níveis envolvidos — Termo (`skosxl:Label`),
Relato e Registro/Mídia (K3). Herança descendente é proibida: registro público não torna público o
que ele contém.

A regra tem um **quarto eixo**, quando o registro é uma gravação com vários participantes (K8.3):
o nível efetivo da mídia é também **o mais restritivo entre as pessoas gravadas**. Um participante
que pede reserva reserva a gravação inteira; revogação por um deles retira a mídia da publicação, sem
exigir justificativa. Suprimir a pessoa por edição não é decisão da plataforma: a versão editada é um
derivado novo, e só existe se a comunidade pedir.

Consequência para quem implementa o filtro: **não basta olhar o `accessLevel` do registro e o do
Relato.** Se houver mídia com participantes, o cálculo percorre também a lista de participantes — e
um só `restricted` entre eles basta para o registro inteiro não atravessar.

Ordem de restritividade, crescente, conforme `propostaGovernanca.md:277-282`:

```
public  <  restricted  <  community-only  <  private
```

O `accessLevel` `sacred` do nível de Termo (`bioculttermos/manual/03-rotulos.md`) não pertence a essa
escala de quatro camadas. **Regra interina, conservadora:** para efeito de cálculo equivale a
`private` — nunca atravessa, em nenhuma hipótese.

> **Pendência aberta, não resolvida aqui.** A equivalência é derivada de K3 e não está escrita na
> ADR-015. É **H-Q1 da ADR-016** e foi levada à reunião com as lideranças: o que é sagrado quem diz é
> a comunidade, e a equivalência pode estar tecnicamente certa e semanticamente errada — `sacred`
> pode merecer nível próprio, acima de `private`, com regra distinta inclusive para o metadado. Até
> a resposta, vale a regra interina acima, que erra para o lado de não publicar.

### 4.2 O que atravessa

Só registro cujo nível efetivo é `public`. Registro de nível superior não aparece na resposta, e
**não aparece nem como tombstone** — a existência do registro é, ela própria, informação da
comunidade.

### 4.3 O caso comum, e o motivo do contrato

Registro `public` que contém rótulo `sacred` **não** é rebaixado nem omitido. É publicado com o
rótulo suprimido e a supressão declarada:

```json
{
  "id": "comunidade-panara/rec-0042",
  "regime": "conhecimento",
  "accessLevel": "public",
  "informationWithheld": "nome da planta em kre suprimido por decisão da comunidade Panará",
  "dataGeneralizations": "coordenada do ato de enunciação generalizada para 0,1°",
  "culturalLabels": [
    { "tipo": "label", "id": "tk-attribution", "hubId": "https://localcontextshub.org/labels/…" }
  ],
  "holderPeople": "Panará",
  "relatedResources": [
    {
      "relationshipType": "refers to",
      "externalRelatedResourceID": "jbrj-herbario/rb-00123456",
      "externalRelatedResourceSource": "https://…/api/federation/records",
      "relatedResourceType": "MaterialEntity",
      "relationshipAccordingTo": "Comitê Federado"
    }
  ],
  "updated_at": "2026-08-13T00:00:00Z",
  "data": { }
}
```

### 4.4 Onde a redação acontece

Na **fronteira da API**, e a fronteira é este endpoint — não a aplicação inteira. O campo restrito é
gravado normalmente e filtrado na saída.

*Redaction at rest* — nunca gravar o campo restrito — foi **rejeitada em K6**: a perda seria
irreversível inclusive para a própria comunidade, e contradiz o direito de exportação integral de
`propostaGovernanca.md:473`. Risco de bug de filtro é mitigável por teste (§7); perda de dado não é
mitigável por nada.

## 5. `culturalLabels`

Array. Cada item:

| Campo | Obrigatório | Tipo | Regra |
|---|---|---|---|
| `tipo` | sim | enum | `label` \| `notice`. Decorre de K4: **Label** só em `regime: conhecimento`, aplicado pela comunidade detentora; **Notice** em `regime: evidencia`, declarada pela unidade custodiante enquanto a comunidade não se manifesta |
| `id` | sim | string | Identificador do rótulo. Nunca o texto |
| `hubId` | não | IRI | Identificador no Local Contexts Hub, quando o rótulo for de lá |
| `projectId` | não | string | Projeto do Hub a que o rótulo pertence |

**O texto do rótulo não trafega neste payload e não é editado em lugar nenhum** (K4). O texto das
Notices é imutável por regra do Local Contexts. Como o consumidor obtém o texto — API do Hub a cada
exibição, ou cache local do texto canônico — é a **pendência ②** de §8 e não afeta este contrato:
qualquer das duas resoluções consome o mesmo `id`.

Combinação inválida, que o teste de §7 deve rejeitar: `tipo: "label"` em registro `regime: evidencia`.
É a unidade custodiante aplicando um instrumento que só a comunidade pode aplicar.

## 6. `relatedResources`

Resolve o requisito registrado e não especificado na ADR-015: *"este registro trata do mesmo objeto
que aquele registro de outro membro"* — o Relato da comunidade sobre uma exsicata do JBRJ, sobre o
material de Spruce em Kew, sobre a peça na coleção etnológica.

Subconjunto da tabela `resource-relationship` do DwC-DP
(<https://github.com/gbif/dwc-dp/tree/master/dwc-dp/table-schemas>), com os nomes de campo do padrão
preservados. O sujeito da relação é sempre o registro que carrega o array — `subjectResourceID` é
implícito e não trafega.

| Campo | Obrigatório | Regra |
|---|---|---|
| `relationshipType` | sim | **Vocabulário fechado em três valores** (ADR-016 H3): `refers to`, `same as`, `derived from`. Ver a tabela abaixo |
| `relationshipTypeIRI` | não | IRI do predicado, quando houver vocabulário controlado |
| `relatedResourceID` | condicional | Quando o alvo é registro **do mesmo membro** |
| `externalRelatedResourceID` | condicional | Quando o alvo é registro **de outro membro** — o caso normal aqui. Valor no formato `<member_id>/<record_id>` |
| `externalRelatedResourceSource` | condicional | Endpoint de harvest do membro que custodia o alvo. Obrigatório junto com o campo acima |
| `relatedResourceType` | não | Classe do alvo: `MaterialEntity`, `Occurrence`, `Event` |
| `relationshipAccordingTo` | não | Agente que afirma a relação. Relevante porque a relação pode ser afirmada por um terceiro, e não pelos dois membros |
| `relationshipEstablishedDate` | não | ISO 8601 |
| `relationshipRemarks` | não | Texto livre |

**Vocabulário de `relationshipType` — fechado** (ADR-016 H3). Um membro que emita um quarto valor
emite dado que o Pluriverso não sabe interpretar; ampliar é ato do Comitê Federado, com o caso de uso
que a motivou.

| Valor | Quando | Exemplo |
|---|---|---|
| `refers to` | O registro **fala sobre** um recurso custodiado por outro membro. **É o caso normal aqui** | Relato Panará sobre a exsicata `jbrj-herbario/rb-00123456` |
| `same as` | Os dois registros descrevem **o mesmo objeto** | Duplicata do mesmo espécime em dois herbários |
| `derived from` | O registro é **derivado** de outro | Versão editada de gravação, transcrição, tradução (K5, K8.3) |

Correção em relação à primeira versão deste contrato, que usava `same as` para o vínculo entre Relato
e exsicata: o Relato **não é** a exsicata, ele fala sobre ela. `same as` afirma identidade e
colapsaria os dois no índice do Pluriverso, apagando exatamente a distinção que a ADR-015 preserva.

`relatedResourceID` e `externalRelatedResourceID` são **mutuamente exclusivos**; ao menos um dos dois
é obrigatório.

A relação **não** cria dependência de leitura entre membros: o Pluriverso resolve o vínculo no
índice, e um alvo indisponível degrada a apresentação, nunca a coleta. É o que preserva a
consequência positiva de resiliência do ADR-004 — falha de um membro não afeta o índice central.

Isto é a implementação da lição do Mukurtu de `propostaGovernanca.md:419` **na federação**, que é o
único lugar onde ela pode acontecer sem inverter a soberania: a narrativa da comunidade é Relato na
unidade da comunidade, a ficha do museu é Evidência na unidade do museu, e as duas coexistem
vinculadas — nenhuma gravada dentro do banco da outra.

## 7. Condição de aceitação do endpoint

**Obrigatória em cada unidade que implementar o endpoint** (ADR-016 H4). Sem ela, o endpoint não é aceito.

Teste automatizado que **falhe** se qualquer registro com nível efetivo diferente de `public`
atravessar o endpoint. O mínimo verificável, contra um conjunto de dados que contenha
deliberadamente ao menos um caso de cada linha:

| # | Cenário no banco | Resposta esperada |
|---|---|---|
| 1 | Registro `restricted`, `community-only` ou `private` | Ausente da resposta, em qualquer página, com e sem `updated_since` |
| 2 | Registro `public` de regime `conhecimento` **sem CLPI válido** | Ausente. `public` é consequência do CLPI, nunca substituto dele (K7, `propostaGovernanca.md:319`) |
| 3 | Registro `public` contendo rótulo de Termo `sacred` | Presente, sem o rótulo, e com `informationWithheld` preenchido |
| 4 | Registro `public` contendo Relato `restricted` | Presente, sem o Relato, e com `informationWithheld` preenchido |
| 5 | Registro com campo generalizado | `dataGeneralizations` preenchido; nenhum campo suprimido presente com valor nulo ou string vazia |
| 6 | Registro `regime: evidencia` com `culturalLabels[].tipo: "label"` | Erro de validação na publicação — não é caso de filtro, é dado inválido (K4) |
| 7 | Registro cujo nível mudou de `public` para `restricted` | Desaparece da coleta seguinte, e o `updated_at` do membro reflete a mudança |
| 8 | Registro `public` com gravação coletiva em que **um** participante está `restricted` | Ausente. O mais restritivo entre as pessoas gravadas vale para a mídia inteira (K8.3) |
| 9 | Participante revoga o consentimento sobre a própria voz ou imagem | A mídia sai da publicação na coleta seguinte. Nenhuma versão editada é gerada automaticamente |
| 10 | Registro de prática **sem fala** | Presente, com `language` = `zxx`. Falha se o campo vier vazio, nulo ou inferido como `por` (K8.2) |

O cenário 7 é o que quase sempre falta: um filtro correto na leitura não basta se a mudança de nível
não propaga, porque o índice do Pluriverso guarda a cópia anterior. Registro removido do harvest
exige remoção no índice, pela mesma operação de `purge` que o ADR-004 D4 já prevê para saída de
membro.

## 8. Pendências que este contrato não resolve

| # | Pendência | Efeito aqui |
|---|---|---|
| ① | Formato do detentor individual — nome protegido, atribuição só coletiva, ou pseudônimo escolhido pela própria pessoa (Q3 da ADR-015). Recomendada: **pseudônimo**, a única que exige perguntar | `holderPeople` está especificado só no nível do coletivo. O campo do detentor individual não entra no payload enquanto ① não fechar |
| ② | Texto dos rótulos culturais: API do Local Contexts Hub a cada exibição ou cache local do texto canônico (Q4 da ADR-015). Recomendada: **guardar identificador, exibir texto canônico com cache, nunca editar** | Nenhum. `culturalLabels` carrega identificador nas duas resoluções |
| ③ | Vocabulário controlado de `assertionType` (Q5 da ADR-015) | Matéria do BioCultTermos e do Comitê. Vive dentro de `data`, não na envoltória |
| ④ | Conteúdo de `data` | Definido pelo Comitê Federado, como no ADR-004 D6. Este contrato especifica a envoltória e as regras de acesso, não o esquema do conteúdo |
| ⑤ | `sacred` equivale a `private` no cálculo do nível efetivo? (H-Q1 da ADR-016) | Vale a **regra interina** de §4.1 — trata-se como `private`. Se as lideranças pedirem nível próprio, muda a escala de §4.1 e o cenário 3 de §7 |

## 9. Referências

- [ADR-016](architecture-decisions/ADR-016-contrato-de-harvest.md) — H1 a H4, normativa em conjunto com este documento
- [ADR-015](architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md) — K1, K3, K4, K7, K8.3
- [ADR-004](architecture-decisions/ADR-004-federated-architecture.md) — D1, D4, D6
- [ADR-003](architecture-decisions/ADR-003-data-model.md) — modelo de dados, com a nota de retificação da ADR-015
- `governanca/propostaGovernanca.md` §5.2 (camadas de acesso), §5.4 (CLPI), §5.5 (rotulagem cultural)
- Darwin Core, `informationWithheld` e `dataGeneralizations` — <https://dwc.tdwg.org/terms/>
- DwC-DP, tabela `resource-relationship` — <https://github.com/gbif/dwc-dp/tree/master/dwc-dp/table-schemas>
- Local Contexts — TK/BC Labels e Notices — <https://localcontexts.org/labels/traditional-knowledge-labels/>
