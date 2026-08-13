# Próximos Passos — retomada após a sessão de 2026-08-13

**Para quem retoma:** leia este arquivo primeiro, depois `conhecimento/sessao-2026-08-13-decisoes-e-pendencias.md`. Os dois juntos dão o estado completo sem precisar reler a sessão inteira.

**Estado do repositório:** `main`, árvore limpa. Últimos commits relevantes: `fc3ebe2` (ADR-015), o commit da v3.7.0 e o commit da **v3.8.0** — Passos 1–3 concluídos.

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

Detalhado com roteiro de perguntas em `conhecimento/sessao-2026-08-13-decisoes-e-pendencias.md` **§5** — a seção feita para sair do computador. Resumo das cinco pautas (a quinta acrescentada por K8, e ainda sem roteiro naquele arquivo):

1. **Como quem fala quer ser nomeado** — resolve ① acima.
2. **Quais rótulos culturais se aplicam** — sazonalidade, restrição por gênero ou família, uso comercial, e quem tem legitimidade para dizer em nome de todos.
3. **O vídeo Panará**, quatro pendências: CLPI não localizado; consentimento específico para imagem e voz; transcrição em `kre` inexistente; grafia não verificada com pesquisadores Panará.
4. **O que não deve ser registrado** — `propostaGovernanca.md:286`: para conhecimento sagrado, a decisão correta pode ser **não registrar**, e a plataforma tem obrigação de dizer isso.
5. **Gravações de prática e oficinas coletivas** (novo, K8) — filmar alguém fazendo um chá ou trançando uma cesta registra conhecimento sem que uma palavra seja dita; e uma oficina grava várias pessoas de uma vez. Perguntar: quem autoriza a gravação de uma prática; se cada participante decide sobre a própria imagem ou se a decisão é do grupo; e o que deve acontecer quando **um** participante muda de ideia depois — a regra adotada por ora é a mais conservadora, a gravação inteira sai.

Enquanto a Pauta 3 não fechar, `conhecimento/conhecimentoPanara.mp4` é `restricted` de fato, não atravessa harvest, e o `.gitignore` de `*.mp4` deve permanecer.

---

## 6. Fora deste repositório

| Onde | O quê |
|---|---|
| `BioCultDB` | 29 registros existentes precisam de valor de `regime`. Trivial: `evidencia` para todos, correto por construção da unidade |
| `BioCultDB` | Campos de acesso do ADR-003 (`visibility`, `restrictions`, `permissions`) **nunca foram materializados** no banco de produção |
| `BioCultRelatos` | Absorve K1–K8 e o contrato de `docs/contrato-harvest.md` como restrição de projeto **antes da primeira linha de código** — momento mais barato. Inclui **upload de mídia como registro primário** (K8.1), participantes de gravação coletiva com decisão de acesso própria (K8.3) e a condição de aceitação em dez cenários (§7 do contrato) |
| `BioCultNaturalistas` | `docs/decisions/ADR-003` V2 ainda precisa remover `bcn_taxons → $.nomeCientificoAtual` (pendência da v3.6.0, ADR-014 N3 — **não é desta sessão**) |
| `dadosEtnoJBRJ_Panara` | `docs/esclarecer.md:218-221` pergunta sobre CLPI, ética, FUNAI e SisGen, sem resposta registrada |

---

## 7. Mapa de dependências

```mermaid
flowchart TD
    A["ADR-015 · Proposto ✔"] --> P1["Passo 1 ✔<br/>ADR-003 retificado"]
    A --> P2["Passo 2 ✔<br/>ADR-004 D6 retificado"]
    P1 --> P3["Passo 3 ✔<br/>contrato de payload"]
    P2 --> P3
    Q1["① detentor<br/>DECISÃO"] --> P4["Passo 4<br/>esquema do Relato"]
    Q2["② rótulos<br/>DECISÃO"] --> P4
    C["Conversa com<br/>a comunidade"] --> Q1
    C --> Q2
    C --> P5["Passo 5<br/>piloto Panará"]
    P3 --> P5
    P4 --> P5
    P5 --> F["ADR-015 → Aceito"]
    style A fill:#28a745,color:#fff
    style P1 fill:#28a745,color:#fff
    style P2 fill:#28a745,color:#fff
    style P3 fill:#28a745,color:#fff
    style C fill:#fd7e14,color:#fff
    style F fill:#1168bd,color:#fff
```

---

## 8. Onde está cada coisa

| Artefato | Caminho |
|---|---|
| Estudo completo, fontes verificadas, caso Panará modelado | `conhecimento/caracterizacao-do-conhecimento-tradicional.md` |
| Registro da sessão + **pauta da comunidade (§5)** | `conhecimento/sessao-2026-08-13-decisoes-e-pendencias.md` |
| Decisão de arquitetura | `docs/architecture-decisions/ADR-015-regime-enunciativo-e-rotulagem-de-acesso.md` |
| Contrato de payload do harvest, campo a campo | `docs/contrato-harvest.md` |
| Glossário da federação | `CONTEXT.md` → seção "Conhecimento e evidência" |
| Governança de acesso, CLPI, rotulagem | `governanca/propostaGovernanca.md` §5.1–§5.10 |
| Rótulos SKOS-XL e `accessLevel` | `BioCultDB/bioculttermos/manual/03-rotulos.md` |
| Modelo de relato do projeto Panará | `dadosEtnoJBRJ_Panara/relatos.md` |
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

## 10. Primeira coisa a fazer ao retomar

Os Passos 1–3 estão feitos. O que resta ou depende de decisão, ou depende da comunidade. Escolher entre:

- **"Responda ① e ②"** — destrava o Passo 4 (esquema do Relato). ① só se resolve honestamente perguntando à pessoa; ② tem meio-termo recomendado e não bloqueia o contrato de harvest.
- **"Extraia K6 para ADR próprio"** — se a supersessão do ADR-004 D6 (*Aceito*) por documento *Proposto* incomodar. A nota do Passo 2 deixou o conflito visível em vez de resolvê-lo; extrair K6 é a alternativa registrada.
- **"Prepare a conversa com a comunidade"** — `conhecimento/sessao-2026-08-13-decisoes-e-pendencias.md` §5 já tem o roteiro em linguagem não-técnica; é o caminho crítico de tudo que sobrou.
- **"Promova a ADR-015"** — só depois das seis questões de §"O que esta ADR não decide". Não é opção hoje.
