# Plano de Elaboração — Proposta de Governança

## Context

Criar **`governanca/propostaGovernanca.md`** no repositório `Arquitetura-BioCultural` (v3.3): uma proposta de governança em três camadas — (1) **dados e informações** de conhecimento tradicional associado à biodiversidade (CTA), que é o núcleo e a maior parte do documento; (2) **ferramentas** que compõem a plataforma (BioCultDB, BioCultPapers, BioCultRelatos, BioCultAcervos, BioCultNaturalistas, BioCultTermos, Pluriverso); (3) **arquitetura** em si (como ela evolui e quem decide).

O documento é fundamentado em pesquisa bibliográfica real (princípios C.A.R.E., soberania de dados indígenas, LGPD, Lei 13.123/2015, Protocolo de Nagoya, Convenção 169 OIT, casos documentados de apropriação indevida), tem **ilustrações SVG+PNG no mesmo sistema visual** de `docs/images/arquitetura-biocultural.svg`, e trata **explicitamente** o receio de lideranças e comunidades quanto ao mau uso dos dados (indústria farmacêutica, bioprospecção, pesquisa extrativa). Encerra com **"Referências Bibliográficas"** em ABNT NBR 6023:2018 (convenção já usada em `Referencias.md`).

Nenhum código é escrito. Entregável: 1 documento markdown + 4 ilustrações (SVG fonte + PNG embutido) + link no README + entrada no CHANGELOG.

A elaboração é **dividida em 6 etapas com checkpoint humano ao final de cada uma** (o usuário pediu explicitamente): ao terminar cada etapa o executor usa a ferramenta `ask` com as opções `Continuar para a Etapa N+1` / `Parar aqui (retomo depois)` e **para de fato** se a resposta for parar. O documento fica coerente e legível ao final de qualquer etapa (nunca com seção vazia ou `TODO` — seções ainda não escritas simplesmente não existem no arquivo até sua etapa).

---

## Fatos verificados no repositório (base para o documento)

Confirmados por leitura nesta sessão — o executor não precisa reinvestigar, mas deve reler os arquivos antes de citar trechos literais:

| Fato | Fonte no repo |
|---|---|
| 4 tipos de membro da federação; cada um = 1 container + 1 arquivo SQLite+JSON soberano | `README.md` §"Tipos de Membros da Federação" |
| Pluriverso: harvest REST periódico só de `visibility: public`; índice derivado, nunca fonte da verdade; mapeamento SKOS-XL; saída reversível (`purge_by_member`) | `README.md` §"Princípios da Federação"; ADR-004 D3/D4/D6 |
| Pluriverso é instanciável em múltiplos escopos, **sem hierarquia**, cada instância com seu próprio Comitê Federado | `README.md` §"Múltiplas Instâncias"; ADR-009 |
| **Comitê Federado** já existe como decisão arquitetural (ADR-004 D3): decide admissão/remoção por consenso ou maioria qualificada | ADR-006 §Contexto |
| Protocolo de inscrição: fila `pending → active \| rejected`, `care_declaration` como campo obrigatório do pedido, probe técnico é sinal e não gate, `member_id` nunca reciclado, autenticação do Comitê (E4) é **bloqueador não resolvido** | ADR-006 E1–E5 + tabela `membership_requests` |
| Modelo de dados já prevê: `visibility: public \| restricted \| private \| community-only`, `restrictions.{reason,allowedRoles,allowedUsers,allowedCommunities}`, `permissions.hiddenFields` (ex.: `location.coordinates`, `community.name`, `source.primary.informants`), `community.consent.{obtained,date,type:"free_prior_informed",document,authorizedBy}`, `verifiedByCommunity`, informante `anonymized` | ADR-003 (linhas ~209, 259–299, 342–350, 586–602) |
| ADR-003 está **"Proposto — aguardando validação com comunidades e pesquisadores"**; próxima revisão após piloto com 3 comunidades | ADR-003 §Status |
| BioCultTermos é submodule git compartilhado; repositório standalone congelado; evolução ocorre a partir das unidades hospedeiras | `README.md` §BioCultTermos; ADR-007 |
| Licença do projeto: **"A definir — considerando licenças que respeitem os princípios C.A.R.E."** — lacuna real a resolver na proposta | `README.md` §Licença |
| 29 classificações de comunidades conforme Decreto 8.750/2016 já usadas no BioCultDB | `README.md` §BioCultDB |
| Iniciativas complementares e seus modelos de governança: GEF Entre-Ciências (MCTI, 2025-2029), RCS (ICMBio/CNPT+UFSC), Modernização SISGEN (RNP-MMA-BID), Useflora (2 níveis de acesso, cadastro comunitário) | `docs/iniciativas/README.md` |
| Desafios já mapeados: conectividade, capacitação, **confiança (histórico de biopirataria gera resistência)**, sustentabilidade pós-financiamento, complexidade institucional, diversidade cultural | `docs/iniciativas/README.md` §"Desafios Comuns" |
| Bibliografia existente em ABNT NBR 6023:2018 (12 seções), com CARE, FAIR, Nagoya, OIT 169, NIKMAS, OAIS, XACML | `Referencias.md` |
| Artigos do autor e coautorias já citáveis: Pankararu et al. 2026 (*npj Biodiversity*, DOI 10.1038/s44185-026-00121-0); Zank et al. 2025 (*J Ethnobiol Ethnomed*, DOI 10.1186/s13002-024-00750-4); posts do blog `eduardo.dalc.in`; DOI da arquitetura `10.5281/zenodo.21396738` | `README.md` §Referências |
| `docs/PrincipiosCAREnaPratica.md` já traduz CARE como Coletividade/Autonomia/Capacidade de Resposta/Equidade — **divergente** da tradução do README (Collective Benefit/Authority to Control/Responsibility/Ethics) | ambos os arquivos |

**Decisão sobre a divergência de tradução do CARE:** o novo documento adota a nomenclatura oficial da GIDA/Carroll et al. 2020 em inglês com tradução entre parênteses — *Collective Benefit* (Benefício Coletivo), *Authority to Control* (Autoridade para Controlar), *Responsibility* (Responsabilidade), *Ethics* (Ética) — igual ao README, que é o documento canônico. Não reescrever `PrincipiosCAREnaPratica.md`; apenas citá-lo como leitura complementar.

---

## Insumos de pesquisa (produzidos nesta sessão)

Quatro relatórios de pesquisa em PT-BR foram produzidos como **artefatos de sessão** — não são versionados neste repositório (existem apenas como `local://` na sessão que gerou este plano). A tabela abaixo resume o que cada um continha; a íntegra foi lida e incorporada ao conteúdo de `governanca/propostaGovernanca.md` e à bibliografia consolidada durante a Etapa 1:

