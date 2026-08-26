# Application Form — Anthropic's AI for Science Program

Answers prepared for the Google Form. Copy each block into the matching field.
Placeholders marked `[CONFIRM]` need your verification before you submit.
Word counts are given for every field that has a limit.

---

## 1. AI for Science

**Name of primary contact** *
```
Eduardo Couto Dalcin
```

**Name of organization or research institution** *
```
Instituto de Pesquisas Jardim Botânico do Rio de Janeiro (JBRJ) —
Rio de Janeiro Botanical Garden Research Institute, Ministry of Environment, Brazil
```

**Position or title at organization** *
```
Biodiversity Informatics Specialist / Technologist
```

**PI academic or organization email address** *
```
[CONFIRM: institutional @jbrj.gov.br address]
```

**Website of organization or research group, link to Google Scholar or GitHub** *
```
GitHub:https://github.com/edalcin/Arquitetura-BioCultural
Architecture v3.5 (citable): https://doi.org/10.5281/zenodo.21738427
Google Scholar: https://scholar.google.com/citations?user=B5xDi0wAAAAJ&hl=en
Institution: https://www.gov.br/jbrj
```

**Where did you hear about this program?**
```
From a researcher friend
```

---

## 2. Project information

**Project title** *
```
BioCultural Architecture: sovereignty by design in a federated data architecture for
traditional knowledge associated with biodiversity
```

**Scientific field(s) (select all that apply)** *

Select:
- [x] Environmental Sciences
- [x] Computer Science
- [x] Others: `Biodiversity informatics; sociobiodiversity; Indigenous data governance`

> Note: add **Computer Science**. The deliverable is a data architecture, a data model and
> reference software, not only an environmental study. This makes the software-engineering
> use of Claude coherent with the declared field.

**Which Organization ID would you like the credits applied to?** *
```
[CONFIRM: copy the Organization ID from Claude Console → Settings]
```

**What type of Claude account do you have?** *
```
[CONFIRM the plan actually in use — the form shows the second option selected]
```

---

## 3. Research team

**Description of the research team (fewer than 300 words)** * — *271 words*

```
Eduardo Dalcin (PI) is a biodiversity informatics specialist and technologist at JBRJ, the
Rio de Janeiro Botanical Garden Research Institute. He is the author of the BioCultural
Architecture: a citable specification (DOI 10.5281/zenodo.21738427), seventeen Architecture
Decision Records, a Unified Data Model with a ten-point conformance checklist, a field-by-
field federation harvest contract with ten acceptance scenarios, and C4 documentation. He
built and operates BioCultDB, the reference federated unit now in production, which includes
an in-browser LLM pipeline that extracts metadata from PDF sources and a retrieval assistant
over curated evidence. He is a co-author of Pankararu et al. (2026), npj Biodiversity, and a
participant in the open debate started by Zank et al. (2025), Journal of Ethnobiology and
Ethnomedicine.

The team's AI experience is applied, not model development: production LLM extraction
pipelines with a configurable provider, structured-output validation against a canonical JSON
schema, and retrieval over a curated corpus. This is the exact competence the project needs,
because every model output enters a human curation queue before publication.

Key members who will use Claude:

- Eduardo Dalcin (JBRJ) — architecture, reference implementation, extraction pipelines,
  conformance auditing.
- Dr. Viviane Fonseca (JBRJ) — ethnobotany; curation of extracted assertions and of the
  SKOS-XL controlled vocabulary. [CONFIRM role and title]
- Lucas Zelesco (FUNAI, the Brazilian Indigenous affairs agency) — community liaison and free,
  prior and informed consent process for the Panará pilot. [CONFIRM role]
- Luisa Ridolph and Camila Dantas (ENBT/JBRJ graduate school) — historical sources, museum
  collections and naturalist works. [CONFIRM roles]
- USEFLORA Steering Committee — institutional partner; the Unified Data Model is the technical
  object of the JBRJ–USEFLORA cooperation agreement.
```

