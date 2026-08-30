# Próximos Passos — estado do projeto e pendências

> **Arquivo de referência único do projeto.** Registra onde o projeto está e o que falta fazer. É o ponto de entrada obrigatório de qualquer nova sessão de trabalho — humana ou assistida por IA — e a garantia de continuidade entre sessões: toda pendência aberta está aqui, com estado e bloqueio explícitos.
>
> **Regras de manutenção:** ao final de cada sessão, atualizar (i) a data do estado, (ii) o estado do repositório, (iii) a seção da sessão com o que foi feito e (iv) a §11 com a próxima ação. Pendência resolvida não é apagada: é marcada como decidida, com o `onde`. Caminhos citados são relativos à raiz do repositório.

**Estado em:** 2026-08-19

**Para quem retoma:** leia a **§0** (sessão de 2026-08-19, projeto de pesquisa) e siga para a **§11**. Depois, se precisar do estado da discussão conhecimento × evidência, leia `conhecimento/sessao-2026-08-13-decisoes-e-pendencias.md`. Da §1 em diante, este arquivo é o estado de 2026-08-14 e continua válido.

**Estado do repositório:** `main`, árvore limpa, sincronizado com o remoto. Últimos commits: `ada39eb` e `15365bc` (projeto de pesquisa), sobre `6392bfc`. Marcos anteriores: **v3.8.0** (`5e1d575`), **v3.9.0** (`c6a8357`), **v3.10.0** (ADR-016).

---

## 0. Sessão 2026-08-19 — `projetoPesquisa.md` e uma afirmativa a verificar

### 0.1 Feito e publicado (dois commits em `main`, push ok)

| # | Onde | O que mudou |
|---|---|---|
| 1 | `projetoPesquisa.md` cabeçalho | "Estado da produção técnica" virou lista: arquitetura (v3.5/DOI, repo v3.10.0, 17 ADRs, C4) + estado de **cada** ferramenta (BioCultDB, BioCultTermos, BioCultRelatos, BioCultAcervos, BioCultNaturalistas, Pluriverso) + documentação normativa concluída |
| 2 | §2 Problema de pesquisa | Reformulado: **representação** precisa do domínio do CTA em suas manifestações, culturas e línguas **e** **garantia** plena dos princípios C.A.R.E. e da repartição justa e equitativa. A formulação anterior (soberania por arquitetura × política de uso) virou o segundo parágrafo |
| 3 | §4 | Tabela de questões Q1–Q7 **removida**. Seção passou a "Questões emergentes": as questões surgirão das comunidades tradicionais e da academia, e responder a elas é a essência do projeto. Referências órfãs a Q3/Q6 reescritas em prosa (§9.1 pauta 1, §9.4, §12); `H-Q1` da ADR-016 preservado |
| 4 | §5 Objetivos | Geral realinhado ao novo problema; específicos de 8 → 10. Novos: mapear cada subprincípio C.A.R.E. e cada exigência da Lei 13.123 ao componente que o implementa; tornar a repartição de benefícios rastreável pela arquitetura (absorveu o antigo Q7) |
| 5 | §14 Equipe | Acrescentadas Luisa Ridolph e Camila Dantas, pós-graduação ENBT/JBRJ |
| 6 | §2, item 1 | Nova dificuldade (a quinta), posicionada como **item 1** por ser a lacuna primária: ausência de proposta concreta e testada de estrutura de dados para o conjunto **dado, informação e conhecimento** tradicional associado à biodiversidade |

### 0.2 Pendência aberta: a afirmativa do item 1 de §2 não tem base citada

O item 1 afirma que **não existe** na literatura estrutura de dados concreta e testada para esse conjunto, em diferentes culturas, línguas e visões de mundo, e que o que existe são padrões parciais e implementações institucionais fechadas. É uma afirmativa forte, escrita **sem referência**. A pesquisa profunda para verificá-la foi despachada em cinco frentes paralelas e **cancelada antes de concluir** no encerramento da sessão — **nenhum resultado foi salvo**. Refazer do zero.

Frentes a re-despachar, uma por agente, em paralelo:

| Frente | O que varrer |
|---|---|
| **Plataformas** | Mukurtu CMS (Christen); Local Contexts Hub — TK/BC Labels, Notices, guia de API; TKDL Índia + TKRC (concreto, testado, **fechado** por NDA); Ara Irititja; Keeping Culture; protocolos ATSILIRN; Sq'éwlets / Plateau Peoples' Web Portal; People's Biodiversity Register (Gadgil et al.); NIKMAS/IKMS África do Sul (Britz, Lor et al.) |
| **Ontologias e knowledge graphs** | `indigenous knowledge ontology`, `traditional knowledge ontology`, `TEK ontology`, ontologias de patrimônio imaterial (ICH), CIDOC-CRM e extensões; grafos de medicina tradicional chinesa e Ayurveda — **contraexemplo mais perigoso**: concretos, testados e ricos, mas monoculturais; pluralismo ontológico e multilinguismo (SKOS-XL para vocabulários indígenas) |
| **Padrões de biodiversidade e etnobiologia** | Darwin Core; DwC-DP (`usage-policy` **já verificado**: só direito autoral, nenhum protocolo cultural — ver §9); Humboldt; Plinian Core; Audubon Core; ABCD; SocioBio/SiBBr (campos reais no GitHub); guias GBIF de dados sensíveis e de dados indígenas; padrões de reporte etnofarmacológico (WECKERLE et al.); NAEB/Moerman; PROTA |
| **Evidência da lacuna** | CARROLL et al. 2020 e 2021; JENNINGS et al.; ANDERSON & CHRISTEN; AGRAWAL; NADASDY 1999; NGULUBE; LWOGA, NGULUBE & STILWELL; STEVENS; ZANK et al. 2025; PANKARARU et al. 2026 — extrair **citação direta curta** onde a fonte declara a lacuna |
| **Brasil e revisões** | SISGEN (campos de cadastro de CTA, natureza declaratória); SinBiota; Plataforma de Territórios Tradicionais (MPF); Rede de Conhecimentos sobre Sociobiodiversidade (ICMBio/CNPT + UFSC); GEF 11269 "Entre-Ciências"; BDTD e repositórios (FERRARI, UFSC, 2020 e similares); WIPO/IGC sobre bases de dados de conhecimento tradicional; revisões sistemáticas e de escopo sobre modelos de dados para conhecimento tradicional |

Regras a repetir no despacho, porque são o que dá valor ao resultado: abrir a **fonte primária** de toda fonte central (página do DOI, PDF, esquema no GitHub), nunca citar de snippet de busca; **proibido fabricar** DOI, volume, página ou ano — campo não conferido escreve-se `[não verificado]`; devolver tabela (referência ABNT | o que é | estrutura publicada? | testada como? | escopo cultural, linguístico e dado/informação/conhecimento | **SUSTENTA / QUALIFICA / CONTRADIZ**), síntese, contraexemplos mais perigosos e termos buscados sem resultado.

**Decisão que a pesquisa vai forçar.** Se aparecer contraexemplo concreto e testado — mesmo monocultural, como os grafos de medicina tradicional chinesa, ou fechado, como o TKDL — o item 1 precisa ser **qualificado**, não mantido. Formulação provável: *não existe estrutura **aberta, intercultural e validada*** para esse conjunto, citando nominalmente os parciais e o que cada um cobre. Manter o texto atual só se as cinco frentes voltarem sem contraexemplo.

**Destino das referências:** `Referencias.md`, em seção nova (ex.: "13. Estruturas de dados para conhecimento tradicional — estado da arte"), norma ABNT NBR 6023:2018; atualizar o rodapé "Última atualização", que ainda diz Janeiro 2025. Citar no corpo do item 1 de §2 e reforçar o parágrafo "Científica" de §3, que hoje afirma a lacuna apenas para a distinção Conhecimento × Evidência no Brasil.

---

## 1. Em uma página: o que mudou

A arquitetura ganhou um **segundo eixo**, ortogonal ao da procedência (artigo / campo / acervo / naturalista):

| Regime Enunciativo | O que é | Quem manda |
|---|---|---|
| **`conhecimento`** | A relação com a biodiversidade **enunciada por quem a detém** — primeira pessoa, presa a um ato de enunciação | A comunidade detentora. Aplica **Label** |
| **`evidencia`** | A **atestação por um terceiro** de que essa relação existe — terceira pessoa, presa a um artefato | Quem custodia o artefato. Só pode declarar **Notice** |

A distinção é **deôntica, não epistêmica**. Evidência não vale menos: é conhecimento com outro dono. O que ela decide é **quem pode classificar o nível de acesso**.

Formalizado em **`docs/architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md`**, status **Proposto**, oito pontos K1–K8.