| Relatório (artefato de sessão, não versionado) | Conteúdo | Volume |
|---|---|---|
| Pesquisa CARE | CARE: origem (workshop Gaborone, 8/11/2018), sub-princípios C1–C3/A1–A3/R1–R3/E1–E3 **transcritos em inglês + tradução PT-BR**, literatura pós-2021 (biodiversidade/GBIF, genômica, arquivos, IA), tensão FAIR×CARE, produção brasileira, e tabela `sub-princípio → mecanismo → componente da arquitetura → status (atendido/parcial/gap)` | ~35 KB, 24 refs |
| Pesquisa Jurídica | LGPD artigo por artigo (5º, 6º, 7º+§4º, 9º, 11+§1º, 18, 33–36, 37–38, 41, 46–49, 42§3º), lacuna dos dados coletivos, Lei 13.123/2015 (arts. 2º III, 9º+§1º, 10§1º, 12, 19–22, 27), Decreto 8.772/2016 (+10.844/2021, 13.014/2026), CGen, SisGen, Nagoya (5, 7, 12), OIT 169 (6º, 7º), UNDRIP 31, TIRFAA, WIPO GRATK, CF 231/215/216, Decreto 3.551/2000, Lei 9.610/1998, CC art. 20, e tabela `norma → exigência → o que implementar` (19 linhas) | ~56 KB, 24 refs |
| Pesquisa Técnica | Listas oficiais completas de **20 TK Labels**, **10 BC Labels** e **12 Notices** (com siglas), Local Contexts Hub API v2, GBIF IDGov Task Group (28/07/2025), GBIF sensitive-species best practices (4 categorias de generalização), termos Darwin Core de restrição, Mukurtu/Ara Irititja, PROV-O, DUO, ODRL, dynamic consent, SKOS-XL para rótulos sensíveis, Cali Fund/DSI, OWASP ASVS 5.0/Top 10:2025, SQLCipher — cada item com veredito **ADOTAR / ADAPTAR / DESCARTAR** para a stack Node+SQLite+Docker | ~30 KB, 27 refs |
| Pesquisa Riscos e Casos | 12 casos de apropriação indevida (10 com nº de patente/marca e desfecho verificados), literatura de desconfiança (data colonialism, helicopter research, ISE/SOLAE), o dilema da documentação defensiva (TKDL) com argumentos dos dois lados, 9 protocolos/conselhos comunitários reais (Wajãpi, Munduruku, Juruna, Krenak, quilombolas do Vale do Ribeira, Te Mana Raraunga, OCAP®, GIDA, NNI), erosão intergeracional, repatriação digital, crítica ao ABS pós-Nagoya | ~39 KB, 33 refs |

### Correções obrigatórias — erros a NÃO repetir no documento

Levantados pela pesquisa contra fonte primária. Cada um deles apareceria naturalmente no texto se ninguém avisasse:

1. **Decreto 8.750/2016 ≠ regulamento da Lei 13.123/2015.** O 8.750/2016 institui o **CNPCT** (e é a fonte correta das 29 classificações de comunidades já usadas no BioCultDB). Quem regulamenta a Lei da Biodiversidade é o **Decreto 8.772/2016**, alterado pelo **Decreto 10.844/2021** e pelo **Decreto 13.014/2026**. Citar os dois, com papéis distintos.
2. **Não existe "Decreto 10.219/2020" sobre patrimônio genético** — esse decreto trata de classificação de risco de atividade econômica. Não citar.
3. **O tratado da OMPI sobre PI, recursos genéticos e CT associado foi adotado em Genebra, 24/05/2024** (*WIPO Treaty on Intellectual Property, Genetic Resources and Associated Traditional Knowledge*). **Não** é o "Tratado de Riad" — o Riyadh Design Law Treaty (22/11/2024) é sobre desenho industrial. Confundir os dois destrói a credibilidade da seção internacional.
4. **`gida-global.org/care` retornou HTTP 404** em julho de 2026. Citar o PDF oficial (`gida-global.org/s/CAREPrinciples_OnePagersFINAL_Oct_17_2019.pdf`) e a captura do Wayback Machine, e recomendar em §8.1 que o projeto **auto-hospede** cópia dos documentos normativos que cita.
5. **Os sub-princípios CARE não foram lidos no PDF original** (apenas em cinco reproduções secundárias idênticas: RDA, The Turing Way, UK Data Service, ARDC, NFDI4Culture). Antes de publicar, baixar o PDF da GIDA e conferir o texto literal — está registrado como pendência no relatório de pesquisa CARE.
6. **Anderson & Hudson (2020) descreve seis BC Labels; hoje são dez.** Ao citar o artigo, citar o número do artigo; ao listar os rótulos, usar a lista atual de `localcontexts.org` (relatório de pesquisa técnica) e dizer que o conjunto cresceu.
7. **Não afirmar parceria Local Contexts × Atlas of Living Australia** — não confirmada. A ALA opera sistema próprio de generalização, independente dos Labels.
8. **O coautor do guia GBIF de 2008 aparece grafado de duas formas no próprio documento** ("Grafton O" na página de controle, "Oliver" no corpo). Citar pelo DOI `10.15468/doc-b02j-gt10` e usar a grafia da página de controle.
9. **`[NÃO VERIFICADO]` significa "não entra"**: IEEE 2890-2025, "GIDA manifesto 2024", desfecho do caso Sambazon, artigo específico de Wynberg/Foster sobre Hoodia, acórdão do TCU citado direto, casos kava e andiroba/copaíba como casos nominais. Para kava e andiroba/copaíba: se citados, apresentar como **padrão documentado na literatura**, nunca como caso com patente e desfecho nominais.

### Achados que o documento precisa carregar (não são opcionais)

Cada um resolve uma seção inteira; a ausência de qualquer um deles empobrece o documento a ponto de descaracterizá-lo:

- **A lacuna dos dados coletivos tem endereço exato** (§3.4): LGPD, art. 5º, V e art. 17 constroem a titularidade sobre a **pessoa natural**; a Lei 13.123/2015, art. 10, §1º diz literalmente que *"qualquer conhecimento tradicional associado ao patrimônio genético será considerado de natureza coletiva, ainda que apenas um indivíduo de população indígena ou de comunidade tradicional o detenha"*. Os dois regimes não conversam. A LGPD só oferece coletivização **processual** (art. 42, §3º — ação coletiva de reparação), não titularidade coletiva substantiva. A EC 115/2022 (CF, art. 5º, LXXIX) elevou proteção de dados a direito fundamental mantendo o desenho individual.
- **Dado sensível por associação** (§3.2 e §5.11): LGPD, art. 11, §1º estende a proteção a *"qualquer tratamento de dados pessoais que revele dados pessoais sensíveis"*. Um relato que identifique o povo/etnia do detentor revela dado sensível (art. 5º, II — origem racial ou étnica, convicção religiosa) **mesmo sem um campo "etnia"**. Consequência direta: a ficha de proveniência inteira do BioCultRelatos é dado sensível, não só um campo.
- **`visibility: public` não dispensa CLPI** (§5.3): o art. 7º, §4º da LGPD dispensa consentimento para dado *"tornado manifestamente público pelo titular"* — quem publica na federação é a plataforma, não o titular; a dispensa não se aplica.
- **As quatro formas legais de comprovar consentimento** (§5.3), à escolha da comunidade — Lei 13.123/2015, art. 9º, §1º: I termo assinado; II **registro audiovisual**; III parecer de órgão oficial competente; IV **adesão na forma de protocolo comunitário**. O inciso IV é a ponte jurídica direta para o art. 12 do Protocolo de Nagoya (direito costumeiro e protocolos comunitários) e para o campo estruturado `consent.protocolReference`.
- **Repartição de benefícios tem números** (§5.9): Lei 13.123/2015, art. 19 (modalidades monetária e não monetária, com a lista de não monetárias), art. 20 (**1% da receita líquida anual**), art. 21 (redução até **0,1%** por acordo setorial), FNRB; sanções no art. 27 (multa de R$ 1.000 a R$ 100.000 para pessoa natural, R$ 10.000 a R$ 10.000.000 para pessoa jurídica) e Decreto 8.772/2016, art. 83 (tipifica acesso a CTA identificável sem consentimento).
- **O tríplice regime do registro audiovisual** (§5.3): Código Civil, art. 20 (imagem e palavra) + LGPD, art. 11 (dado sensível) + Lei 13.123/2015, art. 9º, §1º, II (forma de comprovação do consentimento) — um único termo de CLPI deve cobrir as três bases, com consentimento específico e destacado.
- **A generalização geográfica já é padrão, e tem degraus** (§5.2): GBIF/Chapman (2020) — Categoria 1 (não liberar), 2 (0,1° ≈ 10 km), 3 (0,01° ≈ 1 km), 4 (0,001° ≈ 100 m); **generalizar, nunca randomizar**; princípio 7 do documento: campo restringido **nunca fica nulo ou vazio** — é substituído por texto explicativo; e toda sensibilidade tem **data de revisão obrigatória**. Isso se traduz nos termos Darwin Core `dwc:informationWithheld`, `dwc:dataGeneralizations`, `dcterms:accessRights` e `dcterms:license`, todos padrão e mapeáveis 1:1 para JSON.
- **Rótulo cultural não é licença** (§5.5): Creative Commons rege direito autoral; TK/BC Labels expressam protocolo cultural, que frequentemente não é matéria de direito autoral. Manter `dcterms:license` e a camada de protocolo como campos **distintos e nunca fundidos**.
- **O caminho escolhido já é o do GBIF** (§5.5 e §7.3): o GBIF instituiu em **28/07/2025** um *Task Group on Indigenous Data Governance*, presidido por Lydia J. Jennings, cujo segundo eixo é pilotar TK/BC Labels em registros de ocorrência com três comunidades reais (Sarayaku/Equador, Te Whakatōhea/Nova Zelândia, Te Pu Atiti'a/Polinésia Francesa), com o objetivo declarado de tornar o Darwin Core compatível com CARE. Usar como precedente institucional, não como invenção do projeto.
- **O vácuo regulatório do dado** (§5.9): o regime de ABS foi desenhado para **material genético físico**; a Informação de Sequência Digital (DSI) levou à criação do **Cali Fund** (Decisão CBD/COP/DEC/16/2, COP16 Cali, 2/11/2024; lançado em 25/02/2025 na sessão retomada em Roma). Uma plataforma **de dados sobre CTA** está exatamente nesse vácuo — a legislação vigente pode não cobrir o caso. Posição do documento: os logs de uso devem ser desenhados como **evidência auditável e exportável**, compatível com mecanismos multilaterais, sem que a plataforma opere qualquer fundo.
- **OCAP® separa titularidade de posse** (§5.1 e §6.1): Ownership, Control, Access, **Possession** (FNIGC, princípios de 1998). A arquitetura implementa *Possession* de forma exemplar (1 container + 1 SQLite por unidade) mas **não distingue formalmente titularidade de posse** — nomear isso como distinção conceitual em §5.1.
- **A perda geracional tem evidência quantitativa** (§5.10): Reyes-García et al. (2009), entre os Tsimane' (Amazônia boliviana), mediram transmissão vertical (pais) **e oblíqua** (gerações mais velhas que não os pais), com associação **maior na oblíqua** — o que sustenta a diretriz de priorizar relatos de anciãos e tratar a transmissão oblíqua como via de revitalização, não só de registro.
- **Repatriação digital não é restituição** (§5.10, e limite honesto de §4.3): a literatura debate a devolução digital como possível substituto cínico da devolução física. BioCultAcervos e BioCultNaturalistas lidam justamente com material sobre comunidades que **nunca consentiram** — o documento deve reconhecer o limite em vez de apresentar acesso por API como solução do problema histórico.
- **Consentimento não é perpétuo** (§5.3, §5.4): CARE **E3** (uso futuro) implica reavaliação periódica; *dynamic consent* (Kaye et al., 2015) modela consentimento como relação revisável. Adotar o princípio como **log append-only versionado por registro**, descartando o portal dedicado do projeto original.
- **"Acesso não é autoridade"** (§5.12): dado publicamente acessível não implica consentimento para treinar modelos. Codificar como compromisso negativo **antes** de qualquer busca semântica com IA/embeddings sobre dados federados — o Pluriverso já prevê busca semântica. Não há literatura peer-reviewed específica sobre CARE + IA generativa (lacuna real registrada no relatório de pesquisa CARE) — afirmar o princípio, não inventar citação.

### Citações-âncora com DOI conferido nesta sessão

Resolvidas via CrossRef/fonte oficial durante o planejamento — podem ser citadas sem nova verificação:

- CARROLL, S. R. et al. The CARE Principles for Indigenous Data Governance. **Data Science Journal**, v. 19, n. 1, art. 43, 2020. DOI: 10.5334/dsj-2020-043.
- CARROLL, S. R.; HERCZOG, E.; HUDSON, M.; RUSSELL, K.; STALL, S. Operationalizing the CARE and FAIR Principles for Indigenous data futures. **Scientific Data**, v. 8, art. 108, 2021. DOI: 10.1038/s41597-021-00892-0.
- JENNINGS, L.; ANDERSON, T.; MARTINEZ, A.; STERLING, R.; DAVID-CHAVEZ, D.; GARBA, I.; HUDSON, M.; GARRISON, N. A.; CARROLL, S. R. Applying the 'CARE Principles for Indigenous Data Governance' to ecology and biodiversity research. **Nature Ecology & Evolution**, v. 7, n. 10, p. 1547–1551, 2023. DOI: 10.1038/s41559-023-02161-2. *(autoria e veículo conferidos)*
- ANDERSON, J.; HUDSON, M. The Biocultural Labels Initiative: Supporting Indigenous rights in data derived from genetic resources. **Biodiversity Information Science and Standards**, v. 4, art. e59230, 2020. DOI: 10.3897/biss.4.59230. *(conferido; descreve seis BC Labels)*
- CHAPMAN, A. D. **Current Best Practices for Generalizing Sensitive Species Occurrence Data**. Copenhagen: GBIF Secretariat, 2020. DOI: 10.15468/doc-5jp4-5g10. *(conferido no documento oficial: 10 princípios, 4 categorias)*
- PRESTES, F. P.; PREVE, D. R.; BONA, M. T. de. Controles de proteção de dados pessoais dos povos indígenas implementados na FUNAI. **JURIS**, v. 34, n. 1, 2024. DOI: 10.14295/juris.v34i1.17613. *(conferido — única referência doutrinária brasileira localizada que cruza LGPD e povos indígenas)*
- HUDSON, M. et al. Rights, interests and expectations: Indigenous perspectives on unrestricted access to genomic data. **Nature Reviews Genetics**, v. 21, n. 6, p. 377–384, 2020. DOI: 10.1038/s41576-020-0228-x.
- CHRISTEN, K. Tribal Archives, Traditional Knowledge, and Local Contexts: Why the 's' Matters. **Journal of Western Archives**, v. 6, n. 1, art. 3, 2015. DOI: 10.26077/78d5-47cf.
- CHRISTEN, K.; ANDERSON, J. Toward slow archives. **Archival Science**, v. 19, n. 2, p. 87–116, 2019. DOI: 10.1007/s10502-019-09307-x.
- REYES-GARCÍA, V. et al. Cultural transmission of ethnobotanical knowledge and skills: an empirical analysis from an Amerindian society. **Evolution and Human Behavior**, v. 30, n. 4, p. 274–285, 2009. DOI: 10.1016/j.evolhumbehav.2009.02.001.
- COULDRY, N.; MEJIAS, U. A. Data colonialism: rethinking big data's relation to the contemporary subject. **Television & New Media**, v. 20, n. 4, p. 336–349, 2019. DOI: 10.1177/1527476418796632.
- Além de FAIR (WILKINSON et al., 2016 — DOI 10.1038/sdata.2016.18) e das duas referências já no repositório que devem ser reaproveitadas: PANKARARU et al. (2026) *npj Biodiversity* DOI 10.1038/s44185-026-00121-0 e ZANK et al. (2025) *J. Ethnobiol. Ethnomed.* DOI 10.1186/s13002-024-00750-4 — ambas com coautoria/tema diretamente ligados a esta arquitetura.

## Sistema visual das ilustrações (extraído de `docs/images/arquitetura-biocultural.svg`)

Tokens **literais** a reusar. Toda nova ilustração usa exclusivamente esta paleta e estes padrões — nada de gradientes, sombras, ícones externos, fontes web ou emojis.

```
Fundo da tela      #FAF6EF
Título             #37312A  font-size 31  font-weight bold  text-anchor middle
Subtítulo          #7A7065  font-size 17  text-anchor middle
Corpo / rótulo     #7A7065  font-size 11.5
Destaque no corpo  #37312A  font-size 11.5–16.5
Acento/alerta      #B4542F  font-size 11
Fonte              font-family="Helvetica, Arial, sans-serif" (atributo no <svg> raiz)

Card               <rect rx="14" fill="#FFFFFF" stroke="#D9CBB4" stroke-width="1.5">
Faixa de cabeçalho <path d="M{x} {y+14} a14 14 0 0 1 14 -14 h{w-28} a14 14 0 0 1 14 14 v22 h-{w} z" fill="{cor do tema}">
Texto da faixa     #FFFFFF  font-size 12.5  bold  letter-spacing 0.6  (CAIXA ALTA)
Pílula             <rect rx="13" height="26" fill="{tint do tema}"> + texto 11.5 na cor do tema
Cilindro de banco  path + ellipse, fill #F3EDE2 / #FFFFFF, stroke #C9B79C stroke-width 1.4
Seta tracejada     stroke #8C8377 stroke-width 2 stroke-dasharray "7 5" marker-end url(#arrow)
Seta sólida verde  stroke #2E6B4F stroke-width 2.2 marker-end/start url(#arrowG)
Bloco-destaque     <rect rx="18" fill="#2E6B4F"> com texto branco e pílulas internas #3D7C5E
Card de princípio  <rect rx="12" fill="#FFFFFF" stroke="#D9CBB4" stroke-width="1.3"> (rodapé, 3 colunas)

Temas de cor (faixa / tint da pílula / texto na pílula):
  verde     #2E6B4F / #E4EFE7 / #2E6B4F   → federação, soberania, coletivo
  terracota #B4542F / #FBEBE2 / #B4542F   → consentimento, alerta, fontes primárias
  ocre      #A8801F / #F6EFDC / #8A6A19   → acervos, memória, preservação
  azul      #3D5A80 / #E7EDF5 / #3D5A80   → histórico, jurídico, auditoria

Markers obrigatórios em <defs> (copiar literalmente do arquivo existente):
  id="arrow"  path fill #8C8377 · id="arrowG" path fill #2E6B4F
```

Cabeçalho do SVG, idêntico ao padrão existente:
`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" width="{W}" height="{H}" font-family="Helvetica, Arial, sans-serif">`

### Geração do PNG

O repositório embute PNG no markdown (`README.md` usa `docs/*.png`) mantendo o SVG como fonte. **Não há** `rsvg-convert`, `inkscape` nem ImageMagick nesta máquina (verificado: só `C:\Windows\System32\convert.exe`, que é o utilitário de FAT→NTFS); Node v22.23.0 disponível.

Rota padrão: ferramenta `browser` — `open` com `url: "file:///D:/git/Arquitetura-BioCultural/docs/<nome>.svg"` e `viewport: {width: W, height: H, scale: 2}`, depois `run` com `tab.screenshot({ fullPage: false })`, e mover o arquivo retornado para `docs/<nome>.png`.
**Contingência:** se o screenshot sair com barra de rolagem, faixa branca ou dimensão errada, envolver o SVG em um HTML temporário com `<style>html,body{margin:0;background:#FAF6EF}</style>` e screenshot do elemento (`tab.screenshot({selector:"svg"})`). Se a rota browser falhar por completo, usar `npx -y sharp-cli --input docs/<nome>.svg --output docs/<nome>.png resize {W*2}`. Se nenhuma funcionar, **embutir o `.svg` diretamente no markdown** (`![alt](nome.svg)` — GitHub renderiza SVG) e registrar a ausência do PNG numa linha do CHANGELOG. Em nenhuma hipótese entregar imagem embutida quebrada.

---

## Estrutura definitiva de `governanca/propostaGovernanca.md`

Títulos exatos, na ordem exata. `##` = seção de primeiro nível do documento.

```
# Proposta de Governança — Arquitetura BioCultural
  (bloco de abertura: status "Proposta para consulta", versão de referência 3.3, data,
   nota de que o documento é submetido à validação de comunidades e do Comitê Federado)

## 1. Por que uma proposta de governança
## 2. Escopo: três camadas de governança          [ilustração 1]
## 3. Fundamentos éticos e legais
### 3.1 Os princípios C.A.R.E. e a tensão com FAIR
### 3.2 Marco legal brasileiro (LGPD, Lei 13.123/2015, Decreto 6.040/2007, CF art. 231/215-216)
### 3.3 Marco internacional (CDB art. 8(j), Nagoya, OIT 169, UNDRIP art. 31, OMPI)
### 3.4 A lacuna dos dados coletivos: onde a LGPD não alcança o CTA
## 4. O receio legítimo: por que comunidades desconfiam de bancos de dados
### 4.1 O que já aconteceu (casos documentados de apropriação indevida)
### 4.2 O dilema da documentação: registrar protege ou expõe?
### 4.3 As sete salvaguardas desta arquitetura contra o mau uso
## 5. Governança dos dados e informações        ← núcleo do documento
### 5.1 Titularidade: de quem é o dado
### 5.2 Classificação de sensibilidade e camadas de acesso   [ilustração 2]
### 5.3 CLPI como processo contínuo, não como formulário     [ilustração 3]
### 5.4 Ciclo de vida do dado: da consulta prévia à revogação
### 5.5 Rotulagem cultural: TK/BC Labels e Notices
### 5.6 Proveniência, atribuição e o direito de ser citado
### 5.7 Curadoria e validação comunitária
### 5.8 Vocabulários sensíveis no BioCultTermos
### 5.9 Repartição de benefícios rastreável                  [ilustração 4]
### 5.10 Preservação digital e retorno do dado à comunidade
### 5.11 Conformidade LGPD na prática (papéis, RIPD, direitos do titular)
### 5.12 O que a plataforma nunca fará (compromissos negativos)
## 6. Governança das ferramentas
### 6.1 Instâncias de decisão e papéis
### 6.2 Ciclo de vida do código e das versões
### 6.3 Segurança como requisito de governança
### 6.4 Licenciamento de código, dados e conteúdo
### 6.5 Sustentabilidade e continuidade
## 7. Governança da arquitetura
### 7.1 Como a arquitetura evolui (ADRs e versionamento)
### 7.2 Quem decide o quê (matriz de decisão)
### 7.3 Interoperabilidade com iniciativas nacionais
## 8. Implementação: do documento à prática
### 8.1 Lacunas abertas nesta proposta
### 8.2 Sequência de adoção sugerida
### 8.3 Indicadores de governança
## 9. Referências Bibliográficas
```

**Regras de escrita, aplicáveis a todas as etapas:**
- Português do Brasil. Tom da casa: direto, com frases-conceito curtas; usar blocos `>` para citação de impacto, como o README faz na linha 10.
- Toda afirmação normativa vem com o artigo exato (ex.: "LGPD, art. 11, II, *b*"); toda afirmação da literatura vem com `(AUTOR, ano)` e entra na §9.
- Toda proposta de mecanismo aponta o **componente concreto** que a implementa (nome do campo, endpoint, tabela, papel) e, quando o mecanismo ainda não existe, marca `[a implementar]` com o repositório responsável.
- Nada de invenção bibliográfica. Referência que não foi verificada não entra no documento — nem com ressalva.
- Sem seções de "Riscos e Mitigações" genéricas, sem "Trabalhos Futuros": lacunas reais vão para §8.1 nomeadas.
- Cada ilustração é referenciada no corpo por `![alt descritivo](nome.png)` imediatamente após o parágrafo que ela ilustra, com uma legenda em itálico abaixo.

---

## Ilustrações — especificação (4 arquivos)

Todas em `docs/`, nomes exatos, SVG + PNG. Conteúdo textual fechado abaixo: o executor **não escolhe** o que escrever nos blocos.

### Ilustração 1 — `governanca-tres-camadas.svg` (§2)
Canvas `1200 × 720`. Título: **"Três camadas de governança"**; subtítulo: *"Quem decide o quê, e até onde vai cada decisão"*.
Três cards horizontais (mesmo padrão dos cards do arquivo existente, 250–340 px de largura), de baixo para cima em prioridade:
- Card verde — faixa `GOVERNANÇA DOS DADOS` · título "A comunidade decide" · linhas: "o que se registra · o que se publica · o que se retira"; pílula "CLPI · rotulagem · revogação"; rodapé em `#B4542F`: "nenhuma decisão técnica sobrepõe esta".
- Card terracota — faixa `GOVERNANÇA DAS FERRAMENTAS` · título "O mantenedor da instância decide" · linhas: "deploy · versão · backup · segurança"; pílula "1 container · 1 SQLite soberano".
- Card azul — faixa `GOVERNANÇA DA ARQUITETURA` · título "O Comitê Federado decide" · linhas: "ADRs · contrato de harvest · admissão de membros"; pílula "consenso ou maioria qualificada".
Setas verticais tracejadas (`#8C8377`) mostrando que a camada superior **habilita** e nunca **anula** a inferior; rótulo na seta: "habilita, não decide por". Rodapé com 3 cards de princípio: "Soberania — o dado mora com quem o gerou" / "Consentimento — sem CLPI, o registro não entra" / "Reversibilidade — toda decisão pode ser desfeita".

### Ilustração 2 — `governanca-camadas-acesso.svg` (§5.2)
Canvas `1200 × 800`. Título: **"Quatro camadas de acesso — e o que atravessa o harvest"**; subtítulo: *"O Pluriverso só vê o que a comunidade publicou"*.
Quatro faixas horizontais empilhadas (cards largos, `rx 14`), com faixa colorida à esquerda e um selo circular "sai no harvest / não sai":
1. verde `PUBLIC` — "qualquer pessoa acessa" · exemplos: nome vernacular, uso genérico, táxon, município · selo **sai no harvest**;
2. ocre `RESTRICTED` — "usuário autenticado e autorizado" · `restrictions.allowedRoles/allowedUsers` · selo **não sai** (nota: "harvest autenticado é extensão futura, não implementada — ADR-009");
3. azul `COMMUNITY-ONLY` — "somente membros da comunidade associada" · selo **não sai**;
4. terracota `PRIVATE / SIGILOSO` — "conhecimento sagrado, iniciático ou restrito por gênero — pode nunca ser digitado" · selo **não sai**.
À direita, um painel branco `CAMPOS OCULTADOS` (`permissions.hiddenFields`) listando literalmente `location.coordinates`, `community.name`, `source.primary.informants`. Rodapé em `#B4542F`: "a decisão de camada é da comunidade, revisável a qualquer tempo".

### Ilustração 3 — `governanca-ciclo-clpi.svg` (§5.3)
Canvas `1200 × 840`. Título: **"O CLPI é um ciclo, não um formulário"**; subtítulo: *"Consentir é um processo que pode ser revisto — e revogado"*.
Sete nós em circuito (retângulos `rx 14`, brancos, faixa colorida no topo de cada, setas sólidas verdes `#2E6B4F` entre eles, sentido horário):
`1 Consulta prévia (protocolo próprio da comunidade)` → `2 Acordo de registro (escopo, prazo, uso permitido)` → `3 Registro do relato (BioCultRelatos)` → `4 Validação comunitária (verifiedByCommunity)` → `5 Classificação de acesso (visibility + labels)` → `6 Publicação seletiva (harvest só do public)` → `7 Auditoria e retorno à comunidade`.
Do nó 7 sai uma **seta terracota de retorno** ao nó 2 rotulada "revisão periódica"; e uma segunda seta terracota saindo do centro para fora, rotulada **"REVOGAÇÃO → purge_by_member + remoção do índice"**, apontando para um card terracota isolado "o dado sai da federação e do índice derivado".
Nota em `#7A7065` no rodapé: "prazo, finalidade e uso permitido são registrados como dado, não como PDF esquecido".

### Ilustração 4 — `governanca-reparticao.svg` (§5.9)
Canvas `1200 × 760`. Título: **"Repartição de benefícios rastreável"**; subtítulo: *"Sem rastro de uso, não há repartição — só promessa"*.
Fluxo em três colunas ligadas por setas tracejadas:
- Coluna 1 (verde, `ORIGEM`): card "Registro com proveniência completa" · pílulas "member_id", "comunidade de origem", "DOI do conjunto".
- Coluna 2 (azul, `USO`): card "Todo acesso deixa rastro" · pílulas "log de consulta e download", "citação com DOI", "finalidade declarada"; nota `[a implementar]` em `#B4542F`.
- Coluna 3 (terracota, `RETORNO`): card "Benefício volta em duas formas" · duas sub-pílulas: "**monetária** — Lei 13.123/2015, FNRB, acordo de repartição" e "**não monetária** — coautoria, capacitação, infraestrutura, devolução dos dados".
Faixa inferior verde (`rx 18`, padrão do bloco Pluriverso) com o texto: "O que não se mede não se reparte — o log de uso é instrumento de justiça, não de vigilância", e três pílulas `#3D7C5E`: "SisGen", "acordo registrado como dado", "prestação de contas anual".

---

## Etapas de execução

Cada etapa: **escrever → verificar → `ask` de checkpoint**. O executor NUNCA emenda duas etapas sem o checkpoint. Se a resposta for "Parar", o executor encerra reportando qual etapa foi concluída e qual é a próxima.

Formato obrigatório do checkpoint (ferramenta `ask`, uma pergunta):
- `question`: "Etapa N (<nome>) concluída. Continuar para a Etapa N+1 (<nome da próxima>)?"
- `options`: `[{label:"Continuar para a Etapa N+1", description:"<o que será escrito>"}, {label:"Parar aqui", description:"Retomo depois a partir da Etapa N+1; o documento fica coerente como está."}]`, `recommended: 0`.

### Etapa 1 — Insumos de pesquisa consolidados
Os quatro relatórios de pesquisa (CARE, Jurídico, Técnico, Riscos e Casos) foram produzidos e lidos integralmente como artefatos de sessão — não versionados neste repositório. A seção **"Insumos de pesquisa"** acima resume o que há em cada um, lista as **nove correções obrigatórias**, os **achados que o documento precisa carregar** e as **citações-âncora já conferidas**.
0. **Persistir este plano no repositório**, já que o usuário pediu o planejamento "em um documento separado": copiar o conteúdo deste arquivo para `governanca/planoPropostaGovernanca.md`, sem alterações além de (a) trocar o título para `# Plano de Elaboração — Proposta de Governança` e (b) substituir cada referência aos relatórios de pesquisa por uma nota de que são artefatos de sessão, não versionados. Manter os dois em sincronia não é requisito: `governanca/planoPropostaGovernanca.md` é o registro do planejamento para o usuário; o guia de execução original é o artefato de sessão.
1. Ler os quatro relatórios na íntegra antes de escrever qualquer linha do documento. Descartar toda referência marcada `[NÃO VERIFICADO]` ou sem DOI/URL resolvível — não citar no documento, nem com ressalva.
2. Consolidar a bibliografia em uma lista única ABNT NBR 6023:2018, ordenada alfabeticamente por sobrenome do primeiro autor, agrupada nas mesmas seções temáticas usadas em `Referencias.md` (Legislação Brasileira / Convenções e Protocolos Internacionais / Governança de Dados e Princípios / Etnobiologia e Conhecimento Tradicional / Padrões e Ferramentas). Deduplicar: as quatro fontes citam Carroll et al. 2020, Kukutai & Taylor 2016 e Local Contexts em duplicidade. Guardar em artefato de sessão — é o arquivo-fonte da §9.
3. Criar `governanca/propostaGovernanca.md` com: bloco de abertura, sumário (lista de links `#`-âncora para todas as seções de `##`), §1, §2 (texto, sem a imagem ainda — a referência à imagem entra na Etapa 5) e um esqueleto **apenas com os títulos** das §3–§8 seguidos da linha `*(em elaboração — ver `governanca/planoPropostaGovernanca.md`)*`.
   Exceção à regra "nada de placeholder": este esqueleto existe só entre as etapas 1 e 5 e é removido conforme cada seção é escrita. Ao final da Etapa 4 não pode restar nenhuma linha "(em elaboração)".
4. Checkpoint.

### Etapa 2 — Fundamentos e o receio legítimo (§3 e §4)
1. Escrever §3.1–§3.4. §3.2 cita artigos exatos da LGPD (Lei 13.709/2018) e da Lei 13.123/2015. §3.4 é argumentativa e obrigatória: a LGPD protege o **titular individual**, o CTA tem **titularidade coletiva** — nomear a lacuna, mostrar por que o consentimento individual do art. 7º/art. 11 não substitui o CLPI coletivo da OIT 169 e da Lei 13.123/2015, e explicar como a arquitetura cobre a lacuna por design (soberania do arquivo + `visibility` decidida coletivamente + revogação com purge).
2. Escrever §4.1 com uma **tabela** `caso | o que aconteceu | desfecho | lição para a governança de dados` cobrindo no mínimo: cupuaçu, ayahuasca, jaborandi/pilocarpina, espinheira-santa, Hoodia (San). Só casos com fonte verificável.
3. Escrever §4.2 apresentando os dois lados com literatura (documentação defensiva à TKDL/Índia vs. risco de facilitar bioprospecção) e a posição desta arquitetura: **não é registro defensivo público universal; é registro soberano com publicação seletiva**.
4. Escrever §4.3 — "As sete salvaguardas": lista numerada, cada item = `nome da salvaguarda → mecanismo concreto na arquitetura → limite honesto do mecanismo`. As sete, fechadas: (1) o dado não sai do território digital da comunidade (SQLite soberano); (2) publicar é ato explícito, não padrão (`visibility` default não-público); (3) o índice é derivado e descartável (`purge_by_member`); (4) campo oculto por decisão comunitária (`hiddenFields`); (5) rotulagem cultural legível por humano e máquina (TK/BC Labels); (6) rastro de uso como prova para repartição; (7) direito de sair sem negociar (saída reversível). Para cada uma, dizer o que ela **não** impede (ex.: nada impede uso indevido de dado já público — só torna a origem rastreável e a violação demonstrável)…
5. Checkpoint.

### Etapa 3 — Governança dos dados, parte 1 (§5.1 a §5.6)
1. §5.1 Titularidade: comunidade como titular coletiva; papel do pesquisador como **custodiante**, não proprietário; caso especial de CTA de origem não identificável (Lei 13.123/2015) e como a plataforma o trata (`community: null` + rótulo "atribuição incompleta" em vez de apagar a origem).
2. §5.2 Classificação de sensibilidade: mapear as quatro `visibility` do ADR-003 a critérios culturais (conhecimento cotidiano / especializado / iniciático / sagrado ou restrito por gênero), com a regra explícita "há conhecimento que não deve ser digitado — e a plataforma precisa dizer isso".
3. §5.3 CLPI como processo: o que registrar como dado (escopo, finalidade, prazo, uso permitido, quem consentiu e por qual protocolo, língua da consulta), por que PDF de termo assinado é insuficiente sozinho, e o campo `community.consent` do ADR-003 como ponto de partida — com as extensões propostas nomeadas (`consent.scope`, `consent.expiresAt`, `consent.permittedUses[]`, `consent.protocolReference`, `consent.revokedAt`) marcadas `[a implementar em BioCultRelatos]`.
4. §5.4 Ciclo de vida: sete estágios do ciclo da Ilustração 3, cada um com responsável, artefato gerado e critério de passagem.
5. §5.5 Rotulagem cultural: TK Labels e BC Labels do Local Contexts — lista real dos labels e Notices aplicáveis, como se materializam nos registros e no vocabulário, e por que **rótulo não é licença** (não é instrumento de direito autoral; é declaração de protocolo cultural).
6. §5.6 Proveniência e atribuição: rastreabilidade até a fonte nas quatro fontes de evidência; atribuição de comunidade e de língua; citação obrigatória com `member_id` e DOI; tratamento do caso dos naturalistas (obra em domínio público **não** dissolve a autoria coletiva do conhecimento nela registrado).
7. Checkpoint.

### Etapa 4 — Governança dos dados, parte 2, ferramentas e arquitetura (§5.7 a §7, §8)
1. §5.7 Curadoria e validação comunitária: os seis níveis já descritos no README (estrutural, taxonômica, semântica, especializada, comunitária, auditoria) reordenados como fluxo de governança, com a regra "validação comunitária é a última palavra, e pode reverter a curadoria científica".
2. §5.8 Vocabulários sensíveis: como marcar restrição em nível de rótulo no BioCultTermos (SKOS-XL `skosxl:Label` com anotação de acesso), atribuição de língua/comunidade de origem, e o risco do mapeamento SKOS entre instâncias vazar termo restrito por `skos:exactMatch` — com a regra: **mapeamento só entre conceitos de registros públicos**.
3. §5.9 Repartição: modalidades monetária e não monetária, o que a plataforma pode provar (log de uso, citação, download) e o que não pode; relação com SisGen; a proposta de "prestação de contas anual do uso" por instância.
4. §5.10 Preservação digital e retorno: perda geracional como motivação; backup soberano sob controle da comunidade; formatos abertos e legíveis em 30 anos (SQLite, JSON, SKOS/RDF, mídia sem DRM); repatriação digital; exportação integral pela própria comunidade a qualquer momento.
5. §5.11 LGPD na prática: tabela `exigência da LGPD (artigo) → o que a plataforma implementa → onde`. Cobrir: base legal para dado sensível (art. 7º e 11), informação ao titular (art. 9º), direitos do titular incluindo eliminação e revogação (art. 18), encarregado (art. 41) — propor que **cada membro da federação designe seu encarregado**, e que o Pluriverso designe o seu, sem encarregado único global; registro de operações e RIPD (art. 37 e 38); segurança (art. 46-49); transferência internacional (art. 33) para o caso de instância hospedada fora do Brasil.
6. §5.12 Compromissos negativos — lista curta e literal do que a plataforma nunca fará (ex.: nunca vender dados; nunca ceder base a terceiros sem decisão comunitária; nunca treinar modelo comercial com registros restritos; nunca coletar `restricted` sem harvest autenticado aprovado pelo Comitê; nunca reciclar `member_id`).
7. §6.1–§6.5: instâncias de decisão e papéis (Assembleia/Conselho de Detentores da comunidade, Comitê Federado por instância do Pluriverso, mantenedor da instância, curador, encarregado LGPD) — deixar explícito que **E4 do ADR-006 (autenticação da decisão do Comitê) é bloqueador aberto**; ciclo de código e versões (SemVer + CHANGELOG + ADR, submodule do BioCultTermos e propagação via unidades hospedeiras conforme ADR-007); segurança (OWASP como referência, HTTPS obrigatório, anti-SSRF do probe do ADR-006, rate limit, logs de auditoria append-only, criptografia em repouso quando houver `private`, backup); licenciamento — **resolver a lacuna do README**: propor código em licença permissiva OSI, documentação em CC BY 4.0 e **dados de CTA fora de licença aberta …
8. §7.1–§7.3: ADR como instrumento de governança (quem propõe, quem aceita, quando revisar), matriz de decisão `decisão → quem decide → quem é consultado → quem pode vetar` cobrindo no mínimo: publicar um registro, aceitar novo membro, mudar o contrato de harvest, criar mapeamento SKOS entre membros, remover membro, alterar modelo de dados, liberar harvest autenticado; interoperabilidade com SisGen/SiBBr/GEF Entre-Ciências/RCS e o cuidado de não exportar CTA sensível para redes de dados abertos (Darwin Core `informationWithheld`/`dataGeneralizations` quando houver publicação).
9. §8.1 Lacunas abertas — nomeadas, com responsável e o que falta: autenticação do Comitê (ADR-006 E4); ADR-003 ainda "Proposto" e sem validação comunitária; licença do projeto indefinida; log de uso e mecanismo de repartição não implementados; harvest autenticado inexistente; ausência de RIPD; ausência de protocolo escrito do Comitê Federado. §8.2 sequência de adoção em 4 passos. §8.3 indicadores (nº de registros com CLPI completo, % com rótulo cultural, tempo médio de resposta a pedido de revogação, nº de retornos de dados a comunidades, nº de decisões do Comitê publicadas).
10. Checkpoint.

### Etapa 5 — Ilustrações
1. Criar os quatro SVGs conforme a especificação acima, reusando os tokens literais. Cada um: título + subtítulo + rodapé de princípios quando previsto.
2. Gerar os PNGs (rota `browser`, contingências acima). Conferir visualmente cada PNG lendo o arquivo com `read` — verificar fundo `#FAF6EF`, ausência de texto cortado/sobreposto e dimensão esperada.
3. Inserir as quatro referências de imagem no documento, cada uma logo após o parágrafo que a introduz, com alt text descritivo em português e legenda em itálico.
4. Checkpoint.

### Etapa 6 — Fechamento
1. Escrever §9 "Referências Bibliográficas" a partir da bibliografia consolidada na Etapa 1; conferir que **toda** citação `(AUTOR, ano)` do corpo tem entrada e que **nenhuma** entrada está órfã.
2. Revisar consistência: nomes das ferramentas, campos do ADR-003 grafados exatamente como no ADR, links relativos funcionando, sumário conferindo com os títulos.
3. Adicionar link para o novo documento em `README.md` na lista "Navegação da Documentação" (item novo após "Metodologia e Tecnologias") e uma linha em "Estrutura da Documentação".
4. Adicionar entrada no `CHANGELOG.md` sob nova seção `## [3.4.0] - <data>` → `### Adicionado`, descrevendo a proposta de governança e as quatro ilustrações. Manter o estilo das entradas existentes (negrito no nome do artefato + explicação em uma frase).
5. Checkpoint final: reportar contagem de seções, ilustrações e referências.

---

## Critical files & anchors

- `docs/images/arquitetura-biocultural.svg` — **fonte única do sistema visual**; reler antes de criar cada ilustração e copiar `<defs>`, cores e padrões de card literalmente.
- `docs/architecture-decisions/ADR-003-data-model.md` — campos `visibility`, `restrictions`, `permissions.hiddenFields`, `community.consent`, `verifiedByCommunity`; reler linhas ~200–350 e ~580–610 antes de escrever §5.2, §5.3 e §5.11 para grafar os nomes exatamente.
- `docs/architecture-decisions/ADR-006-federation-membership-protocol.md` — Comitê Federado, fila `pending/active/rejected`, `care_declaration`, E4 como bloqueador; base de §6.1 e §7.2.
- `docs/architecture-decisions/ADR-004-federated-architecture.md` — D3 (governança/Comitê), D4 (saída reversível/purge), D6 (contrato de harvest); citar as decisões pelo identificador (`D3`, `D4`, `D6`).
- `Referencias.md` — formato ABNT de referência a seguir e entradas já existentes que devem ser reaproveitadas sem reformatar.

---

## Verification

Não há código; a prova é o documento renderizando correto, com conteúdo checável.

1. **Estrutura e links** — `grep -n "^#" governanca/propostaGovernanca.md` deve devolver exatamente os títulos da estrutura acima, na ordem. Cada link do sumário resolve para uma âncora existente (comparar slug do título com o link).
2. **Nenhum placeholder ao final da Etapa 4** — `grep -c "em elaboração" governanca/propostaGovernanca.md` = 0.
3. **Integridade bibliográfica** (a checagem que exercita o conteúdo novo): extrair todas as citações `(AUTOR, ano)` do corpo e todas as entradas da §9 e comparar os dois conjuntos — zero citação sem entrada, zero entrada sem citação. Rodar com um one-liner Python via `eval` sobre o texto do arquivo; imprimir as duas diferenças (devem sair vazias).
4. **Nenhum DOI/URL inventado** — `read https://doi.org/<doi>` devolve metadados do CrossRef (título, autores, veículo, ano) em markdown; conferir os quatro campos contra a entrada da §9. Cobertura obrigatória: 100% dos DOIs de artigo citados no corpo, **exceto** os já conferidos nesta sessão e listados em "Citações-âncora com DOI conferido nesta sessão". Se um DOI não resolver ou os metadados divergirem, remover a referência **e** a afirmação que dela dependia — nunca manter a afirmação sem fonte.
5. **Ilustrações** — para cada um dos quatro PNGs: `read docs/<nome>.png` renderiza a imagem; conferir a olho fundo `#FAF6EF`, título legível, nenhum texto sobreposto ou fora do canvas, e paleta idêntica à de `arquitetura-biocultural.png` aberta lado a lado.
6. **Markdown do GitHub** — abrir `governanca/propostaGovernanca.md` no preview do VS Code (ou `read` do arquivo) e confirmar que todas as tabelas fecham, os blocos de código não engolem seções e as imagens têm caminho relativo correto (`nome.png`, mesmo diretório).
7. **Coerência com o repo** — `grep -n "visibility\|hiddenFields\|purge_by_member\|member_id\|care_declaration" governanca/propostaGovernanca.md` e conferir cada ocorrência contra o ADR de origem: nome idêntico, sem campo inventado sem a marca `[a implementar]`.

---

## Assumptions & contingencies

- **Idioma e norma**: documento inteiro em PT-BR, referências em ABNT NBR 6023:2018 (segue `Referencias.md`). *Se o usuário preferir APA* (usada na seção "Artigos e Publicações Relacionadas" do README), converter só a §9 — a estrutura não muda.
- **Bibliografia vive no próprio documento**, não em `Referencias.md`, para evitar duplicação e deriva; `Referencias.md` fica intocado. *Se o usuário pedir consolidação*, mover a §9 para lá e deixar um link.
- **Status do documento**: "Proposta para consulta — submetida à validação de comunidades e do Comitê Federado". Não é norma vigente; nenhuma seção afirma que a plataforma **já** cumpre o que ainda não existe (daí a marca `[a implementar]`).
- **Escopo de arquivos alterados**: cria `governanca/propostaGovernanca.md`, `governanca/planoPropostaGovernanca.md` (cópia do planejamento, pedida pelo usuário) + 4 SVG + 4 PNG; edita `README.md` (2 linhas de navegação) e `CHANGELOG.md` (1 entrada). Nada mais. *Se durante a escrita ficar evidente que o ADR-003 precisa de campo novo*, isso vai para §8.1 como lacuna — **não** editar ADRs nesta tarefa.
- **Nova versão no CHANGELOG**: entrada `[3.4.0]` por ser adição de documento estruturante, coerente com o histórico (a v3.2 subiu minor só por documentação). *Se o usuário preferir não versionar*, registrar sob `## [Não versionado]` no topo.
- **Quatro ilustrações**, não mais. Se ao escrever §5.11 (LGPD) ficar tentador ilustrar a matriz de papéis, resistir: a matriz é tabela, não desenho.
- **Se um checkpoint receber "Parar"**, o executor encerra o turno reportando etapa concluída e próxima etapa — sem adiantar trabalho da etapa seguinte "já que estava perto".