**Links to Google Scholar or other academic profiles of key team members**

```
Eduardo Dalcin — Google Scholar: [CONFIRM]; ORCID: [CONFIRM];
  GitHub: https://github.com/[CONFIRM]
Viviane Fonseca — Lattes/ORCID: [CONFIRM]
Lucas Zelesco — [CONFIRM]
Luisa Ridolph — [CONFIRM]
Camila Dantas — [CONFIRM]
Architecture and all documentation (open source): https://doi.org/10.5281/zenodo.21738427
```

---

## 4. Research proposal

**Describe your research project (fewer than 500 words)** * — *457 words*

```
SCIENTIFIC QUESTION

Traditional knowledge associated with biodiversity exists in two distinct natures:
Knowledge, which is stated by the holder, and Evidence, which is a third party's attestation
that the relation exists. No current standard represents this distinction. The Darwin Core
Data Package usage-policy table, verified at the primary source, carries copyright fields
only and no cultural protocol field. Current solutions centralise the records in an
institutional repository, so the custodian institution holds the authority over what is
published. Sovereignty is then declared in a consent form, but the architecture does not
sustain it.

The question: how do we design a system architecture, a data structure and data standards
that represent the domain of traditional knowledge without loss, and that at the same time
guarantee the C.A.R.E. principles and the fair and equitable benefit sharing required by
Brazilian Law 13.123/2015? The hypothesis: data sovereignty is a property of the
architecture, not of the use policy, and is therefore verifiable, auditable and reversible.

METHODOLOGY AND APPROACH

Design science. The artefact is both the result and the instrument. Each federated unit is
sovereign: one container, one SQLite file, its own tools. A unit publishes only what it
decides to publish. A harvest middleware, Pluriverso, indexes only what was explicitly
published. Every architectural choice is recorded as an ADR with an explicit state. Contracts
are specified before code: the harvest contract has ten testable acceptance scenarios. A
record of the Knowledge regime without valid consent does not pass the harvest. That is a
test, not a promise. Validation is participatory: six agenda items go to community leaders as
open questions, and a pilot runs with the Panará people.

EXPECTED OUTCOMES AND DELIVERABLES

1. BioCultRelatos, the primary-record unit, implemented with the eight access-labelling
   rules and the harvest contract as an executable test suite.
2. Pluriverso, the federation middleware: harvest client, SQLite and FTS5 index, SKOS
   mapping between unit vocabularies, public API.
3. An ingested corpus of Brazilian ethnobotanical literature and of naturalist works from
   the 17th to 19th centuries, reconciled against Flora e Funga do Brasil and GBIF.
4. A conformance report against the ten-point checklist, produced by tools external to the
   federation.
5. Two peer-reviewed papers: one on the enunciative regime, one on federated architecture as
   an answer to the legal gap of collective data.
6. All code under an OSI licence, all documentation under CC BY 4.0. Traditional knowledge
   data receives no open licence, because an open licence is irrevocable and consent must not
   be.

TIMELINE (6 MONTHS)

Month 1: community validation agenda; freeze the Relato schema; promote the harvest ADR to
Accepted. Months 1-3: BioCultRelatos. Months 2-4: Pluriverso. Months 3-5: historical and
literature corpus ingestion and taxonomic reconciliation. Months 4-6: end-to-end Panará
pilot, conformance measurement, external audit, paper submission.
```

**How specifically will Claude's capabilities be used (200 words max)** * — *178 words*

```
Four tasks, all on public artefacts.

1. Evidence extraction. Claude reads scientific articles, theses and museum records, and
   returns structured JSON that validates against our Unified Data Model: taxon, use, holder
   attribution source, community category, locality, language. Today one curator does this by
   hand, about ten papers a day. Existing rule-based parsers fail because the assertion is in
   running prose, not in fields.

2. Historical sources. Naturalist works from the 17th to 19th centuries need OCR correction,
   old-orthography normalisation, Latin, German and French translation, and the linking of
   vernacular names to accepted taxa. No off-the-shelf tool does this combination. Claude
   does it in one long-context pass.

3. Vocabulary work. Claude proposes SKOS-XL candidate labels, ISO 639-3 language tags and
   mapping candidates between unit vocabularies. The Federated Committee approves or rejects.

4. Engineering. Claude Code implements Pluriverso and BioCultRelatos and writes the ten
   harvest acceptance scenarios as tests.

Hard limit: only Evidence-regime public artefacts go to the API. Knowledge-regime records,
which are community statements, never leave the sovereign unit. Every model output enters a
human curation queue before publication.
```

