# Sugestão de pauta — próxima reunião com Sofia Zank (data a definir)

- **Participantes previstos:** Sofia Zank (UseFlora, Ponto-Focal), Eduardo Couto Dalcin (gestão da arquitetura); Viviane Kruel, se aceitar o convite para fontes primárias
- **Duração de referência:** 60 min
- **Data:** a definir por Sofia; ela pediu pelo menos 15 dias depois de 29/09. Quando a data for marcada, este arquivo passa a se chamar `AAAA-MM-DD-pauta-reuniao-sofia.md`
- **Contexto:** quarta reunião do ciclo do Ponto-Focal (`docs/projetoPesquisa.md` §7.2, item 7)
- **Base:** [`2026-09-29-reuniao-sofia.md`](2026-09-29-reuniao-sofia.md) · [`2026-09-29-impactos-reuniao-sofia.md`](2026-09-29-impactos-reuniao-sofia.md) · [`impactos-na-arquitetura.md`](impactos-na-arquitetura.md) · [`2026-09-29-pauta-reuniao-sofia.md`](2026-09-29-pauta-reuniao-sofia.md)

> **Como ler esta pauta.** Cada pergunta que pede decisão vem em quatro partes: **o que está em
> jogo**, em palavras simples; **o que a arquitetura faz hoje**; as **opções**, com a consequência
> de cada uma; e a **pergunta** em uma frase. Todo código (`I-04`, `⑭`) vem com o que ele
> significa. Os códigos `I-xx` são os **itens de impacto na arquitetura** — a lista completa está em
> [`impactos-na-arquitetura.md`](impactos-na-arquitetura.md) §1.

> **Dúvidas antes da reunião.** Abra uma *Issue* no GitHub citando o nome deste arquivo e o número do
> item (ex.: "proxima-pauta-reuniao-sofia.md, item 2.1"). A resposta vem por lá, e a pauta é
> corrigida antes da reunião.

> **Fronteira que continua valendo:** o Ponto-Focal desenha o campo e nunca preenche o valor.
> Nenhum item abaixo pede a Sofia uma decisão sobre um registro concreto de uma comunidade.

---

## Estado de partida

| Frente | Estado depois de 29/09 |
|---|---|
| Leituras do log (pauta de 29/09, Bloco 3) | 3.1, 3.4, 3.5, 3.6, 3.7 e 3.8 respondidas; 3.3 fora do escopo; **3.2 sem decisão** |
| Itens de impacto | 19 (I-01 a I-19); nenhum aplicado. **ADR-018 pode ser escrita**; ADR-019 espera o Bloco 2 desta pauta |
| Bloco 4 da pauta de 29/09 (questões abertas) | Não tratado; vem inteiro para esta pauta, menos o item 2 (respondido) |
| Anotações de Sofia sobre a pauta das comunidades | Concluídas em 29/09 |
| Anuência para transcrição e IA | Dada em 29/09; parte retroativa (16/09 e 18/09) a confirmar |

---

## Retrospecto da pauta de 29/09

A pauta de 29/09 ([`2026-09-29-pauta-reuniao-sofia.md`](2026-09-29-pauta-reuniao-sofia.md)) fica
congelada como memória. O que foi tratado e o que ficou pendente está aqui. "d." = decisão do
[resumo de 29/09](2026-09-29-reuniao-sofia.md).

