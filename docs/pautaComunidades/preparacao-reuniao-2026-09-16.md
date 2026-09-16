# Preparação para Reunião: Pauta com as Comunidades — 16/09/2026

> **Contexto:** Reunião bilateral de alinhamento entre **Eduardo Couto Dalcin** (JBRJ) e **Sofia Zank** (USEFLORA / Comitê Gestor) agendada para 16/09/2026, 09:00–10:00.  
> **Objetivo:** Alinhar o encaminhamento prático das demandas de governança e pautas comunitárias levantadas na reunião do Comitê Gestor do USEFLORA de 18/08/2026, definindo a interlocução formal e os critérios para destravar a federação.  
> **Documentos de referência no repositório:**
> - `docs/pautaComunidades/pauta-comunidades.md` (Documento objetivo do Ponto-Focal)
> - `docs/governanca/propostaGovernanca.md` (Proposta de Governança em 3 Camadas)
> - `docs/reunioes/reuniao-useflora-2026-08-18.md` (Memória da reunião anterior com USEFLORA)
> - `docs/architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md`
> - `docs/architecture-decisions/ADR-016-contrato-de-harvest.md`
> - Base de dados real: `/Storage/appsdata/biocultdb/data/biocultdb.sqlite` (tabela `biocultdb_records`)

---

## 1. Ponto Prévio e Institucional: Designação do Ponto-Focal

- **Situação:** Na reunião de 18/08/2026, acordou-se que o USEFLORA indicaria um **Ponto-Focal** em até duas semanas (prazo expirado em 01/09/2026).
- **Objetivo imediato com Sofia:** Formalizar se ela assume este papel ou se outro membro do Comitê Gestor foi indicado.
- **Demarcação fundamental do papel:**
  - O Ponto-Focal **desenha o campo, mas nunca preenche o valor**.
  - Expressa a posição técnica e institucional da iniciativa parceira para regras gerais de comportamento da arquitetura.
  - **Nunca** substitui ou expressa consentimento de comunidades tradicionais sobre registros concretos (titularidade coletiva inalienável — Lei nº 13.123/2015, art. 10, §1º).

---

## 2. A Issue Crítica: A Ausência do Campo `regime` no BioCultDB

### Diagnóstico Técnico e Bloqueio Prático
Na base de produção do BioCultDB (`biocultdb.sqlite`), existem hoje **29 artigos catalogados e aprovados**. Uma inspeção direta no banco revela que o campo `regime` está **completamente ausente (`None`)** em todos os 29 documentos JSON.

**Por que isso bloqueia a Federação e o Pluriverso?**
- O contrato de harvest da federação ([ADR-016](../architecture-decisions/ADR-016-contrato-de-harvest.md)) e a modelagem do UDM exigem o campo `regime` como metadado de primeira classe.
- O `regime` informa ao sistema **quem fala e quem tem autoridade sobre o registro**:
  - `conhecimento`: Enunciação direta de quem detém o saber (BioCultRelatos, dados primários sob CLPI). Autoridade estrita da comunidade.
  - `evidencia`: Relato de terceiros sobre o saber (BioCultDB, literatura científica, acervos, naturalistas). Autoridade técnica inicial da instituição custodiante, restrita por salvaguardas culturais e *Notices*.
- Sem esse campo, o middleware *Pluriverso* não consegue aplicar as regras automáticas de filtragem de sensibilidade nem distinguir a autoridade de atribuição dos rótulos culturais (Labels vs. Notices).

---

## 3. Exemplos Reais do BioCultDB para Explicar o Impasse à Sofia

Para tornar a conversa didática, objetiva e transparente, podemos apresentar à Sofia 3 registros reais extraídos da base do BioCultDB:

### Exemplo 1: Comunidade identificada na literatura acadêmica
* **Registro real:** `6952636c01018845ec861518`  
  *Artigo:* "Diversity of plant uses in two Caiçara communities from the Atlantic Forest coast, Brazil" (Hanazaki et al., 2000).  
  *Comunidades no banco:* Ponta do Almada e Camburí (Ubatuba/SP).  
* **O caso:** O artigo identifica claramente o povo e o local. Porém, quem fala no registro do BioCultDB é a publicação acadêmica (terceiros), não um relato gravado diretamente com consentimento para este banco.  
* **Regime correto:** `evidencia`. A instituição indexadora não pode aplicar um *TK Label* (que só a comunidade caiçara poderia emitir), mas pode emitir uma *Notice* de contexto biocultural.