---

## 5. Impact assessment

**Potential scientific impact (200 words max)** * — *190 words*

```
Three contributions.

First, a data model that treats the Knowledge and Evidence distinction as a first-class
property of the record, with an operational consequence on access labelling. No published
Brazilian model does this. The reference standards describe occurrence and use, not who
speaks. Making the speaker a field of the record changes who may classify access.

Second, empirical evidence on a claim that is asserted but never tested: that sovereignty
guaranteed by topology, rather than by policy, is perceived as sovereignty by the people who
hold the knowledge. The pilot measures this with the community, not for it.

Third, a released corpus of machine-readable evidence about the relation between Brazilian
traditional communities and biodiversity, extracted from scientific literature and from
naturalist works of the 17th to 19th centuries. Much of this material is legible today only
to specialists. Reconciled against current taxonomy, it becomes usable for ethnobiology,
conservation and historical ecology.

The architecture is offered as an adoptable contract, not as a competitor. It already
dialogues with the GEF Entre-Ciências programme (Brazilian Ministry of Science, 2025-2029),
the Sociobiodiversity Knowledge Network, and the modernisation of SISGEN, the national genetic
heritage system.
```

**Applications beyond scientific discovery (200 words max)** — *183 words*

```
Yes. The project is legal and social infrastructure as much as science.

Compliance. Brazilian Law 13.123/2015, the Nagoya Protocol and Article 8(j) of the Convention
on Biological Diversity require consent, traceability of origin and participation of holders.
Today an institution shows a contract clause. This architecture makes the requirement a
testable condition of the system, so a regulator can audit it.

Benefit sharing. Brazilian law gives collective title over traditional knowledge, while the
data protection law protects only the individual holder. The two regimes do not talk to each
other, and no known implementation closes the gap. Making benefit sharing traceable by the
architecture is a direct path to enforcement.

Community use. Each unit is one container and one SQLite file. A community can copy it, move
it, or delete it. This is the scale path: it does not need a national platform, a central
budget or an institutional custodian.

Documented misappropriation cases exist in Brazil, including cupuaçu, ayahuasca, jaborandi
and espinheira-santa. Our governance proposal names seven safeguards with the honest limit of
each one, and states explicitly what the architecture cannot prevent.
```

**How will you measure the success of using Claude (200 words max)** * — *180 words*

```
Extraction quality. Precision and recall of extracted assertions against a gold standard of
200 papers curated by hand. Target: precision above 0.90 on taxon, use and attribution
source, measured before curation. Also the curator rejection rate in the queue, which we want
below 15 per cent.

Throughput. Curated records per curator-week, against the current manual baseline of about
ten papers a day for metadata only, and near zero for assertions. Target: a tenfold increase
in curated assertions.

Historical corpus. Number of pages of naturalist works transcribed, normalised and reconciled
to accepted taxa, with the share of vernacular-name links that a botanist confirms.

Engineering. Whether the ten harvest acceptance scenarios pass as automated tests, and whether
Pluriverso and BioCultRelatos reach production inside the six months. This is binary and
public: the repository shows it.

Conformance. Score on the ten-point checklist of the Unified Data Model, measured by tools
outside the federation.

Negative control. Zero Knowledge-regime records sent to any external API. We measure this by
audit of the request log, and a non-zero count is a project failure, not a metric.
```

---

## 6. Resource requirements

**How much money in extra usage credits do you anticipate you will need?** *
— *~30,000 USD requested*

