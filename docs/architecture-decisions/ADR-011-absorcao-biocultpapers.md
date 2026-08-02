# ADR-011: Absorção do BioCultPapers pelo BioCultDB

## Status

**Aceito** — Agosto 2026

## Contexto

Desde a v2.0, a extração de dados de artigos científicos por IA era feita pelo **BioCultPapers**, aplicativo
desktop Windows (.NET 8/WPF) separado do BioCultDB: o pesquisador selecionava um PDF localmente, o
BioCultPapers extraía metadados via IA (Gemini/GPT/Claude), persistia o resultado localmente e **exportava**
um arquivo JSON que o BioCultDB **importava** por script/rota dedicada (DA6 do ADR-005). Essa entrega por
arquivo era a única ponte entre as duas aplicações — nenhuma sincronização direta de banco.

O projeto BioCultDB absorveu essa funcionalidade. A extração de dados por IA deixa de ser um aplicativo
desktop separado e passa a ser **Extração por IA**, funcionalidade nativa do BioCultDB no **contexto de
Aquisição**, acessível pelo navegador:

- O pesquisador faz upload do PDF diretamente pelo navegador — **o arquivo PDF nunca sai do navegador do
  usuário**.
- O texto extraído do PDF (não o arquivo binário) é enviado ao **Provedor de IA** configurado.
- O resultado da extração vira uma **Evidência** com status `pending`, que entra no mesmo fluxo de
  Curadoria de qualquer outra evidência — sem tratamento especial, sem exportação/importação de arquivo,
  sem aplicativo separado para manter.

A implementação de código desta absorção já está concluída (ver `BioCultDB/.scratch/extracao-por-ia/spec.md`
e `BioCultDB/docs/decisions/ADR-002-extracao-por-ia.md`, no repositório `BioCultDB`). Restam apenas os
ajustes de documentação e comunicação registrados por esta ADR e pelos demais artefatos deste mesmo
repositório (Arquitetura-BioCultural) atualizados junto com ela.

### Premissa corrigida: o BioCultPapers já não usava MongoDB

É necessário registrar explicitamente uma premissa que **não** se aplica a esta decisão, para evitar uma
leitura retroativa incorreta: a motivação da absorção **não foi** eliminar um banco MongoDB separado do
BioCultPapers. Isso já não existia — o BioCultPapers **já havia migrado sua persistência de MongoDB para
SQLite+JSON local** por força do próprio ADR-005 (DA1/DA2), antes desta absorção. O próprio DA6 do ADR-005 já
registrava isso: *"BioCultPapers persiste localmente em SQLite+JSON e exporta um arquivo JSON..."*.

O ganho real desta absorção foi **eliminar a entrega por arquivo** — a ponte manual de exportar/importar um
JSON entre duas aplicações separadas (DA6) — substituindo-a por um fluxo único dentro do próprio BioCultDB.
Não houve troca de motor de banco de dados nesta decisão; o motor já era SQLite+JSON dos dois lados desde o
ADR-005.

## Decisão

Absorver a funcionalidade de extração de dados por IA do BioCultPapers para dentro do BioCultDB, encerrando
o BioCultPapers como componente da arquitetura. A decisão se desdobra em quatro pontos (H1–H4):

### H1 — BioCultPapers deixa de ser componente do ecossistema arquitetural

O BioCultPapers deixa de existir como aplicativo separado na arquitetura federada. Sua funcionalidade é
absorvida pelo BioCultDB (contexto de Aquisição); não há mais um componente `.NET 8/WPF` desktop no
inventário de componentes ativos.

### H2 — Extração por IA roda no navegador e no BioCultDB; PDF nunca sai do navegador do usuário

O upload do PDF, a extração de texto e o envio ao Provedor de IA acontecem dentro do fluxo do BioCultDB no
navegador do usuário. O arquivo PDF em si nunca é enviado a nenhum servidor além do próprio BioCultDB — o
Provedor de IA recebe apenas o texto extraído, nunca o binário do PDF. O resultado é persistido diretamente
no arquivo SQLite+JSON da unidade, como Evidência `pending`.

### H3 — Dados existentes migrados uma única vez via script de importação já existente

Os dados já extraídos pelo BioCultPapers antes da absorção são migrados para o BioCultDB **uma única vez**,
através do mesmo script/rota de importação de arquivo JSON que já existia (DA6 do ADR-005) — não é criado
um novo mecanismo de migração para isso; o mecanismo de entrega por arquivo que esta ADR descontinua para
uso contínuo é reaproveitado como ferramenta de migração pontual.

### H4 — Congelamento do repositório BioCultPapers é decisão de outro ticket

O aviso de congelamento do repositório `BioCultPapers` e as instruções associadas (arquivamento, README de
aviso, etc.) **não fazem parte desta ADR** — são execução de outro ticket, no repositório `BioCultPapers`.
Esta ADR apenas registra, do lado da Arquitetura-BioCultural, que o BioCultPapers deixa de ser um componente
ativo do ecossistema.

