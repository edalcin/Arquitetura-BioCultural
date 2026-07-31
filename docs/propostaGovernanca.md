# Proposta de Governança — Arquitetura BioCultural

> **Status: Proposta para consulta** — submetida à validação das comunidades tradicionais federadas e do Comitê Federado. Não é norma vigente: nenhuma seção desta proposta afirma que a plataforma já cumpre o que ainda não existe — mecanismos pendentes são marcados `[a implementar]`, com o repositório responsável.

**Versão de referência:** Arquitetura BioCultural v3.3
**Data:** 31 de julho de 2026
**Autor:** Eduardo Dalcin

Esta proposta nomeia, para os dados, as ferramentas e a arquitetura da [Arquitetura BioCultural](../README.md), quem decide o quê, com que processo, e o que acontece quando uma decisão muda — fundamentada nos princípios **C.A.R.E.**, no marco legal brasileiro e internacional de acesso a conhecimento tradicional associado, e em literatura e precedentes institucionais verificados.

## Sumário

1. [Por que uma proposta de governança](#1-por-que-uma-proposta-de-governança)
2. [Escopo: três camadas de governança](#2-escopo-três-camadas-de-governança)
3. [Fundamentos éticos e legais](#3-fundamentos-éticos-e-legais)
4. [O receio legítimo: por que comunidades desconfiam de bancos de dados](#4-o-receio-legítimo-por-que-comunidades-desconfiam-de-bancos-de-dados)
5. [Governança dos dados e informações](#5-governança-dos-dados-e-informações)
6. [Governança das ferramentas](#6-governança-das-ferramentas)
7. [Governança da arquitetura](#7-governança-da-arquitetura)
8. [Implementação: do documento à prática](#8-implementação-do-documento-à-prática)
9. [Referências Bibliográficas](#9-referências-bibliográficas)

---

## 1. Por que uma proposta de governança

A Arquitetura BioCultural nasce comprometida com os princípios **C.A.R.E.** — *Collective Benefit* (Benefício Coletivo), *Authority to Control* (Autoridade para Controlar), *Responsibility* (Responsabilidade), *Ethics* (Ética) (CARROLL et al., 2020) — e já traduz parte desse compromisso em decisões técnicas: cada unidade federada é soberana sobre seu próprio arquivo SQLite+JSON (ADR-005), o Pluriverso só coleta o que é explicitamente marcado `visibility: public` (ADR-004, decisão D6), e a saída da federação é reversível por `purge_by_member` (ADR-004, decisões D3/D4).

Essas decisões resolvem a camada técnica. Mas arquitetura não é governança: dizer *como* o dado é armazenado não diz *quem decide* o que entra, o que sai, quem pode alterar o código que processa esse dado, e quem responde quando uma comunidade pergunta por que um relato está público sem autorização explícita. Três lacunas concretas, já identificadas nos próprios artefatos deste repositório, tornam esta proposta necessária agora, não depois:

- O modelo de dados que estrutura consentimento e visibilidade (ADR-003) está formalmente em status **"Proposto — aguardando validação com comunidades e pesquisadores"** — o campo que mais depende de legitimidade comunitária ainda não foi validado por nenhuma comunidade.
- O protocolo de admissão de novos membros da federação (ADR-006) tem um bloqueador não resolvido: a **autenticação da decisão do Comitê Federado (E4)** — hoje não há mecanismo técnico que garanta que uma decisão de admissão ou remoção reflete a deliberação do comitê, e não a ação isolada de quem tem acesso ao sistema.
- A licença do próprio projeto está, no README, declarada como **"A definir — considerando licenças que respeitem os princípios C.A.R.E."** — uma arquitetura que promete soberania de dados sem uma licença definida deixa em aberto a primeira pergunta que uma comunidade tradicional faria: sob quais termos meu conhecimento pode circular?

Esta proposta não substitui nenhuma decisão arquitetural existente — ela nomeia, para cada uma dessas lacunas e para o restante do sistema, **quem decide, com que processo, e o que acontece quando a decisão muda**. Apoia-se em três corpos de referência: os princípios CARE e o padrão **OCAP®** (*Ownership, Control, Access, Possession* — FIRST NATIONS INFORMATION GOVERNANCE CENTRE, s.d.) como fundamento ético; o marco legal brasileiro e internacional (Lei 13.123/2015, LGPD, Protocolo de Nagoya, Convenção nº 169 da OIT) como fundamento normativo; e o precedente institucional mais próximo do domínio desta arquitetura — o *Indigenous Data Governance Task Group* do GBIF, criado em 28 de julho de 2025 sob liderança de Lydia J. Jennings, com o objetivo declarado de tornar o Darwin Core compatível com CARE (GLOBAL BIODIVERSITY INFORMATION FACILITY, 2025) — como evidência de que essas exigências não são exclusividade desta proposta, mas uma tendência já em curso na infraestrutura internacional de dados de biodiversidade.

O restante do documento está organizado em três camadas de governança — dados, ferramentas, arquitetura — detalhadas na próxima seção, seguidas dos fundamentos éticos e legais (§3), do receio legítimo das comunidades e das salvaguardas desta arquitetura contra o mau uso (§4), do núcleo da proposta sobre governança de dados (§5), da governança das ferramentas (§6) e da arquitetura (§7), e de um plano honesto de implementação que nomeia o que ainda falta (§8).

## 2. Escopo: três camadas de governança

A palavra "governança" nesta proposta cobre três decisões de natureza distinta, que não podem ser resolvidas pelo mesmo processo nem pela mesma pessoa:

**Governança dos dados** — o que se registra, o que se publica, o que se retira. Decidida pela **comunidade** (ou, no caso de fontes secundárias, acervos e obras de naturalistas, pela curadoria informada pela fonte e, quando aplicável, pela comunidade de origem do conhecimento registrado). Mecanismos: CLPI (§5.3), rotulagem cultural (§5.5), revogação (§5.4). Nenhuma decisão técnica ou de produto sobrepõe esta camada: o mantenedor de uma instância não publica um registro que a comunidade marcou `private`, e o Comitê Federado não decide, para um registro específico, se ele deve ser público.

**Governança das ferramentas** — deploy, versão, backup, segurança de cada unidade federada. Decidida pelo **mantenedor da instância** — a pessoa, equipe ou instituição que opera o container e o arquivo SQLite+JSON de uma unidade específica (BioCultDB, BioCultRelatos, BioCultAcervos, BioCultNaturalistas, ou uma instância do Pluriverso). Mecanismos: ciclo de releases (§6.2), segurança operacional (§6.3), licenciamento de código (§6.4).

**Governança da arquitetura** — ADRs, contrato de harvest, admissão e remoção de membros da federação. Decidida pelo **Comitê Federado** (ADR-004, decisão D3), por consenso ou maioria qualificada, com um comitê próprio para cada instância do Pluriverso quando há múltiplas instâncias soberanas (ADR-009). Mecanismos: processo de ADR (§7.1), matriz de decisão (§7.2).

As três camadas formam uma hierarquia de **habilitação, não de subordinação**: a camada de arquitetura habilita a existência técnica das camadas abaixo — é o Comitê que aprova, por exemplo, a criação de um novo valor de `visibility` — mas não decide *pelas* comunidades ou pelos mantenedores dentro do espaço que essas camadas já controlam.

Três princípios atravessam as três camadas e resumem o compromisso desta proposta:

- **Soberania** — o dado mora com quem o gerou. Cada unidade federada mantém seu próprio arquivo SQLite+JSON (ADR-005); nenhuma camada de governança superior tem acesso direto ao dado de uma unidade além do que essa unidade publica explicitamente.
- **Consentimento** — sem CLPI, o registro não entra. Aplica-se com o mesmo rigor às quatro fontes de evidência da arquitetura, com o processo de consentimento apropriado a cada uma (§5.3).
- **Reversibilidade** — toda decisão de publicação pode ser desfeita. `purge_by_member` remove um membro inteiro do índice federado (ADR-004, decisão D4); o mesmo princípio se aplica a um único registro cuja `visibility` deixa de ser `public`.

## 3. Fundamentos éticos e legais

*(em elaboração — ver `docs/planoPropostaGovernanca.md`)*

## 4. O receio legítimo: por que comunidades desconfiam de bancos de dados

*(em elaboração — ver `docs/planoPropostaGovernanca.md`)*

## 5. Governança dos dados e informações

*(em elaboração — ver `docs/planoPropostaGovernanca.md`)*

## 6. Governança das ferramentas

*(em elaboração — ver `docs/planoPropostaGovernanca.md`)*

## 7. Governança da arquitetura

*(em elaboração — ver `docs/planoPropostaGovernanca.md`)*

## 8. Implementação: do documento à prática

*(em elaboração — ver `docs/planoPropostaGovernanca.md`)*