**A unidade de Conhecimento chama-se `Relato`** (decidido em 2026-08-13, contra "Enunciado"). Mapeia para `dwc:Assertion` na implementação. **Vive sempre na unidade da comunidade detentora**, nunca na de quem custodia o objeto de que ele fala.

---

## 2. Correção importante feita no fim da sessão

Uma versão anterior dizia que a narrativa de uma comunidade sobre uma peça de museu seria "Conhecimento dentro do BioCultAcervos". **Estava errado** e foi corrigido em todos os arquivos.

- **BioCultAcervos** guarda evidência física custodiada por instituições: material de Spruce em Kew, exsicatas do JBRJ, peças de coleções etnológicas.
- A narrativa da comunidade sobre esse item é um **Relato no BioCultRelatos da própria comunidade**, que *referencia* o item.
- Gravá-la no SQLite do museu violaria `Conteúdo Soberano` (`CONTEXT.md`) — soberania invertida.
- A coexistência das duas narrativas (lição do Mukurtu, `propostaGovernanca.md:419`) acontece **na federação**: dois registros de dois membros, vinculados.

**Consequência prática:** BioCultDB, BioCultAcervos e BioCultNaturalistas são `evidencia` **sempre**. O único provedor com os dois regimes é o **BioCultRelatos** — onde a nota de campo do pesquisador é Evidência, por falhar Q2 do teste de K1.

**Requisito novo, ainda não especificado:** o payload de harvest precisa expressar "este registro trata do mesmo objeto que aquele registro de outro membro". O DwC-DP tem `resource-relationship` para isso.

---

## 3. Concluído na v3.8.0 — Passos 1, 2 e 3

Os três estavam prontos e sem dependência. Foram executados.

| Passo | O que foi feito | Onde |
|---|---|---|
| **1** ✔ | Nota de retificação no ADR-003, seção "1. Registro Principal (Record)": três retificações (`type` → `regime` de K1; `media` deixa de ser "(futuro)" por K5; `language` → ISO 639-3 por K5) e quatro acréscimos (`relato` de K2, `accessLevel` por nível e `reviewDate` de K3, padrão de acesso por regime de K7). Texto original preservado; o ADR-003 **não** foi promovido nem reescrito | `docs/architecture-decisions/ADR-003-data-model.md:106-129` |
| **2** ✔ | Nota de retificação no ADR-004, em **D6** e no bloco "Contrato de Publicação". Registra o que **permanece válido** (paginação, `updated_since`, `member_id` + `record_id`) e sinaliza no próprio texto que a supersessão só tem efeito quando a ADR-015 for aceita — o conflito *Aceito* × *Proposto* ficou explícito, não resolvido por omissão | `docs/architecture-decisions/ADR-004-federated-architecture.md:80-96` e `:150-154` |
| **3** ✔ | Contrato de payload campo a campo, com a envoltória, o registro, o cálculo do nível efetivo, a redação na fronteira da API, `culturalLabels`, `relatedResources` e a condição de aceitação em dez cenários | `docs/contrato-harvest.md` |

Três coisas que o Passo 3 fechou e que estavam em aberto:

- **`relatedResources`** — o vínculo entre registros de membros distintos (§2 acima). Subconjunto de `resource-relationship` do DwC-DP, com os nomes de campo verificados na fonte primária. O caso entre membros usa `externalRelatedResourceID` + `externalRelatedResourceSource`.
- **Condição de aceitação de K6** — especificada em dez cenários, inclusive os que costumam faltar: registro `public` de regime `conhecimento` **sem CLPI válido** deve estar ausente; mudança de nível de `public` para `restricted` deve desaparecer da coleta seguinte (senão o índice do Pluriverso guarda a cópia anterior); e gravação coletiva com um participante `restricted` não atravessa.
- **Ordem de restritividade** — `public < restricted < community-only < private`, com `sacred` do nível de Termo equivalendo a `private`. Esta última equivalência é **derivada de K3 e não está na ADR-015**; está marcada como tal em §4.1 do contrato, para o Comitê corrigir se discordar.

Correção de percurso: a ADR-015 ainda dizia "entidade `enunciado`" em Relações, contradizendo K2 e a decisão pelo termo **`Relato`**. Corrigido.

---

## 3-bis. Concluído na v3.10.0 — as decisões de arquitetura pura

Triagem entre o que se decide na mesa e o que só se decide na roda. Das três pendências que não dependiam da comunidade, duas foram decididas e uma se revelou mal classificada.