## Relações

- Esta decisão **supersede o ponto D7 do ADR-004** ("Posição do BioCultPapers: Exclusivo de Iniciativas de
  Fontes Secundárias") — a distinção que D7 estabelecia (BioCultPapers exclusivo de iniciativas de fontes
  secundárias, comunidades usam BioCultRelatos) deixa de se aplicar porque o BioCultPapers deixa de existir
  como componente independente.
- Esta decisão **supersede parcialmente o ponto DA1 do ADR-005** ("Um arquivo por unidade, compartilhado
  pelas ferramentas, um container por unidade") — especificamente a ressalva de que "BioCultPapers, por ser
  aplicativo desktop fora de container de unidade, não participa deste compartilhamento": essa ressalva
  deixa de se aplicar, porque a extração por IA agora participa do mesmo arquivo/container do BioCultDB como
  qualquer outra funcionalidade da unidade. O restante de DA1 (um arquivo SQLite por unidade, WAL, tabelas
  distintas) permanece inalterado.
- Esta decisão **supersede o ponto DA6 do ADR-005** ("BioCultPapers entrega por arquivo") por completo — não
  há mais exportação/importação de arquivo entre duas aplicações; a Extração por IA grava diretamente no
  banco da unidade (H2 acima).
- As demais decisões do ADR-004 (D1–D4, D6) e do ADR-005 (DA2, DA4, DA7, DA8) permanecem inalteradas.
- O inventário de componentes e os diagramas C4 (containers e componentes) do repositório
  Arquitetura-BioCultural precisam refletir a remoção do BioCultPapers e a adição da Extração por IA como
  funcionalidade do BioCultDB — ver Consequências.

## Consequências

### Positivas

- **Elimina a ponte manual de entrega por arquivo** (DA6) — ponto único de fricção e de possível
  atraso/perda de dados entre extração e curadoria deixa de existir.
- **Um componente a menos para manter**: sem aplicativo desktop `.NET`/WPF separado, sem instalador, sem
  distribuição por plataforma, sem duas bases de código para manter em sincronia funcional.
- **Superfície de exposição do PDF menor**: o arquivo nunca sai do navegador do usuário nem é armazenado
  localmente por um aplicativo desktop; apenas o texto extraído trafega até o Provedor de IA.
- **Resultado entra na Curadoria pelo mesmo fluxo de qualquer Evidência**, sem tratamento especial para dados
  vindos de extração por IA.

### Negativas

- Perde-se a distribuição desktop nativa, útil para uso eventualmente offline/local do fluxo de extração.
  - *Mitigação*: nenhuma prevista nesta ADR — não há demanda reportada por uso offline até o momento; a
    extração por IA já depende de uma API externa (Provedor de IA) para funcionar, portanto já pressupõe
    conectividade.

### Consequências para este repositório (Arquitetura-BioCultural)

O inventário de componentes e os diagramas C4 (Level 2 — Containers, Level 3 — Componentes) deste
repositório precisam refletir a remoção do BioCultPapers e a adição da Extração por IA como funcionalidade
do BioCultDB. Isso é feito, junto com esta ADR, em: `README.md` (inventário de componentes),
`docs/c4-model/02-container-diagram.md` (remoção do container `.NET 8/WPF` do BioCultPapers) e
`docs/c4-model/03-component-diagram.md` (adição do componente Extração por IA dentro do BioCultDB).

## Pendências

- **Vocabulário "Evidência" ainda não federado.** O termo canônico adotado pelo BioCultDB para o resultado
  de uma extração (por IA ou manual) é **Evidência**. Se o BioCultRelatos — ou outro membro futuro da
  federação — usa outro termo para o mesmo conceito, a federação passa a falar duas línguas para a mesma
  coisa. Decisão de vocabulário de arquitetura é matéria do **Comitê Federado** (D3 do ADR-004), não
  decidida por esta ADR: fica registrada aqui como pendência a levar ao Comitê, não como resolução.

## Referências

- [ADR-004: Arquitetura Federada v3.0](ADR-004-federated-architecture.md) — ponto D7 supersedido
- [ADR-005: Persistência SQLite com JSON por Unidade Federada (v3.1)](ADR-005-sqlite-json-persistence.md) —
  pontos DA1 (parcial) e DA6 supersedidos
- `BioCultDB/.scratch/extracao-por-ia/spec.md` (repositório `BioCultDB`) — especificação da funcionalidade
  Extração por IA
- `BioCultDB/docs/decisions/ADR-002-extracao-por-ia.md` (repositório `BioCultDB`) — decisão de implementação
  correspondente no lado do BioCultDB

## Data de Revisão

Revisar quando o BioCultRelatos ou outro membro da federação passar a expor um conceito equivalente a
"Evidência" sob outro nome — momento em que a pendência de vocabulário registrada acima precisa
efetivamente ir ao Comitê Federado para decisão.
