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

A pesquisa combina três frentes: (i) construção conceitual (modelo de dados unificado, regime enunciativo, vocabulário controlado SKOS-XL); (ii) implementação de referência em software livre (cinco ferramentas + middleware); e (iii) validação com iniciativas de sistematização de conhecimento tradicional associado à biodiversidade, por meio dos estudos de caso do projeto **USEFLORA** e do projeto GEF MCTI **"Entre-Ciências: Territórios de Saber em Diálogo"** (Componente 03, Produto 3.2.3).

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

**Científica.** Não há, no Brasil, modelo de dados publicado que trate a distinção Conhecimento × Evidência como propriedade de primeira classe do registro, com consequência operacional sobre a rotulagem de acesso. Os padrões de referência (Darwin Core, DwC-DP, SocioBio) tratam de ocorrência e de uso, não de regime enunciativo. A tabela `usage-policy` do DwC-DP, verificada na fonte primária, contém apenas campos de direito autoral — **nenhum** de protocolo cultural. Kock et al. (2026), ao caracterizar riqueza de espécies arbóreas em Terras Indígenas na Bolívia com Red List, GBIF e BBON, mostram empiricamente o mesmo vazio no domínio de ocorrência biológica: a maioria dos dados vem de instituições internacionais sem qualquer metadado sobre contribuição indígena, o que "complicates sensitive interpretation and weakens visibility of Indigenous knowledge systems" — evidência externa e quantificada de que nenhum padrão vigente, nem para CTA nem para ocorrência, registra formalmente *quem fala*.

**Harmonização de iniciativas dispersas.** Uma arquitetura capaz de tratar, sob um contrato de dados comum, as quatro naturezas de fonte de CTA — artigos científicos, trabalho de campo junto às comunidades, coleções e acervos etnobiológicos, e registros de naturalistas — permite harmonizar iniciativas hoje dispersas e mutuamente ilegíveis. O ganho é concreto e imediato: alunos de pós-graduação, projetos de pesquisa e programas institucionais passam a consolidar dados e informações numa plataforma aberta e interoperável, em vez de em planilhas e bases isoladas que morrem com o projeto. O resultado é um corpo de dados robusto e rastreável até a fonte — condição para que a governança do CTA e a repartição justa e equitativa de benefícios possam ser exercidas sobre evidência, e não sobre estimativa.

**Legal.** Lei 13.123/2015, Protocolo de Nagoya e CDB Art. 8(j) exigem consentimento, rastreabilidade de origem e participação dos detentores. A conformidade exige mecanismo técnico, não apenas cláusula contratual.

**Ética.** Os princípios C.A.R.E. (Collective Benefit, Authority to Control, Responsibility, Ethics) só se tornam auditáveis quando mapeados, subprincípio a subprincípio, ao componente de software que os implementa — inclusive os que ainda não têm implementação.

**Institucional.** O Modelo de Dados Unificado (UDM) é o objeto técnico do acordo de cooperação entre o JBRJ e o USEFLORA, e dialoga com o GEF "Entre-Ciências" (MCTI, 2025–2029), a Rede de Conhecimentos sobre Sociobiodiversidade (ICMBio/CNPT + UFSC) e a modernização do SISGEN (RNP-MMA-BID). A arquitetura não busca substituí-las: oferece um modelo federado adotável por qualquer uma.

---

## 4. Questões emergentes

Este projeto não parte de um conjunto fechado de questões de pesquisa. Diversas questões surgirão ao longo da pesquisa, formuladas em especial pelas **comunidades tradicionais** e pela **academia**, à medida que a arquitetura for apresentada, consultada e usada. **Responder a essas questões e demandas é a essência deste projeto** — e é o que determina o que a arquitetura precisa passar a garantir.

Questões já nomeadas em documentos técnicos permanecem registradas onde nasceram, com estado explícito: as ADRs mantêm suas questões abertas numeradas. Nenhuma delas é tratada como decisão técnica quando a decisão pertence a quem detém o conhecimento.

