# Roteiro — Arquitetura BioCultural v3

**Deck:** `Arquitetura BioCultural v3.pptx` (28 slides)
**Audiência:** lideranças de comunidades tradicionais (público principal) + pesquisadores e acadêmicos
**Tempo sugerido:** 35–40 min de fala + escuta aberta no slide 27
**Fio condutor:** a construção de uma casa. Toda a apresentação volta a essa imagem:

| Imagem da casa | O que representa |
|---|---|
| O plano da casa | a arquitetura de informação |
| Quem vai morar | as comunidades detentoras do saber |
| Os materiais | as quatro fontes de evidência |
| Cada casa com a sua chave | soberania federada (dado mora com quem o gerou) |
| Os cômodos (varanda, sala, quarto) | camadas de acesso (public, restricted, community-only) |
| A praça da vila | o Pluriverso |
| Os alicerces | os princípios CARE |
| As regras da casa | governança em três camadas |

**Regra de ouro para o público misto:** falar sempre para as lideranças. O conteúdo acadêmico fica nas notas de cada slide, marcado como "para acadêmicos" — só usar se perguntarem. Jargão que escapar, traduzir na hora com a imagem da casa.

---

## Bloco 0 — Abertura (slides 1–3, ~4 min)

### Slide 1 — Arquitetura BioCultural
Não anunciar um "sistema de TI". Frase de abertura sugerida:

> "Eu vim mostrar para vocês o plano de uma casa. E plano de casa não se aprova sem conversar com quem vai morar nela."

Apresentar-se brevemente. Não explicar o subtítulo — ele se explica sozinho ao longo da fala.

### Slide 2 — Uma casa se constrói para quem vai morar nela
**O slide mais importante da abertura. Falar devagar.**

> "Ninguém constrói casa começando pelos tijolos. Primeiro vem a conversa: quem vai morar, como essa família vive, o que ela precisa guardar, quem pode entrar em cada cômodo. Desse entendimento nasce um plano. Esse plano tem um nome: arquitetura."

> "Com um lugar que guarda saberes é a mesma coisa. O que eu trouxe é o plano de uma casa para o conhecimento tradicional. E quem vai morar nessa casa são vocês — por isso o plano só se aprova aqui."

Se essa imagem ficar, o resto da apresentação é só voltar a ela.

**Transição:** "Deixa eu mostrar o caminho da nossa conversa."

### Slide 3 — Neste convite
Ler os cinco pontos como capítulos da construção: por que construir, com que materiais, qual é a planta, como a obra foi se corrigindo, e as regras da casa. Destacar o item 5: "tem coisas nesse plano que só vocês podem decidir — e é para isso que eu vim."

---

## Bloco 1 — Por que esta casa precisa existir (slides 4–6, ~5 min)

### Slide 4 — (seção)
Uma frase de respiro: "Primeiro: por que construir?"

### Slide 5 — Um saber espalhado
Contar como história, não como diagnóstico. O saber sobre plantas e animais existe, mas está espalhado em quatro lugares — artigos que poucos leem, memória dos mais velhos, prateleiras de museu, livros raros de viajantes — e está em risco em todos eles.

> "A casa é o lugar onde esses pedaços podem se encontrar sem se perder."

### Slide 6 — Por que o nome científico não é o ponto de partida
Ponto sensível para os dois públicos — para as lideranças é respeito; para os acadêmicos é decisão de modelagem (ADR-014).

> "Uma casa se desenha em função de quem mora. Se quem mora é a comunidade, a porta de entrada não pode ser o nome científico — é o nome que a planta tem aqui, o uso que ela tem, e quem ensinou esse uso."

**Transição:** "Então, de que materiais essa casa é feita?"

---

## Bloco 2 — Os materiais (slides 7–9, ~5 min)

### Slide 7 — (seção)

### Slide 8 — De onde vem o que a arquitetura reúne
Apresentar as quatro fontes. **Sublinhar a frase final do slide:** três fontes trazem o registro feito por um terceiro; uma — os relatos — traz a própria comunidade falando.

> "A diferença parece pequena. É ela que decide quem manda em cada registro. Guardem essa frase: ela volta no final."

