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
   trabalho inclui o registro. Regra para agentes em [`../../CLAUDE.md`](../../../CLAUDE.md).
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

### P-0004 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: `wayfinder`
- Resultado: (a preencher no *commit* da sessão)

````text
Quero agora, para consolidar esta nova versão, antes do novo release para o Zenodo, quero re-estruturar todas as pastas deste repositório. Quero uma estrutura mais simples, didática e objetiva para que novos visitantes e colaboradores encontrem com mais facilidade documentos importantes. Este repositório tem dois grupos de usuários: humanos, participantes da governança e interessados na gestão de dados, informações e conhecimento sobre conhecimento tradicional associado a biodiversidade; e agentes de IA, que vão auxiliar na gestão e criação dos documentos necessários ao desenvolvimento, aprimoramento e implementação desta arquitetura. Assim, a primeira grande divisão é separar toda a documentação técnica (para IA, como ADRs, agents, c4-models) da documentação de divulgação e governança, para os humanos. Penso que uma pasta chamada "ComecePorAqui" com um resumo executivo do projeto e guias de colaboração para diferentes participantes das diferentes camadas de governança seria interessante. Talvez, para cada camada de governança, pastas específicas de documentos e histórico de reuniões. Pense e proponha uma estrutura de pastas e arquivos mais adequada para suportar esta nova fase onde novos integrantes devem ser atraídos para a participação e para que estes novos participantes tenham toda a informação necessária para participar adequadamente, através da interface do GitHub. Sugiro que re-escreva também o @README.md e que deixe o diretório raiz somente com o @README.md, com uma explicação da estrutura de pastas que o visitante irá encontrar. Por fim, em "/ComecePorAqui", um resumo executivo, bem sintético e didático, do que é este projeto e qual seu objetivo e relevância. Quero também separar toda a documentação do @docs/projetoPesquisa.md em uma pasta separada.
````

### P-0005 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
uma pergunta por vez
````

### P-0006 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
sigo com a recomendação
````

### P-0007 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
sigo com a recomendação
````

### P-0008 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
sigo com a recomendação
````

### P-0009 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
sigo com a recomendação
````

### P-0010 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
sigo com a recomendação
````

### P-0011 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
sigo com a recomendação
````

### P-0012 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
sigo com a recomendação
````

### P-0013 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
sigo com a recomendação mas quero também o glossário
````

### P-0014 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
sigo com a recomendação
````

### P-0015 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
a "pautaComuidades" e "PrincipiosCAREnaPratica.md" devem ir apra a raiz da pasta "Governanca", de resto sigo com a recomendação
````

### P-0016 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: *commit* da reorganização de pastas (v4.0.0), que também resolve P-0004 a P-0015

````text
confirmo. execute.
````

### P-0017 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: *commit* da reorganização de pastas (v4.0.0)

````text
Na atrualização do @README.md quero definir que esta é a versão 4.0 da arquitetura!
````

### P-0018 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
ME ajude a decidir a melhor licença para este repositório. Que tal usar o judge()?
````

### P-0019 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: *commit* "docs: licença CC BY 4.0" (inclui P-0018)

````text
Sim. Aplique e crie uma Issue para Sofia.
````

### P-0020 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
O que falta eu fazer antes de criar o novo release?
````

### P-0021 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: *commit* "chore: planilha SiBBr/SISGEN movida para projeto-gef-mcti-entre-ciencias"

````text
Sobre o 1 - vou aguardar Sofia responder o ISSUE
Sobre docs/SiBBr_SISGEN_CTA_Todas_fontes.xlsx, quero mover esta planilha para o projeto @../projeto-gef-mcti-entre-ciencias/docs/ e manter neste projeto no .gitignore
Sobre o 2, vou ler os documentos, oportunamente. Entretanto, já podemos commit to main and sync para encerrar por hoje.
````

### P-0022 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
Quero ajustar a pasta @docs/
quero separar as pastas em @docs/ em pastas de documentos técnicos e documentos de governança e para "humanos". Isso, sem prejuízo do entendimento dos agentes de IA. Quero uma visão da estrutura mais simples para os participantes e interessados, que não estão interessados em documentação técnica, como, por exemplo, @docs/c4-model/ , @docs/diagrams/ , @docs/bin/ e @docs/architecture-decisions/ 
Faça este ajuste na estrutura de pastas para mim!
````

### P-0023 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
Considere todas as pastas que possuem documentação técnica, não apenas os exemplos que dei
````

### P-0024 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: (a preencher no *commit* da sessão)

````text
quero a opção "b" com a correção de todos os links. Quero ainda mover a pasta @Governanca/ e @Pesquisa/ para @docs/ e também corrigir todos os links.
Arquivos técnicos em @docs/ como por exemplo @docs/contrato-harvest.md , @docs/rotulos-skos-xl.md  devem ir para docs/tecnico
Garanta que apos esta mudança todos os links em todos os documentos estarão corrigidos e que os agentes de IA irão encontrar com facilidade toda a documentação técnica de que necessitam.
````

### P-0025 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: *commit* "docs(ia): registra P-0025"

````text
As pastas vazias em @docs/ devem ser deletadas, com segurança.
````

### P-0026 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: *commit* "docs(ia): registra P-0026"

````text
Vou encerrar por aqui. Commit to main and sync
````

### P-0027 — 2026-10-03

- Ferramenta: oh-my-pi · Modelo: anthropic/claude-opus-5-5 (high) · Skills invocadas: nenhuma
- Resultado: *commit* "docs(tecnico): proximosPassos atualizado — sessão v4.0"

````text
Atualize os @docs/tecnico/proximosPassos.md
````
