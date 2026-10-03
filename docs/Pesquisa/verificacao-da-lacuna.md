# Verificação da lacuna de pesquisa — estruturas de dados para conhecimento tradicional (2026-09-11)

> Varredura em fontes primárias que fundamenta o item 1 da §2 e o parágrafo "Científica" da §3 do
> [projeto de pesquisa](projetoPesquisa.md). Referências completas em [`Referencias.md`](Referencias.md), seção 13.


A afirmativa do item 1 de §2 foi submetida a varredura primária exaustiva nas cinco frentes metodológicas, abrindo fontes primárias (DOIs, esquemas em repositórios e especificações normativas vigentes).

## Tabela de Evidências das 5 Frentes

| Frente | Referência ABNT Central | O que é | Estrutura publicada? | Testada como? | Escopo cultural, linguístico e CTA | Veredito |
|---|---|---|---|---|---|---|
| **Plataformas** | CHRISTEN et al. (2012, 2017); ANDERSON & CHRISTEN (2019); LOCAL CONTEXTS (2025) | Mukurtu CMS e Local Contexts Hub (TK/BC Labels & Notices) | Sim (Dublin Core estendido / JSON REST API v2) | Sim (centenas de comunidades e projetos ativos) | Gestão arquivística de acervos digitais e rotulagem de direitos/atribuição. Não modela biodiversidade (espécies, órgãos, preparações, usos taxonômicos) | **QUALIFICA** |
| **Plataformas (Fechadas)** | CSIR / MIN. AYUSH (2006) | Traditional Knowledge Digital Library (TKDL) e classificação TKRC | Sim (XML/TKRC mapeado à IPC A61K 36/00, ~25 mil subgrupos) | Sim (>450 mil formulações de Ayurveda, Siddha, Unani, Yoga) | **Fechada por NDA** com escritórios de patentes; estatal; restrita a textos médicos clássicos codificados. Não aplicável a povos indígenas orais nem orientada a soberania comunitária | **QUALIFICA** (contraexemplo) |
| **Ontologias / KGs** | ZHOU et al. (2019); ISO/TS 17938:2014; CHEN et al. (2007) | TCMLS-SN / GFO-TCM e grafos de Medicina Tradicional Chinesa | Sim (OWL/RDF, >120 mil conceitos, 1,27 mi links) | Sim (usada em NLP e sistemas de apoio clínico na China) | **Monocultural e hegemônica** (doutrina médica chinesa formal). Sem pluralismo cosmopolítico, sem modelagem de soberania ou consentimento comunitário C.A.R.E. | **QUALIFICA** (contraexemplo) |
| **Padrões de Biodiversidade** | GBIF / TDWG (2024); SiBBr (2024); HEINRICH/WECKERLE et al. (2018) | DwC-DP (tabela `usage-policy`); SocioBio/SiBBr; ConSEFS | Sim (JSON schema do DwC-DP; star schema SiBBr no GitHub; checklist de reporte) | Sim (GBIF, SiBBr) | DwC-DP `usage-policy` é **100% direito autoral ocidental** (zero suporte a protocolos culturais). SocioBio trata apenas de ocorrência e uso utilitário (`usedTo`, `organismPart`) sem regime enunciativo | **SUSTENTA** a lacuna |
| **Evidência da Lacuna** | CARROLL et al. (2020, 2021); JENNINGS et al. (2023); ZANK et al. (2025) | Governança C.A.R.E., soberania de dados indígenas e descolonização da etnobiologia | Sim (artigos conceituais e empíricos em periódicos de alto impacto) | Sim (adotados pela RDA, GIDA, etc.) | Demonstram que bases globais apagam os guardiões de dados e que inexiste modelo técnico que garanta soberania de dados por arquitetura | **SUSTENTA** a lacuna |
| **Brasil e WIPO** | FERRARI (UFSC, 2020); WIPO (2022, 2023); BRASIL (SISGEN) | SISGEN (declaratório); Useflor@; Relatórios WIPO/IGC (46/8 e 46/12) | SISGEN: formulário sem modelo semântico; WIPO: registros defensivos | SISGEN em produção federal; WIPO em debate intergovernamental | WIPO declara expressamente que "dados estruturados e formato interoperável para bases de TK" permanecem como **Future Work** pendente | **SUSTENTA** a lacuna |

## Síntese e Decisão Adotada

1. **Contraexemplos mais perigosos:** O TKDL da Índia (fechado/estatal) e o TCMLS da China (monocultural/doutrinário) provam que existem estruturas de dados formais em larga escala para conhecimentos tradicionais, mas nenhuma delas é **aberta, intercultural ou orientada à soberania e consentimento de povos tradicionais**.
2. **Decisão:** A afirmativa do item 1 da §2 do `projetoPesquisa.md` foi **QUALIFICADA** (passando a *"Ausência de proposta aberta, intercultural e validada"* e citando nominalmente as implementações parciais).
3. **Consequência nos arquivos:**
   - `docs/Pesquisa/Referencias.md`: Nova seção "13. Estruturas de Dados para Conhecimento Tradicional e Lacunas na Literatura" adicionada com 23 referências completas em ABNT NBR 6023:2018; rodapé atualizado para Setembro 2026.
   - `docs/Pesquisa/projetoPesquisa.md`: Item 1 de §2 e parágrafo "Científica" de §3 retificados e fundamentados nas fontes primárias.
   - `docs/tecnico/proximosPassos.md`: §0.2 e §11.1 atualizados.
