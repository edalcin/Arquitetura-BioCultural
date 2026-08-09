# Arquitetura BioCultural — Linguagem da Federação

Glossário dos termos que atravessam **todos** os repositórios da Arquitetura BioCultural.
Termos internos a uma única ferramenta vivem no `CONTEXT.md` daquele repositório
(ex.: *Evidência*, *Curadoria* e *Extração por IA* pertencem ao `BioCultDB/CONTEXT.md`).

Este arquivo é **apenas glossário**. Decisões e mecanismos ficam em
`docs/architecture-decisions/`.

## Language

### Federação

**Unidade Federada**:
Uma instalação soberana da Arquitetura BioCultural — um container, um arquivo SQLite, as
ferramentas que aquela unidade opera. Soberana sobre seus dados; nunca sobre seu código.
_Avoid_: Instância, Nó, Deployment

**Unidade Hospedeira**:
A Unidade Federada considerada do ponto de vista de um Módulo Compartilhado que ela embarca.
BioCultDB, BioCultRelatos, BioCultNaturalistas e BioCultAcervos são as quatro unidades
hospedeiras do BioCultTermos. Todo hospedeiro é uma Unidade Federada; o termo só se usa
quando o assunto é o módulo que ela carrega.
_Avoid_: Consumidor, Host, Container pai, Repositório pai

**Comitê Federado**:
O corpo que decide admissão de membros, mapeamentos entre vocabulários e vocabulário de
arquitetura. Nenhuma unidade decide por outra.

### Código compartilhado

**Módulo Compartilhado**:
Corpo de código que existe uma única vez na federação e é embarcado, idêntico, por várias
Unidades Hospedeiras. O BioCultTermos é o único da arquitetura. Um Módulo Compartilhado não
tem existência autônoma: ele não é instalado, publicado nem executado fora de uma Unidade
Hospedeira.
_Avoid_: Biblioteca, Pacote, Dependência, Sub-repositório, Submódulo (mecanismo, não conceito)

**Cópia de Trabalho**:
O diretório, na máquina de quem desenvolve, em que o código de um Módulo Compartilhado é
editado. Existe exatamente uma Cópia de Trabalho por Unidade Hospedeira, e nenhuma fora de
uma Unidade Hospedeira. Uma cópia que não pertence a nenhum hospedeiro é, por definição, um
erro — não tem como ser executada nem testada.
_Avoid_: Clone, Checkout, Standalone, Working copy

**Versão Adotada**:
A versão exata do Módulo Compartilhado que uma Unidade Hospedeira carrega no momento. Cada
hospedeira declara a sua explicitamente; duas hospedeiras podem, transitoriamente, ter
Versões Adotadas diferentes.
_Avoid_: Pin, SHA, Release, Tag

**Atraso de Módulo**:
A distância entre a Versão Adotada por uma Unidade Hospedeira e a última versão publicada do
Módulo Compartilhado. É um estado **visível e temporário**, nunca uma escolha permanente:
toda hospedeira deve, eventualmente, zerar o seu. Atraso que deixa de ser medido deixa de ser
atraso e vira bifurcação.
_Avoid_: Divergência, Fork, Defasagem, Drift

### Vocabulário e procedência

**Vocabulário Controlado**:
O conjunto de termos aceitos para os campos que o BioCultTermos governa, modelado em SKOS-XL.
_Avoid_: Taxonomia, Dicionário, Lista de valores

**Conteúdo Soberano**:
Os termos, rótulos, definições e relações curados por uma Unidade Federada. Vivem no arquivo
SQLite daquela unidade, pertencem a ela, e **nunca** atravessam para outra unidade —
diferentemente do código do Módulo Compartilhado, que atravessa sempre. É a fronteira que a
arquitetura existe para sustentar.
_Avoid_: Dados, Base, Acervo de termos

**Fonte de Atribuição**:
A entidade a que um termo minerado é atribuído — a resposta a "de quem veio este termo?".
Tem sempre um **tipo** e um **nome**. O tipo é declarado pela Unidade Hospedeira e é
semanticamente carregado: `comunidade_tradicional` invoca CLPI, CARE e repartição de
benefícios; `naturalista` e `colecao` são procedência histórica e não invocam nenhum dos três.
A estrutura é única em toda a federação; o tipo nunca é achatado.
_Avoid_: Origem, Comunidade (só um dos tipos), Provenance, Fornecedor

**Comunidade Tradicional**:
Grupo humano culturalmente diferenciado que se reconhece como tal e mantém relação própria
com o território e a biodiversidade. Seu tipo vem da lista de 29 categorias do
Decreto 8.750/2016. É **um** dos tipos possíveis de Fonte de Atribuição, e o único que
carrega consequência jurídica.
_Avoid_: População, Grupo, Etnia

## Referências

- `docs/architecture-decisions/ADR-007` — distribuição do Módulo Compartilhado
- `docs/architecture-decisions/ADR-012` — manutenção do código do BioCultTermos
- `BioCultDB/CONTEXT.md` — linguagem interna da Unidade de Fontes Secundárias
