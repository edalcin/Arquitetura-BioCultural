# Arquitetura BioCultural — Versão 4.0

**Uma arquitetura federada para registrar e compartilhar o conhecimento tradicional associado à
biodiversidade, com a comunidade no controle.**

[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.21738427-blue)](https://doi.org/10.5281/zenodo.21738427)
[![Versão](https://img.shields.io/badge/Versão-4.0.0-green)](docs/tecnico/CHANGELOG.md)
[![Governança da arquitetura](https://img.shields.io/badge/Governança%20da%20arquitetura-em%20operação-2E7D32)](docs/Governanca/README.md)
[![Questões abertas](https://img.shields.io/github/issues/edalcin/Arquitetura-BioCultural?label=Quest%C3%B5es%20abertas)](https://github.com/edalcin/Arquitetura-BioCultural/issues/6)

O conhecimento das comunidades tradicionais sobre plantas, animais e territórios está espalhado em
artigos, museus, obras históricas e bases de dados isoladas — quase sempre sob o controle de quem o
guardou, e não de quem o detém. Esta arquitetura propõe outro caminho: cada comunidade ou iniciativa
opera a **sua própria unidade**, decide o que publica, e as unidades se conectam numa **federação**
sem banco central. A soberania deixa de ser promessa num termo de consentimento e passa a ser
propriedade do sistema.

> **Novo por aqui?** Comece pelo **[resumo executivo](ComecePorAqui/README.md)** — uma página, em
> linguagem simples.

## O que mudou na versão 4.0

A versão 4.0 marca o início da **governança da arquitetura em operação** e reorganiza este
repositório para quem vai participar dela.

- **A arquitetura evolui com as pessoas.** As decisões que dependem de alguém — do Ponto-Focal de
  uma iniciativa parceira, das comunidades, de quem responde por um tipo de fonte — são
  **questões públicas** (*Issues*), cada uma com número fixo, escrita para quem conhece o
  conhecimento tradicional e não é da área de sistemas, e com o que é preciso para fechá-la.
- **Reuniões de governança da arquitetura** com pauta curta, resumo revisado pelo Ponto-Focal e
  registro do que cada decisão muda na arquitetura.
- **Transparência no uso de IA.** Todo pedido significativo feito à IA sobre esta arquitetura é
  registrado literalmente.
- **Pastas novas, por público.** Quem participa encontra o seu caminho em português; a
  documentação técnica fica separada, em `docs/tecnico/`.

📌 **[Painel das questões abertas](https://github.com/edalcin/Arquitetura-BioCultural/issues/6)** ·
**[Pauta da próxima reunião](docs/Governanca/Arquitetura/Reunioes/proxima-pauta-reuniao-sofia.md)**

## Como este repositório está organizado

```
/
├── ComecePorAqui/      → para quem chega: resumo executivo, glossário e guias de participação
├── docs/               → toda a documentação, em três partes:
│   ├── Governanca/     → quem decide o quê: proposta, camadas (dados, ferramentas, arquitetura) e reuniões
│   ├── Pesquisa/       → o projeto de pesquisa, referências, estudos e a transparência no uso de IA
│   └── tecnico/        → documentação técnica, para a equipe técnica e agentes de IA
├── README.md           → este arquivo
├── LICENSE             → licença (precisa ficar na raiz)
└── CLAUDE.md           → regras para agentes de IA (precisa ficar na raiz)
```

| Pasta | Para quem | O que você encontra |
|---|---|---|
| **[ComecePorAqui/](ComecePorAqui/README.md)** | Todos os que chegam | Resumo executivo de uma página; [glossário](ComecePorAqui/glossario.md) em linguagem simples; guias para cada perfil; [como usar o GitHub](ComecePorAqui/guia-github.md) |
| **[docs/Governanca/](docs/Governanca/README.md)** | Participantes da governança e interessados | A [Proposta de Governança](docs/Governanca/Proposta/propostaGovernanca.md) em três camadas; uma pasta por camada — [Dados](docs/Governanca/Dados/README.md), [Ferramentas](docs/Governanca/Ferramentas/README.md), [Arquitetura](docs/Governanca/Arquitetura/README.md); as reuniões, com pautas, resumos e impactos; a [pauta das comunidades](docs/Governanca/pautaComunidades/pauta-comunidades.md) |
| **[docs/Pesquisa/](docs/Pesquisa/README.md)** | Pesquisadores e avaliadores | O [projeto de pesquisa](docs/Pesquisa/projetoPesquisa.md); o [resumo executivo completo](docs/Pesquisa/resumoExecutivo-completo.md); [referências](docs/Pesquisa/Referencias.md); Conhecimento × Evidência; iniciativas correlatas; [uso de IA](docs/Pesquisa/IA/uso-de-ia.md) e [registro de prompts](docs/Pesquisa/IA/registro-de-prompts.md) |
| **[docs/tecnico/](docs/tecnico/README.md)** | Equipe técnica e agentes de IA | Descrição completa da arquitetura; decisões registradas (ADRs); diagramas C4; modelo de dados; contrato de coleta; [glossário oficial](docs/tecnico/CONTEXT.md); [estado do projeto](docs/tecnico/proximosPassos.md); [histórico de versões](docs/tecnico/CHANGELOG.md) |

## Quem decide o quê

| Camada | Quem decide | Sobre o quê | Hoje |
|---|---|---|---|
| **Dados** | A comunidade | O que se registra, o que se publica, o que se retira | Ainda sem comunidade com voz direta |
| **Ferramentas** | Quem mantém cada instalação | Instalação, versão, cópia de segurança, segurança | Cada ferramenta tem seu repositório |
| **Arquitetura** | Comitê Federado (ainda não constituído) | Regras da federação, modelo de dados, admissão de membros | **Em operação** nas reuniões de governança da arquitetura |

A fronteira não muda: a governança da arquitetura decide o **desenho** (que campo, que regra). O
consentimento sobre um registro concreto é sempre da comunidade detentora, registro a registro.

## As ferramentas da federação

| Tipo de fonte | Ferramenta | Estado |
|---|---|---|
| Registro feito diretamente com a comunidade | [BioCultRelatos](https://github.com/edalcin/BioCultRelatos) | Fase inicial |
| Artigos científicos publicados | [BioCultDB](https://github.com/edalcin/BioCultDB) | Em produção |
| Acervos históricos e museológicos | [BioCultAcervos](https://github.com/edalcin/BioCultAcervos) | Documentação |
| Obras de naturalistas, séculos XVII–XIX | [BioCultNaturalistas](https://github.com/edalcin/BioCultNaturalistas) | Planejamento completo |
| Vocabulário compartilhado (SKOS-XL) | [BioCultTermos](https://github.com/edalcin/BioCultTermos) | Em produção, dentro do BioCultDB |
| Conexão entre as unidades | [Pluriverso](https://github.com/edalcin/pluriverso) | Planejamento completo |

## Como participar

Esta é uma construção coletiva: toda crítica, sugestão e contribuição é registrada e considerada.

- **Comente uma questão** no [painel](https://github.com/edalcin/Arquitetura-BioCultural/issues/6), ou
  [abra uma dúvida ou uma questão nova](https://github.com/edalcin/Arquitetura-BioCultural/issues/new/choose).
- **Corrija um resumo de reunião** por *pull request* — [passo a passo](ComecePorAqui/guia-github.md).
- **Tudo é público.** Nunca escreva conhecimento tradicional de uma comunidade, nome de detentor,
  local sensível ou dado pessoal. Fale do desenho, nunca do valor de um registro concreto.

## Citação

O DOI abaixo corresponde à última versão depositada no Zenodo; a versão atual do repositório é a
4.0.0.

```
Dalcin, E. (2026). Arquitetura para um Sistema de Informações sobre Conhecimento Tradicional Associado à Biodiversidade [Software documentation]. Zenodo. https://doi.org/10.5281/zenodo.21738427
```

Histórico completo em [`docs/tecnico/CHANGELOG.md`](docs/tecnico/CHANGELOG.md); mudanças na forma de trabalhar em
[`docs/Governanca/Arquitetura/metodo-de-evolucao.md`](docs/Governanca/Arquitetura/metodo-de-evolucao.md).

## Licença

Os textos, diagramas e imagens deste repositório estão sob a licença
**[Creative Commons Atribuição 4.0 Internacional (CC BY 4.0)](LICENSE)**: qualquer pessoa pode copiar,
traduzir e adaptar, desde que cite a fonte. Exceções:

- **Dados de conhecimento tradicional nunca estão sob licença aberta.** Eles dependem do
  consentimento da comunidade, que pode ser retirado. Este repositório não guarda esses dados
  ([Proposta de Governança, §6.4](docs/Governanca/Proposta/propostaGovernanca.md#64-licenciamento-de-código-dados-e-conteúdo)).
- **Documentos de terceiros** em [`docs/Pesquisa/iniciativas/`](docs/Pesquisa/iniciativas/README.md) (PDFs de
  relatórios, trabalhos acadêmicos e artigos) mantêm os direitos dos seus autores.
- **Código:** o script `docs/tecnico/bin/termos-status.ps1` está sob MIT. As ferramentas da federação têm,
  cada uma, a licença do próprio repositório.

Até 03/10/2026 o arquivo de licença era a GPL-3.0. A concordância dos colaboradores com a mudança é
registrada na [questão #35](https://github.com/edalcin/Arquitetura-BioCultural/issues/35).

## Agradecimentos

A Viviane Fonseca-Kruel (JBRJ), Lucas Zelesco (FUNAI), Luisa Ridolph e Camila Dantas (ENBT/JBRJ),
Sofia Zank (Ponto-Focal do UseFlora) e aos membros do Comitê Gestor do UseFlora, cuja dedicação à
salvaguarda da sociobiodiversidade e ao respeito às comunidades tradicionais inspira esta
arquitetura.
