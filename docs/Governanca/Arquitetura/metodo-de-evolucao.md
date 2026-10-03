# Método de construção e evolução da Arquitetura BioCultural

> **O que este documento é.** A porta de entrada do **método**: como a arquitetura é construída, como
> ela muda, quem decide o quê, e onde cada coisa fica registrada. Escrito para quem participa da
> governança da arquitetura — inclusive quem não é da área de sistemas. Cada instrumento tem seu
> documento próprio; aqui fica o mapa e o **histórico das mudanças de método** (§5). A fundamentação
> de pesquisa está em [`projetoPesquisa.md`](../../Pesquisa/projetoPesquisa.md) §7.

## 1. Por onde começar

| Você quer… | Leia |
|---|---|
| Entender a arquitetura em poucos minutos | O [resumo executivo](../../../ComecePorAqui/README.md), na pasta `ComecePorAqui/` |
| Saber o que está em discussão agora | O painel das questões, [Issue #6](https://github.com/edalcin/Arquitetura-BioCultural/issues/6), e a [próxima pauta](Reunioes/proxima-pauta-reuniao-sofia.md) |
| Comentar, corrigir ou perguntar | O [guia do GitHub](../../../ComecePorAqui/guia-github.md) |
| Ver o que já foi decidido nas reuniões | Os resumos em [`Reunioes/`](Reunioes/) (índice em [`README.md`](README.md)) |
| Ver o que as reuniões mudam na arquitetura | [`impactos-na-arquitetura.md`](../../tecnico/impactos-na-arquitetura.md), na pasta `docs/tecnico/` |
| Saber o que foi pedido à IA, e como ela foi usada | [`registro-de-prompts.md`](../../Pesquisa/IA/registro-de-prompts.md) e [`uso-de-ia.md`](../../Pesquisa/IA/uso-de-ia.md), na pasta `docs/Pesquisa/IA/` |
| Saber onde o projeto está e o que falta | [`proximosPassos.md`](../../tecnico/proximosPassos.md), na pasta `docs/tecnico/` |

## 2. Os instrumentos do método

| Instrumento | Para quê | Onde | Quem escreve |
|---|---|---|---|
| **Decisão registrada (ADR)** | Toda escolha de arquitetura, com alternativas, estado (`Proposto` / `Aceito`) e questões abertas | [`architecture-decisions/`](../../tecnico/architecture-decisions/) | Gestão da arquitetura, com IA |
| **Modelo C4** | Diagramas em quatro níveis (contexto, contêiner, componente, código) | [`c4-model/`](../../tecnico/c4-model/) | Idem |
| **Linguagem ubíqua** | Um glossário único para os termos que atravessam todos os repositórios | [`CONTEXT.md`](../../tecnico/CONTEXT.md) | Idem |
| **Contrato antes de código** | Modelo de dados e contrato de coleta especificados antes de implementar | [`modelo-de-dados-unificado.md`](../../tecnico/modelo-de-dados-unificado.md), [`contrato-harvest.md`](../../tecnico/contrato-harvest.md) | Idem |
| **Reunião de governança da arquitetura** | Onde as questões de desenho que dependem de pessoas são respondidas | [`README.md`](README.md) desta pasta; arquivos em [`Reunioes/`](Reunioes/) | Participantes da governança |
| **Questão (*Issue*)** | Uma por pergunta aberta, com número fixo; o único lugar do estado dela | [Issues do GitHub](https://github.com/edalcin/Arquitetura-BioCultural/issues) | Eduardo e IA criam; participantes comentam |
| **Impactos** | O que cada reunião muda na arquitetura, item a item (`I-xx`) | [`impactos-na-arquitetura.md`](../../tecnico/impactos-na-arquitetura.md) | IA, conferida por Eduardo |
| **Pautas das comunidades** | Perguntas que só a comunidade detentora responde, registro a registro | [`pautaComunidades/`](../pautaComunidades/) (congelada em 28/09/2026) | — |
| **Episódios de uso de IA** | Cada uso de IA com fonte conferível, com a falha observada | [`uso-de-ia.md`](../../Pesquisa/IA/uso-de-ia.md) | Eduardo e IA |
| **Registro de prompts** | Todo pedido feito à IA, literal e em ordem | [`registro-de-prompts.md`](../../Pesquisa/IA/registro-de-prompts.md) | O agente, como primeiro ato da sessão |
| **Continuidade** | Onde o projeto está e o que falta, para toda sessão nova | [`proximosPassos.md`](../../tecnico/proximosPassos.md) | Fim de cada sessão |
| **Histórico de versões** | Toda mudança dos documentos, por versão | [`CHANGELOG.md`](../../tecnico/CHANGELOG.md) | Idem |

## 3. A governança da arquitetura em operação

A proposta de governança tem três camadas: **dados** (a comunidade decide), **ferramentas** (quem
mantém cada instalação) e **arquitetura** (o Comitê Federado, ainda não constituído)
([`propostaGovernanca.md`](../Proposta/propostaGovernanca.md)). Desde setembro de 2026 a
camada de arquitetura **começou a operar** na forma de **reuniões de governança da arquitetura**:

- **Hoje:** Eduardo (gestão da arquitetura) e Sofia Zank (Ponto-Focal do UseFlora, desde 17/09/2026).
- **Em seguida:** pessoas de outras iniciativas e de outros **tipos de fonte** — registro primário
  com comunidades, acervos, obras de naturalistas. Viviane Kruel foi convidada para as fontes
  primárias. Como uma pessoa nova entra é a questão
  [#11](https://github.com/edalcin/Arquitetura-BioCultural/issues/11); os convites, a
  [#33](https://github.com/edalcin/Arquitetura-BioCultural/issues/33).
- **Como as questões chegam à pessoa certa:** toda *Issue* diz quem responde (`para-ponto-focal`,
  `para-comunidades`, `para-gestao`) e, quando for o caso, a que tipo de fonte se refere
  (`fonte-primaria`, `fonte-secundaria`, `fonte-acervos`, `fonte-naturalistas`). Uma pessoa que entra
  pelas fontes primárias encontra de uma vez as questões que são dela.
- **A fronteira que não muda:** a governança da arquitetura decide o **desenho** (que campo, que
  regra). O **valor** — o consentimento sobre um registro concreto — é sempre da comunidade
  detentora, registro a registro.

O ciclo de cada reunião — da transcrição ao resumo, à revisão das *Issues*, aos impactos e à pauta
seguinte — está descrito, com diagrama, em [`README.md`](README.md).

## 4. Transparência no uso de IA

A IA participa de todas as etapas (`projetoPesquisa.md` §7.5). Três regras tornam esse uso conferível
por qualquer pessoa da governança:

1. **O pedido fica registrado, literalmente.** [`registro-de-prompts.md`](../../Pesquisa/IA/registro-de-prompts.md).
2. **O que a IA produz a partir de uma reunião é conferido contra a transcrição** e revisado pelo
   Ponto-Focal antes de virar questão ou pauta. Cada reunião gera um episódio com a falha observada:
   [`uso-de-ia.md`](../../Pesquisa/IA/uso-de-ia.md).
3. **A IA propõe; uma pessoa decide.** Nenhuma questão de desenho é respondida por um agente, e
   nenhuma decisão que pertence a quem detém o conhecimento é delegada a ele.

## 5. Histórico das mudanças de método

O "changelog" do método: só as mudanças na **forma de trabalhar**, uma entrada por mudança, a mais
recente no fim. Mudanças de conteúdo da arquitetura ficam no [`CHANGELOG.md`](../../tecnico/CHANGELOG.md).
Uma entrada nova é escrita na mesma sessão em que a mudança de método é feita, com o motivo e a
evidência.

| # | Data | O que mudou | Por quê | Onde |
|---|---|---|---|---|
| M-01 | 2024-01 | Origem: proposta de uma "Base de Dados de Plantas Medicinais", com Dra. Viviane Fonseca, depois corrigida passo a passo até a arquitetura federada | — | `projetoPesquisa.md` (cabeçalho) |
| M-02 | 2025-01-05 | Arquitetura documentada em modelo C4 e decisões em ADR; versão citável no Zenodo; histórico de versões semântico | Documentação auditável e citável | `docs/tecnico/CHANGELOG.md` 1.0.0; `architecture-decisions/`; `c4-model/` |
| M-03 | 2026-08-09 a 08-13 | Glossário federado único (linguagem ubíqua) e arquivo único de continuidade entre sessões, humanas ou de IA | Sessões com IA perdiam termos e contexto entre uma e outra | `docs/tecnico/CONTEXT.md`; `proximosPassos.md` |
| M-04 | 2026-08-19 | O projeto passa a ser projeto de pesquisa, com a IA como objeto de pesquisa (objetivo 12) | Formalizar método, objetivos e avaliação | `projetoPesquisa.md` |
| M-05 | 2026-09-03 | O que depende das comunidades ganha documento próprio, separado em pautas de desenho e de consentimento; papel de Ponto-Focal definido | Decisões "que não são nossas" precisavam ter para onde ir | `pautaComunidades/`; `docs/tecnico/CONTEXT.md`, Ponto-Focal (v3.11.0) |
| M-06 | 2026-09-16 | Primeira reunião com o Ponto-Focal; transcrição integral (Tactiq) como fonte do resumo | Sem transcrição, a reunião de 18/08 deixou dúvida sem solução | `docs/Governanca/Arquitetura/Reunioes/`; `docs/Pesquisa/IA/uso-de-ia.md`, E-01 e E-02 |
| M-07 | 2026-09-19 | O ciclo de reuniões com o Ponto-Focal passa a ser procedimento declarado de pesquisa, com log de impacto sobre a arquitetura | Duas reuniões produziram 15 itens de impacto, 5 contradizendo texto vigente | `projetoPesquisa.md` §7.2, item 7 (v3.11.3) |
| M-08 | 2026-09-24 | Log de episódios de uso de IA, um por reunião | Tornar o uso de IA resultado de pesquisa conferível | `docs/Pesquisa/IA/uso-de-ia.md` |
| M-09 | 2026-09-29 | Três documentos por reunião (resumo, impactos, próxima pauta); pauta didática; estado consolidado dos impactos; revisão do resumo pelo Ponto-Focal por *pull request* | Pauta com códigos sem texto travou o Ponto-Focal (E-04) | `docs/Governanca/Arquitetura/README.md` (v3.11.4); `ComecePorAqui/guia-github.md` |
| M-10 | 2026-10-03 | **Governança da arquitetura por *Issues* (Cenário B):** uma *Issue* por questão, com etiquetas de quem responde e de tipo de fonte; pauta curta gerada da *milestone* (até 3 decisões, sem códigos); revisão obrigatória das *Issues* em todo ciclo; primeiro validar o resumo, depois derivar; impactos em blocos de formato fixo; **registro literal de prompts**; este documento e este histórico | A pauta cresceu de 1.117 para 3.212 palavras em duas reuniões e guardava o estado de tudo; a mesma questão tinha seis nomes; documentos derivados nasciam antes da revisão; a governança vai receber novos participantes | [`novaFaseArquitetura-analise.md`](novaFaseArquitetura-analise.md); `docs/Governanca/Arquitetura/README.md`; `agents/issue-tracker.md`; `docs/Pesquisa/IA/registro-de-prompts.md`; [#5](https://github.com/edalcin/Arquitetura-BioCultural/issues/5) (v3.12.0) |
| M-11 | 2026-10-03 | **Repositório organizado por público (versão 4.0):** raiz só com README, LICENSE e CLAUDE.md; `ComecePorAqui/` para quem chega; `docs/Governanca/` com uma pasta por camada e as reuniões; `docs/Pesquisa/` com o projeto de pesquisa e a transparência no uso de IA; `docs/tecnico/` técnico, com caminhos estáveis | Novos participantes, de outras iniciativas e tipos de fonte, precisam achar o seu caminho pela interface do GitHub; humanos e agentes de IA leem documentos diferentes; 301 links de outros repositórios apontam para `docs/tecnico/` | [`README.md`](../../../README.md); [`ComecePorAqui/`](../../../ComecePorAqui/README.md); `docs/tecnico/CHANGELOG.md` (4.0.0); prompts P-0004 a P-0017 |

**Como M-10 se afasta da análise**, por decisão de 03/10/2026: (1) adotado antes da reunião, por
Eduardo; a opinião de Sofia sobre o formato entra na abertura da próxima reunião; (2) a pauta em
preparo continua num arquivo (`proxima-pauta-reuniao-sofia.md`), gerado da *milestone*, porque é onde
o Ponto-Focal já lê e corrige; (3) etiquetas por **tipo de fonte**, pedidas por Eduardo; (4) a terceira
decisão da primeira pauta curta é a composição da governança (#11), e não o conflito entre coletivos
(#16), porque destrava a entrada de novos participantes; (5) as *Issues* formam um mapa (#6), o
painel das questões de desenho até o fechamento das regras da arquitetura.

**Medidas para avaliar M-10**, a comparar depois de duas reuniões no formato novo: palavras por pauta
(1.117 → 2.121 → 3.212; primeira pauta curta: cerca de 930); fração das questões da pauta tratadas na
reunião; questões respondidas entre reuniões; dias entre a reunião e o resumo validado.