```
We request 30,000 USD, below the 50,000 USD maximum, for six months.

Breakdown and expected impact:

1. Evidence extraction from literature — 4,000 USD. About 8,000 PDF sources, two passes each:
   one extraction pass and one verification pass with a different prompt. Impact: the corpus of
   secondary sources goes from 29 curated records to a national-scale base. Without credits,
   this stays a manual task and does not finish inside the grant.

2. Historical naturalist works — 7,000 USD. About 60,000 pages, with page images, needing OCR
   correction, old-orthography normalisation, translation from Latin, German and French, and
   vernacular-to-taxon linking. Impact: it unlocks 17th to 19th century evidence that is
   currently legible only to specialists.

3. Engineering with Claude Code — 14,000 USD. Two developers for six months, implementing
   Pluriverso and BioCultRelatos and the harvest test suite. Impact: this is the difference
   between a specification and a running federation.

4. Vocabulary and conformance work — 3,000 USD. SKOS-XL candidate labels, cross-vocabulary
   mapping proposals, and audit of the ten-point checklist.

5. Retrieval assistant during the Panará pilot — 2,000 USD. Query over published evidence
   only.
```

---

## 7. Biosecurity assessment

**Does your research involve any of the following?** *

Select:
- [x] None of the above

> Not selected: pathogen research or virology, drug resistance studies, toxicology, synthetic
> biology. The project studies data architecture and knowledge representation. It records that
> a community states a use of a species. It does not test, isolate, synthesise or assay
> anything, and it holds no laboratory component.

**If you checked any of the above, explain the safeguards** — leave empty, or use this
optional note (*144 words*):

```
Not applicable: the project has no biosecurity dimension. It does have an analogous risk,
which we treat with the same rigour: misappropriation of traditional knowledge, historically
documented in Brazil.

The safeguards are architectural, not declarative. Records of the Knowledge regime never
leave the sovereign unit of the holding community, and never reach any external API. A record
without valid free, prior and informed consent does not pass the federation harvest, which is
an automated test. Consent is a revisable cycle: the community may reclassify or revoke a
record at any time, with no justification. Traditional knowledge data receives no open
licence, because an open licence is irrevocable. Where the correct decision is not to record,
the platform has the obligation to say so.

The work follows Law 13.123/2015, the Nagoya Protocol and the Brazilian data protection law,
and will be submitted to external audit.
```

---

## 8. Additional information

**Is there anything else you would like the review committee to know?** — *161 words*

```
This is not a proposal from zero. The conceptual phase is finished and public: architecture
v3.5 has a DOI, the repository is at v3.10.0, seventeen ADRs are recorded, the Unified Data
Model and the harvest contract are specified field by field, and the reference unit BioCultDB
is in production with an LLM extraction pipeline already in daily use. The credits would fund
the next phase, which is federation and validation, not exploration.

Two points a review committee may want to weigh.

First, our strongest architectural rule limits our own use of Claude: community statements
never reach an external API. We use Claude on published artefacts, on historical works and on
our own code. We state this limit as a feature, not as an apology.

Second, the honest risk. The critical path depends on the agenda of Indigenous leaders, which
does not belong to the researcher. If validation slips, the interim rules stay conservative,
and the engineering and corpus deliverables proceed independently.
```

---

## 9. Terms of Service

- [x] I agree.

---

## Checklist before you submit

| Field | Action |
|---|---|
| PI email | Fill in the institutional address. |
| Organization ID | Copy from Claude Console → Settings. |
| Claude account type | Confirm the plan in use. |
| Scientific field | Add **Computer Science** next to Environmental Sciences. |
| Team roles and titles | Confirm with Fonseca, Zelesco, Ridolph and Dantas. |
| Scholar, ORCID, GitHub URLs | Fill in the five profile links. |
| Credit total | Confirm 30,000 USD, or adjust the corpus sizes in section 6. |
| Corpus estimates | Confirm the 8,000 PDF and 60,000 page figures. |
