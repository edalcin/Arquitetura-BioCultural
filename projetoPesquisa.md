# Arquitetura BioCultural — Projeto de Pesquisa

**Título:** Arquitetura federada para registro, documentação e compartilhamento de conhecimento tradicional associado à biodiversidade sob os princípios C.A.R.E.

**Proponente:** Eduardo Dalcin — Instituto de Pesquisas Jardim Botânico do Rio de Janeiro (JBRJ)
**Versão do documento:** 1.0 (primeira formalização como projeto de pesquisa)
**Data:** 2026-08-19
**Estado da produção técnica:**
- **Arquitetura:** v3.5 publicada e citável (DOI [10.5281/zenodo.21738427](https://doi.org/10.5281/zenodo.21738427)); repositório em v3.10.0; 17 ADRs (ADR-015 e ADR-016 em estado *Proposto*, demais *Aceitos*); diagramas C4 de contexto, contêiner e componente (letra desatualizada desde a ADR-016).
- **BioCultDB** (unidade de fontes secundárias): em produção, com três interfaces (Aquisição, Curadoria, Apresentação), extração de metadados de PDF por IA (absorveu o BioCultPapers, ADR-011), painel analítico e etnoChat.
- **BioCultTermos** (módulo SKOS-XL compartilhado): implementado, com API REST e exportação RDF/JSON-LD/Dublin Core/CSV; em produção apenas como módulo hospedado no BioCultDB.
- **BioCultRelatos** (unidade de registro primário, CLPI): fase inicial.
- **BioCultAcervos** (acervos museológicos e históricos): repositório e documentação apenas.
- **BioCultNaturalistas** (obras dos séculos XVII–XIX): planejamento completo (cinco entidades, roadmap de 7 fases); código não iniciado.
- **Pluriverso** (middleware de federação): planejamento completo (stack, API, contrato de harvest, C4, roadmap de 7 fases); código não iniciado.
- **Documentação normativa concluída:** Modelo de Dados Unificado (UDM) com checklist de conformidade C1–C10; caracterização Conhecimento × Evidência; contrato de harvest campo a campo com dez cenários de aceitação; referência de rótulos SKOS-XL; Proposta de Governança em três camadas (em consulta); glossário federado (`CONTEXT.md`); levantamento de iniciativas correlatas.
**Origem:** proposta inicial de "Base de Dados de Plantas Medicinais" (jan/2024, com Dra. Viviane Fonseca), sucessivamente corrigida até a arquitetura federada atual

---

## 1. Resumo

O conhecimento tradicional associado à biodiversidade (CTA) brasileira existe em duas naturezas distintas — o **Conhecimento**, enunciado por quem o detém, e a **Evidência**, atestação por terceiros de que essa relação existe — e está disperso em bibliotecas, museus, acervos históricos e bases de dados isoladas. As soluções correntes centralizam esses registros em repositórios institucionais, o que transfere para a instituição custodiante a autoridade sobre o que se publica: soberania declarada em termo de consentimento, mas não sustentada pela arquitetura.

Este projeto investiga e constrói uma alternativa: uma **arquitetura federada** em que cada comunidade ou iniciativa opera uma unidade soberana (um contêiner, um arquivo SQLite, suas ferramentas), publica apenas o que decide publicar, e é integrada por um middleware de coleta (*Pluriverso*) que indexa exclusivamente o que foi explicitamente publicado. A hipótese central é que **soberania de dados é propriedade da arquitetura, não da política de uso** — e, portanto, é verificável, auditável e reversível.

A pesquisa combina três frentes: (i) construção conceitual (modelo de dados unificado, regime enunciativo, vocabulário controlado SKOS-XL); (ii) implementação de referência em software livre (cinco ferramentas + middleware); e (iii) validação com comunidades tradicionais, com um piloto planejado junto ao povo Panará.

---

## 2. Problema de pesquisa

**Como conceber uma arquitetura de sistema, uma estrutura e padrões de dados que representem com precisão o domínio do conhecimento tradicional associado à biodiversidade — suas diferentes manifestações e fontes — e que, ao mesmo tempo, garantam em plenitude os princípios C.A.R.E. e a repartição justa e equitativa de benefícios prevista na legislação?**

O problema tem, portanto, duas faces inseparáveis. A primeira é de **representação**: o domínio do CTA se manifesta em enunciados de detentores, em atestações de terceiros, em acervos, em obras históricas e em registros de campo, e nenhum padrão vigente o descreve sem perda. A segunda é de **garantia**: representar bem não basta se a autoridade da comunidade detentora sobre o registro depender da política de uso da instituição custodiante, e não da própria arquitetura. Os princípios C.A.R.E. e a repartição de benefícios da Lei 13.123/2015 só são plenos quando têm consequência técnica verificável — campo, contrato e topologia — e não apenas cláusula declarada.

O problema desdobra-se em cinco dificuldades concretas:

1. **Ausência de proposta concreta e testada.** Não existe, na literatura científica e acadêmica, proposta de estrutura de dados concreta e testada que represente com precisão e robustez a complexidade do conjunto **dado, informação e conhecimento** tradicional associado à biodiversidade, em suas diferentes manifestações, em diferentes culturas, línguas e povos — cada qual com sua visão de mundo única. O que existe são padrões parciais (ocorrência, uso, metadado bibliográfico) e implementações institucionais fechadas, nenhuma validada como estrutura de representação desse conjunto.
2. **Dispersão heterogênea.** Quatro tipos de fonte (artigos científicos, registro primário de campo, acervos museológicos, obras de naturalistas dos séculos XVII–XIX) exigem processos de aquisição e curadoria distintos, mas precisam de um contrato de dados comum para serem relacionáveis.
3. **Assimetria de autoridade.** Um registro sobre conhecimento tradicional produzido por um terceiro é hoje governado por esse terceiro. Nenhum padrão vigente distingue formalmente *quem fala* — e é *quem fala* que deveria decidir a classificação de acesso.
4. **Vazio normativo dos dados coletivos.** A LGPD protege o titular individual; a Lei 13.123/2015 atribui titularidade coletiva ao CTA. Os dois regimes não conversam, e nenhuma implementação conhecida resolve a lacuna.
5. **Desconfiança historicamente fundamentada.** Há casos documentados de apropriação indevida (cupuaçu, ayahuasca, jaborandi, espinheira-santa, Hoodia, nim, cúrcuma, quinoa, açaí). Qualquer proposta de base de dados de CTA precisa demonstrar, tecnicamente, o que **não** consegue impedir.

---

## 3. Justificativa

**Científica.** Não há, no Brasil, modelo de dados publicado que trate a distinção Conhecimento × Evidência como propriedade de primeira classe do registro, com consequência operacional sobre a rotulagem de acesso. Os padrões de referência (Darwin Core, DwC-DP, SocioBio) tratam de ocorrência e de uso, não de regime enunciativo. A tabela `usage-policy` do DwC-DP, verificada na fonte primária, contém apenas campos de direito autoral — **nenhum** de protocolo cultural.

**Legal.** Lei 13.123/2015, Protocolo de Nagoya e CDB Art. 8(j) exigem consentimento, rastreabilidade de origem e participação dos detentores. A conformidade exige mecanismo técnico, não apenas cláusula contratual.

**Ética.** Os princípios C.A.R.E. (Collective Benefit, Authority to Control, Responsibility, Ethics) só se tornam auditáveis quando mapeados, subprincípio a subprincípio, ao componente de software que os implementa — inclusive os que ainda não têm implementação.

**Institucional.** O Modelo de Dados Unificado (UDM) é o objeto técnico do acordo de cooperação entre o JBRJ e o USEFLORA, e dialoga com o GEF "Entre-Ciências" (MCTI, 2025–2029), a Rede de Conhecimentos sobre Sociobiodiversidade (ICMBio/CNPT + UFSC) e a modernização do SISGEN (RNP-MMA-BID). A arquitetura não busca substituí-las: oferece um modelo federado adotável por qualquer uma.

---

## 4. Questões emergentes

Este projeto não parte de um conjunto fechado de questões de pesquisa. Diversas questões surgirão ao longo da pesquisa, formuladas em especial pelas **comunidades tradicionais** e pela **academia**, à medida que a arquitetura for apresentada, consultada e usada. **Responder a essas questões e demandas é a essência deste projeto** — e é o que determina o que a arquitetura precisa passar a garantir.

Questões já nomeadas em documentos técnicos permanecem registradas onde nasceram, com estado explícito: as ADRs mantêm suas questões abertas numeradas, e as pautas de validação comunitária estão listadas na seção 9.1. Nenhuma delas é tratada como decisão técnica quando a decisão pertence a quem detém o conhecimento.

---

## 5. Objetivos

### 5.1 Objetivo geral

Conceber, especificar, implementar e validar com comunidades detentoras uma arquitetura de sistema — com estrutura e padrões de dados próprios — que represente com precisão o domínio do conhecimento tradicional associado à biodiversidade em suas diferentes manifestações e fontes, e que garanta por construção, de modo verificável por terceiros, os princípios C.A.R.E. e a repartição justa e equitativa de benefícios prevista na legislação.

### 5.2 Objetivos específicos

1. **Caracterizar** o domínio do CTA em suas diferentes manifestações e fontes, formalizando a distinção entre Conhecimento e Evidência e suas consequências para a classificação de acesso.
2. **Especificar** um Modelo de Dados Unificado (UDM), independente de engine, que represente esse domínio sem perda e cuja conformidade seja verificável por ferramentas externas à federação.
3. **Mapear** cada subprincípio C.A.R.E. e cada exigência da Lei 13.123/2015 ao componente técnico que o implementa, nomeando explicitamente os que ainda não têm implementação.
4. **Definir** o contrato de publicação (*harvest*) entre unidades federadas e middleware, com condição de aceitação testável que faça da autoridade da comunidade um requisito do sistema.
5. **Implementar** a unidade de referência (fontes secundárias) e o módulo de vocabulário controlado SKOS-XL compartilhado.
6. **Implementar** as demais unidades (primária, acervos, naturalistas) e o middleware Pluriverso.
7. **Tornar rastreável pela arquitetura** — e não apenas declarada — a repartição de benefícios decorrente do uso dos registros.
8. **Formular** e submeter à consulta uma proposta de governança em três camadas (dados, ferramentas, arquitetura).
9. **Validar** a arquitetura em piloto com comunidade detentora, incluindo processo de CLPI como ciclo revisável, e responder às questões que a consulta trouxer.
10. **Publicar** os resultados como software livre, documentação citável e artigos revisados por pares.

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

1. **Como quem fala quer ser nomeado** (destrava o esquema do Relato: conciliar `assertionByID`, LGPD art. 11 e o direito ao reconhecimento previsto em CARE A1 e na Lei 13.123/2015).
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
- Promover ADR-015 a *Aceito* (depende da validação comunitária).
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
| Custo de armazenamento de mídia inviável para a comunidade | Questão explicitamente aberta; solução dependente da infraestrutura real das comunidades, não presumida |
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
- **Pós-graduação:** Luisa Ridolph e Camila Dantas, alunas da pós-graduação da Escola Nacional de Botânica Tropical (ENBT/JBRJ).
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
