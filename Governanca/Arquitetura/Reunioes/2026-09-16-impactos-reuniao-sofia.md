# Impactos na arquitetura — reunião de 2026-09-16 (Sofia Zank)

- **Resumo:** [`2026-09-16-reuniao-sofia.md`](2026-09-16-reuniao-sofia.md) — primeira reunião de trabalho com o Ponto-Focal. Doze decisões.
- **Itens criados:** I-03, I-04, I-05, I-09, I-10, I-11, I-14, I-15
- **Estado de cada item:** [`impactos-na-arquitetura.md`](../../../docs/impactos-na-arquitetura.md) §1

> Escrito em 2026-09-19 como seção do log único e separado em arquivo próprio em 2026-09-29, sem
> mudança de conteúdo. Este documento registra a leitura feita depois da reunião; o estado atual de
> cada item está no documento consolidado.

## 1. O que fecha

**I-03 — `sacred` deixa de equivaler a `private`** (decisões 3 e 4).

- Vigente: `contrato-harvest.md:96-98` — "para efeito de cálculo equivale a `private` — nunca
  atravessa, em nenhuma hipótese". Regra declarada **interina** e levada à reunião como **H-Q1** da
  `ADR-016`.
- Decisão: registrar **o metadado do sagrado**, nunca o conteúdo. É legítimo afirmar que existe
  Conhecimento sagrado associado a uma espécie; é ilegítimo registrar qual é.
- Conflito: com a equivalência vigente, o metadado também não atravessa, e a decisão fica
  inimplementável. O que nunca atravessa é o **conteúdo**, não a **afirmação de existência**.
- Consequência: `sacred` sai da escala `public < restricted < community-only < private` e passa a
  dimensão do registro, com dois portadores distintos — existência (publicável) e conteúdo (não
  persistido, ver I-04). A decisão 4 acrescenta **níveis dentro do sagrado** e a matriz
  `sagrado × secreto`, com a célula "secreto não-sagrado" declarada vazia até resposta das
  comunidades.
- Fecha também a pendência "revisitar a equivalência `privado` = `secreto` no ADR-015", nomeada no
  próprio resumo de 16/09.

## 2. O que contradiz

**I-04 — conteúdo sagrado não deve ser persistido, ainda que o artigo o publique** (decisão 3).

- Vigente: `ADR-015:284` rejeita *redaction at rest* — "a perda é irreversível inclusive para a
  própria comunidade", e contradiria o direito de exportação integral.
- Conflito: o argumento do K6 pressupõe que o dado é da comunidade e a unidade o guarda **para** ela.
  Conteúdo sagrado extraído de artigo de terceiro não é esse caso — a comunidade não pede que a
  unidade o guarde.
- Consequência: a regra vira dupla, com a fronteira no Regime Enunciativo. *Redaction at rest* para
  conteúdo sagrado em `evidencia`; *redaction at the API boundary* para todo o resto. Atinge o
  pipeline de extração por IA do BioCultDB, que hoje extrai o que o artigo diz.
- O insight "nem IA nem curador identificam todo sagrado" acrescenta a exigência de **supressão
  retroativa a pedido da comunidade** — o controle não pode depender de marcação prévia.

**I-05 — sai a pessoa, não sai o vídeo** (decisão 2).

- Vigente: `ADR-015:349-355` (K8.3) — "Um participante que pede reserva **reserva a gravação
  inteira**"; "Editar a gravação para suprimir aquela pessoa **não é decisão da plataforma nem do
  curador**". Repetido em `contrato-harvest.md:80-84` e na nota do `ADR-003:126`.
- Decisão: o coletivo decide sobre o Conhecimento, porque o Conhecimento é coletivo; o indivíduo é
  soberano sobre imagem, voz e fala. Autorizada a publicação pela comunidade, a recusa individual
  suprime a pessoa, não o registro.
- Conflito: é uma inversão de default. Hoje a recusa individual bloqueia o registro coletivo.
- Reconciliação possível, a decidir no destino: K8.3 mantém "a plataforma não edita por conta
  própria" e mantém o original `restricted` enquanto não houver derivado; o que muda é o caminho
  esperado — a recusa individual dispara **pedido de derivado editado**, não bloqueio do coletivo. A
  cadeia PROV-O do K8.1 permanece intacta, porque a versão editada já é, por definição, derivado
  novo.

## 3. O que acrescenta

| # | Requisito | De onde vem | Por que não existe hoje |
|---|---|---|---|
| **I-09** | Relatórios de pendência por coletivo, periódicos e por demanda | decisão 8 | Nenhum ADR prevê. A `ADR-015:393` dá **CARE A2** por satisfeito com "a comunidade pode consultar", o que é insuficiente: o requisito é ativo, não consultivo. Exige estado "aguardando decisão" no ciclo do registro, e a hierarquia de coletivos (I-07) para a cascata nacional → regional → local |
| **I-10** | Rótulo afirmativo de detentor não identificado na fonte | decisão 7, caminho 3 | Existe como "Evidência com atribuição incompleta" (`ADR-015:159`), que é descrição de lacuna. O que se pede é um **Notice obrigatório** com redação afirmativa: *há detentor, não se sabe quem é* — nunca *não há detentor*. O insight dos ~90% do CGen é a razão: a categoria é usada como porta de fuga do consentimento, e a arquitetura não pode legitimá-la |
| **I-11** | Default privado estendido a toda dúvida de classificação | decisão 5 | O K7 (`ADR-015:288-296`) dá `restricted` por omissão só ao regime `conhecimento`; `evidencia` "segue o ADR-003", cujo exemplo nasce `public`. Falta a linha para Evidência com marcação de sagrado — que é exatamente o caso do BioCultDB |

## 4. O que confirma, sem mudar nada

- **Decisão 6** — a unidade declara Notice, o Label é da comunidade: é literalmente o K4
  (`ADR-015:217-230`). Nenhuma mudança.
- **Decisão 11** — quem classifica é a camada intermediária de governança: coerente com o K4, mas
  depende de **I-15** para ter sujeito. A camada existe no papel e não tem composição.
- **Decisão 1** — prioridade de Evidência, fontes secundárias: ordem de trabalho, não modelo.
- **Decisão 12** e o atrito de onboarding: documentação, não arquitetura. Resolvido na reunião
  seguinte por demonstração ao vivo do fluxo de edição e commit.

## 5. O que abre

- **I-14** — decisão 9, o BioCultDB precisará de capacidade de Relato. Ver
  [`impactos-na-arquitetura.md`](../../../docs/impactos-na-arquitetura.md) §2.
- **I-15** — camadas de governança: quem decide o quê, em que camada. A camada dos dados é
  exclusivamente das comunidades e está definida; as camadas da arquitetura e das ferramentas seguem
  **sem composição, sem mandato e sem regra de formação**. Hoje a camada de arquitetura é, de fato,
  uma reunião de duas pessoas.
- **Decisão 10** — pedido de remoção de registro do banco: **adiada**, e a reunião seguinte
  confirmou o adiamento. Nomeada, não resolvida. Observação de compatibilidade: o
  `contrato-harvest.md:108-110` já determina que registro não público "não aparece **nem como
  tombstone**", o que é consistente com remoção; o que falta é a política, não o mecanismo de
  harvest.
