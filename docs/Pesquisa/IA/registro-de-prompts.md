# Registro de prompts — o que foi pedido à IA, literalmente

> **O que é.** O registro literal, em ordem cronológica, dos *prompts* significativos escritos por
> uma pessoa e executados por um agente de IA sobre esta arquitetura, a partir de 2026-10-03 (o que
> conta como significativo: regra 2). É a parte de
> transparência do uso de IA no projeto de pesquisa ([`../projetoPesquisa.md`](../projetoPesquisa.md)
> §7.2, item 9, e §7.5): qualquer pessoa da governança da arquitetura pode ler o que foi pedido e
> comparar com o que a IA entregou (o *commit* de cada entrada).
>
> **Relação com o log de episódios.** [`uso-de-ia.md`](uso-de-ia.md) analisa os usos de IA com fonte
> primária conferível (as reuniões). Este registro não analisa: guarda o pedido, sem comentário.

## Onde estão os prompts

Um arquivo por dia, numa pasta por ano: `prompts/AAAA/AAAA-MM-DD.md`. Dentro do dia, os prompts
ficam agrupados por **sessão** — uma conversa contínua com um agente, numa ferramenta e num modelo.
Este arquivo é só o índice e as regras; ele cresce uma linha por dia.

| Dia | Sessões | Prompts | Arquivo |
|---|---|---|---|
| 2026-10-03 | 1 | P-0001 a P-0013 | [`prompts/2026/2026-10-03.md`](prompts/2026/2026-10-03.md) |
| 2026-10-04 | 1 | P-0014 a P-0018 | [`prompts/2026/2026-10-04.md`](prompts/2026/2026-10-04.md) |

## Regras

1. **Literal.** O texto entra como foi escrito: erros de digitação, menções a arquivos (`@arquivo`)
   e quebras de linha incluídos. O conteúdo de arquivos anexados não é copiado; fica a menção.
2. **Só o que é significativo.** Entram o **prompt que abre a sessão** e todo prompt que **traz uma
   demanda nova** ou **muda o conteúdo da arquitetura ou do método**. Não entram confirmações e
   escolhas entre opções que a IA já propôs ("sigo com a recomendação", "confirmo. execute."),
   pedidos de *commit* ou de sincronização, pedidos de forma ("uma pergunta por vez") e perguntas
   que não mudam nenhum documento. Se uma escolha também acrescenta algo ("sigo com a recomendação
   mas quero também o glossário"), ela entra. Na dúvida, entra. Uma entrada por prompt.
3. **Ordem cronológica, só acréscimo.** Entrada nova vai para o fim do arquivo do dia. Entrada
   antiga não muda, exceto para preencher o *commit* do resultado.
4. **Antes do trabalho.** O agente registra o prompt como primeiro ato e o *commit* do trabalho
   inclui o registro. Regra para agentes no [`CLAUDE.md`](../../../CLAUDE.md).
5. **Numeração contínua.** `P-NNNN` segue de um dia para o outro e nunca recomeça: é o
   identificador citado em outros documentos. Na limpeza de 04/10/2026, as entradas retiradas saíram e as
   restantes foram renumeradas, com as citações corrigidas.
6. **Uma única exceção: o que não pode ser público.** O repositório é público. Conhecimento
   Tradicional, nome de detentor, local sensível ou dado pessoal de terceiro dentro de um prompt é
   trocado por `[omitido: motivo]`. A omissão fica visível; o resto do texto continua literal.
7. **Quem conta.** Prompts escritos por pessoas. As instruções que um agente gera para outro agente
   (subagentes) não entram: são derivadas do prompt humano registrado.
8. **Prompts do roteiro.** Um prompt do [roteiro de prompts](../../Governanca/Arquitetura/roteiro-de-prompts.md)
   entra literal e completo, com os campos `<…>` já trocados; o código (`roteiro C2`) vai no campo
   "Skills invocadas".

## Como registrar

- **Primeiro prompt do dia:** criar `prompts/AAAA/AAAA-MM-DD.md` (e a pasta do ano, se for o
  primeiro do ano) e acrescentar a linha do dia na tabela acima.
- **Sessão nova no mesmo dia:** nova seção `## Sessão N — <ferramenta> · <modelo>` no arquivo do dia;
  atualizar a coluna "Sessões" da tabela.
- **Cada prompt:** acrescentar ao fim da sessão e atualizar a coluna "Prompts".

```text
## Sessão N — <ferramenta> · <modelo>

Início às HH:MM. Prompts P-NNNN a P-NNNN: <assunto em uma linha>.

### P-NNNN — HH:MM
- Skills invocadas: <lista ou "nenhuma">
- Resultado: <commit(s)>
(prompt literal, num bloco de texto)
```