(É a semente do slide 25 — conhecimento × evidência.)

### Slide 9 — Uma linguagem comum (BioCultTermos)
Na imagem da casa: a língua que se fala dentro dela.

> "Cada fonte fala com as suas palavras. O BioCultTermos é um dicionário vivo que relaciona esses nomes — sem exigir que ninguém troque o seu jeito de nomear pelo da ciência. E cada comunidade guarda a sua própria cópia."

**Para acadêmicos (se perguntarem):** SKOS-XL trata o rótulo como recurso de primeira classe — accessLevel, povo detentor e consentimento por forma textual; nome em língua indígena pode ter nível de acesso diferente do nome em português. Alinhamento GBIF/Darwin Core na camada de mapeamento do Pluriverso, não dentro do vocabulário da comunidade.

**Transição:** "Materiais na mão. Mas antes de mostrar a planta, preciso falar de um medo."

---

## Bloco 3 — A planta (slides 10–16, ~10 min)

### Slide 10 — (seção)

### Slide 11 — O risco que nenhuma comunidade quer correr de novo
O medo que a planta precisa responder. Cupuaçu, ayahuasca, jaborandi: saber que virou patente ou produto sem autorização nem retorno.

> "Por isso muitas comunidades desconfiam — com toda razão — de qualquer sistema que peça seus saberes. Uma casa que ignora esse medo não recebe morador."

### Slide 12 — A resposta: cada um guarda a própria chave
O coração da planta.

> "A resposta não é um prédio único onde todos são obrigados a guardar seus bens. É uma vila: cada família tem a sua casa e a sua chave. Nada sai de casa sem decisão explícita de quem mora."

### Slide 13 — (diagrama da federação)
**Não ler o diagrama.** Apontar com a mão: cada caixa de cima é uma casa soberana — um arquivo, um dono. Embaixo, o ponto de encontro, que só recebe o que cada casa decidiu tornar público.

**Para acadêmicos:** harvest REST periódico, SQLite por unidade, um container por unidade, sem banco central.

### Slide 14 — (diagrama das quatro camadas de acesso)
Os cômodos da casa:

> "O que fica na varanda, qualquer um vê. O que fica na sala, só convidado. O que fica no quarto, só a família. E tem coisa que não se mostra — e que talvez seja melhor nem registrar. Quem decide em que cômodo fica cada coisa é a comunidade, e pode mudar de ideia a qualquer tempo."

A última linha (private/sigiloso — "pode nunca ser digitado") prepara a pergunta do sagrado no slide 27.

### Slide 15 — O Pluriverso: um ponto de encontro, não um dono
> "O Pluriverso é a praça da vila, não o cartório. Reúne o que cada casa decidiu mostrar na janela e dá um só lugar de busca. Quem sai da vila, some da praça na hora."

### Slide 16 — (diagrama de múltiplas instâncias)
Rápido: pode haver mais de uma praça. Uma associação pode ter a sua, fechada para os seus membros; a praça pública convive com ela sem hierarquia.

**Transição:** "Esse plano não nasceu pronto. Ele foi se corrigindo — e vou mostrar como."

---

## Bloco 4 — A obra (slides 17–18, ~4 min)

### Slide 17 — (seção)

### Slide 18 — Uma ideia que foi se corrigindo
**Não ler versão por versão.** A história em uma frase:

> "Começou como um prédio único. Virou uma vila de casas soberanas. E cada correção do plano veio de ouvir quem vai morar."

Se quiser marcar três momentos: a virada federada (cada um dono do seu dado), as regras escritas (quem decide o quê) e a mais recente — separar a fala da comunidade do registro de terceiro.

---

## Bloco 5 — As regras da casa (slides 19–26, ~10 min)

### Slide 19 — (seção)

### Slide 20 — Os alicerces: quatro princípios, sempre
São os princípios CARE em linguagem simples — não precisa dizer a sigla, a não ser para os acadêmicos. Benefício coletivo, autoridade para decidir, responsabilidade, ética.

### Slide 21 — Quem decide o quê
As três camadas: dados (a comunidade), ferramentas (quem mantém), arquitetura (comitê de todos). Fechar com o respaldo legal: Lei da Biodiversidade (13.123) e Protocolo de Nagoya exigem consentimento e repartição de benefícios — "isso não é favor, é lei".

