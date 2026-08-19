# Arquitetura BioCultural — Projeto de Pesquisa

**Título:** Arquitetura federada para registro, documentação e compartilhamento de conhecimento tradicional associado à biodiversidade sob os princípios C.A.R.E.

**Proponente:** Eduardo Dalcin — Instituto de Pesquisas Jardim Botânico do Rio de Janeiro (JBRJ)
**Versão do documento:** 1.0 (primeira formalização como projeto de pesquisa)
**Data:** 2026-08-19
**Estado da produção técnica:** Arquitetura v3.5 publicada (DOI [10.5281/zenodo.21738427](https://doi.org/10.5281/zenodo.21738427)); repositório de arquitetura em v3.10.0
**Origem:** proposta inicial de "Base de Dados de Plantas Medicinais" (jan/2024, com Dra. Viviane Fonseca), sucessivamente corrigida até a arquitetura federada atual

---

## 1. Resumo

O conhecimento tradicional associado à biodiversidade (CTA) brasileira existe em duas naturezas distintas — o **Conhecimento**, enunciado por quem o detém, e a **Evidência**, atestação por terceiros de que essa relação existe — e está disperso em bibliotecas, museus, acervos históricos e bases de dados isoladas. As soluções correntes centralizam esses registros em repositórios institucionais, o que transfere para a instituição custodiante a autoridade sobre o que se publica: soberania declarada em termo de consentimento, mas não sustentada pela arquitetura.

Este projeto investiga e constrói uma alternativa: uma **arquitetura federada** em que cada comunidade ou iniciativa opera uma unidade soberana (um contêiner, um arquivo SQLite, suas ferramentas), publica apenas o que decide publicar, e é integrada por um middleware de coleta (*Pluriverso*) que indexa exclusivamente o que foi explicitamente publicado. A hipótese central é que **soberania de dados é propriedade da arquitetura, não da política de uso** — e, portanto, é verificável, auditável e reversível.

A pesquisa combina três frentes: (i) construção conceitual (modelo de dados unificado, regime enunciativo, vocabulário controlado SKOS-XL); (ii) implementação de referência em software livre (cinco ferramentas + middleware); e (iii) validação com comunidades tradicionais, com um piloto planejado junto ao povo Panará.

---

## 2. Problema de pesquisa

**Como registrar, documentar e compartilhar conhecimento tradicional associado à biodiversidade de modo que a autoridade da comunidade detentora sobre esse registro seja garantida pela própria arquitetura do sistema — e não apenas prometida por sua política de uso?**

O problema desdobra-se em quatro dificuldades concretas:

1. **Dispersão heterogênea.** Quatro tipos de fonte (artigos científicos, registro primário de campo, acervos museológicos, obras de naturalistas dos séculos XVII–XIX) exigem processos de aquisição e curadoria distintos, mas precisam de um contrato de dados comum para serem relacionáveis.
2. **Assimetria de autoridade.** Um registro sobre conhecimento tradicional produzido por um terceiro é hoje governado por esse terceiro. Nenhum padrão vigente distingue formalmente *quem fala* — e é *quem fala* que deveria decidir a classificação de acesso.
3. **Vazio normativo dos dados coletivos.** A LGPD protege o titular individual; a Lei 13.123/2015 atribui titularidade coletiva ao CTA. Os dois regimes não conversam, e nenhuma implementação conhecida resolve a lacuna.
4. **Desconfiança historicamente fundamentada.** Há casos documentados de apropriação indevida (cupuaçu, ayahuasca, jaborandi, espinheira-santa, Hoodia, nim, cúrcuma, quinoa, açaí). Qualquer proposta de base de dados de CTA precisa demonstrar, tecnicamente, o que **não** consegue impedir.

---

## 3. Justificativa

**Científica.** Não há, no Brasil, modelo de dados publicado que trate a distinção Conhecimento × Evidência como propriedade de primeira classe do registro, com consequência operacional sobre a rotulagem de acesso. Os padrões de referência (Darwin Core, DwC-DP, SocioBio) tratam de ocorrência e de uso, não de regime enunciativo. A tabela `usage-policy` do DwC-DP, verificada na fonte primária, contém apenas campos de direito autoral — **nenhum** de protocolo cultural.

**Legal.** Lei 13.123/2015, Protocolo de Nagoya e CDB Art. 8(j) exigem consentimento, rastreabilidade de origem e participação dos detentores. A conformidade exige mecanismo técnico, não apenas cláusula contratual.

**Ética.** Os princípios C.A.R.E. (Collective Benefit, Authority to Control, Responsibility, Ethics) só se tornam auditáveis quando mapeados, subprincípio a subprincípio, ao componente de software que os implementa — inclusive os que ainda não têm implementação.

**Institucional.** O Modelo de Dados Unificado (UDM) é o objeto técnico do acordo de cooperação entre o JBRJ e o USEFLORA, e dialoga com o GEF "Entre-Ciências" (MCTI, 2025–2029), a Rede de Conhecimentos sobre Sociobiodiversidade (ICMBio/CNPT + UFSC) e a modernização do SISGEN (RNP-MMA-BID). A arquitetura não busca substituí-las: oferece um modelo federado adotável por qualquer uma.

---

## 4. Questões de pesquisa

| # | Questão | Estado |
|---|---|---|
| Q1 | Uma federação de unidades soberanas, sem base central de verdade, sustenta consulta integrada útil ao pesquisador? | Especificado; implementação do Pluriverso pendente |
| Q2 | O regime enunciativo (Conhecimento × Evidência) é distinção operacionalizável em esquema de dados e em contrato de publicação? | Formalizado (ADR-015, ADR-016); validação pendente |
| Q3 | Como identificar o detentor individual sem expor a pessoa, conciliando `assertionByID`, LGPD art. 11 e o direito ao reconhecimento (CARE A1 / Lei 13.123)? | **Aberto** — recomendação: pseudônimo escolhido pela própria pessoa |
| Q4 | O que é sagrado deve desaparecer por inteiro do índice, ou pode restar visível que existe sem mostrar conteúdo? Quem diz, por todos, que um saber é sagrado? | **Aberto** — decisão da comunidade, não técnica |
| Q5 | Quem autoriza a gravação de uma prática coletiva: cada participante ou o grupo? O que acontece quando um participante revoga depois? | **Aberto** — regra interina conservadora: a gravação inteira sai |
| Q6 | Onde reside fisicamente a mídia soberana quando a comunidade tem dezenas de gravações de dezenas de MB e banda limitada? | **Aberto** — depende de infraestrutura real das comunidades |
| Q7 | A repartição de benefícios pode ser tornada rastreável pela arquitetura, e não apenas declarada? | Especificado na proposta de governança; sem implementação |

---

## 5. Objetivos

### 5.1 Objetivo geral

Conceber, especificar, implementar e validar com comunidades detentoras uma arquitetura federada de informação para conhecimento tradicional associado à biodiversidade, na qual a soberania das comunidades sobre seus registros seja garantida por construção e verificável por terceiros.

### 5.2 Objetivos específicos

1. **Caracterizar** conceitualmente a distinção entre Conhecimento e Evidência e suas consequências para a classificação de acesso.
2. **Especificar** um Modelo de Dados Unificado (UDM), independente de engine, com checklist de conformidade verificável por ferramentas externas à federação.
3. **Definir** o contrato de publicação (*harvest*) entre unidades federadas e middleware, com condição de aceitação testável.
4. **Implementar** a unidade de referência (fontes secundárias) e o módulo de vocabulário controlado SKOS-XL compartilhado.
5. **Implementar** as demais unidades (primária, acervos, naturalistas) e o middleware Pluriverso.
6. **Formular** e submeter à consulta uma proposta de governança em três camadas (dados, ferramentas, arquitetura).
7. **Validar** a arquitetura em piloto com comunidade detentora, incluindo processo de CLPI como ciclo revisável.
8. **Publicar** os resultados como software livre, documentação citável e artigos revisados por pares.

---

## 6. Fundamentação teórica e referencial

| Eixo | Referencial adotado |
|---|---|
| Governança de dados indígenas | Princípios C.A.R.E. (GIDA), em complemento — e tensão — com FAIR |
| Rotulagem cultural | TK/BC Labels e Notices (Local Contexts Hub) |
| Marco legal | Lei 13.123/2015; LGPD; Protocolo de Nagoya; CDB Art. 8(j); Convenção 169 OIT; UNDRIP; Decreto 8.750/2016 (29 categorias de comunidades) |
| Padrões de dados | Darwin Core; DwC-DP (guia ratificado TDWG, 2026-04-17); Dublin Core; SKOS-XL (W3C); PROV-O; SocioBio (SiBBr) |
| Arquitetura de sistemas | C4 Model (documentação); NIKMAS (África do Sul) — modelo dual artefato/metadado, nós distribuídos, catálogo de detentores; Mukurtu — coexistência de narrativas |
| Tecnologias móveis e participação | CyberTracker; MAPEO |
| Crítica etnobiológica | Zank et al. (2025); Pankararu et al. (2026) |

Referências completas em [`Referencias.md`](Referencias.md), norma ABNT NBR 6023:2018.

---

## 7. Metodologia

### 7.1 Natureza

Pesquisa aplicada, de caráter **construtivo** (*design science*): o artefato — arquitetura, modelo de dados e implementação de referência — é simultaneamente o resultado e o instrumento de investigação. A validação é feita por conformidade especificada, por implementação executável e por consulta às comunidades detentoras.

### 7.2 Procedimentos

1. **Documentação por decisão registrada.** Toda escolha arquitetural é registrada como ADR (*Architecture Decision Record*), com estado explícito (`Proposto` / `Aceito`), pontos numerados e questões abertas nomeadas. Dezessete ADRs produzidos até a data.
2. **Modelagem C4.** Documentação em quatro níveis (Contexto, Contêiner, Componente, Código).
3. **Linguagem ubíqua.** Glossário federado único (`CONTEXT.md`) governa os termos que atravessam todos os repositórios; termos internos vivem no repositório da ferramenta.
4. **Contrato antes de código.** O contrato de *harvest* é especificado campo a campo, com dez cenários de aceitação, antes da implementação das unidades que o cumprirão.
5. **Implementação de referência.** Software livre, contêineres pequenos, dependências mínimas, persistência em arquivo único SQLite+JSON1 por unidade.
6. **Validação participativa.** Pautas levadas às lideranças comunitárias como perguntas abertas, não como decisões a ratificar; piloto com o povo Panará.

### 7.3 Decisões arquiteturais estruturantes

| Decisão | Consequência de pesquisa |
|---|---|
| Federação sem base central (ADR-004) | Soberania deixa de depender de política e passa a depender de topologia |
| Um arquivo SQLite+JSON por unidade (ADR-005, ADR-008) | Soberania torna-se um fato do sistema de arquivos: portátil, copiável, deletável pela comunidade |
| Regime enunciativo como campo do registro (ADR-015) | Quem classifica o acesso deriva de quem fala, não de quem hospeda |
| Contrato de harvest com ADR própria (ADR-016) | O contrato pode ser aceito sem esperar a validação comunitária dos demais pontos |
| Pluriverso instanciável em múltiplos escopos (ADR-009) | Uma associação de comunidades pode federar-se sem depender do índice público global |
| Módulo de vocabulário compartilhado, dados nunca compartilhados (ADR-007, ADR-012) | O código atravessa sempre; o conteúdo soberano, nunca |
| Composição multiespécie (ADR-017) | Usos e preparos com N plantas (ex.: o Daime) são representáveis com papel por componente |

---

## 8. O que já foi realizado

### 8.1 Produção conceitual e normativa

| Produto | Estado |
|---|---|
| Arquitetura v3.5, publicada e citável (DOI Zenodo) | Concluído |
| Modelo de Dados Unificado (UDM) — documento JSON canônico, interoperabilidade DwC/DwC-DP/SKOS-XL, checklist de conformidade C1–C10 | Concluído; objeto do acordo JBRJ ↔ USEFLORA |
| Caracterização Conhecimento × Evidência, com caso Panará modelado | Concluído |
| ADR-015 — regime enunciativo e três níveis de rotulagem de acesso (K1–K8) | Proposto |
| ADR-016 — contrato de harvest (H1–H4) | Proposto; depende de uma única questão comunitária (H-Q1) |
| Contrato de harvest campo a campo, com dez cenários de aceitação | Concluído |
| Referência central de rótulos SKOS-XL (tipos, ISO 639-3, `accessLevel`, proveniência) | Concluído |
| Proposta de Governança em três camadas, com marco legal artigo por artigo, sete salvaguardas com seus limites honestos, compromissos negativos e catorze lacunas nomeadas | Proposta para consulta |
| Glossário federado (`CONTEXT.md`) | Concluído |
| Diagramas C4 (contexto, contêiner, componente) | Concluído (letra desatualizada desde ADR-016) |
| Levantamento de iniciativas correlatas (GEF Entre-Ciências, RCS, SISGEN, USEFLORA) | Concluído |

### 8.2 Produção de software

| Componente | Estado |
|---|---|
| **BioCultDB** — unidade de fontes secundárias, três interfaces (Aquisição, Curadoria, Apresentação), 29 classificações de comunidade, painel analítico, etnoChat | **Em produção** |
| **Extração por IA** — extração de metadados de PDF no navegador, com provedor configurável; absorve o extinto BioCultPapers (ADR-011) | Implementado |
| **BioCultTermos** — módulo SKOS-XL compartilhado, exportação RDF/JSON-LD/Dublin Core/CSV, API REST | Implementado; em produção apenas no BioCultDB |
| **BioCultRelatos** — unidade de fonte primária (CLPI) | Fase inicial |
| **BioCultAcervos** — unidade de acervos históricos e museológicos | Repositório e documentação apenas |
| **BioCultNaturalistas** — unidade de obras de naturalistas (séc. XVII–XIX) | Planejamento completo (cinco entidades, roadmap de 7 fases); código não iniciado |
| **Pluriverso** — middleware de federação | Planejamento completo (stack, API, contrato, C4, roadmap de 7 fases); código não iniciado |

### 8.3 Divulgação

Seis artigos de divulgação publicados (2024–2026) e dois artigos revisados por pares com participação do proponente: Pankararu et al. (2026), *npj Biodiversity*; e o debate aberto por Zank et al. (2025), *Journal of Ethnobiology and Ethnomedicine*.

---

## 9. O que falta fazer

### 9.1 Caminho crítico — validação comunitária

Seis pautas para a reunião com lideranças. Nada abaixo pode ser decidido no computador.

1. **Como quem fala quer ser nomeado** (destrava Q3 e o esquema do Relato).
2. **Quais rótulos culturais se aplicam** — sazonalidade, restrição por gênero ou família, uso comercial — e quem tem legitimidade para dizê-lo por todos.
3. **Vídeo Panará** — quatro pendências: CLPI não localizado; consentimento específico para imagem e voz; transcrição em `kre` inexistente; grafia não verificada com pesquisadores Panará.
4. **O que não deve ser registrado** — para conhecimento sagrado, a decisão correta pode ser *não registrar*, e a plataforma tem obrigação de dizer isso.
5. **Gravações de prática e oficinas coletivas** — quem autoriza; decisão individual ou do grupo; o que acontece na revogação posterior de um participante.
6. **O que é sagrado, e o que acontece com ele** (H-Q1 da ADR-016).

Pendência imediata: escrever o roteiro das pautas 5 e 6, ainda inexistente.

### 9.2 Decisões técnicas pendentes (não vão à reunião)

- Rótulos culturais: consultar a API do Local Contexts Hub a cada acesso, copiar localmente, ou guardar identificador + cache do texto canônico (recomendada). Texto de Notice nunca é editável.
- Fila de curadoria para registros com língua `und`, sob pena de o estado transitório virar final por inércia.

### 9.3 Implementação pendente

| Frente | O que falta |
|---|---|
| BioCultDB | Materializar campos de acesso do ADR-003 (`visibility`, `restrictions`, `permissions`), nunca criados em produção; atribuir `regime: evidencia` aos 29 registros existentes |
| BioCultRelatos | Absorver K1–K8 e o contrato de harvest **antes da primeira linha de código**: mídia como registro primário, participantes de gravação coletiva com decisão de acesso própria, dez cenários de aceitação |
| BioCultAcervos | Modelo de dados, contextos, integração com BioCultTermos, implementação |
| BioCultNaturalistas | Executar o roadmap de 7 fases; remover `bcn_taxons → $.nomeCientificoAtual` (ADR-014 N3) |
| Pluriverso | Executar o roadmap de 7 fases: harvest, índice SQLite+FTS5, mapeamento SKOS entre vocabulários, API pública, autenticação do Comitê |
| BioCultTermos | Integrar às três unidades hospedeiras restantes (padrão já documentado) |
| Transversal | Integração taxonômica (Flora e Funga do Brasil, Fauna do Brasil, GBIF como *fallback*); integração territorial (Plataforma de Territórios Tradicionais do MPF); acesso móvel *offline-first* |

### 9.4 Governança e formalização

- Promover ADR-016 a *Aceito* (depende apenas de H-Q1 e do Comitê).
- Promover ADR-015 a *Aceito* (depende de Q3–Q6 e da validação comunitária).
- Constituir formalmente o Comitê Federado, com protocolo de admissão de membros.
- Fechar as catorze lacunas nomeadas na proposta de governança.
- Definir o licenciamento: código em licença permissiva OSI, documentação em CC BY 4.0, dados de CTA **fora** de licença aberta — porque licença aberta é irrevogável e o CLPI não pode ser.
- Executar o piloto Panará de ponta a ponta e submeter a arquitetura a auditoria externa.

---

## 10. Cronograma por fases

Fases lógicas, encadeadas por dependência e não por calendário fixo: a Fase B depende de agenda comunitária, que não é do pesquisador.

| Fase | Escopo | Depende de |
|---|---|---|
| **A — Fundação conceitual** ✔ | UDM, regime enunciativo, contrato de harvest, governança proposta, unidade de referência em produção | — |
| **B — Validação comunitária** | Seis pautas; roteiros das pautas 5 e 6; decisão sobre nomeação do detentor e sobre o sagrado | Agenda das lideranças |
| **C — Fechamento normativo** | ADR-015 e ADR-016 a *Aceito*; esquema do Relato; licenciamento; Comitê Federado constituído | B |
| **D — Implementação da federação** | BioCultRelatos; Pluriverso; BioCultTermos nas quatro hospedeiras | C (parcialmente paralelizável com B) |
| **E — Expansão de fontes** | BioCultAcervos; BioCultNaturalistas; integrações taxonômica e territorial | D |
| **F — Piloto e avaliação** | Piloto Panará ponta a ponta; auditoria externa; medição de conformidade C1–C10 | B, D |
| **G — Publicação** | Artigos revisados por pares; versão citável consolidada; disseminação às iniciativas correlatas | F |

---

## 11. Resultados esperados

1. Arquitetura federada especificada, implementada e validada em uso real, adotável por qualquer iniciativa nacional.
2. Modelo de Dados Unificado com conformidade declarável por ferramentas de terceiros.
3. Cinco ferramentas e um middleware em software livre, todos containerizados e de dependência mínima.
4. Proposta de governança validada por comunidades e por Comitê Federado constituído.
5. Evidência empírica, do piloto, sobre se a soberania garantida por arquitetura é percebida como tal por quem detém o conhecimento.
6. Artigos revisados por pares sobre o regime enunciativo e sobre a arquitetura federada como resposta à lacuna dos dados coletivos.

---

## 12. Riscos e mitigações

| Risco | Mitigação |
|---|---|
| Validação comunitária não ocorrer no prazo, travando C, D e F | Regras interinas sempre conservadoras (o sagrado equivale a `private`; um participante revoga, a gravação inteira sai); ADR-016 desacoplada da ADR-015 para poder ser aceita antes |
| Arquitetura federada não sustentar consulta integrada útil | Índice do Pluriverso com FTS5 e mapeamento SKOS; medição de utilidade no piloto |
| Custo de armazenamento de mídia inviável para a comunidade | Questão Q6 explicitamente aberta; solução dependente da infraestrutura real, não presumida |
| Dependência de serviço externo (Local Contexts Hub) | Identificador + cache do texto canônico; degradação para a última versão conhecida |
| Reprodução de apropriação indevida apesar das salvaguardas | Sete salvaguardas documentadas **com o limite honesto de cada uma**; compromissos negativos explícitos |
| Sobreposição com iniciativas governamentais | Posicionamento explícito de complementaridade; UDM oferecido como contrato adotável |

---

## 13. Considerações éticas

O projeto opera sob CLPI entendido como **ciclo revisável**, não como formulário assinado uma única vez: a comunidade pode reclassificar ou revogar um Relato a qualquer tempo, sem justificativa. Registros de regime `conhecimento` sem CLPI válido não atravessam o harvest — condição de aceitação testável, não promessa. A mídia do caso-teste Panará permanece `restricted` de fato e fora do versionamento enquanto sua pauta não fechar.

Dados de CTA não recebem licença aberta. Onde a decisão correta for **não registrar**, a plataforma tem a obrigação de dizê-lo.

---

## 14. Equipe e parcerias

- **Proponente:** Eduardo Dalcin (JBRJ) — arquitetura, modelagem de dados, implementação.
- **Parcerias institucionais:** JBRJ; USEFLORA (acordo de cooperação técnica tendo o UDM como objeto); FUNAI.
- **Interlocução técnica e ética:** Dra. Viviane Fonseca (JBRJ), Lucas Zelesco (FUNAI), Comitê Gestor USEFLORA.
- **Comunidades:** povo Panará (piloto planejado); demais comunidades a serem convidadas como unidades federadas soberanas.
- **A constituir:** Comitê Federado, com representação de cada membro.

---

## 15. Documentos de referência do projeto

| Documento | Caminho |
|---|---|
| Arquitetura completa (v3.5) | [`README.md`](README.md) |
| Modelo de Dados Unificado | [`docs/modelo-de-dados-unificado.md`](docs/modelo-de-dados-unificado.md) |
| Proposta de Governança | [`governanca/propostaGovernanca.md`](governanca/propostaGovernanca.md) |
| Conhecimento × Evidência | [`conhecimento/caracterizacao-do-conhecimento-tradicional.md`](conhecimento/caracterizacao-do-conhecimento-tradicional.md) |
| Contrato de harvest | [`docs/contrato-harvest.md`](docs/contrato-harvest.md) |
| Rótulos SKOS-XL | [`docs/rotulos-skos-xl.md`](docs/rotulos-skos-xl.md) |
| Decisões arquiteturais (ADR-001…017) | [`docs/architecture-decisions/`](docs/architecture-decisions/) |
| Metodologia e tecnologias | [`docs/metodologia-e-tecnologias.md`](docs/metodologia-e-tecnologias.md) |
| Glossário federado | [`CONTEXT.md`](CONTEXT.md) |
| Estado operacional e pendências | [`conhecimento/proximosPassos.md`](conhecimento/proximosPassos.md) |
| Referências bibliográficas (ABNT) | [`Referencias.md`](Referencias.md) |