---

## 5. Objetivos

### 5.1 Objetivo geral

Conceber, especificar, implementar e validar com iniciativas de sistematização de conhecimento tradicional associado à biodiversidade uma arquitetura de sistema — com estrutura e padrões de dados próprios — que represente com precisão o domínio do conhecimento tradicional associado à biodiversidade em suas diferentes manifestações e fontes, e que garanta por construção, de modo verificável por terceiros, os princípios C.A.R.E. e a repartição justa e equitativa de benefícios prevista na legislação.

### 5.2 Objetivos específicos

1. **Caracterizar** o domínio do CTA em suas diferentes manifestações e fontes, formalizando a distinção entre Conhecimento e Evidência e suas consequências para a classificação de acesso.
2. **Especificar** um Modelo de Dados Unificado (UDM), independente de engine, que represente esse domínio sem perda e cuja conformidade seja verificável por ferramentas externas à federação.
3. **Mapear** cada subprincípio C.A.R.E. e cada exigência da Lei 13.123/2015 ao componente técnico que o implementa, nomeando explicitamente os que ainda não têm implementação.
4. **Definir** o contrato de publicação (*harvest*) entre unidades federadas e middleware, com condição de aceitação testável que faça da autoridade da comunidade um requisito do sistema.
5. **Prospectar e avaliar** as tecnologias capazes de suportar a implementação da arquitetura — engines de persistência, formatos de serialização semântica, mecanismos de busca federada, empacotamento e distribuição, e acesso móvel *offline-first* — com critérios explícitos de soberania, custo de operação e dependência mínima.
6. **Implementar** a unidade de referência (fontes secundárias) e o módulo de vocabulário controlado SKOS-XL compartilhado.
7. **Implementar** as demais unidades (primária, acervos, naturalistas) e o middleware Pluriverso.
8. **Tornar rastreável pela arquitetura** — e não apenas declarada — a repartição de benefícios decorrente do uso dos registros.
9. **Formular** e submeter à consulta uma proposta de governança em três camadas (dados, ferramentas, arquitetura).
10. **Validar** a arquitetura junto às iniciativas de sistematização de CTA — estudos de caso do USEFLORA e do GEF MCTI "Entre-Ciências" — e responder às questões que a consulta trouxer.
11. **Publicar** os resultados como software livre, documentação citável e artigos revisados por pares.

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
| Crítica etnobiológica | Zank et al. (2025); Pankararu et al. (2026); Kock et al. (2026) — viés de proveniência em dados globais de ocorrência em Terras Indígenas |

Referências completas em [`Referencias.md`](Referencias.md), norma ABNT NBR 6023:2018.

---

## 7. Metodologia

### 7.1 Natureza

Pesquisa aplicada, de caráter **construtivo** (*design science*): o artefato — arquitetura, modelo de dados e implementação de referência — é simultaneamente o resultado e o instrumento de investigação. A validação é feita por conformidade especificada, por implementação executável e por consulta à iniciativas de sistematização de conhecimento tradicional associado à biodiversidade. Nenhuma validação desta pesquisa é feita por comunidades tradicionais: a interlocução com comunidades pertence às iniciativas que já a mantêm, e é por meio delas que as questões comunitárias chegam à arquitetura.

### 7.2 Procedimentos

