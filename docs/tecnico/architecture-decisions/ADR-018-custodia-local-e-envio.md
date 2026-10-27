# ADR-018: Custódia Local e Envio ao pluriverso

## Status

**Proposto** — Outubro 2026. Decisões tomadas com a gestão da arquitetura em 26/10/2026 (prompts
P-0023 a P-0025) e ajustadas em 27/10/2026 (P-0026: sem app de celular por ora). Achados da pesquisa
em [`pesquisa/envio-apps-offline.md`](../pesquisa/envio-apps-offline.md) incorporados. Fica
*Proposto* até a resposta da comunidade (L13). Mapa:
[Custódia Local e Envio ao pluriverso — documentação](https://github.com/edalcin/Arquitetura-BioCultural/issues/36);
decisões de origem em
[Visão: Custódia Local, apps stand alone e Envio](https://github.com/edalcin/Arquitetura-BioCultural/issues/37).

## Contexto

Até a v4.0, toda Unidade Federada é um container web ([ADR-004](ADR-004-federated-architecture.md),
[ADR-005](ADR-005-sqlite-json-persistence.md)), e o pluriverso só **busca** dados nas unidades
(Harvest, [ADR-016](ADR-016-contrato-de-harvest.md)). Isso pede servidor, internet e alguém que
cuide do servidor.

Duas ferramentas de coleta não cabem nesse molde:

- **BioCultRelatos** registra o conhecimento na voz de quem o detém (Relato, ADR-015 K2). A comunidade
  quase nunca tem servidor, e muitas vezes não tem internet. Soberania, aqui, é ter o dado **na mão**.
- **BioCultNaturalistas** é trabalho de uma pessoa (pesquisador, aluno de pós-graduação) sobre um ou
  mais relatórios de naturalistas. Um servidor é peso morto para isso.

BioCultDB e BioCultAcervos têm caráter institucional, com servidor disponível; continuam como estão.

## Decisão

### L1 — Forma de cada ferramenta

| Ferramenta | Forma | Chega ao pluriverso por |
|---|---|---|
| BioCultDB | Web (Docker) | Harvest |
| BioCultAcervos | Web (Docker) | Harvest |
| **BioCultRelatos** | App Windows que roda de **pen-drive**, sem instalar | **Envio** |
| **BioCultNaturalistas** | App desktop (Windows, macOS, Linux) | **Envio** |

Não há app de celular por ora (P-0026). Volta só como decisão nova.

### L2 — Custódia Local e Envio

- **Custódia Local:** o dado nasce e fica no aparelho de quem provê (o pen-drive, o computador). O app
  funciona sem internet. O dado só sai por ato da pessoa.
- **Envio:** a pessoa, no app, manda dados a um pluriverso. É o par do **Harvest** (o pluriverso
  busca). É de **uma via só**: o pluriverso devolve recibo e aviso, nunca dado. Não usar
  "sincronizar", que promete duas vias.
- O pluriverso é **índice derivado**. O aparelho é a fonte da verdade: um registro editado no
  pluriverso é sobrescrito no Envio seguinte.

### L3 — Unidade Federada = uma instalação

Cada pen-drive do BioCultRelatos e cada instalação do BioCultNaturalistas é uma Unidade Federada, com
SQLite próprio e inscrição própria. O pluriverso agrupa as unidades pela Fonte de Atribuição.

O pen-drive do BioCultRelatos é a unidade **da comunidade**, não de uma pessoa: fica com a liderança e
passa para quem vai registrar relatos ou fazer curadoria. Um só arquivo, um só escritor por vez: não há
conflito de edição para resolver.

Identidade (ajuste da pesquisa, §5.3):

- o **`member_id`** é da comunidade (ou da pessoa, no Naturalistas). Nasce na aprovação e vai no backup;
- a **credencial** é do aparelho. Não vai no backup;
- pen-drive perdido ou trocado = restaurar o backup num pen-drive novo + **pedido de credencial nova**
  para o mesmo `member_id` + revogação da antiga. Os `id` dos registros não mudam, e nada duplica;
- o pluriverso aceita **uma credencial ativa por `member_id`**, para nunca haver dois escritores.

Troca de dados entre aparelhos fica fora.

### L4 — O Envio leva só `public`

- Só registro de nível efetivo `public` (ADR-015 K3), no formato do contrato de Harvest
  ([`contrato-harvest.md`](../contrato-harvest.md) §3 e §4). Nada de outro nível sai do aparelho.
- **Tombstone** só `{id, rev, deleted: true}`, igual para registro apagado, rebaixado de nível ou
  retirado por revogação de consentimento. Sem motivo e sem nível. Só para `id` **já enviado** àquele
  pluriverso: o pluriverso nada aprende de novo.
- O app guarda, **por pluriverso**, o que já enviou (`id`, `rev`). O tombstone só some do app depois
  do recibo **e** de um Envio completo bem-sucedido.
- **"Retirar tudo"** é operação própria (o `purge_by_member` do ADR-004 D4), idempotente, retomável,
  confirmada por recibo. O app mostra que a retirada está pendente até o recibo. Texto da tela, em
  palavras simples: *"Ao retirar, seus registros somem do pluriverso. Quem já copiou ou baixou antes
  continua com a cópia; nós não temos como pedir de volta."*
- O pluriverso não guarda cópia de segurança para a comunidade. Exceção mínima, escrita aqui: o backup
  operacional do próprio pluriverso contém o que foi enviado. Por isso o pluriverso registra as
  retiradas (só `id` e data, sem conteúdo) e **as reaplica depois de qualquer restauração**; a guarda
  desses backups tem prazo máximo, fixado pelo pluriverso.

### L5 — Proteção no pen-drive e no computador

- **BioCultRelatos:** banco cifrado, no formato compatível com SQLCipher, pelo SQLite3 Multiple Ciphers
  (`sqlite-jdbc-crypt`). Não há SQLCipher oficial para JVM; o documento diz "compatível com SQLCipher",
  não "SQLCipher". A chave vem de uma **senha da comunidade** (derivação Argon2id, chave bruta ao
  SQLCipher). A senha não fica no pen-drive.
- **BioCultNaturalistas:** cifra opcional, com o mesmo mecanismo.
- **Backup:** arquivo cifrado com a senha da comunidade, gerado pela API de backup do SQLite (ou
  `VACUUM INTO`), nunca por cópia de arquivo, e guardado onde a comunidade escolher. O app faz o backup
  **ao fechar**.
- **Pen-drive:** `journal_mode=DELETE` (nunca WAL), `synchronous=FULL`, `locking_mode=EXCLUSIVE`. Cada
  transação é gravada no pen-drive na hora; uma remoção abrupta perde no máximo a transação em curso.
  `PRAGMA integrity_check` ao abrir. Aviso para fechar o app antes de tirar o pen-drive e para não
  mexer nos arquivos da pasta de dados.
- **Sem rastro no computador:** o app grava tudo dentro da própria pasta no pen-drive
  (`skiko.data.path` e o diretório temporário do driver SQLite apontados para `$APPDIR`).
- **Senha perdida = dado perdido.** O app nunca recria o banco em silêncio: mostra o erro e oferece
  restaurar um backup.

### L6 — Pacote de Vocabulário

O Módulo Compartilhado (código, [ADR-007](ADR-007-shared-bioculttermos-module.md)) fica só entre as
unidades web. Os apps recebem o **Pacote de Vocabulário**: o vocabulário SKOS-XL como **dado
versionado**, não como código. Um contrato de formato com testes comuns impede a divergência entre os
apps e o Módulo Compartilhado. Cada lote do Envio leva o identificador e a versão do pacote usado.

### L7 — Inscrição de apps

Apps não têm URL-BASE e não passam por *probe* ([ADR-006](ADR-006-federation-membership-protocol.md)
E1/E3). O fluxo:

1. O app faz o pedido e gera um **segredo de retirada** aleatório, que guarda.
2. O Comitê Federado aprova (decisão humana, ADR-006 E2). O ADR-006 E4 (autenticação da decisão do
   Comitê) continua **bloqueador**.
3. O pluriverso entrega a credencial **uma só vez**, a quem apresentar o segredo de retirada, e guarda
   só o *hash*. Uma credencial por aparelho e por pluriverso.
4. A credencial vai só no cabeçalho `Authorization`, nunca em URL. O pluriverso registra `lastUsed`.
5. Revogação pelos dois lados. No pluriverso é imediata; o app só sabe no próximo contato, recebe o
   motivo (`401`/`403`/`410`), mostra em palavras simples e para de tentar. No app, "desligar deste
   pluriverso" apaga a credencial local; "retirar tudo" é ação separada, na mesma tela.
6. O Comitê pode retirar os dados de um `member_id` sem o aparelho (ADR-004 D4), sem lixeira, e registra
   quem pediu e quando, sem conteúdo.

### L8 — O Envio

- A pessoa aperta "Enviar". Sem envio automático.
- **Por pluriverso:** cursor e conjunto do que já foi enviado.
- **Incremental**, e **completo** a cada 30 dias ou quando a pessoa pedir. O completo é "tudo ou nada":
  o pluriverso só aplica as exclusões por ausência quando recebe o manifesto final; um completo
  interrompido não apaga nada. Um completo vindo de backup velho não ressuscita o que já foi retirado
  (L4).
- **Idempotência por `(id, rev)`**: cada registro tem um contador `rev` que sobe a cada alteração local
  (o relógio do aparelho não é confiável). O pluriverso guarda o maior `rev` e o *hash* do conteúdo:
  mesmo `(id, rev)` com *hash* diferente = `409`; `rev` menor = ignorado. `updated_at` continua no
  payload, como informação.
- **Lotes** determinísticos, ordenados por `rev`, com `batch_id` guardado; a retentativa repete o mesmo
  lote. O pluriverso informa o tamanho máximo do lote.
- **Recibo por item** (aceito, ignorado por `rev`, rejeitado com motivo), com o `batch_id` ecoado. Só o
  recibo vale; um `200` sem recibo válido (portal de Wi-Fi) não conta. Registro que chega com nível
  diferente de `public` é rejeitado como erro de validação.

### L9 — Mídia

O Envio leva **só metadados e referência**, nunca o arquivo. O arquivo fica no pen-drive e no backup;
a comunidade o publica onde quiser. O link vai em `data`, em campo definido pelo Comitê Federado
(pendência ④ do contrato), e **não** em `relatedResources`, que liga só registros da federação
(contrato §6). O app pergunta "este link está aberto a qualquer pessoa?" e registra a resposta.
Retirar o registro remove o link, não o arquivo: a tela de retirada diz isso.

### L10 — Tecnologia (recomendação)

Kotlin + Compose Desktop (JVM) para os dois apps: uma só implementação do Envio e da regra contra
vazamento. Sem alvo Android por ora.

- BioCultRelatos: *app-image* Windows (`createDistributable` / `jpackage --type app-image`), com JRE,
  sem instalador. Tamanho não medido (~100 MB estimado).
- BioCultNaturalistas: distribuição para Windows, macOS e Linux. Não há compilação cruzada: um
  *runner* de CI por sistema.
- O JRE reduzido declara `java.sql`.

### L11 — Quem está usando o pen-drive

O pen-drive passa de mão em mão, e a credencial é dele, não da pessoa. Proposta: ao abrir, o app pede o
nome de quem está usando e grava esse nome no log de auditoria (`propostaGovernanca.md` §6.3; curadoria em §5.7) em cada
registro e cada ato de curadoria. É identificação, não autenticação: a proteção do dado é a senha da
comunidade (L5). Depende da resposta da comunidade (L13).

### L12 — Critérios de aceitação técnicos

Antes de prometer o app à comunidade, testar em máquina real:

1. tirar o pen-drive em laço durante gravações, em exFAT e FAT32;
2. o *app-image* limpo, num PC sem Java;
3. que nada é gravado fora da pasta do app no PC hospedeiro, inclusive em perfil somente leitura;
4. SmartScreen, AppLocker e antivírus com `.exe` não assinado;
5. o backup cifrado abre noutro computador, com a senha.

### L13 — Governança

Uma *Issue* `para-ponto-focal` + `fonte-primaria` pergunta à comunidade, em palavras simples: quem
guarda o pen-drive; quem guarda a senha e o que fazer se ela se perder; quem pode pedir a retirada
total (pessoa, comunidade, Comitê); que computadores existem. A *Issue* nasce depois que o resumo da
próxima reunião for validado. Esta ADR fica *Proposto* até a resposta.

## Relações

Esta ADR muda pontos de ADRs vigentes. Cada uma recebe nota "em revisão por esta ADR", sem apagar o
texto original:

| ADR | Ponto | O que muda |
|---|---|---|
| [ADR-004](ADR-004-federated-architecture.md) | D1, D6 | O pluriverso passa a ter duas entradas: Harvest e Envio |
| [ADR-005](ADR-005-sqlite-json-persistence.md) | DA1 | Nos apps, um arquivo SQLite por instalação, sem container e sem WAL |
| [ADR-006](ADR-006-federation-membership-protocol.md) | E1, E3 | Tipo de membro sem URL-BASE e sem *probe* |
| [ADR-007](ADR-007-shared-bioculttermos-module.md) | F1 | Módulo Compartilhado só nas unidades web; apps recebem o Pacote de Vocabulário |
| [ADR-009](ADR-009-pluriverso-multi-instance-topology.md) | MI4 | O app se inscreve em um ou mais pluriversos, com credencial por pluriverso |
| [ADR-016](ADR-016-contrato-de-harvest.md) | H2, H4 | No Envio, a redação acontece no app; condição de aceitação própria do Envio |

Emendas pedidas ao [contrato de Harvest](../contrato-harvest.md):

- §4.2: tombstone "no Harvest, nunca; no Envio, só para `id` já enviado e sem motivo" (L4);
- §3: `rev` no registro enviado (L8);
- §6 e pendência ④: o link de mídia vai em `data`, não em `relatedResources` (L9).

## Consequências

### Positivas

- A custódia passa a ser física: a comunidade guarda o pen-drive. É a soberania do ADR-004 levada ao
  objeto.
- Funciona sem internet e sem servidor. O pluriverso não é necessário para coletar nem para curar.
- Um escritor por unidade: não há conflito de edição.
- O pluriverso nunca recebe o que não é `public`.

### Negativas

- **Senha perdida = dado perdido.** *Mitigação:* backup cifrado; a pergunta de L13 trata de quem guarda
  a senha.
- **Pen-drive é mídia frágil** (perda, queda, controlador que mente sobre a gravação). *Mitigação:* L5 e
  testes de L12; recomendar pen-drive de marca.
- **Duas formas de entrada no pluriverso** para manter (Harvest e Envio). *Mitigação:* o Envio usa o
  mesmo formato de registro do contrato de Harvest.
- **Retirar não recolhe** o que alguém já copiou. *Mitigação:* dizer isso na tela, antes do primeiro
  Envio e na retirada.
- **Revogação chega ao app só no próximo contato.**
- **Duas bases de código** para o vocabulário (Módulo Compartilhado e apps). *Mitigação:* Pacote de
  Vocabulário como dado e testes de formato comuns.

## O que esta ADR não decide

| # | Questão | Situação |
|---|---|---|
| L-Q1 | Respostas da comunidade (L13) | Aguarda a *Issue* para a Ponto-Focal |
| L-Q2 | Campos de `data` para o link de mídia | Comitê Federado (pendência ④ do contrato) |
| L-Q3 | Prazo de guarda dos backups do pluriverso | Cada pluriverso |
| L-Q4 | App de celular | Fora do escopo por ora (P-0026) |
| L-Q5 | Harvest autenticado de `restricted` | Continua extensão futura (ADR-009) |

## Referências

- [`pesquisa/envio-apps-offline.md`](../pesquisa/envio-apps-offline.md) — CoMapeo, ODK/Kobo, GBIF IPT,
  Mukurtu; fatos de viabilidade
- [ADR-004](ADR-004-federated-architecture.md), [ADR-005](ADR-005-sqlite-json-persistence.md),
  [ADR-006](ADR-006-federation-membership-protocol.md), [ADR-007](ADR-007-shared-bioculttermos-module.md),
  [ADR-009](ADR-009-pluriverso-multi-instance-topology.md), [ADR-015](ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md),
  [ADR-016](ADR-016-contrato-de-harvest.md)
- [`contrato-harvest.md`](../contrato-harvest.md) §3, §4, §6, §7
- `docs/Governanca/Proposta/propostaGovernanca.md` §5.7 (curadoria), §6.3 (log de auditoria, cifra em repouso)
- Prompts P-0023 a P-0026 (`docs/Pesquisa/IA/prompts/2026/`)

## Data de Revisão

Revisitar quando (a) a comunidade responder L13; (b) os testes de L12 rodarem pela primeira vez; ou
(c) voltar o pedido de app de celular.