| Item da pauta de 29/09 | O que aconteceu | Onde segue |
|---|---|---|
| Abertura — anuência para transcrição e IA | Dada para a reunião de 29/09 (d. 1). A parte retroativa (16/09 e 18/09) não foi dita em separado | Abertura, item 1 |
| 1.1 ICMBio / Programa Monitora | Sofia falou com Rodrigo Jorge em Brasília; o ICMBio quer saber o que pode ser público. Sofia sugeriu ao CNPT que a rede interna faça a ponte | Eduardo manda mensagem informal a Rodrigo depois desta reunião (fora da pauta) |
| 1.2 Farmacopeia popular (Jaqueline) | Suspensa: sem apoio institucional, Jaqueline não quer tocar a nova fase sozinha | Fora da pauta, até haver cenário adequado |
| 1.3 Iniciativas do GEF no SiBBr | Nenhuma demanda nova chegou | Encerrado |
| 1.4 Domesticação e manejo | Nivaldo e Carol precisam conversar entre eles antes; Eduardo pediu para ouvir essa conversa | Bloco 1, item 2 (I-19) |
| 2 — Revisão dos resumos de 16/09 e 18/09 | Feitas por Sofia (PR #1 e PR #2) | Encerrado |
| 2 — Anotações de Sofia | Concluídas: Sofia não tem mais anotações. A dúvida dela sobre os códigos `I-xx` foi resolvida na reunião | Encerrado |
| 3.1 Existência do sagrado publicável | Sim: "o aviso precisa aparecer" (d. 2). Ressalva: o que protege pode ser o sigilo (d. 3) | Bloco 2.2 |
| 3.2 Conteúdo sagrado de artigo: guardar ou não | Sem decisão: a resposta de 29/09 difere da de 16/09 (d. 4) | Bloco 2.1 |
| 3.3 Quem edita o vídeo | Fora do escopo deste canal: é fonte primária (d. 5) | Bloco 1, item 1; fora da pauta |
| 3.4 Default privado por coletivo | Cada coletivo define o que é privado (d. 6) | Encerrado (I-11, I-13) |
| 3.5 Decreto 8.750 × 8.772 | Os dois valem: a raiz é a Lei nº 13.123, regulamentada pelo 8.772; o 8.750 lista os segmentos (d. 11) | Encerrado (I-16) |
| 3.6 "Segmento" = categoria legal | Sim, e a lista do decreto não é exaustiva (d. 11) | Encerrado (I-07, I-16) |
| 3.7 Sagrado muda com o tempo | Sim, nos dois sentidos (d. 8) | Encerrado; vai para a ADR-019 |
| 3.8 Nomeação muda por assunto | Não: uma escolha geral por pessoa (d. 10) | Encerrado (I-01) |
| 4.1 Relato sobre Evidência (I-14) | Não tratado | Bloco 4, item 1 |
| 4.2 Existe secreto não-sagrado? | Sim (d. 3) | Encerrado |
| 4.3 Camadas de governança (I-15) | Não tratado. Eduardo convidou Viviane para fontes primárias; não espera mais a proposta de Laura Madeira (⑮) | Bloco 1, item 1; Bloco 4, item 2 |
| 4.4 Princípios mínimos da federação (⑭) | Não tratado; explicado a Sofia na reunião. Sem retorno do Comitê Gestor | Bloco 1, item 3 |
| 4.5 Uso real de TK/BC Labels | Não tratado | Bloco 4, item 3 |
| 4.6 Conjunto brasileiro de rótulos (I-12) | Não tratado | Bloco 4, item 4 |
| 4.7 Quem controla o rótulo | Não tratado | Bloco 4, item 5 |
| 4.8 Contato para mudar de ideia | Não tratado | Bloco 4, item 6 |
| Checklist — data da próxima reunião | Sofia agenda, com pelo menos 15 dias | Cabeçalho desta pauta |

Temas novos que não estavam na pauta de 29/09: conflito entre coletivos (d. 7, I-17) e incerteza
declarada (d. 9, I-18) → Bloco 3.

---

## Abertura (5 min)

1. **Anuência retroativa.** Em 29/09 Sofia deu anuência para a transcrição e o processamento por IA
   daquela reunião. Falta confirmar que a mesma anuência vale para as reuniões de 16/09 e 18/09, cujos
   resumos já estão publicados.
2. **Revisão do resumo de 29/09.** Sofia revisou? Há correção de conteúdo, em especial nas decisões
   3, 4 e 7?

---

## Bloco 1 — Informes (10 min)

Não pedem decisão; registram o estado das pontes.

1. **Interlocutor de fontes primárias.** Viviane aceita participar da governança da arquitetura com
   esse papel (ligado ao BioCultRelatos)? Se sim, as perguntas de fonte primária que saíram deste
   canal — como a 3.3, sobre edição de vídeo (I-05) — voltam com ela.
2. **Domesticação e manejo (Nivaldo e Carol).** Eles já conversaram entre eles? Eduardo pode ouvir a
   conversa? (I-19: a arquitetura ainda não modela a evidência de domesticação e manejo.)
3. **Princípios mínimos da federação (⑭).** É o conjunto mínimo de regras que toda instância aceita
   para entrar na federação — uma "carta de adesão": registrar logs de acesso, respeitar os rótulos de
   sensibilidade, tratar o consentimento como ciclo que pode ser revogado. Foi encaminhado ao Comitê
   Gestor do UseFlora em 18/08. Sofia conseguiu saber em que pé está?
4. **Guardiões e Conselho do UseFlora.** Sofia já levou alguma das perguntas do Bloco 3? Sem pressão
   de prazo: o tempo é o das comunidades.
5. **Lista de povos indígenas.** Viviane circulou o dado da FUNAI?

---

## Bloco 2 — Decisões que liberam a ADR-019 (25 min)

A ADR-019 é o documento de arquitetura que vai dizer como o sistema trata o **sagrado** e o
**secreto**. Ela só pode ser escrita depois destas duas decisões.

### 2.1 Conteúdo sagrado descrito num artigo: a unidade guarda ou não guarda? (I-04)

**O que está em jogo.** Um artigo científico publicado descreve **como** um conhecimento sagrado é
usado. O BioCultDB lê o artigo e extrai o que ele diz. A pergunta é o que acontece com o trecho
sagrado **dentro do banco** — não na tela.

**O que a arquitetura faz hoje.** Guarda tudo e filtra na saída: o trecho fica no banco, mas não
aparece para o público (ADR-015, K6).

**As duas respostas que Sofia já deu:**

- Em 16/09: "é ilegítimo registrar por quê e como — **mesmo quando o artigo publicado descreve**".
- Em 29/09: "se está no artigo, a unidade registra; **só não deixa público**".

| | Opção A — guardar e não publicar | Opção B — não guardar |
|---|---|---|
| O que acontece | O trecho fica no banco, marcado; ninguém de fora vê | O trecho nunca entra no banco; fica só a marca "aqui há conhecimento sagrado" |
| A favor | A comunidade pode, um dia, pedir o trecho de volta ou liberá-lo. Nada se perde | Não há o que vazar: nem erro de programa, nem invasão, nem pessoa da equipe expõe o trecho |
| Contra | Se o filtro falhar, o trecho aparece. A equipe da unidade vê o trecho | A perda é definitiva. Se a comunidade quiser o trecho, tem de voltar ao artigo |
| Muda a arquitetura? | Não — é a regra de hoje | Sim — cria uma exceção à ADR-015 só para conteúdo sagrado de artigo |

**Pergunta:** para conteúdo sagrado descrito num artigo, A ou B? Se a resposta depender da
comunidade, qual é o default até ela decidir?

### 2.2 Sagrado e sigilo: uma marca ou duas? (I-03)

**O que está em jogo.** Em 29/09 ficou claro que há conhecimento **secreto que não é sagrado** (por
exemplo, um uso econômico que o coletivo não quer divulgar) e conhecimento **sagrado que não é
secreto** (a jurema-preta: todos sabem que é sagrada). Sofia sugeriu que o que protege é o **sigilo**,
e que o sagrado talvez seja mais próximo de uma categoria de uso.

**O que a arquitetura faz hoje.** Tem só a marca "sagrado", e ela funciona como nível de acesso:
sagrado é tratado como privado (regra interina do contrato de *harvest*).

| | Opção A — duas marcas independentes | Opção B — uma marca só, "sagrado" |
|---|---|---|
| O que acontece | **Sagrado** diz o que o conhecimento é, e pode aparecer como aviso. **Sigiloso** diz se o conteúdo pode ser mostrado. Um registro pode ter uma, as duas ou nenhuma | Sagrado continua sendo a única marca e controla o acesso |
| A favor | Cobre os quatro casos (sagrado e sigiloso; só sagrado; só sigiloso; nenhum). O segredo econômico fica protegido sem ser chamado de sagrado | Mais simples de explicar e de preencher |
| Contra | Quem preenche precisa entender duas perguntas diferentes | O segredo econômico fica sem marca, ou tem de ser chamado de sagrado. A jurema-preta ficaria escondida sem motivo |

**Pergunta:** A ou B? E, em qualquer das duas: os nomes finais ("sagrado", "sigilo", "secreto",
"mistério") esperam a resposta dos Guardiões? O sistema pode usar um nome interno e mostrar na tela o
nome que a comunidade escolher.

---

## Bloco 3 — Conflito entre coletivos e incerteza: como funciona (10 min)

As duas regras foram firmadas em 29/09. O que falta é o **mecanismo**.

### 3.1 Conflito entre coletivos (I-17)

**A regra firmada:** se um coletivo quer publicar e outro, também representativo, não quer, tudo fica
privado até eles resolverem — mesmo que um deles já tenha autorizado a inserção.

**O que está em jogo.** Quando os dois coletivos usam a **mesma** unidade, o sistema consegue aplicar
a regra. Quando cada um tem a sua unidade (por exemplo, dois BioCultRelatos), o sistema **não tem como
saber** que os dois registros falam da mesma coisa: não há banco central, e nenhuma unidade decide
por outra.

| | Opção A — embargo a pedido | Opção B — detecção automática |
|---|---|---|
| O que acontece | O coletivo que discorda pede o embargo, com ata. A unidade que publicou tira o registro do público até o conflito se resolver | O sistema compara registros de unidades diferentes e bloqueia sozinho quando acha divergência |
| A favor | Funciona com a arquitetura de hoje. Quem pede se identifica e mostra que é representativo | Não depende de o coletivo saber que o outro publicou |
| Contra | O coletivo precisa saber que o registro existe | Exige um ponto central que lê e compara tudo — o que a federação foi desenhada para não ter |

**Pergunta:** A é suficiente? Quem pode pedir o embargo — qualquer coletivo com ata, na lógica da
Plataforma de Territórios Tradicionais?

### 3.2 Incerteza declarada (I-18)

**A regra firmada:** "não tenho certeza" é uma resposta válida. O registro fica privado, e a dúvida
vai para um relatório.

**Perguntas:** a regra firmada fala do "não sei" sobre o que é **secreto** e sobre o que pode ser
**publicado**. Ele vale também para a marca de **sagrado**? Quem recebe o
relatório: o próprio coletivo escolhe a instância (Câmara Setorial dos Guardiões, APIB, outra), ou há
uma instância padrão?

---

## Bloco 4 — Questões abertas, vindas da pauta de 29/09 (10 min)

Não foram tratadas em 29/09. Para cada uma: Sofia tem posição, ou leva às comunidades? O item 2 da
pauta anterior ("existe secreto não-sagrado?") saiu: a resposta foi sim.

1. **Onde nasce a correção que a comunidade faz de um artigo?** (I-14) Quando uma comunidade se
   reconhece num artigo e diz "não é bem assim", essa correção é conhecimento dela — um Relato. Pela
   regra da arquitetura, um Relato vive na unidade da própria comunidade. Mas quase nenhuma comunidade
   tem unidade. Opções: (A) a arquitetura **oferece** uma instância do BioCultRelatos à comunidade;
   (B) a correção fica guardada como **pendência ligada ao artigo**, até a comunidade ter unidade.
2. **Quem compõe a governança da arquitetura?** (I-15) Hoje é esta reunião de duas pessoas. Próximo
   passo realista: ampliar a reunião (convite a Viviane já feito), levar ao Comitê Gestor do UseFlora,
   ou esperar a proposta de governança de Laura Madeira (⑮), que Eduardo não espera mais? Inclui quem
   declara o sagrado e quem fala pelo grupo numa gravação.
3. **Uso real de TK/BC Labels.** Sofia pediu apoio de IA para o levantamento. Escopo parcial: bancos de
   dados de CTA. Falta dizer quais agregadores e quais países.
4. **Conjunto brasileiro de rótulos** (I-12). Os rótulos dizem o que se pode fazer com o registro.
   Quais famílias entram: época do ano, restrição por gênero ou família, usos permitidos (inclusive
   comercial — ver insight de 29/09 sobre sagrado e comércio)?
5. **Quem controla o rótulo?** Sem o serviço do Local Contexts, o rótulo fica no banco da unidade. Como
   a comunidade muda o rótulo sem depender do curador?
6. **Contato para mudar de ideia.** A arquitetura guarda um canal de contato da pessoa, para uma
   revogação futura? Se guarda, esse contato é dado pessoal sensível e segue a mesma escolha de
   nomeação da pessoa.

---

## Para Sofia levar às comunidades (Guardiões e Conselho do UseFlora)

Perguntas que só as comunidades respondem. Não precisam de resposta nesta reunião.

1. **Os nomes.** Como vocês chamam o que é sagrado, o que é secreto, o que é sigilo, o que é
   mistério? O que cada um muda na prática — quem pode saber, quem pode usar, o que pode ser vendido?
2. **Conflito entre coletivos.** A regra "na dúvida entre dois coletivos, fica privado" é aceitável? Que
   documento prova que um coletivo é representativo?
3. **Incerteza.** Quando uma comunidade não sabe se algo pode ser publicado, a quem ela gostaria de
   pedir ajuda?

---

## Itens que ficam fora desta reunião

- **I-05 e demais pautas de campo** — edição de vídeo, imagem e voz, língua originária, o que não
  registrar, onde mora o vídeo (⑩). Esperam interlocutor de fontes primárias.
- **`regime: "evidencia"` para os 29 registros do BioCultDB** — ato técnico, decidido daqui, com
  registro na reunião seguinte.
- **Política de remoção do banco a pedido da comunidade** — adiada desde 16/09.
- **ICMBio / Programa Monitora** — Eduardo manda mensagem informal a Rodrigo Jorge depois desta
  reunião.
- **Farmacopeia popular** — suspensa até haver cenário adequado.
- **Pontos-focais das outras iniciativas** — nenhum solicitado.

---

## Rastreio da pauta das comunidades

Origem: [`../pautaComunidades/pauta-comunidades.md`](../pautaComunidades/pauta-comunidades.md) (P) e
[`../pautaComunidades/preparacao-reuniao-2026-09-16.md`](../pautaComunidades/preparacao-reuniao-2026-09-16.md) (Prep),
congelados em 28/09/2026. Tabela copiada da pauta de 29/09, com a coluna *Estado* atualizada.

| Origem | Assunto | Estado depois de 29/09 | Onde segue |
|---|---|---|---|
| Prep §1 | Designação do Ponto-Focal | Resolvido (17/09) | — |
| Prep §2, §4 | `regime` ausente nos 29 registros; pipeline | Decisão técnica pendente | Fora desta reunião |
| P1 q1–q2 | Como a pessoa quer ser nomeada | Desenho decidido em 18/09; valor é consentimento | I-01, I-02 → ADR-018 |
| P1 q3 | Nomeação muda por assunto? | **Decidido em 29/09: não** (d. 10) | I-01 → ADR-018 |
| P1 q4 | Contato para mudar de ideia | Aberta; não tratada em 29/09 | Bloco 4.6 |
| P1 q5 | Nome do grupo | Decidido em 18/09 (autodenominação); raiz legal decidida em 29/09 (d. 11) | I-07, I-16 → ADR-018 |
| P2 q1–q4 | Época, gênero, usos, legitimidade | Princípio decidido em 18/09; conjunto a desenhar | Bloco 4.4 |
| P2 q5 | Quem controla o rótulo | Aberta | Bloco 4.5 |
| P3 | Imagem e voz; língua originária; forma do consentimento | Não aplicável ao UseFlora | Fora (fontes primárias) |
| P4 | O que não registrar | Não aplicável ao UseFlora; remoção adiada | Fora (política de remoção) |
| P5 q1, q2, q4 | Gravação coletiva: pessoa × grupo | Decidido em 16/09; **fora do escopo do canal desde 29/09** (d. 5) | I-05, espera interlocutor de fontes primárias |
| P5 q3 | Quem fala pela gravação | Parcial em 16/09 | Bloco 4.2 (I-15) |
| P6 q1 | Sagrado some ou mostra que existe | Confirmado em 29/09: mostra que existe (d. 2); guardar ou não o conteúdo em aberto | Bloco 2 (I-03, I-04) |
| P6 q2 | Quem declara o sagrado | Parcial em 16/09 | Bloco 4.2 (I-15); Guardiões (item 1) |
| P6 q3 | Sagrado muda com o tempo | **Decidido em 29/09: sim, nos dois sentidos** (d. 8) | ADR-019 |
| P7 | Detentor apagado pela publicação | Decidido em 16/09 (caminho iii) | I-10 |
| P, Iniciativas parceiras | Pontos-focais de Silveiras, BioCultNaturalistas, GEF | Não solicitados | Fora |
| P, Como conduzir; Roteiro mínimo | Instrumentos de campo | Congelados como referência | P, seções próprias |

---

## Checklist de encerramento

- [ ] Anuência retroativa (16/09 e 18/09) confirmada
- [ ] Revisão de Sofia do resumo de 29/09 recebida ou com data
- [ ] Informes registrados (Viviane, domesticação e manejo, ⑭, Guardiões, lista de povos indígenas)
- [ ] Decisão 2.1 (guardar ou não o conteúdo sagrado de artigo) — libera a ADR-019
- [ ] Decisão 2.2 (uma marca ou duas) — libera a ADR-019
- [ ] Mecanismo do conflito entre coletivos (3.1) e da incerteza (3.2)
- [ ] Posição ou encaminhamento para cada item do Bloco 4
- [ ] Data da próxima reunião

## Depois da reunião

Seguir o ciclo do Ponto-Focal ([`README.md`](README.md)): resumo → documento de impactos → próxima
pauta → estado consolidado em [`impactos-na-arquitetura.md`](impactos-na-arquitetura.md) → episódio
em [`../ia/uso-de-ia.md`](../ia/uso-de-ia.md).