| # | Decisão | Onde |
|---|---|---|
| **③** ✔ | **K6 extraído para a ADR-016** — Contrato de Harvest da Federação, *Proposto*, com H1 (payload), H2 (redação na fronteira), H3 (vocabulário de vínculo) e H4 (condição de aceitação). Motivo: K6 supersedia o ADR-004 D6, **Aceito**, a partir de texto que depende de validação com comunidades. Agora o contrato tem ciclo de aceitação próprio e não espera a ADR-015 | `docs/architecture-decisions/ADR-016-contrato-de-harvest.md` |
| **⑤** ✔ | **`relationshipType` fechado em três valores**: `refers to`, `same as`, `derived from`. E uma correção: o exemplo usava `same as` entre Relato e exsicata — errado, o Relato **fala sobre** a exsicata, não **é** a exsicata. `same as` afirmaria identidade e colapsaria os dois no índice do Pluriverso | `docs/contrato-harvest.md` §6 |
| **④** → reunião | **`sacred` ≡ `private` não é decisão técnica.** Parecia; não é. O que é sagrado quem diz é a comunidade, e a equivalência pode estar tecnicamente certa e semanticamente errada. Virou **H-Q1 da ADR-016**, foi para a pauta das lideranças e para o slide de perguntas. Regra interina até lá: trata-se como `private`, que erra para o lado de não publicar | `contrato-harvest.md` §4.1, `ADR-016` H-Q1 |

Limpeza junto: a Q1 da ADR-015 ("o regime entra no glossário da federação?") constava aberta desde a v3.7.0, que já a respondera. Fechada — a contagem de questões abertas passa de seis para quatro (Q3–Q6) e agora é verdadeira.

---

## 4. Bloqueado: precisa de decisão

Duas perguntas. A recomendação está marcada; nenhuma foi respondida.

### ① Como identificar o detentor sem expor a pessoa

Bloqueia o formato de `relato.detentor` e, portanto, o Passo 4 (esquema como tabela).

Conflito real: `assertionByID` quer identificador estável; LGPD art. 11 protege voz+imagem+etnia; CARE A1 e a Lei 13.123 dão à pessoa **direito ao reconhecimento**. Apagar o nome "para proteger" repete o apagamento histórico do informante indígena.

| | O sistema guarda | O público vê | Quem decidiu |
|---|---|---|---|
| A | nome real, protegido | "um ancião Panará" | nós |
| B | só o coletivo | "Panará" | nós |
| **C ← recomendada** | pseudônimo escolhido pela pessoa | o pseudônimo | **ela** |

**C é a única que exige ir a campo perguntar** — e é exatamente por isso que A e B são suspeitas: são as que se decidem sozinho.

### ② Rótulos culturais: API do Local Contexts Hub ou cópia local

| | Comunidade muda o rótulo | Serviço externo cai |
|---|---|---|
| Consultar API sempre | reflete na hora — **autoridade fica com ela** | some o rótulo |
| Copiar para o SQLite | desatualiza | funciona |
| **Guardar ID + cache do texto ← recomendada** | atualiza no próximo cache | mostra a última versão conhecida |

Tensão: soberania e simplicidade pedem não depender de serviço externo; mas copiar o rótulo para dentro significa passar a controlar algo que é da comunidade. **Nunca editar o texto** — o das Notices, em particular, é imutável por regra do Local Contexts.

---

## 5. Bloqueado: precisa da comunidade

Detalhado com roteiro de perguntas em `conhecimento/sessao-2026-08-13-decisoes-e-pendencias.md` **§5** — a seção feita para sair do computador. Resumo das **seis** pautas (a quinta veio de K8 e a sexta da triagem da v3.10.0; nenhuma das duas tem roteiro naquele arquivo ainda). As pautas 1, 4, 5 e 6 são as quatro que já estão na apresentação, mais a pergunta de nomeação:

