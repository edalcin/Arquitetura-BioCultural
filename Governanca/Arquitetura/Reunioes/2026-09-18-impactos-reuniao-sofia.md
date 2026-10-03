# Impactos na arquitetura — reunião de 2026-09-18 (Sofia Zank)

- **Resumo:** [`2026-09-18-reuniao-sofia.md`](2026-09-18-reuniao-sofia.md) — segunda reunião de trabalho com o Ponto-Focal. Doze decisões.
- **Itens criados:** I-01, I-02, I-06, I-07, I-08, I-12, I-13
- **Estado de cada item:** [`impactos-na-arquitetura.md`](../../../docs/impactos-na-arquitetura.md) §1

> Escrito em 2026-09-19 como seção do log único e separado em arquivo próprio em 2026-09-29. Duas
> frases novas, ambas marcadas com a data de 29/09: em I-07 e na §5. O estado atual de cada item
> está no documento consolidado.

## 1. O que fecha

**I-01 e I-02 — identificação do detentor** (decisões 2 e 3).

- Travava: **Q3** da `ADR-015:418`, a **pendência ①** do `contrato-harvest.md:250`, a **H-Q2** do
  `ADR-016:132` e, por consequência, o Passo 4 do `proximosPassos.md` (esquema como tabela).
- Decisão: três formas de nomeação — nome verdadeiro, pseudônimo escolhido pela própria pessoa,
  pseudônimo gerado pelo sistema. A escolha é individual e soberana, nunca do coletivo.
- Confirma a recomendação (c) da Q3 e a **amplia**: a recomendação previa o pseudônimo; a decisão
  prevê as três, e acrescenta que a exibição varia por público (decisão 4), o que é o mesmo eixo dos
  níveis de compartilhamento já previstos.
- **Nota de método, importante.** A Pauta 1 é **pauta de consentimento**
  (`pautaComunidades/pauta-comunidades.md:122`), e nenhuma pauta de consentimento se fecha por
  atacado. O que esta decisão fecha é o **cardápio de opções** — matéria de desenho, que o
  Ponto-Focal responde. O valor por pessoa continua sendo consentimento, registro a registro. A Q3
  pode ser promovida; a escolha concreta, não.

## 2. O que contradiz

**I-06 — o detentor é sempre coletivo; o enum `individual | coletivo` cai** (decisão 1).

- Vigente: `modelo-de-dados-unificado.md:155` — `"detentor": { "tipo": "coletivo", // individual |
  coletivo`; `ADR-015:156` (Q1 do teste do K1) e `ADR-015:178` — "detentor identificável — pessoa ou
  coletivo"; `docs/CONTEXT.md:84-90`, verbete **Relato** — "um detentor (pessoa ou coletivo)".
- Decisão: o Conhecimento é coletivo por lei, e é o coletivo que figura como detentor. Quem
  compartilhou é **campo adicional**, opcional, e nunca substitui o vínculo com o coletivo — mesmo
  uma benzedeira isolada é vinculada ao coletivo das benzedeiras.
- Consequência: cai o discriminador `tipo`. `detentor` passa a referência obrigatória a um Coletivo;
  `compartilhadoPor` é campo separado, com a nomeação de I-01. Reescreve a Q1 do K1 e o verbete
  **Relato** do glossário da federação.

**I-07 — Coletivo é entidade, não string** (decisões 5, 6 e 7).

- Vigente: `ADR-003:312-316` — `community: { name, ethnicity, language }`, objeto plano;
  `contrato-harvest.md:63` — `holderPeople` é **string**; `docs/CONTEXT.md:112-125` — Fonte de Atribuição
  `{tipo, nome}`, com `nome` livre.
- Decisão: raiz na denominação legal; níveis intermediários **opcionais**, que podem não existir;
  pertencimento **muitos-para-muitos** (benzedeira, raizeira e quilombola ao mesmo tempo);
  autodenominação registrada, sempre com referência ao termo legal.
- Consequência: entidade `Coletivo` com categoria legal obrigatória, autodenominação, hierarquia
  opcional, e relação N:N com pessoa. `holderPeople` precisa carregar ao menos o identificador da
  categoria legal — mudança de **forma** no contrato de harvest, não só de conteúdo.
