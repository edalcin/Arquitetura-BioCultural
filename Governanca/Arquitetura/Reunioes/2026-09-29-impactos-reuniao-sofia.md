# Impactos na arquitetura — reunião de 2026-09-29 (Sofia Zank)

- **Resumo:** [`2026-09-29-reuniao-sofia.md`](2026-09-29-reuniao-sofia.md) — terceira reunião de trabalho com o Ponto-Focal. Doze decisões.
- **Itens criados:** I-16, I-17, I-18, I-19
- **Itens revistos:** I-01, I-03, I-04, I-05, I-07, I-11, I-13, I-14, I-15
- **Estado de cada item:** [`impactos-na-arquitetura.md`](../../../docs/impactos-na-arquitetura.md) §1

> Esta reunião respondeu às leituras que o log tinha feito das reuniões de 16 e 18/09 (pauta de
> 29/09, Bloco 3). Por isso a maior parte do efeito é sobre itens que já existiam: confirma quatro,
> põe um em revisão e tira um do escopo. Os quatro itens novos vêm da discussão sobre sagrado e
> secreto, que não estava na pauta.

## 1. O que fecha

**Pauta 1, questão 3 — a nomeação não muda por assunto** (decisão 10). Afeta **I-01**.

- Pergunta aberta: a forma de nomeação é uma por pessoa, ou muda conforme o assunto?
- Decisão: uma escolha geral por pessoa, para toda a informação que ela acrescenta.
- Consequência: a escolha de nomeação é atributo da **pessoa**, não do registro. O esquema tem um
  campo por pessoa, não um por Relato. A variação por **público** (18/09, decisão 4) continua valendo;
  a variação por **assunto** não existe. Simplifica a ADR-018.

**A verificação Decreto nº 8.750 × nº 8.772** (antiga §6 do log) — resolvida (decisão 11). Os dois
decretos valem, com papéis diferentes. O resumo de 18/09 não tem erro. O efeito sobre o glossário é
I-16.

**"Existe secreto não-sagrado?"** — pendente desde 16/09 — **sim** (decisão 3). Afeta **I-03**.

