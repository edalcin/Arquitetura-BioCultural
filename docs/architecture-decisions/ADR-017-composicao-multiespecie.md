# ADR-017: Composição Multi-Espécie de Usos, Preparos e Artefatos

## Status

**Proposto** — Agosto 2026. Registra uma **demanda de modelo de dados** que vincula as quatro
unidades federadas (BioCultDB, BioCultRelatos, BioCultAcervos, BioCultNaturalistas) e o contrato de
harvest ([ADR-016](ADR-016-contrato-de-harvest.md)). Retifica por nota o
[ADR-003](ADR-003-data-model.md) e generaliza a definição de Relato do
[ADR-015 K2](ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md).

## Contexto

### O caso que expõe a lacuna: o Daime

No ritual do Santo Daime, a bebida sacramental — chamada **Daime**, e em outras tradições
**ayahuasca**, **vegetal** ou **hoasca** — é preparada pela decocção conjunta de **duas plantas**:

| Planta | Nomes tradicionais | Papel na composição |
|---|---|---|
| *Banisteriopsis caapi* | **Jagube**, Cipó, Mariri | caule; fonte das β-carbolinas (inibidoras de MAO) |
| *Psychotria viridis* | **Rainha**, Chacrona, Folha | folhas; fonte de DMT |

O ponto decisivo: **nenhuma das duas plantas, sozinha, constitui o uso.** A DMT da folha é
inativa por via oral sem as β-carbolinas do cipó — o efeito, o preparo, o nome e o próprio
conhecimento existem **apenas na combinação**. O conhecimento tradicional aqui não é
"planta X → uso Y" duas vezes; é *quais* plantas, *em que papéis*, *em que proporção e preparo*,
combinadas para *um* uso.

O caso não é exótico — é um padrão recorrente do domínio:

- **Garrafadas**: preparados medicinais com várias plantas maceradas juntas;
- **Xaropes e chás compostos**: múltiplas espécies numa mesma indicação terapêutica;
- **Defumações**: combinações de ervas com papel ritual;
- **Artefatos multi-material**: um arco (madeira de uma espécie, corda de fibra de outra,
  resina de uma terceira), um cesto (fibra estrutural + fibra de amarração + corante vegetal);
- **Corantes com fixador**: a planta tintória e a planta mordente.

E o caso do Daime carrega um agravante que a
[Proposta de Governança](../../governanca/propostaGovernanca.md) já documenta: a **ayahuasca é um
dos casos históricos de apropriação indevida** (patente US Plant Patent 5.751 sobre *B. caapi*).
Um modelo que não sabe representar a composição também não sabe protegê-la — a classificação de
acesso e a rotulagem cultural precisam poder incidir sobre **a combinação**, não apenas sobre cada
planta isolada.

### Onde os modelos atuais falham

**BioCultDB** (`Referência → Comunidade → Planta → Uso`): o `tipoUso[]` é atributo de **uma**
planta (`comunidades[].plantas[].tipoUso[]`). Representar o Daime hoje obriga a registrar
`ritual` separadamente em *B. caapi* e em *P. viridis* — duas linhas independentes que:

1. **Perdem a relação n:m** — nada no dado diz que os dois registros compõem um único uso;
2. **Perdem os papéis** — caule/fonte de β-carbolinas × folha/fonte de DMT desaparecem;
3. **Perdem o nome do composto** — "Daime"/"ayahuasca" não nomeia planta alguma, nomeia o
   preparo, e não há onde registrá-lo;
4. **Quebram a consulta** — "quais plantas compõem o Daime?" e "que preparos usam o jagube?"
   não têm resposta.

**ADR-003**: o registro é centrado em `species` (singular) com `uses[]` aninhado — mesmo limite,
um uso pertence a uma espécie.