### Slide 22 — (diagrama das três camadas de governança)
A mesma tabela em desenho. A frase que importa:

> "Nenhuma decisão técnica sobrepõe a decisão da comunidade."

### Slide 23 — (diagrama do ciclo de CLPI)
> "Consentir não é assinar um papel uma vez. É um ciclo: pode ser revisto — e pode ser revogado. Revogar tira o dado da federação e do índice, a qualquer tempo, sem precisar justificar."

### Slide 24 — (diagrama de repartição de benefícios)
> "Se alguém usar o saber e gerar benefício, o uso deixa rastro, e o rastro permite repartição — em dinheiro ou não. Sem rastro, repartição é só promessa."

Se soar vigilância, corrigir na hora: o log de uso é instrumento de justiça, não de vigilância.

### Slide 25 — Conhecimento e evidência não são a mesma coisa
Retomar a semente do slide 8: "lá atrás eu pedi para guardarem uma frase…".

> "Quando um pesquisador, um museu ou um livro de trezentos anos registra o que vocês sabem, quem está falando é quem registrou. Quando são vocês que falam, na sua língua, é outra coisa — não vale mais nem menos: tem outro dono. E quando o registro é de vocês, quem decide são vocês."

**Para acadêmicos:** a distinção é deôntica, não epistêmica — não diz o que é mais verdadeiro, diz quem tem autoridade para classificar o acesso (ADR-015).

### Slide 26 — Quatro avanços, e o que cada um protege
Consolidação rápida, um fôlego por item. Fechar com a frase do slide:

> "Nenhum dos quatro é sobre tecnologia. Os quatro são sobre quem decide — e é por isso que a parte mais difícil não se resolve programando."

**Transição:** "E é exatamente por isso que eu trouxe cinco perguntas."

---

## Bloco 6 — Escuta e convite (slides 27–28, tempo aberto)

### Slide 27 — Cinco perguntas que só vocês podem responder
**Slide de escuta, não de exposição.** Fazer as cinco perguntas e parar de falar. Registrar as respostas na hora — elas destravam o desenho do modelo de dados. Enquanto não houver resposta, ficam como pendências abertas e nada é publicado.

Contexto de apoio, **só se perguntarem**:

1. **Nome de quem fala** — conflito real entre dar crédito (Lei 13.123) e proteger dado sensível (LGPD art. 11). Saída recomendada: pseudônimo escolhido pela própria pessoa. É a única pergunta que exige resposta antes de qualquer registro.
2. **O que não registrar** — o projeto já assume que há saber sagrado mais bem protegido pela não existência do registro do que por qualquer camada de acesso.
3. **Marcas de uso** — TK/BC Labels (Local Contexts). Só a comunidade aplica; aplicadas por terceiro chamam-se Notices e valem menos.
4. **Gravações e oficinas** — vídeo captura prática, não só fala: o gesto, a sequência, o material. Em gravação coletiva, cada participante tem direito próprio sobre voz e imagem; regra atual, a mais conservadora: se um pede reserva, a gravação inteira sai. Caso concreto: o vídeo de 42 segundos em língua Panará — sem consentimento formalizado, sem transcrição com falante nativo — fora de qualquer publicação até que isso se resolva.
5. **O sagrado** — quem declara que um saber é sagrado, e se o registro deve sumir por inteiro ou ficar visível apenas a existência.

### Slide 28 — Um convite
Fechar voltando à casa:

> "O plano está desenhado. Mas casa não se constrói sozinha — e esta só fica de pé se quem vai morar nela aprovar cada parede. O convite é esse: participar, contribuir, corrigir o plano."

Deixar o contato na tela e agradecer.

---

## Lembretes finais

- **Registrar por escrito** toda resposta dada no slide 27, na hora.
- Se a conversa esquentar em qualquer slide técnico, voltar à casa: chave, cômodo, praça, regras.
- Se houver tempo para uma só frase de fechamento: *os três primeiros avanços protegem o dado; o quarto protege quem decide sobre o dado.*
