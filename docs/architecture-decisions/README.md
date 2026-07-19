# Architecture Decision Records (ADRs)

## Sobre ADRs

Architecture Decision Records (ADRs) são documentos que capturam decisões arquiteturais importantes tomadas durante o desenvolvimento do sistema, incluindo o contexto, alternativas consideradas, decisão tomada e consequências.

## Por que documentar decisões?

1. **Transparência**: Entender o "porquê" por trás das escolhas técnicas
2. **Onboarding**: Novos membros do time podem entender rapidamente o contexto
3. **Revisão**: Facilita revisitar decisões quando o contexto muda
4. **Aprendizado**: Documentar o que funcionou e o que não funcionou

## Status dos ADRs

- **Proposto**: Decisão ainda em discussão
- **Aceito**: Decisão aprovada e sendo implementada
- **Implementado**: Decisão já em produção
- **Depreciado**: Decisão substituída por outra
- **Rejeitado**: Proposta não aceita

## Lista de ADRs

### ADR-001: Abordagem de Armazenamento de Dados
**Status:** Depreciado — substituído por ADR-005
**Data:** Janeiro 2025

Decisão sobre qual abordagem de armazenamento utilizar para dados de conhecimento tradicional. Avalia bancos SQL, orientados a documentos (JSON) e multi-modais, considerando flexibilidade de schema, escalabilidade e complexidade dos dados.

**Decisão:** Arquitetura orientada a documentos (JSON) como solução principal, com avaliação futura de abordagens multi-modais.

**[Leia o documento completo →](ADR-001-database-selection.md)**

---

### ADR-002: Padrões de API e Integração
**Status:** Proposto
**Data:** Janeiro 2025

Define os padrões de APIs para os três contextos do sistema (Aquisição, Curadoria, Apresentação). Avalia REST vs GraphQL, estratégias de autenticação, versionamento e documentação.

**Decisão:** Abordagem híbrida - REST para contextos internos, GraphQL para API pública.

**[Leia o documento completo →](ADR-002-api-standards.md)**

---

### ADR-003: Modelo de Dados para Conhecimento Tradicional
**Status:** Proposto
**Data:** Janeiro 2025

Especifica a estrutura de dados para armazenar conhecimento tradicional associado à biodiversidade. Considera diversidade cultural, flexibilidade, interoperabilidade com Darwin Core e proteção de dados sensíveis.

**Decisão:** Modelo híbrido com estrutura core padronizada e extensões flexíveis.

### ADR-004: Arquitetura Federada v3.0
**Status:** Aceito
**Data:** Junho 2026

Redefine a arquitetura como explicitamente federada. Cada entidade (iniciativa de fontes secundárias ou comunidade tradicional) é soberana na gestão de seus próprios dados. Documenta 7 decisões: modelo de acesso por harvest REST, BioCultTermos por membro com mapeamento SKOS no Pluriverso, governança por comitê federado, remoção imediata ao sair, MongoDB pertence à Iniciativa #1, protocolo de publicação REST paginado, BioCultPapers exclusivo de fontes secundárias.

**Decisão:** Arquitetura federada com Pluriverso como middleware de federação.

**[Leia o documento completo →](ADR-004-federated-architecture.md)**


### ADR-005: Persistência SQLite com JSON por Unidade Federada (v3.1)
**Status:** Aceito
**Data:** Julho 2026

Substitui a persistência MongoDB por membro (ADR-001, D5 do ADR-004) por SQLite com JSON (JSON1) — um arquivo por unidade federada, compartilhado pelas ferramentas da unidade em tabelas distintas, um container por unidade, WAL, FTS5 para busca textual, BioCultPapers entregando por arquivo (export/import).

**Decisão:** SQLite com JSON como persistência embutida de cada unidade federada, superando ADR-001 e a decisão D5 do ADR-004.

**[Leia o documento completo →](ADR-005-sqlite-json-persistence.md)**

---

### ADR-006: Protocolo de Inscrição na Federação
**Status:** Aceito
**Data:** Julho 2026

Complementa D3/D6 do ADR-004: define o protocolo self-service com fila de aprovação do Comitê Federado pelo qual uma instância nova (qualquer um dos quatro tipos de membro da v3.2) solicita entrada na federação — cadastro via URL-BASE, verificação técnica automática (anti-SSRF) como sinal não-bloqueante, e decisão humana obrigatória do Comitê.

**Decisão:** Inscrição self-service com fila de aprovação do Comitê Federado; nenhuma admissão automática.

**[Leia o documento completo →](ADR-006-federation-membership-protocol.md)**

---

### ADR-007: Distribuição do Módulo BioCultTermos via Git Submodule Compartilhado
**Status:** Aceito
**Data:** Julho 2026

Formaliza, ao nível arquitetural, o padrão já implementado (BioCultDB) e planejado (BioCultRelatos) de distribuir o código do BioCultTermos como git submodule compartilhado pelas quatro unidades federadas — um único repositório, consumido independentemente por cada unidade, "congelado como produto" standalone. Esclarece que soberania (D2 do ADR-004) é sobre dados, nunca sobre código: o módulo é intencionalmente compartilhado, cada unidade mantém seu próprio arquivo SQLite/ConceptScheme.

**Decisão:** Repositório único consumido via git submodule por todas as unidades; propagação de mudanças via bump do ponteiro do submodule, não automática nem hierárquica.

**[Leia o documento completo →](ADR-007-shared-bioculttermos-module.md)**


## Template para Novos ADRs

Ao criar um novo ADR, utilize o seguinte template:

```markdown
# ADR-XXX: [Título da Decisão]

## Status
[Proposto | Aceito | Implementado | Depreciado | Rejeitado]

## Contexto
[Descrever o problema ou situação que requer uma decisão]

## Requisitos
### Funcionais
- [Requisito 1]
- [Requisito 2]

### Não-Funcionais
- [Requisito 1]
- [Requisito 2]

## Opções Consideradas
### Opção 1: [Nome]
**Prós:**
- [Pro 1]

**Contras:**
- [Contra 1]

### Opção 2: [Nome]
...

## Decisão
[Descrever a decisão tomada e justificativa]

## Consequências
### Positivas
- [Consequência positiva 1]

### Negativas
- [Consequência negativa 1]

### Mitigações
- [Como mitigar negativos]

## Referências
- [Referência 1]

## Data de Revisão
[Quando revisitar esta decisão]
```

## Como Contribuir

1. **Propor novo ADR**: Crie um arquivo `ADR-XXX-titulo.md` com status "Proposto"
2. **Discussão**: Abra uma issue no GitHub para discussão
3. **Aprovação**: Após consenso, mude status para "Aceito"
4. **Implementação**: Atualize para "Implementado" quando em produção
5. **Revisão**: Revisite periodicamente conforme definido no ADR

## Convenções

- **Numeração**: Sequencial (ADR-001, ADR-002, ...)
- **Nome do arquivo**: `ADR-XXX-titulo-kebab-case.md`
- **Imutabilidade**: ADRs não devem ser editados após aceitos (criar novo ADR se mudança necessária)
- **Links**: Referenciar outros ADRs quando relevante

## Histórico de Mudanças

| 2026-06-23 | ADR-004 | Arquitetura federada v3.0 |
| 2026-07-11 | ADR-005 | Persistência SQLite com JSON (v3.1) |
| 2026-07-19 | ADR-006 | Protocolo de inscrição na federação (v3.2) |
| 2026-07-19 | ADR-007 | Distribuição do módulo BioCultTermos via submodule compartilhado |

---

**Última atualização:** Junho 2026