1. **Como quem fala quer ser nomeado** — resolve ① acima.
2. **Quais rótulos culturais se aplicam** — sazonalidade, restrição por gênero ou família, uso comercial, e quem tem legitimidade para dizer em nome de todos.
3. **O vídeo Panará**, quatro pendências: CLPI não localizado; consentimento específico para imagem e voz; transcrição em `kre` inexistente; grafia não verificada com pesquisadores Panará.
4. **O que não deve ser registrado** — `propostaGovernanca.md:286`: para conhecimento sagrado, a decisão correta pode ser **não registrar**, e a plataforma tem obrigação de dizer isso.
5. **Gravações de prática e oficinas coletivas** (novo, K8) — filmar alguém fazendo um chá ou trançando uma cesta registra conhecimento sem que uma palavra seja dita; e uma oficina grava várias pessoas de uma vez. Perguntar: quem autoriza a gravação de uma prática; se cada participante decide sobre a própria imagem ou se a decisão é do grupo; e o que deve acontecer quando **um** participante muda de ideia depois — a regra adotada por ora é a mais conservadora, a gravação inteira sai.
6. **O que é sagrado — e o que acontece com ele** (novo, v3.10.0, ④/H-Q1) — quando um saber é sagrado, o registro dele deve sumir por inteiro, ou pode ficar visível que ele existe sem mostrar o conteúdo? E quem diz, por todos, que um saber é sagrado? Tecnicamente a pergunta é se `sacred` equivale a `private` ou merece nível próprio; a decisão, porém, não é técnica. Regra interina: equivale a `private`, nunca atravessa.

As pautas 1, 4, 5 e 6 estão no slide "Cinco perguntas que só vocês podem responder" de `docs/apresentacoes/Arquitetura BioCultural v2.pptx`, junto com a pauta 2.

Enquanto a Pauta 3 não fechar, `conhecimento/conhecimentoPanara.mp4` é `restricted` de fato, não atravessa harvest, e o `.gitignore` de `*.mp4` deve permanecer.

---

## 6. Fora deste repositório

| Onde | O quê |
|---|---|
| `BioCultDB` | 29 registros existentes precisam de valor de `regime`. Trivial: `evidencia` para todos, correto por construção da unidade |
| `BioCultDB` | Campos de acesso do ADR-003 (`visibility`, `restrictions`, `permissions`) **nunca foram materializados** no banco de produção |
| `BioCultRelatos` | Absorve K1–K8 e o contrato de `docs/contrato-harvest.md` como restrição de projeto **antes da primeira linha de código** — momento mais barato. Inclui **upload de mídia como registro primário** (K8.1), participantes de gravação coletiva com decisão de acesso própria (K8.3) e a condição de aceitação em dez cenários (§7 do contrato) |
| `BioCultNaturalistas` | `docs/decisions/ADR-003` V2 ainda precisa remover `bcn_taxons → $.nomeCientificoAtual` (pendência da v3.6.0, ADR-014 N3 — **não é desta sessão**) |

---

## 7. Mapa de dependências

```mermaid
flowchart TD
    A["ADR-015 · Proposto"] --> P1["Passo 1 ✔<br/>ADR-003 retificado"]
    A --> P2["Passo 2 ✔<br/>ADR-004 D6 retificado"]
    P1 --> P3["Passo 3 ✔<br/>contrato de payload"]
    P2 --> P3
    P3 --> H["ADR-016 ✔ · Proposto<br/>contrato extraído de K6"]
    H --> HA["ADR-016 → Aceito<br/>não depende da comunidade"]
    Q1["① detentor<br/>DECISÃO"] --> P4["Passo 4<br/>esquema do Relato"]
    Q2["② rótulos<br/>DECISÃO"] --> P4
    C["Reunião com<br/>as lideranças"] --> Q1
    C --> Q2
    C --> Q4["④ sagrado<br/>H-Q1 da ADR-016"]
    Q4 --> HA
    C --> P5["Passo 5<br/>piloto Panará"]
    P3 --> P5
    P4 --> P5
    P5 --> F["ADR-015 → Aceito"]
    style P1 fill:#28a745,color:#fff
    style P2 fill:#28a745,color:#fff
    style P3 fill:#28a745,color:#fff
    style H fill:#28a745,color:#fff
    style C fill:#fd7e14,color:#fff
    style Q4 fill:#fd7e14,color:#fff
    style F fill:#1168bd,color:#fff
    style HA fill:#1168bd,color:#fff
```

---

## 8. Onde está cada coisa

