# ADR-010: Documentação Central e Verificação de Build para Mudanças no BioCultTermos

## Status

**Aceito** — Julho 2026

## Contexto

O ADR-007 formalizou a distribuição do BioCultTermos como git submodule compartilhado pelas quatro
unidades federadas (F1), o repositório congelado como produto standalone (F2), propagação por bump de
submodule **não automática nem hierárquica** entre unidades (F3), soberania de dados nunca de código (F4),
generalização obrigatória antes de novas unidades entrarem (F5), e documentação local da integração em
cada unidade hospedeira (F6).

Duas lacunas concretas apareceram na primeira operação real desse padrão em produção (BioCultDB,
julho/2026), nenhuma delas prevista pelo ADR-007:

1. **Nenhum lugar central registra o que mudou no módulo compartilhado.** F6 documenta a *integração* de
   cada unidade (portas, convenções, checklist), não o *histórico de mudanças de código* do módulo em si.
   Uma mudança feita a partir de `BioCultDB/bioculttermos/` e pushada para
   `github.com/edalcin/BioCultTermos` fica registrada só no `git log` desse remoto — sem resumo legível,
   sem indicação de qual unidade originou a mudança, sem nada que uma unidade ainda sem código (ex.:
   BioCultAcervos) possa ler para saber o que mudou desde a última vez que olhou.
2. **Nada garantia que a própria unidade que originou a mudança a refletisse no seu build.** Em julho/2026
   o BioCultDB teve um commit real de bump de submodule que **não apareceu na imagem Docker publicada**:
   `.dockerignore` só ignorava `node_modules/`/`​.git/` na raiz do contexto de build (não em profundidade),
   então um `node_modules` do submodule presente na máquina de build sobrescrevia silenciosamente o
   binário nativo compilado corretamente dentro do container — o container entrava em crash-loop e, por
   causa de `restart: unless-stopped`, o container antigo (código velho) permanecia de pé sem qualquer
   erro visível no fluxo normal de deploy. Além disso os `ARG`/`LABEL` de proveniência de build
   (`GIT_COMMIT`, `BUILD_DATE`) existiam no `Dockerfile.unidade` mas nunca eram passados por
   `docker-compose.unidade.yml` — não havia como, de dentro do container rodando, verificar qual commit
   ele realmente continha.

Esta ADR fecha as duas lacunas **sem alterar F3**: propagação para as demais unidades continua opcional e
não-automática, pela mesma justificativa já registrada no ADR-007 (uma unidade em produção não deve
receber uma mudança não testada só porque outra unidade fez push).

## Decisão

### G1 — Push ao remoto compartilhado e documentação central são obrigatórios; bump entre unidades continua opcional (reafirma F3)

Toda mudança de código feita dentro do submodule `bioculttermos/` de qualquer unidade hospedeira segue
este fluxo, com os passos 1–3 **obrigatórios** e o passo 4 **opcional por unidade**, herdado sem alteração
do ADR-007 F3:

1. Commit + push para o remoto compartilhado (`cd <unidade>/bioculttermos && git push origin main`).
2. Registrar a mudança em `BioCultTermos/CHANGELOG.md` (ver G2) — obrigatório, é o que faz do BioCultTermos
   a documentação central prevista no título desta ADR.
3. Bump do ponteiro do submodule + commit **na unidade que originou a mudança** (obrigatório) — é o que
   faz a mudança aparecer no próximo build/imagem *dessa* unidade (ver G3).
4. Bump do ponteiro nas **outras** unidades hospedeiras (opcional, ADR-007 F3 inalterado) — cada uma
   decide quando incorporar, sem automação nem obrigação de sincronismo.

### G2 — `BioCultTermos/CHANGELOG.md` como documentação central de mudanças

O repositório `BioCultTermos`, já "congelado como produto" pelo ADR-007 F2, passa a ter um papel ativo
adicional: **documentação central de toda mudança de código feita através de qualquer unidade
hospedeira**. Mecanismo: um `CHANGELOG.md` na raiz do repositório, formato
[Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/), uma entrada por mudança relevante, contendo
no mínimo: data, unidade hospedeira de origem, resumo, SHA do commit no remoto compartilhado. Não é
changelog de *release* (o repositório não tem versão própria implantável) — é changelog de *módulo
compartilhado*, para que qualquer unidade (inclusive as três ainda sem código) veja o que mudou sem
precisar ler `git log` do remoto.

**Alternativa descartada**: usar apenas mensagens de commit do remoto compartilhado como documentação —
insuficiente porque não indica a unidade de origem nem agrega o contexto de *por quê*, exigindo que cada
leitor reconstrua isso a partir do diff.

### G3 — Cada unidade hospedeira verifica e carimba seu próprio build antes de publicar

Toda unidade hospedeira com Docker em produção deve, antes de buildar sua imagem:

- **Falhar o build se o submodule local não bater com o commit pinado pelo próprio repositório** (`git
  rev-parse HEAD:bioculttermos` deve ser igual a `git -C bioculttermos rev-parse HEAD`) — evita
  exatamente o cenário do BioCultDB em julho/2026 (submodule desatualizado copiado silenciosamente para a
  imagem).
