# Sugestão de pauta — reunião com Sofia Zank, 2026-09-29

- **Participantes previstos:** Sofia Zank (UseFlora, Ponto-Focal), Eduardo Couto Dalcin (gestão da arquitetura)
- **Duração de referência:** 60 min
- **Contexto:** terceira reunião do ciclo do Ponto-Focal (`docs/projetoPesquisa.md` §7.2, item 7), a primeira depois do evento de Sofia em Brasília.
- **Base:** [`2026-09-16-reuniao-sofia.md`](2026-09-16-reuniao-sofia.md) · [`2026-09-18-reuniao-sofia.md`](2026-09-18-reuniao-sofia.md) · [`impactos-na-arquitetura.md`](impactos-na-arquitetura.md) · [`../pautaComunidades/pauta-comunidades.md`](../pautaComunidades/pauta-comunidades.md) · [`../pautaComunidades/preparacao-reuniao-2026-09-16.md`](../pautaComunidades/preparacao-reuniao-2026-09-16.md)

> **`docs/pautaComunidades/` está congelada desde 28/09/2026.** A pauta das comunidades segue daqui
> em diante nas reuniões com o Ponto-Focal. A seção [Rastreio da pauta das comunidades](#rastreio-da-pauta-das-comunidades)
> mostra onde cada item daquela pasta está. A próxima pauta copia a tabela e atualiza a coluna *Estado*.

> **Regra de ordem, combinada em 18/09:** primeiro concluir as anotações de Sofia; só depois voltar
> ao documento de preparação. Esta pauta respeita essa ordem. Os blocos 3 e 4 entram no tempo que
> sobrar, e o que não couber passa para a próxima reunião.

> **Fronteira que continua valendo:** o Ponto-Focal desenha o campo e nunca preenche o valor.
> Nenhum item abaixo pede a Sofia uma decisão sobre um registro concreto de uma comunidade.

---

## Estado de partida

| Frente | Estado em 2026-09-29 |
|---|---|
| Designação do Ponto-Focal | Resolvida — e-mail de Nivaldo, 17/09/2026 |
| Pautas 5, 6 e 7 (desenho) | Discutidas em 16/09 — decisões 2 a 7 daquele resumo |
| Pautas 1 e 2 (consentimento, parte de desenho) | Discutidas em 18/09 — decisões 1 a 11 daquele resumo |
| Pautas 3 e 4 | Consideradas não aplicáveis ao UseFlora, com ressalva sobre ocultação/retirada; continuam abertas para iniciativas com gravação de campo |
| Impacto sobre a arquitetura | 15 itens no log (I-01 a I-15); **nenhum aplicado**; ADR-018 e ADR-019 propostas, não escritas |
| Anotações de Sofia | Não esgotadas |

---

## Abertura — Anuência para transcrição e uso de IA (2 min)

Antes de ligar a transcrição. Pedir a Sofia anuência explícita para:

1. **Transcrição integral** da reunião pelo Tactiq.
2. **Processamento por IA** da transcrição, para gerar o resumo publicado em `docs/reunioes/` e
   avaliar o impacto na arquitetura (`docs/projetoPesquisa.md` §7.2, item 7, e §7.5).
3. **Retroativo:** a mesma anuência para as transcrições e resumos de 16/09 e 18/09, que já foram
   feitos sem registro de anuência.

A resposta fica registrada na transcrição e no cabeçalho do resumo de 29/09. A transcrição bruta
não é versionada (`.gitignore`); só o resumo revisado é publicado.

---

## Bloco 1 — Retorno de Brasília e articulações (10 min)

Informes de Sofia. Não pedem decisão; registram o estado das pontes abertas em 18/09.

1. **ICMBio / Programa Monitora (Rodrigo Jorge).** Resultado da sondagem no evento. Eduardo mandou
   (ou manda) a mensagem prévia de apresentação? Há interesse numa apresentação da arquitetura?
2. **Farmacopeia popular (Jaqueline).** Sofia encaminhou o contato? Data possível para a conversa
   sobre a fase piloto no Cerrado e o banco de dados deles.
3. **Iniciativas do GEF com dados primários no SiBBr.** Chegou mais demanda de política de dados?
   É pressão de escopo registrada, sem decisão (log §3.5).
4. **Reunião sobre domesticação e manejo (Nivaldo e Carol).** Ainda sem contato; confirmar se Sofia
   pode reforçar o pedido de agendamento.

---

## Bloco 2 — Anotações de Sofia (25 min)

Retomar exatamente do ponto em que parou em 18/09. Eduardo não conduz este bloco: registra.

- **Revisão do resumo de 16/09.** Sofia fez a revisão pedida em 18/09? Há correção de conteúdo, em
  especial nas decisões 3, 4 e 7, que viraram impacto direto (I-03, I-04, I-10)?
- **Revisão do resumo de 18/09** — feita por Sofia (PR #1, 28/09). Confirmar se a revisão está completa.
- **Anotações restantes** sobre `pauta-comunidades.md` e demais documentos.

---

## Bloco 3 — Confirmar as leituras que a arquitetura fez das decisões (15 min)

O log de impactos interpretou as decisões das duas reuniões. Algumas interpretações **vão além** do
que foi dito e contradizem texto vigente. Antes de escrever a ADR-018 e a ADR-019, confirmar com
Sofia que a leitura está certa. Uma pergunta por item, com a resposta do log ao lado.

| # | Pergunta para Sofia | Leitura que o log fez | Item |
|---|---|---|---|
| 3.1 | "Sagrado" pode ser **publicado como existência** (o registro diz que há Conhecimento sagrado) mesmo quando o registro é privado no resto? | Sim: `sacred` deixa de ser nível de acesso e passa a ser dimensão do registro, com existência publicável e conteúdo não persistido | I-03 |
| 3.2 | Quando o artigo publicado descreve o conteúdo sagrado, a unidade **não guarda** esse trecho, nem internamente? | Sim: *redaction at rest* para conteúdo sagrado em Evidência — exceção à regra geral da ADR-015 | I-04 |
| 3.3 | Se uma pessoa recusa aparecer num vídeo autorizado pela comunidade, quem produz a versão editada, e quem confere? | A plataforma não edita por conta própria; a recusa dispara **pedido** de derivado editado; o original fica restrito até existir o derivado | I-05 |
| 3.4 | O default privado vale para **todo** o Coletivo, ou cada Coletivo pode escolher o seu (ex.: farmacopeia popular, para quem registrar é proteger)? | Default privado como omissão segura, revisável por Coletivo | I-11, I-13 |
| 3.5 | A raiz legal dos Coletivos é o **Decreto nº 8.750/2016** (institui o CNPCT) ou o **nº 8.772/2016** (regulamenta a Lei 13.123)? | O `CONTEXT.md` usa o 8.750; o resumo de 18/09 registrou "8772"; Sofia manteve o número na revisão de 28/09 | Log §6 |
| 3.6 | "Segmento" (benzedeiras, raizeiras…) é o mesmo que a categoria legal do Decreto? | Sim: o nível mínimo do Coletivo é a categoria legal; "segmento" não está no `CONTEXT.md` | I-07 |
| 3.7 | Um saber classificado como sagrado pode **deixar de ser** sagrado com o tempo? Quem pede a mudança? | O log cobre só um sentido: a supressão retroativa, quando algo passa a ser sagrado. O sentido contrário não tem leitura | I-03, I-04 (Pauta 6 q3) |
| 3.8 | A forma de nomeação é **uma por pessoa**, ou pode mudar conforme o assunto (ex.: nome no uso alimentar, pseudônimo no ritual)? | Não há leitura. A decisão 4 de 18/09 varia a exibição por público, não por assunto | I-01 (Pauta 1 q3) |

---

## Bloco 4 — Questões abertas, para Sofia levar ou opinar (10 min)

Itens que nenhuma das duas reuniões fechou. Para cada um: Sofia tem posição, ou leva às reuniões
ampliadas?

1. **Relato da comunidade sobre uma Evidência publicada — onde ele nasce?** (I-14, o buraco
   estrutural). Pergunta direta: a arquitetura deve **oferecer uma instância do BioCultRelatos** à
   comunidade que se reconhece num artigo, ou a correção fica como item do relatório de pendências,
   ligada ao artigo, até a comunidade ter Unidade Federada?
2. **Existe secreto não-sagrado?** Pendente desde 16/09. Determina se a matriz sagrado × secreto tem
   três ou quatro células.
3. **Camadas de governança — composição e mandato** (I-15). Hoje a camada de arquitetura é esta
   reunião de duas pessoas. Qual o próximo passo realista: ampliar a reunião, levar ao Comitê Gestor
   do UseFlora, ou esperar a proposta de Laura Madeira (pendência ⑮)? Inclui quem declara o sagrado
   e quem fala pelo grupo numa gravação (Pautas 6 q2 e 5 q3). Base de 16/09: a regra interna do
   coletivo vale; a **Plataforma de Territórios Tradicionais** é precedente de prova de
   representatividade (ata ou carta assinada por várias pessoas).
4. **Princípios mínimos da federação** (pendência ⑭). Encaminhados ao Comitê Gestor em 18/08, com
   4–6 semanas sugeridas — **o prazo vence nesta data**. Há retorno do Comitê?
5. **Uso real de TK/BC Labels.** Sofia pediu apoio de IA para o levantamento. Escopo parcial definido
   na revisão de 28/09: bancos de dados de CTA. Falta definir quais agregadores e quais países.
6. **Conjunto brasileiro de rótulos** (I-12; pendência de 18/09). Quais famílias entram — época,
   restrição por gênero ou família, usos permitidos (Pauta 2 q1–q4)? O valor de cada rótulo continua
   consentimento, registro a registro.
7. **Quem controla o rótulo brasileiro?** (Pauta 2 q5). Sem o Hub do Local Contexts, o rótulo fica no
   banco da unidade. Como a comunidade muda o rótulo sem depender do curador?
8. **Contato para mudar de ideia** (Pauta 1 q4). A arquitetura guarda um canal de contato para a
   revogação futura? Se guarda, esse contato é dado pessoal sensível e segue a mesma escolha de
   nomeação?

---

## Itens que ficam fora desta reunião

Registrados para não serem esquecidos, mas sem espaço hoje:

- **`regime: "evidencia"` para os 29 registros do BioCultDB** — checklist de 16/09. A decisão 1
  daquela reunião (prioridade de Evidência) e a decisão 6 (Notice para Evidência) já dão a base; a
  migração é ato técnico e pode ser decidida daqui, com registro na próxima reunião. Junto: tornar
  `regime` obrigatório no esquema do BioCultDB e gravar `evidencia` por default no BioCultPapers
  (preparação de 16/09, §4.3).
- **Política de remoção do banco a pedido da comunidade** — adiada nas duas reuniões; continua
  adiada. Cobre também a Pauta 4 q2 (registro que entrou por engano) e o item 9 do roteiro de campo.
- **Onde mora o vídeo (⑩)** — pauta de campo, não do UseFlora.
- **Pautas de campo sem interlocução** — Pauta 3 (imagem e voz, transcrição em língua originária,
  forma de comprovar o consentimento do art. 9º, §1º) e Pauta 4 (o que não registrar). Esperam
  ponto-focal de iniciativa com gravação de campo.
- **Pontos-focais das outras iniciativas** — BioCultRelatos (mestrado de Silveiras),
  BioCultNaturalistas e GEF "Entre-Ciências": nenhum foi solicitado.

---

## Rastreio da pauta das comunidades

Origem: [`../pautaComunidades/pauta-comunidades.md`](../pautaComunidades/pauta-comunidades.md) (P) e
[`../pautaComunidades/preparacao-reuniao-2026-09-16.md`](../pautaComunidades/preparacao-reuniao-2026-09-16.md) (Prep),
congelados em 28/09/2026. Valores de registro concreto (consentimento) nunca fecham nesta reunião.

| Origem | Assunto | Estado em 29/09 | Onde segue |
|---|---|---|---|
| Prep §1 | Designação do Ponto-Focal | Resolvido (17/09) | — |
| Prep §2, §4 | `regime` ausente nos 29 registros; pipeline | Decisão técnica pendente | Fora desta reunião |
| P1 q1–q2 | Como a pessoa quer ser nomeada | Desenho decidido em 18/09 (d. 2–4); valor é consentimento | I-01, I-02 → ADR-018 |
| P1 q3 | Nomeação muda por assunto? | Aberta | 3.8 |
| P1 q4 | Contato para mudar de ideia | Aberta | Bloco 4.8 |
| P1 q5 | Nome do grupo | Decidido em 18/09 (d. 7, autodenominação) | I-07 |
| P2 q1–q4 | Época, gênero, usos, legitimidade | Princípio decidido em 18/09 (d. 8, 9, 11); conjunto a desenhar | Bloco 4.6 |
| P2 q5 | Quem controla o rótulo | Aberta | Bloco 4.7 |
| P3 | Imagem e voz; língua originária; forma do consentimento | Não aplicável ao UseFlora | Fora (pautas de campo) |
| P4 | O que não registrar | Não aplicável ao UseFlora; remoção adiada | Fora (política de remoção) |
| P5 q1, q2, q4 | Gravação coletiva: pessoa × grupo | Decidido em 16/09 (d. 2) | 3.3 (I-05) |
| P5 q3 | Quem fala pela gravação | Parcial em 16/09 (regra interna do coletivo) | Bloco 4.3 (I-15) |
| P6 q1 | Sagrado some ou mostra que existe | Decidido em 16/09 (d. 3–4) | 3.1, 3.2 (I-03, I-04) |
| P6 q2 | Quem declara o sagrado | Parcial em 16/09 (d. 11, camada intermediária) | Bloco 4.3 (I-15) |
| P6 q3 | Sagrado muda com o tempo | Parcial (só supressão retroativa) | 3.7 |
| P7 | Detentor apagado pela publicação | Decidido em 16/09 (d. 7, caminho iii) | I-10 |
| P, Iniciativas parceiras | Pontos-focais de Silveiras, BioCultNaturalistas, GEF | Não solicitados | Fora |
| P, Como conduzir; Roteiro mínimo | Instrumentos de campo | Congelados como referência; valem para qualquer consulta de campo | P, seções próprias |

---

## Checklist de encerramento

- [ ] Anuência de Sofia para transcrição e processamento por IA (29/09 e retroativa) registrada
- [ ] Informes de Brasília registrados (ICMBio, farmacopeia popular, GEF)
- [ ] Revisão de Sofia dos resumos de 16/09 e 18/09 recebida ou com data
- [ ] Anotações de Sofia concluídas, ou ponto de parada registrado
- [ ] Leituras 3.1 a 3.8 confirmadas ou corrigidas — libera a escrita da ADR-018 e da ADR-019
- [ ] Posição sobre o Relato sobre Evidência (I-14), ou encaminhamento às reuniões ampliadas
- [ ] Retorno do Comitê Gestor sobre princípios mínimos (⑭), ou nova data
- [ ] Data da próxima reunião

## Depois da reunião

Seguir o ciclo do Ponto-Focal: resumo em `docs/reunioes/2026-09-29-reuniao-sofia.md` → nova entrada
em [`impactos-na-arquitetura.md`](impactos-na-arquitetura.md) → alteração dos documentos de destino
por ato próprio → episódio E-04 em [`../ia/uso-de-ia.md`](../ia/uso-de-ia.md).