- O caso que quebra a árvore é o **coletivo jurídico sem coletivo organizado**: a benzedeira Camila e
  a benzedeira Sueli, em comunidades diferentes, sem grupo entre elas. Forçar nível intermediário
  produz dado falso; deixar a pessoa fora de qualquer coletivo contradiz a natureza coletiva do
  Conhecimento. O único nível disponível é a categoria legal, e é suficiente.
- Na revisão de 28/09, Sofia chamou o nível mínimo de "segmento" (ex.: segmento das benzedeiras),
  aplicável mesmo sem organização local. Isto confirma a leitura acima. Em 29/09, Sofia confirmou
  que "segmento" é a categoria do Decreto nº 8.750/2016, e que a lista não é exaustiva (ver I-16).

**I-08 — o nome real pode não existir na persistência** (decisão 3).

- Vigente: `ADR-003:346-352` — `informants[].anonymized: true // Não incluir nome`, combinado com
  `permissions.hiddenFields` (`ADR-003:407`). O modelo é **guardar e ocultar**.
- Decisão: as duas opções precisam existir. Há quem recuse o **armazenamento**, não apenas a
  exibição.
- Consequência: o campo de nome real deixa de ser obrigatório-com-máscara e passa a **opcional na
  própria persistência**. É o único ponto da arquitetura em que a ausência no repouso é direito da
  pessoa, e não perda de dado. A regra "campo ausente ≠ campo retido" do UDM §5 passa a ter **três**
  estados: ausente por não se ter; retido por decisão de acesso; nunca gravado por escolha da pessoa.
- O insight que sustenta a decisão: entre as benzedeiras, a recusa veio das de religião de matriz
  africana. Não-identificação é **proteção contra dano**, não lacuna de qualidade de dado — e a
  desconfiança é sobre a promessa de não publicar, não sobre o campo.

## 3. O que acrescenta

| # | Requisito | De onde vem | Nota de implementação |
|---|---|---|---|
| **I-12** | Princípio das etiquetas adotado; conjunto internacional **não** adotado. Etiquetas brasileiras com tabela de correspondência para exportação | decisões 8, 9 e 11 | O K4 (`ADR-015:217-230`) nomeia TK/BC Label como **o** instrumento. A envoltória do harvest sobrevive sem mudança de forma: `culturalLabels[].id` já é identificador opaco e `hubId` já é opcional (`contrato-harvest.md:152-166`). Basta **namespace no `id`** e `hubId` ausente para rótulo próprio. As opções não são excludentes |
| **I-13** | Perfil de sensibilidade por coletivo | insight da farmacopeia popular | Para raizeiras e medicina tradicional, **registrar é proteger** — posição oposta à de povos indígenas e de terreiro. O K7 tem um default único para toda a federação. Precisa ser default **revisável pelo coletivo**, não constante global. Não contradiz o K7: mantém `restricted` como omissão segura e admite sobreposição por decisão da comunidade |

## 4. O que confirma ou adia

- **Decisão 10** — adoção prática do Local Contexts **adiada** até o recurso do GEF, com reunião a
  marcar com Keila e o MCTI. Isso mantém a **Q4** da `ADR-015:419` aberta, agora com motivo
  registrado: modelo de negócio pago, e um único caso de uso real encontrado no contexto de DSI — um
  Notice, em repositório pequeno, que **não propagou** para os agregadores.
- **Decisão 11** — etiqueta em exsicata de herbário viaja com o registro para o GBIF: é o argumento
  de por que adotar padrão em vez de convenção local, e confirma o caminho do BioCultAcervos.
- **Decisão 12** — resumos separados, um por reunião, com a consolidação do impacto como etapa à
  parte. **Os documentos de impactos são essa etapa.**
- **Mecanismo de ocultação ou retirada de registro** — reafirmado na Pauta 4, **continua adiado**.

## 5. Pressão de escopo registrada, sem decisão

- Das 16 iniciativas apoiadas pelo GEF, algumas já inserem dados primários no SiBBr e procuraram o
  UseFlora para discutir política de dados. Não é escopo formal; é demanda real. Em 29/09, nenhuma
  demanda nova tinha chegado.
- O ICMBio / Programa Monitora identificou Conhecimento Tradicional nas próprias bases. Terceiro ator
  independente a chegar ao mesmo problema.
- Efeito sobre a arquitetura: nenhum hoje. Efeito sobre a prioridade de **I-14**: alto — é pelo
  Relato que o BioCultDB toca dado primário, independentemente do escopo declarado.