### Exemplo 2: Menção a rituais sagrados em literatura secundária (Pauta 6)
* **Registro real:** `6952636b01018845ec861516`  
  *Artigo:* "Rapid Ethnobotanical Diagnosis Of The Fulni-ô Indigenous Lands (NE Brazil)..." (Albuquerque et al., 2010).  
  *Comunidade no banco:* Fulni-ô (Águas Belas/PE).  
  *Observação registrada:* Detalha o calendário do ritual sagrado *Ouricuri* (setembro a novembro) e usos de plantas associadas.  
* **O caso:** O dado é público na revista acadêmica, mas toca em conhecimento iniciático/sagrado.  
* **Encaminhamento:** Se o regime for `evidencia`, como a federação deve tratá-lo? Regra interina: marcar como `sacred` que equivale a `private` (o registro não é exportado no harvest público do Pluriverso).

### Exemplo 3: O detentor apagado na fonte original (Pauta 7)
* **Registro real:** Estudos onde a autoria cita apenas *"entrevistas com 30 informantes locais (idade média 62 anos)"*, sem registrar nomes nem vinculação a povo tradicional específico (origem não identificável — Lei 13.123/2015, art. 2º, III).  
* **O caso:** O conhecimento teve um detentor, mas a prática acadêmica da época apagou sua identidade.  
* **Encaminhamento (Os 3 Caminhos):**
  1. Classificar como `evidencia` atribuída ao autor do artigo. (Técnico, resolve o harvest, mas chancela o apagamento).
  2. Represar como `restrito` por falta de consentimento de quem nunca foi identificado. (Inviabiliza dados de artigos já públicos).
  3. **Solução recomendada:** Classificar como `evidencia` acompanhada do rótulo explícito *"detentor não identificável na fonte"*. Transparente, honesto com a limitação histórica e aberto a reclassificação futura.

---

## 4. Proposta de Encaminhamento da Issue (Plano de Ação)

Apresentar à Sofia uma solução em três passos pragmáticos para destravar o banco:

1. **Definição conceitual com o USEFLORA:** Acordar que todo registro gerado pelo BioCultDB a partir de literatura científica publicada assume por padrão `regime: "evidencia"`.
2. **Script de migração no banco:** Executar script de migração no `biocultdb.sqlite` para preencher `"regime": "evidencia"` nos 29 registros aprovados existentes.
3. **Atualização do pipeline de ingestão:**
   - Tornar o campo `regime` obrigatório no esquema JSON do BioCultDB.
   - Atualizar a interface de curadoria e o extrator de PDFs por IA (BioCultPapers) para já gravar `regime: "evidencia"` por padrão nas novas extrações.

---

## 5. Demarcação das Pautas de Campo (BioCultRelatos)

Para manter a reunião focada e evitar atritos desnecessários:

- **Separar Secundário de Primário:** Deixar claro que a regra `regime: "evidencia"` vale estritamente para o BioCultDB (fontes secundárias).
- **Proteção dos Dados de Campo:** No BioCultRelatos (campo/primário), o regime será obrigatoriamente `conhecimento`. As decisões sobre como nomear o detentor (Pauta 1), quais TK Labels aplicar (Pauta 2) e o direito ao não-registro em computador (Pauta 4) continuam pertencendo com exclusividade às próprias comunidades locais.
- **Gravações Coletivas (Pauta 5):** Validar se o Comitê Gestor concorda com a salvaguarda conservadora interina: havendo gravação em roda de conversa ou oficina, se um participante revogar, a gravação inteira é despublicada.

---

## 6. Checklist de Deliberações ao Fim da Sessão

- [ ] **Ponto-Focal:** Nome formalizado para interlocução com a arquitetura.
- [ ] **Aprovação do Regime no BioCultDB:** Consenso sobre atribuir `regime: "evidencia"` aos 29 registros de fontes secundárias.
- [ ] **Encaminhamento da Pauta 7:** Validação do caminho (3) — rótulo explícito de detentor não identificado.
- [ ] **Confirmação da Pauta 6:** Regra `sacred = private` aprovada para artigos que descrevam rituais.