| Artefato | Caminho |
|---|---|
| Estudo completo, fontes verificadas, caso Panará modelado | `conhecimento/caracterizacao-do-conhecimento-tradicional.md` |
| Registro da sessão + **pauta da comunidade (§5)** | `conhecimento/sessao-2026-08-13-decisoes-e-pendencias.md` |
| Decisão de arquitetura | `docs/architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md` |
| Contrato de payload do harvest, campo a campo | `docs/contrato-harvest.md` |
| Contrato de harvest como ADR (H1–H4) | `docs/architecture-decisions/ADR-016-contrato-de-harvest.md` |
| Glossário da federação | `CONTEXT.md` → seção "Conhecimento e evidência" |
| Governança de acesso, CLPI, rotulagem | `governanca/propostaGovernanca.md` §5.1–§5.10 |
| Rótulos SKOS-XL e `accessLevel` | `BioCultDB/bioculttermos/manual/03-rotulos.md` |
| Vídeo caso-teste (não versionado) | `conhecimento/conhecimentoPanara.mp4` — 42 s, HEVC 1080p, língua `kre` |

---

## 9. Referências externas já verificadas nesta sessão

Não precisam ser reconferidas.

- ISO 639-3 `kre` = Panará, *Active* — <https://iso639-3.sil.org/code/kre>. A *reference name* era `Kreen-Akarore` até a solicitação 2006-019, adotada em 2007-07-18: <https://iso639-3.sil.org/request/2006-019>
- DwC-DP, guia ratificado TDWG 2026-04-17 — <https://dwc.tdwg.org/dp/>
- Tabelas `*-assertion` e `usage-policy` — <https://github.com/gbif/dwc-dp/tree/master/dwc-dp/table-schemas>. Confirmado: `usage-policy` só tem campos de direito autoral, **nenhum** de protocolo cultural
- TK Labels, 20 rótulos em três categorias — <https://localcontexts.org/labels/traditional-knowledge-labels/>
- Local Contexts Hub API — <https://localcontexts.org/wp-content/uploads/2023/08/API-Implementation-Guide.pdf>
- CARE Principles, subprincípios C1–E3 — <https://www.gida-global.org/careprinciples>
- W3C PROV-O — <https://www.w3.org/TR/prov-o/>

---

## 10. Pendências da discussão "conhecimento × evidência"

Consolida tudo o que a discussão abriu, em um só lugar. Itens riscados foram decididos na v3.10.0; o resto continua aberto, e onde há recomendação ela está marcada como tal.

### 10.1 O que já ficou decidido (para não reabrir)

| Questão | Decisão | Onde |
|---|---|---|
| Nome da unidade de Conhecimento | **`Relato`**. Descartados *Enunciado*, *Asserção*, *Depoimento* | ADR-015 K2, Q2 |
| Regime é campo do registro ou propriedade do provedor? | **Campo do registro**, com padrão por unidade sobreponível | ADR-015 K1 |
| Onde vive a narrativa da comunidade sobre peça de acervo | **No BioCultRelatos dela**, referenciando o item; nunca no banco do museu | ADR-015 §Contexto, §2 acima |
| O regime entra no glossário da federação? | **Sim.** Quatro termos acrescentados ao `CONTEXT.md` na v3.7.0. A Q1 da ADR-015 foi fechada na v3.10.0 | `CONTEXT.md`, "Conhecimento e evidência" |
| Mídia é anexo ou é o registro? | Em Relato de prática, **a mídia é o Relato**; a descrição é derivada | ADR-015 K8.1 |
| Língua sem fala | `zxx`; não identificada, `und` | ADR-015 K8.2 |
| Onde vive o contrato de harvest | **ADR própria, a ADR-016**, para poder ser aceita sem esperar a validação com comunidades | ADR-016, §3-bis |
| Tipos de vínculo entre registros de membros | **Três, fechados:** `refers to`, `same as`, `derived from` | ADR-016 H3 |

### 10.2 Decisões que dependem de você