**ADR-015 K2**: o Relato guarda quem enunciou, quando, onde e sob que protocolo — mas a
compartimentalização que o próprio K2 condena ("guardar `planta X → uso Y` é a
compartimentalização que a crítica antropológica identifica como perda") vale igualmente para o
número de plantas por Relato. Um mestre daimista descrevendo o feitio do Daime é **um**
ato de enunciação sobre **duas** plantas; fatiá-lo em dois Relatos repete o mesmo erro.

**BioCultAcervos / BioCultNaturalistas**: ainda sem código — absorvem esta demanda como restrição
de projeto antes da primeira linha, o momento mais barato (mesmo argumento do ADR-014 e ADR-015).
Obras de naturalistas descrevem preparos compostos com frequência (curares, por exemplo, que
combinam várias espécies).

## Requisitos (a demanda, detalhada)

**R1 — Composição como unidade própria.** Toda unidade federada DEVE poder representar um
**Uso/Preparo/Artefato composto** como entidade que referencia **1..n plantas**. O caso
mono-espécie é o caso degenerado (n=1) da mesma estrutura — não um modelo paralelo.

**R2 — Papel de cada componente.** Cada referência a planta dentro da composição carrega:
- **papel na composição** (ex.: `princípio ativo`, `ativador`, `veículo`, `fibra estrutural`,
  `corante`, `fixador`) — vocabulário controlado SKOS-XL, novo Campo Semântico do BioCultTermos
  (ver [`docs/rotulos-skos-xl.md`](../rotulos-skos-xl.md));
- **parte usada** (caule, folha, raiz…);
- proporção/observações de preparo, quando enunciadas.

**R3 — O composto tem nome próprio.** "Daime", "ayahuasca", "vegetal", "hoasca" são rótulos
SKOS-XL de **um** conceito (o preparo), com a mesma mecânica de `pref`/`alt`/`hidden`, idioma e
`accessLevel` de qualquer termo — independentes dos nomes vernaculares de cada planta componente.

**R4 — Classificação de acesso sobre a composição.** A regra do nível efetivo de ADR-015 K3
estende-se: a composição é rotulável independentemente de seus componentes. Cada planta pode ser
`public` e **a receita — proporções, preparo, contexto ritual — ser `restricted` ou `sacred`**.
Publicar os componentes não publica a composição; herança descendente continua proibida.

**R5 — Compatibilidade retroativa.** A extensão é **aditiva**: os registros existentes
(mono-espécie) permanecem válidos sem migração. No BioCultDB, o caminho natural é um array
`composicoes[]` no nível da comunidade, referenciando as plantas já registradas por identificador
estável (não por índice de array):

```json
"comunidades": [{
  "plantas": [
    { "id": "p1", "nomeCientifico": ["Banisteriopsis caapi"], "nomeVernacular": ["jagube", "cipó", "mariri"] },
    { "id": "p2", "nomeCientifico": ["Psychotria viridis"], "nomeVernacular": ["rainha", "chacrona", "folha"] }
  ],
  "composicoes": [{
    "nome": ["Daime", "ayahuasca"],
    "tipoUso": ["ritual"],
    "componentes": [
      { "plantaId": "p1", "papel": "ativador (IMAO)", "parteUsada": "caule" },
      { "plantaId": "p2", "papel": "princípio ativo (DMT)", "parteUsada": "folha" }
    ],
    "preparo": "decocção conjunta"
  }]
}]
```

O esboço é ilustrativo — o esquema final é decisão de implementação de cada unidade; o que esta
ADR fixa são os requisitos R1–R6.

**R6 — A composição atravessa o harvest.** O payload do ADR-016 carrega a composição dentro de
`data` sem achatá-la; quando os componentes vivem em registros de membros distintos (ex.: Relato
da comunidade sobre preparo cujo exemplar está num acervo), o vínculo usa `relatedResources`
(`resource-relationship` do DwC-DP). O Pluriverso DEVE conseguir responder "quais plantas compõem
X" e "que composições usam a planta Y" a partir do índice.

**R7 — Relato multi-planta (BioCultRelatos).** A definição de Relato do ADR-015 K2 é
generalizada: *a menção de **uma ou mais** plantas por um participante (ou grupo) em um contexto
específico*. Um ato de enunciação sobre uma composição é **um** Relato — com um detentor, uma
data, uma língua, uma classificação de acesso — nunca n Relatos fatiados por espécie.

## Opções consideradas

### Opção A: Duplicar o uso em cada planta componente (estado atual)
**Prós:** custo zero. **Contras:** perde a relação n:m, os papéis, o nome do composto e a
possibilidade de classificar o acesso da combinação — falha R1–R4. Rejeitada.

### Opção B: Inverter a hierarquia (Uso como entidade central, plantas penduradas nele)
**Prós:** modelo mais "correto" em abstrato. **Contras:** migração destrutiva de todos os
registros e telas existentes do BioCultDB, para um ganho que a Opção C entrega sem quebrar nada.
Rejeitada.

### Opção C: Extensão aditiva — entidade de composição referenciando plantas (escolhida)
**Prós:** retrocompatível (R5); mono-espécie continua simples; a composição vira endereço natural
para nome, papel, preparo e classificação de acesso; unidades ainda sem código a absorvem como
restrição de projeto. **Contras:** duas formas de registrar uso mono-espécie passam a coexistir
(atributo da planta × composição de 1 componente) — mitigado documentando que `composicoes[]` só
é usada quando há composição de fato ou quando o preparo tem nome/receita próprios.

## Decisão

Adotar a **Opção C**. As quatro unidades federadas e o Pluriverso incorporam R1–R7 como requisito
de modelo de dados. BioCultDB implementa como extensão aditiva; BioCultRelatos, BioCultAcervos e
BioCultNaturalistas incorporam antes da primeira linha de código. O vocabulário de **papéis na
composição** é matéria do BioCultTermos, documentado na referência central de rótulos
([`docs/rotulos-skos-xl.md`](../rotulos-skos-xl.md)).

## Consequências

### Positivas
- O conhecimento sobre preparos compostos — o caso do Daime, das garrafadas, dos curares — passa
  a ser representável **sem perda da relação que o constitui**;
- A classificação de acesso pode proteger a receita mesmo com componentes públicos (R4), fechando
  a lacuna que os casos de apropriação (ayahuasca) tornam concreta;
- Consultas de composição ("quais plantas compõem X?") tornam-se respondíveis na unidade e na
  federação.

### Negativas
- Complexidade adicional de esquema e de interface de aquisição/curadoria em cada unidade;
- O corpus já registrado no BioCultDB pode conter composições achatadas (usos duplicados por
  planta) que só curadoria humana consegue reconstituir — nenhuma reclassificação automática.

### Neutras
- Nenhum registro existente muda de forma ou de nível de acesso por efeito desta ADR.

## Relação com outros ADRs
- **ADR-003**: retificado por nota (a estrutura `species`/`uses[]` é anterior a esta demanda);
- **ADR-015**: K2 generalizado (R7); K3 estendido à composição (R4);
- **ADR-016**: `data` carrega a composição; `relatedResources` vincula componentes entre membros.

## Revisão
Junto com a rodada de validação com comunidades do ADR-003/ADR-015 — o caso do Daime deve ser
apresentado às comunidades como exemplo concreto da consulta.