- Exemplo: conhecimento que um coletivo usa economicamente e não quer divulgar. Analogia legal:
  segredo industrial (propriedade intelectual) e **sigilo** (regime do SisGen; revisão de Sofia, PR #4).
- Consequência: a matriz `sagrado × secreto` tem quatro células, nenhuma vazia. A ADR-019 não pode
  tratar o secreto como nível dentro do sagrado (redação de 16/09, decisão 4): secreto e sagrado são
  **independentes**.

## 2. O que contradiz

**I-16 — a raiz dos coletivos é a Lei nº 13.123/2015, com três grupos, e nenhuma lista é fechada**
(decisão 11).

- Vigente: `docs/CONTEXT.md:127-128`, verbete **Comunidade Tradicional** — "Seu tipo vem da lista de 29
  categorias do Decreto 8.750/2016"; `modelo-de-dados-unificado.md:77` — `comunidade_tradicional`
  (Decreto 8.750/2016, 29 categorias).
- Decisão: a lei trata de três grupos — povos indígenas, povos e comunidades tradicionais, e
  agricultores (o termo da lei é *agricultor tradicional*). O Decreto nº 8.772/2016 regulamenta a lei.
  O Decreto nº 8.750/2016 lista os **segmentos** de povos e comunidades tradicionais, e é base, não
  lista fechada.
- Conflito: o texto vigente faz de uma lista de um decreto a fonte **única e fechada** do tipo. Ela
  não cobre povos indígenas como povos (cerca de 390, segundo Sofia), não cobre agricultores, e não
  cobre segmentos fora do decreto.
- Consequência: a raiz de I-07 passa a ter dois níveis. (1) O **grupo legal** da Lei nº 13.123, com
  três valores. (2) A **categoria**, tirada de uma lista de referência por grupo: segmentos do Decreto
  nº 8.750 para povos e comunidades tradicionais; uma lista de povos indígenas a escolher (ISA, IBGE
  ou FUNAI); para agricultores, nenhuma lista está definida. Cada lista admite "outro". As listas são
  relacionadas em SKOS-XL (BioCultTermos), sem que uma exclua a outra, e cada categoria guarda a
  referência à norma de onde vem. Reescreve o verbete **Comunidade Tradicional** e a linha da Fonte
  de Atribuição no UDM; entra na ADR-018 com I-07.

**I-04 — a leitura "não persistir" não foi confirmada** (decisão 4). Não é item novo; é revisão.

- Leitura do log (16/09): conteúdo sagrado extraído de artigo não é gravado — *redaction at rest*, em
  exceção à `ADR-015:284`.
- Resposta de 29/09: se o conhecimento está no artigo, a unidade o registra e **não o publica**. É a
  regra vigente da `ADR-015:282` — gravar e filtrar na fronteira da API.
- Conflito: as duas respostas vêm de Sofia, em datas diferentes. A redação de 16/09 (decisão 3) diz
  "ilegítimo registrar por quê e como — mesmo quando o artigo publicado descreve".
- Consequência: I-04 passa a **Em revisão**. Nenhuma mudança na `ADR-015`. A decisão vai à próxima
  pauta com as duas opções e as consequências de cada uma.

## 3. O que acrescenta

| # | Requisito | De onde vem | Destino e nota de implementação |
|---|---|---|---|
| **I-17** | **Conflito entre coletivos: o privado prevalece.** Se um coletivo quer publicar e outro, também representativo, não quer, a informação fica privada até que eles resolvam o conflito. Um coletivo representativo (com ata) pode pedir esse **embargo**, **mesmo quando outro coletivo representativo já autorizou a inserção** (revisão de Sofia, PR #4). A autorização de um coletivo não impede o embargo pedido por outro | decisão 7; insight do caso Krahô | É a regra do **mais restritivo** (`ADR-015:205`, K3) num eixo novo. K3 compara termo, Relato e registro; K8.3 compara pessoas numa gravação (`ADR-015:349`); I-17 compara **coletivos**. Destino: emenda à `ADR-015` K3; estado `embargado` no ciclo do registro, que se sobrepõe a uma autorização já dada; o embargo entra no relatório de pendências (I-09). Dentro de uma unidade é implementável. Entre unidades, ver §5 |
| **I-18** | **Incerteza declarada.** "Não tenho certeza" é valor válido quando quem classifica não sabe se algo é **secreto** ou se pode ser **publicado** (revisão de Sofia, PR #4: a decisão 9 fala de secreto, não de sagrado). O nível efetivo é o privado; a dúvida fica gravada e entra num relatório dirigido a quem pode ajudar a decidir — por exemplo, a Câmara Setorial dos Guardiões ou a APIB | decisão 9 | Hoje a dúvida vira privado e some (I-11): não se distingue "decidido privado" de "privado porque não se sabe". Destino: `ADR-015` K7 (terceiro estado de classificação, ao lado de decidido e não decidido); UDM; relatório de pendências (I-09). Liga-se a ⑱ (capacitação). Se o "não sei" também vale para a marca de sagrado fica em aberto: pergunta da próxima pauta |

## 4. O que confirma

- **I-03 — existência do sagrado publicável** (decisão 2, pergunta 3.1). Confirmado: "o aviso precisa
  aparecer". **Ressalva** (decisão 3): o eixo que protege pode ser o **sigilo**, e o sagrado pode ser
  mais próximo de uma categoria de uso. O desenho de dois portadores — existência publicável,
  conteúdo protegido — continua. O que muda é o nome e o número das dimensões: talvez duas marcas
  independentes (sagrado; sigiloso). A ADR-019 espera o vocabulário.
- **I-11 e I-13 — default privado revisável por coletivo** (decisão 6, pergunta 3.4). Confirmado: cada
  coletivo define o que é privado.
- **I-07 — "segmento" é a categoria legal** (pergunta 3.6). Confirmado, com a lista não exaustiva de
  I-16.
- **Reclassificação nos dois sentidos** (decisão 8, pergunta 3.7). Para Conhecimento, o texto vigente
  já cobre: a comunidade "pode reclassificá-lo ou revogá-lo a qualquer tempo" (`docs/CONTEXT.md:79`), e o
  Relato só fica `public` por ato positivo (`ADR-015:297`). Para Evidência com marca de sagrado, a
  **supressão retroativa** de I-04 ganha o sentido inverso: **liberação a pedido**. Vai para a
  ADR-019, sem item novo. O precedente do Local Contexts relatado por Viviane (restrição de
  conhecimento já publicado há séculos) confirma a supressão retroativa.
- **Sigilo por campo** (insight do Rio Negro). A planta e o uso são publicáveis; a tecnologia de
  salvaguarda (parte usada, preparo, combinação) não. O `informationWithheld` da `ADR-015` K6
  (`ADR-015:279`) já declara supressão por campo. Nenhuma mudança; é caso de teste para a ADR-019.
- **I-14 — Relato sobre Evidência** — reafirmado (Eduardo, 65 min; checklist de encerramento): a
  correção de um artigo pela comunidade é Relato, conhecimento primário que corrige secundário. Sofia
  acrescentou que a comunidade também pode pedir que uma Evidência publicada fique sigilosa no banco:
  é o Label da comunidade sobre Evidência, já previsto na `ADR-015` K4. A pergunta de onde o Relato
  vive continua sem resposta.

## 5. O que abre

- **I-17, entre unidades.** Se dois coletivos registram o mesmo conhecimento em unidades diferentes,
  nada hoje permite saber que é o mesmo: não há base central (ADR-004), e nenhuma unidade decide por
  outra (`docs/CONTEXT.md`, **Comitê Federado**). O único ponto em que os dois registros se encontram é o
  Pluriverso, que é índice e não decide. O caminho implementável é o **embargo a pedido**: o coletivo
  que discorda pede à unidade que publicou. A detecção automática, pedida por Sofia, não tem
  mecanismo. Pergunta para a próxima pauta.
- **I-19 — Evidência de domesticação e manejo.** Eduardo: é evidência de relação entre grupos e
  plantas numa escala de tempo longa, diferente da evidência de uso. Nenhum documento de arquitetura
  a modela. Insumo conhecido: o UseFlora troca indicadores por categorias. Espera a reunião com Nivaldo
  e Carol.
- **I-15 — composição da camada de arquitetura.** Primeiro movimento concreto: Eduardo convidou
  Viviane Kruel para participar como interlocutora de fontes primárias (BioCultRelatos). Continua
  **Em aberto** até haver resposta e regra de formação.

## 6. O que sai do escopo deste canal

- **I-05 — sai a pessoa, não sai o vídeo** (decisão 5, pergunta 3.3). A edição de vídeo é questão de
  fonte primária. O canal com o UseFlora prioriza Evidência. O item continua válido e continua *Não
  aplicado*, mas espera interlocutor de fontes primárias (I-15).

## 7. Efeito sobre o plano mínimo de documentos

| Documento | Mudança |
|---|---|
| **ADR-018 — Identificação do detentor** | Ganha I-16 (grupo legal + categoria por lista) e a decisão 10 (uma nomeação por pessoa). Os itens que consome (I-01, I-02, I-06, I-07, I-08, I-16) estão todos confirmados: **a ADR-018 pode ser escrita** |
| **ADR-019 — Sagrado como dimensão** | **Bloqueada** por duas perguntas da próxima pauta: guardar ou não o conteúdo sagrado de artigo (I-04) e o vocabulário sagrado × sigilo (I-03). Quando sair, ganha a liberação a pedido e o caso do sigilo por campo |
| Emenda à **ADR-015** | Ganha I-17 (K3, eixo entre coletivos) e I-18 (K7, incerteza declarada) |
| Emenda ao **`docs/CONTEXT.md`** e ao **UDM** | Verbete **Comunidade Tradicional** e linha da Fonte de Atribuição (I-16). Avaliar verbete **Segmento** |
| Requisito, sem ADR | Relatórios de pendência (I-09) passam a ter três entradas: registro sem decisão, registro embargado (I-17) e classificação incerta (I-18) |