- **Carimbar a imagem com os commits de ambos os repositórios** (unidade hospedeira + bioculttermos),
  legível de dentro do container em execução (não só como `LABEL` da imagem, que só ajuda *antes* do
  container subir) — permite responder "qual código está rodando agora?" com um único comando.
- **Ignorar `node_modules/`/`.git/` em qualquer profundidade** no `.dockerignore` do contexto de build,
  não só na raiz — mesma causa raiz do incidente de julho/2026.

**Implementação de referência**: `BioCultDB/docker/build-unidade.sh` (roda `git submodule update --init
--recursive`, valida o SHA pinado, exporta `GIT_COMMIT`/`BIOCULTTERMOS_COMMIT`/`BUILD_DATE` como build
args) + `BioCultDB/docker/Dockerfile.unidade` (grava `/app/BUILD_INFO` com os três valores) +
`BioCultDB/verify-container-setup.sh` (lê `/app/BUILD_INFO` como primeiro passo de verificação). Cada
unidade hospedeira que ainda vai construir seu `Dockerfile.unidade` (BioCultAcervos, BioCultNaturalistas,
BioCultRelatos) deve copiar esse padrão quase literalmente, análogo ao que os `integracao.md` de cada uma
já instruem para o `Dockerfile.unidade` em si.

### G4 — Cada `CLAUDE.md` de unidade hospedeira aponta para este fluxo

Para que um agente de IA trabalhando isoladamente em qualquer unidade hospedeira veja a regra
automaticamente (sem precisar já conhecer esta ADR), cada `CLAUDE.md` de unidade hospedeira
(`BioCultDB`, `BioCultRelatos`, `BioCultAcervos`, `BioCultNaturalistas` — os dois últimos ainda sem
`CLAUDE.md`, criados por esta ADR) recebe uma seção curta ("Regra: Mudanças no submódulo
`bioculttermos`") resumindo os 4 passos de G1 e apontando para esta ADR e para o ADR-007.

## Consequências

### Positivas
- Qualquer pessoa (ou agente) olhando o repositório `BioCultTermos` isoladamente vê o que mudou e por
  qual unidade, sem precisar clonar as quatro unidades hospedeiras para reconstruir o histórico.
- O incidente de julho/2026 (mudança commitada mas nunca refletida na imagem em produção) fica
  estruturalmente mais difícil de repetir — falha alto e cedo (no build), não silenciosamente em runtime.
- F3 permanece intacto: nenhuma unidade em produção é forçada a receber uma mudança não testada só
  porque outra unidade fez push — a decisão de quando fazer bump continua exclusivamente da unidade que
  recebe.

### Negativas
- Mais um passo manual (G1.2, atualizar `CHANGELOG.md`) no fluxo de qualquer mudança no submodule —
  quem esquecer, o histórico central fica incompleto.
  - *Mitigação*: aceitável dado o estágio atual (poucas unidades, um mantenedor); revisitar automação
    (ex.: gerar a entrada a partir da mensagem de commit) se o volume de mudanças justificar.
- G3 é trabalho de infraestrutura real (script de build + `.dockerignore` correto + `BUILD_INFO`) que as
  três unidades ainda sem código (BioCultAcervos, BioCultNaturalistas, BioCultRelatos) só vão implementar
  quando o `Dockerfile.unidade` de cada uma for criado — não há nada a executar hoje além de documentar o
  padrão de referência.
  - *Mitigação*: já é exatamente o que o checklist de cada `integracao.md` local instrui ("copiar a
    estrutura de `BioCultDB/docker/Dockerfile.unidade`... quase literalmente") — esta ADR só formaliza que
    o script de build (`build-unidade.sh`) e `BUILD_INFO` fazem parte dessa cópia.

## Relações

- Estende o ADR-007 sem alterar F3 (propagação entre unidades continua opcional/não-automática) — G1
  só torna obrigatórios o push e a documentação central, que já eram implícitos em F3/F6 mas nunca
  ficaram explícitos como passos obrigatórios.
- G3 generaliza para as quatro unidades hospedeiras uma correção de infraestrutura aplicada primeiro no
  BioCultDB (`docker/build-unidade.sh`, `.dockerignore` corrigido, `BUILD_INFO`) — ver commits `112bf52`
  em `BioCultDB` (correção original).
- Usa o padrão de persistência do ADR-005 e a distribuição de código do ADR-007 como base.

## Referências

- [ADR-007: Distribuição do Módulo BioCultTermos via Git Submodule Compartilhado](ADR-007-shared-bioculttermos-module.md)
- [ADR-005: Persistência SQLite com JSON por Unidade Federada (v3.1)](ADR-005-sqlite-json-persistence.md)
- `BioCultDB/docker/build-unidade.sh`, `BioCultDB/docker/Dockerfile.unidade`, `BioCultDB/verify-container-setup.sh`
- `BioCultTermos/CHANGELOG.md`

## Data de Revisão

Revisar quando a primeira unidade além do BioCultDB (BioCultAcervos, BioCultNaturalistas ou
BioCultRelatos) implementar seu próprio `Dockerfile.unidade` — confirmar que o padrão de G3 foi copiado
corretamente, e que o `CHANGELOG.md` central (G2) está sendo mantido em uso real por mais de uma unidade.
