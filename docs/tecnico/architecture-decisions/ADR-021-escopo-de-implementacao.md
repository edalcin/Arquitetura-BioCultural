---
type: Decisão de arquitetura
description: "Escopo de implementação: BioCultDB integrado ao BioCultTermos é o único caso implementado; BioCultRelatos, BioCultAcervos, BioCultNaturalistas e Pluriverso são propostas, sem implementação e sem stack."
status: stable
---

# ADR-021: Escopo de implementação — BioCultDB + BioCultTermos como único caso implementado; demais unidades como propostas

## Status

**Aceito** — 1º de novembro de 2026. Decisão do responsável pela arquitetura.

O número 019 segue reservado ([ADR-020](ADR-020-adocao-do-okf.md)).

## Contexto

A arquitetura descreveu, até aqui, cinco unidades como se fossem ser construídas em paralelo, com
stack, módulo compartilhado e topologia próprios. O responsável pela arquitetura não vai desenvolver
todas. A única ferramenta que vai à produção é o **BioCultDB integrado ao BioCultTermos** (código já
em desenvolvimento e em produção), por ligação direta com o projeto
`projeto-gef-mcti-entre-ciencias` (repositório local, sem espelho no GitHub) e com as entregas da
USEFLORA e do Jardim Botânico do Rio de Janeiro (JBRJ).

## Decisão

1. **Caso implementado.** BioCultDB, com o BioCultTermos integrado, é o estudo de caso completo da
   arquitetura. Estado: BioCultDB "Em produção (caso implementado)"; BioCultTermos "Em produção,
   integrado ao BioCultDB".
2. **Propostas.** BioCultRelatos, BioCultAcervos, BioCultNaturalistas e Pluriverso são **propostas,
   sem implementação**: mostram como a arquitetura poderia ser realizada no futuro por quem assumir
   a responsabilidade. O responsável pela arquitetura não vai desenvolvê-las.
3. **Sem stack.** Nenhuma tecnologia está definida para as propostas. Onde os ADRs anteriores citam
   SQLite, Node, SvelteKit, Docker, imagem em `ghcr.io/edalcin/pluriverso`, submódulo git, motor de banco do Pluriverso etc. para essas unidades, isso é
   **orientação não vinculante**; quem implementar escolhe.
4. **O que continua valendo para todos.** Os contratos de nível de arquitetura (modelo de dados,
   Regime Enunciativo, rotulagem de acesso, contrato de Harvest, composição multiespécie, protocolo
   de federação) seguem como a especificação que um futuro implementador deve respeitar.
5. **Hospedagem do BioCultTermos.** Só o BioCultDB hospeda o módulo. O fluxo de submódulo
   ([ADR-007](ADR-007-shared-bioculttermos-module.md), [ADR-012](ADR-012-manutencao-codigo-bioculttermos.md))
   aplica-se a ele; para as propostas, vira desenho a adotar se e quando existirem.

## Consequências

- Os ADRs 005, 007, 008, 009, 012, 013 e 018 ganham nota datada restringindo o escopo; o texto
  original é preservado como histórico.
- Os repositórios das unidades-proposta ficam só com documentação.
- O script `bin/termos-status.ps1` reporta apenas o BioCultDB.
- Documentos de estado passam a usar o vocabulário: "Em produção (caso implementado)", "Em produção,
  integrado ao BioCultDB" e "Proposta, sem implementação".
