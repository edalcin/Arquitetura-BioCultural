# Sugestão de pauta — reunião com Sofia Zank, 2026-09-29

- **Participantes previstos:** Sofia Zank (UseFlora, Ponto-Focal), Eduardo Couto Dalcin (gestão da arquitetura)
- **Duração de referência:** 60 min
- **Contexto:** terceira reunião do ciclo do Ponto-Focal (`docs/projetoPesquisa.md` §7.2, item 7), a primeira depois do evento de Sofia em Brasília.
- **Base:** [`2026-09-16-reuniao-sofia.md`](2026-09-16-reuniao-sofia.md) · [`2026-09-18-reuniao-sofia.md`](2026-09-18-reuniao-sofia.md) · [`impactos-na-arquitetura.md`](impactos-na-arquitetura.md) · [`../pautaComunidades/pauta-comunidades.md`](../pautaComunidades/pauta-comunidades.md) · [`../pautaComunidades/preparacao-reuniao-2026-09-16.md`](../pautaComunidades/preparacao-reuniao-2026-09-16.md)

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
| Pautas 3 e 4 | Consideradas não aplicáveis ao UseFlora, com ressalva sobre ocultação/retirada |
| Impacto sobre a arquitetura | 15 itens no log (I-01 a I-15); **nenhum aplicado**; ADR-018 e ADR-019 propostas, não escritas |
| Anotações de Sofia | Não esgotadas |

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
- **Revisão do resumo de 18/09.** Mesmo pedido, agora para o segundo resumo.
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
| 3.5 | A raiz legal dos Coletivos é o **Decreto nº 8.750/2016** (institui o CNPCT) ou o **nº 8.772/2016** (regulamenta a Lei 13.123)? | O `CONTEXT.md` usa o 8.750; o resumo de 18/09 registrou "8772" a partir da transcrição automática | Log §6 |

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
   do UseFlora, ou esperar a proposta de Laura Madeira (pendência ⑮)?
4. **Princípios mínimos da federação** (pendência ⑭). Encaminhados ao Comitê Gestor em 18/08, com
   4–6 semanas sugeridas — **o prazo vence nesta data**. Há retorno do Comitê?
5. **Uso real de TK/BC Labels.** Sofia pediu apoio de IA para o levantamento. Combinar o escopo da
   busca (quais agregadores, quais países) antes de rodar.

---

## Itens que ficam fora desta reunião

Registrados para não serem esquecidos, mas sem espaço hoje:

- **`regime: "evidencia"` para os 29 registros do BioCultDB** — checklist de 16/09. A decisão 1
  daquela reunião (prioridade de Evidência) e a decisão 6 (Notice para Evidência) já dão a base; a
  migração é ato técnico e pode ser decidida daqui, com registro na próxima reunião.
- **Política de remoção do banco a pedido da comunidade** — adiada nas duas reuniões; continua
  adiada.
- **Onde mora o vídeo (⑩)** — pauta de campo, não do UseFlora.
- **Nova versão da `pauta-comunidades.md`** — combinado fazer depois de fechadas as discussões em
  curso.

---

## Checklist de encerramento

- [ ] Informes de Brasília registrados (ICMBio, farmacopeia popular, GEF)
- [ ] Revisão de Sofia dos resumos de 16/09 e 18/09 recebida ou com data
- [ ] Anotações de Sofia concluídas, ou ponto de parada registrado
- [ ] Leituras 3.1 a 3.5 confirmadas ou corrigidas — libera a escrita da ADR-018 e da ADR-019
- [ ] Posição sobre o Relato sobre Evidência (I-14), ou encaminhamento às reuniões ampliadas
- [ ] Retorno do Comitê Gestor sobre princípios mínimos (⑭), ou nova data
- [ ] Data da próxima reunião

## Depois da reunião

Seguir o ciclo do Ponto-Focal: resumo em `docs/reunioes/2026-09-29-reuniao-sofia.md` → nova entrada
em [`impactos-na-arquitetura.md`](impactos-na-arquitetura.md) → alteração dos documentos de destino
por ato próprio.
