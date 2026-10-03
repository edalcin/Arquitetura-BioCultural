# Registro de prompts — o que foi pedido à IA, literalmente

> **O que este documento é.** O registro literal, em ordem cronológica, de todo *prompt* escrito
> por uma pessoa e executado por um agente de IA sobre esta arquitetura, a partir de 2026-10-03. É
> a parte de transparência do uso de IA no projeto de pesquisa
> ([`../projetoPesquisa.md`](../projetoPesquisa.md) §7.2, item 9, e §7.5): qualquer pessoa da
> governança da arquitetura pode ler o que foi pedido e comparar com o que a IA entregou (o
> *commit* de cada entrada).
>
> **Relação com o log de episódios.** [`uso-de-ia.md`](uso-de-ia.md) analisa os usos de IA com fonte
> primária conferível (as reuniões). Este documento não analisa: guarda o pedido, sem comentário.

## Regras

1. **Literal.** O texto entra como foi escrito: erros de digitação, menções a arquivos (`@arquivo`)
   e quebras de linha incluídos. O conteúdo de arquivos anexados não é copiado; fica a menção.
2. **Todo prompt.** Os curtos também ("continue", "faça o commit"). Uma entrada por prompt.
3. **Ordem cronológica, só acréscimo.** Entrada nova vai para o fim. Entrada antiga não muda.
4. **Antes do trabalho.** O agente registra o prompt como primeiro ato da sessão e o *commit* do
   trabalho inclui o registro. Regra para agentes em [`../../CLAUDE.md`](../../CLAUDE.md).
5. **Uma única exceção: o que não pode ser público.** O repositório é público. Conhecimento
   Tradicional, nome de detentor, local sensível ou dado pessoal de terceiro dentro de um prompt é
   trocado por `[omitido: motivo]`. A omissão fica visível; o resto do texto continua literal.
6. **Quem conta.** Prompts escritos por pessoas. As instruções que um agente gera para outro agente
   (subagentes) não entram: são derivadas do prompt humano registrado aqui.

## Formato de cada entrada

```text
### P-NNNN — AAAA-MM-DD HH:MM
- Ferramenta: <harness de agente> · Modelo: <modelo> · Skills invocadas: <lista ou "nenhuma">
- Resultado: <commit(s)>
(prompt literal, num bloco de texto)
```

## Prompts

### P-0001 — 2026-10-03 07:35

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: `wayfinder`
- Resultado: *commit* "docs: Cenário B — governança da arquitetura por Issues, pauta curta, registro de prompts"

````text
Considerando cuidadosamente a @docs/novaFaseArquitetura-analise.md  vamos implementar o Cenário B recomendado, a partir de agora. Desta forma, revise cuidadosamente os documentos em @docs/reunioes/ e refaça a proposta de pauta para a próxima reunião com Sofia seguindo esta nova abordagem.
Quero também que garanta que toda descrição da metodologia de construção e evolução deste projeto está documentada, incluindo esta nova fase.
Quero sugerir um "label" para as ISSUES: "fonte do conhecimento" - primaria, secundária, acervos, relatos. Desta forma será possível relacionar as ISSUES também com as ferramentas e eventuais novos participantes da governança afetos a estas fontes.
É preciso garantir também que, doravante, o processo que envolve a absorção do resumo da ultima reunião, e a geração dos documentos da proposta de pauta da proxima reunião e do impacto na arquitetura irá sempre incluir uma revisão detalhada e cuidadosa das ISSUES e seus estados. Um novo diagrama do processo de geração dos documentos a partir do registro de uma reunião, envolvendo as ISSUES, deve ser criado para a documentação e futura referência.
Um dos aspectos mais importantes desta nova fase do desenvolvimento desta arquitetura é o início das atividades da camada de governança da arquitetura que, inicialmente incorporou a Sofia mas deve incorporar mais participantes de diferentes iniciativas em breve. Isso requer esta mudança na forma de trabalho e documentação para a evolução da arquitetura.
Importante destacar que as ISSUES são criadas para humanos não-técnicos em desenvolvimento ou arquitetura de sistemas, mas com profundo conhecimento, acadêmico ou prático e de vivência, do conhecimento tradicional associado a biodiversidade. O tom e linguagem das ISSUES deve considerar isto, e ser claro e objetivo no que é esperado para fechar a ISSUE e avançar com a arquitetura.
Quero também que, a partir de hoje, todo e qualquer prompt criado e "rodado" em cima desta arquitetura, como este, agora seja registrado literalmente como foi criado e usado, em uma ordem cronológica, em um documento próprio. Desta forma, fica garantida a transparência da utilização da IA nesta proposta, parte integrante do @docs/projetoPesquisa.md, e que deve ser documentado adequadamente. Esta transparência é fundamental para a credibilidade da proposta, perante a todos os envolvidos na sua governança, e deve ser sempre exercida.
Por fim, penso que estas mudanças metodológicas mais significativas podem fazer parte de um "changelog" ou algo assim. Considere e implemente algo adequado.
````

### P-0002 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: mesmo *commit* de P-0001 (pedido feito durante a execução de P-0001)

````text
Creio que esta nova fase merece uma atualização significativa no @README.md , incluindo uma nova versão.
````

### P-0003 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: *commit* "docs(ia): registra P-0003"

````text
commit to main and sync
````
