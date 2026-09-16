# Preparação para Reunião: Pauta com as Comunidades — 16/09/2026

> **Contexto:** Reunião bilateral de alinhamento entre **Eduardo Couto Dalcin** (JBRJ) e **Sofia Zank** (USEFLORA / Comitê Gestor) agendada para 16/09/2026, 09:00–10:00.  
> **Objetivo:** Alinhar o encaminhamento prático das demandas de governança e pautas comunitárias levantadas na reunião do Comitê Gestor do USEFLORA de 18/08/2026, definindo a interlocução formal e os critérios para destravar a federação.  
> **Documentos de referência no repositório:**
> - `docs/conhecimento/pauta-comunidades.md` (Documento objetivo do Ponto-Focal)
> - `governanca/propostaGovernanca.md` (Proposta de Governança em 3 Camadas)
> - `docs/reunioes/reuniao-useflora-2026-08-18.md` (Memória da reunião anterior com USEFLORA)
> - `docs/architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md`
> - `docs/architecture-decisions/ADR-016-contrato-de-harvest.md`

---

## 1. Ponto Prévio e Institucional: Designação do Ponto-Focal

- **Situação:** Na reunião de 18/08/2026, acordou-se que o USEFLORA indicaria um **Ponto-Focal** em até duas semanas (prazo expirado em 01/09/2026).
- **Objetivo imediato com Sofia:** Formalizar se ela assume este papel ou se outro membro do Comitê Gestor foi indicado.
- **Demarcação fundamental do papel:**
  - O Ponto-Focal **desenha o campo, mas nunca preenche o valor**.
  - Expressa a posição técnica e institucional da iniciativa parceira para regras gerais de comportamento da arquitetura.
  - **Nunca** substitui ou expressa consentimento de comunidades tradicionais sobre registros concretos (titularidade coletiva inalienável — Lei nº 13.123/2015, art. 10, §1º).

---

## 2. Pautas Prioritárias com o USEFLORA (Fontes Secundárias)

O USEFLORA atua prioritariamente sobre a literatura etnobotânica publicada (fontes secundárias). Portanto, a conversa deve focar nas pautas de desenho que não dependem de gravações de campo:

### A. Pauta 7 — O Detentor Apagado pela Publicação (*Prioritária e Bloqueante*)
- **O problema concreto:** No BioCultDB, há registros históricos oriundos de artigos científicos onde o autor registrou apenas "informante, 60 anos", omitindo nome e comunidade originária. Há atualmente **29 registros sem `regime` represados** no BioCultDB aguardando este critério (`docs/proximosPassos.md` §6).
- **Três caminhos conceituais para deliberação:**
  1. **Publicar como Evidência** atribuída ao autor do artigo (aplicação direta do teste de 4 perguntas de K1 / ADR-015; a instituição custodiante apenas sinaliza via *Notice*). *Limite:* Resolve quem tem autoridade sobre o registro na máquina, mas herda e chancela o apagamento histórico cometido pela ciência tradicional.
  2. **Manter restrito**, represando os registros pela ausência de quem consinta. *Limite:* Represa dados que já são de domínio público há décadas e trata uma falha documental do passado como decisão comunitária de proteção.
  3. **Caso próprio com rótulo explícito:** Publicar como Evidência com metadado/rótulo transparente de *"detentor não identificável na fonte"* (além da *Attribution Incomplete Notice*). Garante transparência histórica e permite que, caso a comunidade venha a se identificar futuramente, o registro seja reclassificado de imediato.
- **Pergunta à Sofia:** Qual caminho o USEFLORA recomenda formalmente que a Arquitetura BioCultural adote como padrão para esses registros?

### B. Pauta 6 — O que é Sagrado em Fontes Secundárias
- **A regra interina atual:** `sacred` equivale a `private` (H-Q1 da ADR-016). O registro nunca atravessa o *harvest* para o índice público do Pluriverso.
- **Questão para o USEFLORA:** Quando um conhecimento comprovadamente sagrado ou ritual foi publicado sem consentimento em artigos do passado, o registro deve sumir por completo da federação ou pode constar apenas a indicação de sua existência (*Notice*), omitindo o conteúdo e a taxonomia aplicada?

---

## 3. Demarcação das Pautas de Campo (BioCultRelatos)

Caso surjam temas relativos a coletas de campo e dados primários (ex.: mestrado em Silveiras):

- **Inversão da lógica extrativista:** Reiterar a premissa da v3.0 (*"Sementes Livres, Solos Próprios"*). Não se convida comunidades para alimentar o banco da academia; oferece-se uma infraestrutura soberana (instância local de BioCultRelatos/BioCultDB em SQLite local, operando inclusive offline via pendrive/laptop).
- **Pautas 1 e 2 (Identificação e TK/BC Labels):** Jamais decidíveis por atacado por comitês acadêmicos. Cada comunidade decide se quem fala quer ser nomeado (e como: nome, povo ou pseudônimo) e quais rótulos culturais se aplicam.
- **Pauta 4 (O Não-Registro):** Reconhecimento explícito de que saberes sagrados podem ter como melhor proteção a decisão soberana de **não serem digitalizados**.
- **Pauta 5 (Gravações Coletivas):** Confirmar se a regra interina mais conservadora é aceita: se em uma oficina ou gravação coletiva uma única pessoa solicitar reserva ou revogação, **a gravação inteira é retirada**, priorizando a proteção individual sobre o interesse do acervo.

---

## 4. Encaminhamentos e Decisões Esperadas ao Fim da Sessão

1. [ ] Nome e contato formal do Ponto-Focal do USEFLORA estabelecido.
2. [ ] Posição do parceiro sobre os 3 caminhos da Pauta 7 para resolver os 29 registros pendentes.
3. [ ] Confirmação da regra `sacred = private` para fontes secundárias (Pauta 6).
4. [ ] Cronograma de validação dos princípios mínimos comuns da federação junto ao Comitê Gestor.