1. **Documentação por decisão registrada.** Toda escolha arquitetural é registrada como ADR (*Architecture Decision Record*), com estado explícito (`Proposto` / `Aceito`), pontos numerados e questões abertas nomeadas. Dezessete ADRs produzidos até a data.
2. **Modelagem C4.** Documentação em quatro níveis (Contexto, Contêiner, Componente, Código).
3. **Linguagem ubíqua.** Glossário federado único (`CONTEXT.md`) governa os termos que atravessam todos os repositórios; termos internos vivem no repositório da ferramenta.
4. **Contrato antes de código.** O contrato de *harvest* é especificado campo a campo, com dez cenários de aceitação, antes da implementação das unidades que o cumprirão.
5. **Implementação de referência.** Software livre, contêineres pequenos, dependências mínimas, persistência em arquivo único SQLite+JSON1 por unidade.
6. **Validação por estudo de caso.** A arquitetura é submetida a iniciativas de sistematização de CTA — USEFLORA e GEF MCTI "Entre-Ciências" — como conjuntos de dados reais e como interlocução técnica: cada estudo de caso testa a conformidade do UDM, o contrato de *harvest* e a suficiência do vocabulário SKOS-XL. Pautas que dependem de decisão comunitária são levadas às iniciativas como perguntas abertas, não como decisões a ratificar.

### 7.3 Estudos de caso por unidade

Cada unidade da federação tem um estudo de caso próprio, que fornece o conjunto de dados real, os requisitos de visualização e a crítica de usabilidade que orientam sua especificação. Nenhuma unidade é projetada sobre requisito presumido.

| Unidade | Estudo de caso | Origem |
|---|---|---|
| **BioCultDB** (fontes secundárias) | Subconjunto de dados de CTA do **USEFLORA** e literatura acadêmica; curadoria do Campo Semântico "Tipos de Usos de Plantas" (713 termos brutos → 332 conceitos SKOS-XL) | Acordo de Cooperação Técnica JBRJ ↔ USEFLORA |
| **BioCultNaturalistas** (obras dos séc. XVII–XIX) | **"Da Obra Histórica à Exsicata Digital: A Salvaguarda do Conhecimento Biocultural e a Resiliência do Uso de Plantas no Brasil"** — mestrado de Camila Nascimento Dantas (orientação Dra. Viviane Stern da Fonseca-Kruel) | PPG em Botânica, ENBT/JBRJ; iniciado no âmbito do Projeto CESP/GBIF ID 015-2024 |
| **BioCultRelatos** (registro primário, CLPI) | **"O Uso de Plantas Medicinais e os Saberes Locais em Quintais de Silveiras (SP): diante de desafios climáticos e socioeconômicos no entorno da Serra da Bocaina"** — mestrado de Luisa Ridolph Tostes Braga (orientação Dra. Viviane Stern da Fonseca-Kruel; coorientação Dr. Nivaldo Peroni) | PPG em Botânica, ENBT/JBRJ |
| **BioCultAcervos** (acervos museológicos) | **Coleção Etnobotânica do JBRJ (RBetno)** — acervo de matérias-primas e artefatos vegetais registrado no *Index Herbariorum* desde 2012, catalogado no sistema Jabot, com digitalização 2D descrita em Fonseca-Kruel et al. (2026) | Coleções do JBRJ |
| **Pluriverso** (middleware) | Federação das unidades acima mais o **GEF MCTI "Entre-Ciências"** (Componente 03, Produto 3.2.3) como consumidor de dados harmonizados | RNP / IEB / JBRJ |

**O que cada mestrado exige da arquitetura.** O trabalho de Camila Dantas sistematiza as espécies registradas em comum na *Historia Naturalis Brasiliae* (Piso & Marcgrave, 1648) e no *Systema Materiae Medicae Vegetabilis Brasiliensis* (Martius, 1843), confronta-as com exsicatas de metadados etnobotânicos em repositórios digitalizados (JABOT, Reflora) e cruza as localidades em SIG com Territórios Tradicionais e Unidades de Conservação. Disso decorrem requisitos diretos do **BioCultNaturalistas**: nomenclatura pré-linneana transposta para o sistema binomial sem perder a grafia original; nomes vernaculares rastreados na persistência, variação ou substituição entre séculos; atribuição de autoria aos detentores silenciados sob a homogeneização linguística do "tupi" — que é exatamente o problema do regime enunciativo (ADR-015) aplicado à fonte histórica; e evidência física (exsicata) ligada ao enunciado de uso. Hoje esses dados são mantidos em plataforma externa (GRIST), o que torna o mestrado também um teste de migração e de conformidade do UDM.