| # | Pendência | Recomendação | O que trava |
|---|---|---|---|
| ① | Formato do detentor individual | Pseudônimo escolhido pela pessoa (§4). **Vai à reunião** | Esquema do Relato (Passo 4) |
| ② | Rótulos culturais: API do Hub ou cópia local | Guardar identificador + cache do texto canônico (§4). Decisão técnica, **não vai à reunião** — mas quem tem legitimidade para aplicar rótulo em nome de todos, sim (Pauta 2) | Nada no contrato; trava só a interface |
| ~~③~~ | ~~Extrair **K6** para ADR próprio~~ | **Decidido na v3.10.0: extraído para a ADR-016** | — |
| ④ | `sacred` equivale a `private`? | **Reclassificada na v3.10.0: não é decisão técnica.** Virou H-Q1 da ADR-016 e **vai à reunião** (Pauta 6). Regra interina: equivale a `private` | Promoção da ADR-016 a *Aceito* |
| ~~⑤~~ | ~~Vocabulário de `relationshipType`~~ | **Decidido na v3.10.0:** `refers to`, `same as`, `derived from`. `same as` entre Relato e exsicata estava errado e foi corrigido | — |
| ⑥ | Vocabulário controlado de `assertionType` | Q5 da ADR-015: matéria do BioCultTermos e do Comitê, fora do escopo | Esquema do Relato |
| ⑦ | Promoção da ADR-015 a *Aceito* | Depende de Q3–Q6 e da validação com comunidades | Tudo o que depende de ADR aceita |
| ⑫ | Promoção da **ADR-016** a *Aceito* | Depende só de H-Q1 (④) e do Comitê. **Não depende da comunidade para existir** — depende dela para uma linha | Implementação do endpoint de harvest |

### 10.3 Aberturas que o K8 criou

O ponto K8 nasceu de uma observação de campo — vídeo registra prática, não só fala — e abriu quatro coisas que não têm resposta ainda.

| # | Aberto | Por quê |
|---|---|---|
| ⑧ | **Quem autoriza a gravação de uma prática coletiva** — cada participante, ou o grupo? | Pauta 5. **Vai à reunião.** A regra adotada por ora é a mais conservadora: um pede reserva, sai tudo |
| ⑨ | **Versão editada de gravação** após revogação de um participante | K8.3 diz que a plataforma não edita por conta própria e que a versão editada é derivado novo. Falta dizer **se** e **como** a comunidade pede isso, e quem confere o resultado. **Não foi para a pauta desta reunião** |
| ⑩ | **Onde mora o vídeo** | K8.4 exige original em armazenamento soberano. Uma comunidade com dezenas de gravações de 60 MB tem problema real de custo e banda. **Vai à reunião** — a solução depende do que elas têm e aceitam |
| ⑪ | **`und` como estado transitório** | Precisa de um lugar na curadoria que liste os registros em `und` e cobre resolução; senão vira estado final por inércia. Puramente técnico, **não vai à reunião** |

### 10.4 Consistência a verificar quando houver fôlego

- **README, "Quatro Fontes"** — a coluna de regime foi acrescentada na v3.7.0, mas o corpo do texto ainda fala em "evidências" como termo guarda-chuva em vários pontos. Não é erro; é vocabulário anterior à distinção.
- **`propostaGovernanca.md`** — descreve Label/Notice (§5.5) sem citar o regime, que é a propriedade que decide qual dos dois se aplica. Vale uma nota de vínculo quando o documento for revisado.
- **Diagramas C4** (`docs/c4-model/`) — falam em coleta de registros `visibility: public`. Prosa conceitual, ainda correta em espírito, desatualizada na letra desde a ADR-016.
- **`conhecimento/sessao-2026-08-13-decisoes-e-pendencias.md` §5** — tem roteiro de perguntas para as quatro pautas originais; **a quinta (gravações e oficinas) e a sexta (o sagrado) ainda não têm roteiro**.

---

## 11. Primeira coisa a fazer ao retomar

Passos 1–3 feitos, K8 registrado, ③ e ⑤ decididos, ④ reclassificada e levada à pauta. O que resta:

- **Refazer a pesquisa profunda da §0.2** — verificar a afirmativa do item 1 de §2 do `projetoPesquisa.md` e levar as referências para o `Referencias.md`. A afirmativa está publicada **sem base citada**; é a única coisa desta sessão que ficou pela metade. **Primeira coisa no computador.**
- **Escrever o roteiro das pautas 5 e 6** — gravações/oficinas e o sagrado. São as duas perguntas da reunião que ainda não têm roteiro em `sessao-2026-08-13-decisoes-e-pendencias.md` §5, e a reunião é o caminho crítico de quase tudo. **Primeira coisa fora do computador.**
- **"Decida ② e ⑪"** — as duas técnicas que sobraram e não vão à reunião: cache do texto dos rótulos, e a fila de curadoria dos registros em `und`.
- **Depois da reunião:** ① (nomeação), ④ (sagrado → fecha a ADR-016), ⑧ (autorização de gravação coletiva) e ⑩ (onde mora o vídeo).
- **Passo 4 (esquema do Relato)** continua travado por ①. **Passo 5 (piloto Panará)** continua travado pela Pauta 3.