O trabalho de Luisa Ridolph inventaria o Conhecimento Ecológico Local sobre plantas medicinais em quintais de Silveiras (SP) — município integralmente decretado APA, portal de entrada do PARNA Serra da Bocaina, altitudes de 615 a 1.800 m — por entrevistas semiestruturadas em amostragem estratificada, sob TCLE, aprovação da CONEP (Resolução CNS 466/2012) e submissão ao SisGen, com devolutiva dos resultados à comunidade. Disso decorrem requisitos diretos do **BioCultRelatos**: registro primário enunciado por quem detém o conhecimento (indicação de uso, modo de preparo, dosagem, contraindicação); consentimento como ciclo revisável, e não como formulário; dado sociodemográfico do participante sob LGPD convivendo com titularidade coletiva do CTA; coordenada de quintal como dado sensível; e devolutiva como função da própria ferramenta, não como anexo do projeto.

Os dois mestrados cumprem, além do papel de fonte de requisitos, a função descrita na justificativa: são o caso concreto de trabalho de pós-graduação que consolida dados numa plataforma aberta e interoperável, em vez de em base isolada que termina com a dissertação.

### 7.4 Decisões arquiteturais estruturantes

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

## 8. Cronograma por fases

Fases lógicas, encadeadas por dependência e não por calendário fixo: a Fase B depende da agenda das iniciativas parceiras, que não é do pesquisador.

| Fase | Escopo | Depende de |
|---|---|---|
| **A — Fundação conceitual** ✔ | UDM, regime enunciativo, contrato de harvest, governança proposta, unidade de referência em produção | — |
| **B — Validação por estudos de caso** | Submissão do UDM, do contrato de harvest e do vocabulário aos estudos de caso do USEFLORA e do GEF MCTI "Entre-Ciências"; consolidação das questões que retornarem | Agenda das iniciativas parceiras |
| **C — Fechamento normativo** | ADR-015 e ADR-016 a *Aceito*; esquema do Relato; licenciamento; Comitê Federado constituído | B |
| **D — Implementação da federação** | BioCultRelatos; Pluriverso; BioCultTermos nas quatro hospedeiras | C (parcialmente paralelizável com B) |
| **E — Expansão de fontes** | BioCultAcervos; BioCultNaturalistas; integrações taxonômica e territorial | D |
| **F — Avaliação** | Execução ponta a ponta nos estudos de caso; auditoria externa; medição de conformidade C1–C10 | B, D |
| **G — Publicação** | Artigos revisados por pares; versão citável consolidada; disseminação às iniciativas correlatas | F |

---

## 9. Resultados esperados

1. Arquitetura federada especificada, implementada e validada em uso real, adotável por qualquer iniciativa nacional.
2. Modelo de Dados Unificado com conformidade declarável por ferramentas de terceiros.
3. Cinco ferramentas e um middleware em software livre, todos containerizados e de dependência mínima.
4. Proposta de governança validada pelas iniciativas de sistematização de CTA e por Comitê Federado constituído.
5. Evidência empírica, dos estudos de caso, sobre se a soberania garantida por arquitetura é verificável por terceiros e reconhecida pelas iniciativas que a adotam.
6. Artigos revisados por pares sobre o regime enunciativo e sobre a arquitetura federada como resposta à lacuna dos dados coletivos.

---

## 10. Equipe e parcerias

**Proponente:** Eduardo Dalcin (JBRJ)

**Interlocução conceitual, técnica e ética:** Dra. Viviane Fonseca (JBRJ), Lucas Zelesco (FUNAI), Comitê Gestor USEFLORA, Luisa Ridolph (ENBT/JBRJ) e Camila Dantas (ENBT/JBRJ).

---

## 11. Documentos de referência do projeto

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
