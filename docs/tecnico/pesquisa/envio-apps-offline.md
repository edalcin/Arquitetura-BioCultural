# Pesquisa — como apps offline enviam dados a um agregador web

> Resolve o ticket [#38](https://github.com/edalcin/Arquitetura-BioCultural/issues/38) do mapa
> [#36](https://github.com/edalcin/Arquitetura-BioCultural/issues/36). Testa as 12 decisões de
> [#37](https://github.com/edalcin/Arquitetura-BioCultural/issues/37) (26/10/2026) contra o que
> CoMapeo, ODK Central/Collect, KoboToolbox, GBIF IPT e Mukurtu Mobile fazem de fato.
> Pesquisa de 26/10/2026; nenhum código foi escrito nem executado.

## 0. Como ler

- Termos de [`CONTEXT.md`](../CONTEXT.md): **Custódia Local**, **Envio**, **Harvest**, **Unidade Federada**,
  **Pacote de Vocabulário**, **Fonte de Atribuição**. "Sincronizar" só aparece ao descrever as ferramentas
  estudadas, que o usam.
- Cada afirmação sobre uma ferramenta aponta para a fonte primária (documentação oficial, especificação ou
  código-fonte do próprio projeto). O que não consegui confirmar numa fonte primária está marcado
  **[não verificado]**; o que é conclusão minha, e não da fonte, está marcado **[inferência]**.
- O que o contrato atual diz está em [`contrato-harvest.md`](../contrato-harvest.md) (aqui, "contrato"),
  [ADR-004](../architecture-decisions/ADR-004-federated-architecture.md),
  [ADR-006](../architecture-decisions/ADR-006-federation-membership-protocol.md),
  [ADR-009](../architecture-decisions/ADR-009-pluriverso-multi-instance-topology.md) e
  [ADR-016](../architecture-decisions/ADR-016-contrato-de-harvest.md).

## 1. Resumo para quem decide

1. **Nenhuma ferramenta estudada tem a combinação que decidimos** (o aparelho é a fonte da verdade, só o
   público sai, e a pessoa pode retirar tudo depois). O mais próximo é o CoMapeo (o aparelho edita e apaga, e
   isso se propaga), mas ele replica *tudo* a quem está no projeto, sem filtro de nível de acesso.
   KoboToolbox e ODK fazem o oposto: depois de enviado, o dado é do servidor e o aparelho não edita nem apaga.
2. **O desenho de Envio se confirma na estrutura** (envio manual, lotes que recomeçam, recibo, credencial por
   aparelho, aprovação humana). Há **cinco ajustes concretos** (§5): chave de idempotência por contador e não
   por relógio; *tombstone* uniforme e só para o que já foi enviado; backup do Android também fora da
   transferência entre aparelhos; entrega única da credencial após a aprovação; e o vínculo de mídia, que
   **não cabe em `relatedResources` como o contrato está escrito**.
3. **Retirar nunca é recolher.** CoMapeo, GBIF e ODK deixam isso explícito: quem já copiou, copiou. O texto que
   a comunidade lê ao apertar "retirar tudo" precisa dizer isso em palavras simples (§5, decisão 5).
4. **Viabilidade técnica:** *app-image* do Windows por `jpackage` roda sem instalador e sem WiX; SQLCipher
   oficial tem edição Community para Android, e no desktop JVM a opção que encontrei é o SQLite3 Multiple Ciphers em modo
   compatível com SQLCipher; SQLite em `DELETE` num pen-drive é seguro **se** cada transação for gravada na hora
   (a leitura "gravação ao fechar" de #37 é perigosa). Dois detalhes derrubam a promessa de "não deixa rastro"
   do pen-drive se não forem tratados: o Skiko (motor gráfico do Compose) desempacota binários em
   `~/.skiko` e o driver SQLite JDBC desempacota em `java.io.tmpdir` (§4).

## 2. Fichas das ferramentas

Quadro-resumo (detalhes e fontes nas fichas, §2.1 a §2.5):

| Eixo | CoMapeo | ODK Collect + Central / KoboCollect | GBIF IPT → GBIF | Mukurtu Mobile → Mukurtu CMS |
|---|---|---|---|---|
| Direção | Dois sentidos, par a par e com servidor-arquivo (*Remote Archive*) | Só do aparelho ao servidor; o formulário vem do servidor | O IPT *publica* um arquivo; o GBIF *busca* (modelo Harvest) | Dois sentidos: seleciona-se conteúdo no site para levar ao aparelho; o aparelho envia o que criou |
| Protocolo | Replicação de logs (Hypercore) sobre WebSocket, fluxo cifrado Noise | HTTP `POST` multipart (OpenRosa) | HTTP: Darwin Core Archive + EML; registro no Registry do GBIF | HTTP para o CMS (API própria) [não verificado] |
| Credencial do aparelho | Identidade própria do aparelho (chave raiz), papel dado por um Coordenador | Central: *App User* com token (por formulário); Kobo: usuário e senha da conta | Não há aparelho: há usuário do IPT e token da organização para registrar | Usuário e senha do CMS; permissões vêm dos protocolos culturais |
| Revogar | Coordenador remove o aparelho; só vale quando o aparelho encontra alguém que saiba | Central: "Revogar" encerra a sessão do token na hora; Kobo: trocar a senha / retirar permissão | Apagar o recurso (do IPT, ou do IPT e do GBIF) | Desativar o usuário no CMS [não verificado] |
| Lote e retomada | Replicação incremental por natureza | Um envio por registro; arquivos grandes em vários `POST` com o mesmo XML | Tudo ou nada; falhou, volta à versão anterior | Fila local; envia quando houver rede |
| Idempotência | Versões e *links* nos documentos | `instanceID` único; XML diferente com o mesmo ID = `409` | Registro identificado por `occurrenceID` | [não verificado] |
| Exclusão | Documento com `deleted = true` | Central: apaga com 30 dias para restaurar, depois remove de vez; Kobo/Collect: aparelho não apaga depois de enviar | Ausente do arquivo = apagado no GBIF; ou apagar o dataset inteiro | Remover do aparelho não apaga do site |
| Cifra no aparelho | Chave raiz no Keystore; senha de acesso ao app | Só ao finalizar, se o formulário for cifrado (chave pública) | Não se aplica (servidor) | [não verificado] |
| Backup | O servidor-arquivo é cópia de segurança | O servidor é o destino; aparelho pode apagar após enviar | Cópia do diretório de dados do IPT | O servidor |
| Mídia | Blobs separados dos dados; servidor guarda | Partes do mesmo envio | Referência por URL (extensão multimídia) [não verificado] | Sobe para o CMS |
| Vários destinos | Um projeto, servidor-arquivo configurável [quantidade não verificada] | Collect aceita vários *Projects*, cada um com seu servidor | Qualquer coletor lê o arquivo publicado | Um site por vez |
| Plataformas | App móvel e app desktop sobre o mesmo núcleo | Collect: Android. Kobo: Android + web | Servidor Java | **iOS**; Android "planejado" |

### 2.1 CoMapeo (`comapeo-core`, `comapeo-cloud`, documentação)

- **Arquitetura.** O `comapeo-core` é a biblioteca "local-first" usada pelos apps móvel e desktop
  ([README](https://github.com/digidem/comapeo-core)). É a mesma lógica de "uma só implementação" da decisão 11.
- **Protocolo de troca.** Dois dispositivos se acham por UDP *multicast* na rede local; com internet, trocam
  pelo servidor-arquivo. O servidor (`@comapeo/cloud`) expõe `GET /sync/:projectPublicId` como WebSocket e
  roda a mesma replicação do aparelho ([`routes.js`](https://github.com/digidem/comapeo-cloud/blob/main/src/routes.js);
  [documentação do *Remote Archive*](https://docs.comapeo.app/docs/setting-up-a-remote-archive/)).
  **O servidor é um par completo**: recebe as chaves de criptografia do projeto em `PUT /projects` e replica
  tudo. Não filtra por nível de acesso; não é um agregador de dados públicos.
- **Autenticação.** O servidor tem **um** token único (`SERVER_BEARER_TOKEN`) e uma lista de projetos
  permitidos (`ALLOWED_PROJECTS`, padrão 1) ([README](https://github.com/digidem/comapeo-cloud)). No código lido,
  o token protege as rotas de leitura (`GET /projects`, etc.); `PUT /projects` e o WebSocket são limitados pela
  lista de projetos e pelo conhecimento da chave do projeto [pode haver outra camada de verificação — não
  verificado]. A autorização do *aparelho* no projeto vem do papel que um Coordenador lhe deu
  ([convites](https://github.com/digidem/comapeo-core/blob/main/docs/concepts/invites.md): convidar, aceitar,
  atribuir papel).
- **Identidade do aparelho.** A chave raiz de 16 bytes é a identidade do aparelho em todos os projetos; **não
  pode ser rotacionada nem recuperada de um backup que não a contenha**. No Android fica embrulhada por uma
  chave AES-256-GCM no `AndroidKeyStore` (`setUnlockedDeviceRequired(true)`, `StrongBox` quando houver), e é
  **excluída do backup** do Android; se o Keystore for apagado por redefinição de credencial em alguns
  fabricantes, o app deve mostrar erro e **nunca regenerar a chave em silêncio**
  ([`root-key-storage-and-migration-plan.md`](https://github.com/digidem/comapeo-core-react-native/blob/main/docs/root-key-storage-and-migration-plan.md)).
  Que os dados em repouso estejam cifrados com essa chave **[não verificado]**: não encontrei isso na
  documentação do núcleo.
- **Revogação.** Só Coordenador remove. A remoção é gravada nos dados do projeto e o aparelho removido **só
  fica sabendo quando encontra um aparelho atualizado** (mesmo roteador ou servidor-arquivo); "se isso não
  acontecer, os aparelhos removidos continuam no projeto até a próxima vez que se conectarem"
  ([remover aparelho](https://docs.comapeo.app/docs/removing-a-device-from-a-project/)). Remover **não apaga** o
  que o aparelho já tem. Encerrar o projeto também não:
  "sem servidor-arquivo e sem roteador comum, não há como confirmar 100% que todos saíram"
  ([encerrar projeto](https://docs.comapeo.app/docs/ending-a-project/)).
- **Exclusão.** Todo documento tem `deleted` obrigatório, além de `createdAt`, `updatedAt` e versões
  ([`comapeo-schema`, `proto/common/v1.proto`](https://github.com/digidem/comapeo-schema/blob/main/proto/common/v1.proto)).
  Conflito entre edições: vale a última, e a documentação avisa isso
  ([como a troca funciona](https://docs.comapeo.app/docs/understanding-how-exchange-works/)).
- **Mídia.** Fotos e áudios são *blobs* num espaço de replicação separado do dos dados
  ([`sync-api.js`](https://github.com/digidem/comapeo-core/blob/main/src/sync/sync-api.js): namespaces `initial`
  com blob index e `data` com dados e blobs); o servidor-arquivo serve as variantes por
  `/projects/:id/attachments/...`.
- **Plataformas.** Móvel (`comapeo-mobile`) e desktop (`comapeo-desktop`) sobre o mesmo núcleo.

### 2.2 ODK Collect + ODK Central, e KoboCollect + KoboToolbox

KoboCollect é o ODK Collect configurado para o servidor Kobo; ambos usam o mesmo protocolo de envio.

- **Protocolo.** [OpenRosa *Form Submission API*](https://docs.getodk.org/openrosa-form-submission/): `POST`
  `multipart/form-data` com uma parte `xml_submission_file` e zero ou mais partes de arquivo; o servidor tem que
  aceitar *chunked transfer*. Recomenda-se um `HEAD` antes (negocia autenticação e canal, e o servidor devolve
  `X-OpenRosa-Accept-Content-Length`, o tamanho máximo recomendado de corpo).
- **Lote e retomada.** Cada formulário é um envio. Se XML mais arquivos passam do limite, o cliente **divide em
  vários `POST`, cada um repetindo o XML**, com um ou mais arquivos; um arquivo maior que o limite vai sozinho.
  Motivo declarado: o cliente não precisa entender o conteúdo, e o custo de reenviar ~2 KB de XML é desprezível.
  **Só vale como enviado após `201` ou `202` com o corpo `OpenRosaResponse`**; `200` "não significa nada" porque
  portais de Wi-Fi e *proxies* respondem `200` ([especificação](https://docs.getodk.org/openrosa-form-submission/)).
- **Idempotência.** O Central exige que o XML não mude entre os `POST` do mesmo `instanceID`; se mudar,
  responde **`409`**. Também devolve `409` se a submissão foi apagada no servidor no meio do envio. Para editar
  uma submissão, o novo XML traz `deprecatedID` com o `instanceID` que substitui; se aquele já foi substituído,
  `409` ([endpoints OpenRosa do Central](https://docs.getodk.org/central-api-openrosa-endpoints/)).
- **Credencial do aparelho.** No Central, o *App User* é um ator com token, preso a **um projeto** e aos
  formulários que o administrador atribuir; só consegue listar formulários, baixá-los e criar submissões. Entra
  no aparelho por QR code com a URL que contém o token. O `deviceId` que vem na submissão é **autodeclarado**,
  não autentica ([contas](https://docs.getodk.org/central-api-accounts-and-users/);
  [submissões](https://docs.getodk.org/central-api-submission-management/)). O Kobo é pior para este fim: o
  aparelho usa o **usuário e a senha da conta** do Kobo, e um QR code replica a configuração em outros aparelhos
  ([KoboCollect](https://support.kobotoolbox.org/kobocollect_on_android_latest.html)).
- **Revogação.** Central: "Revogar" na administração **encerra a sessão do token**, sem apagar o *App User*
  (preserva histórico); excluir o ator é outra operação ([API](https://docs.getodk.org/central-api-accounts-and-users/):
  sem `token` na resposta = acesso revogado; `lastUsed` mostra o último uso). Como a verificação é no servidor,
  a revogação vale no próximo pedido, ao contrário do CoMapeo. Kobo: retirar a permissão "Add submissions" da conta
  ou trocar a senha [inferência: a documentação lista as permissões, mas não descreve a revogação de um aparelho]
  ([permissões](https://support.kobotoolbox.org/managing_permissions.html)).
- **Exclusão.** Central: `DELETE` marca `deletedAt`, **há 30 dias para restaurar**, depois "todos os seus
  recursos e anexos são automaticamente removidos" ([gestão de submissões](https://docs.getodk.org/central-api-submission-management/)).
  No Kobo, "submissões coletadas com o KoboCollect **não podem ser editadas nem apagadas no KoboCollect depois de
  enviadas**; toda mudança posterior é feita no KoboToolbox"
  ([editar e apagar](https://support.kobotoolbox.org/editing_deleting_data.html)). O servidor é o dono.
- **Cifra no aparelho.** Não há cifra do banco do aparelho na documentação. Há **formulário cifrado**: cifra
  assimétrica (chave pública no formulário) **no momento de finalizar**; só quem tem a chave privada decifra
  (via Briefcase), e o servidor não consegue nem exibir os dados
  ([ODK](https://docs.getodk.org/encrypted-forms/); [Kobo](https://support.kobotoolbox.org/encrypting_forms.html)).
  Rascunhos ficam sem essa cifra [inferência: a doc só fala em cifrar ao finalizar]. A senha de administração do
  Collect só trava configurações ([Collect, configurações](https://docs.getodk.org/collect-settings/)).
- **Vários destinos.** A partir da v2021.2 o Collect aceita vários *Projects*, cada um com seus formulários,
  configurações e servidor ([projetos](https://docs.getodk.org/collect-projects/)).
- **Envio pelo usuário ou automático.** O Collect tem "Auto send" (liga/desliga), "Delete after send" (apaga o
  formulário do aparelho ao enviar) e "Finalizar" antes de enviar
  ([configurações](https://docs.getodk.org/collect-settings/); [formulários](https://docs.getodk.org/collect-forms/)).
- **Plataformas.** Collect é Android; não há app desktop portátil de coleta (Briefcase é de extração).

### 2.3 GBIF IPT → GBIF (modelo de publicação)

- **Modelo.** O IPT não "envia": **publica um arquivo e o GBIF busca**. Cada publicação gera uma versão nova,
  completa, do Darwin Core Archive e do EML, e "é tudo ou nada: se um passo falha ou é cancelado, volta-se à
  última versão publicada" ([manual do IPT](https://ipt.gbif.org/manual/en/ipt/latest/manage-resources),
  "Publishing steps"). Cada versão é anunciada ao Registry e por RSS. É o mesmo desenho do Harvest; que o GBIF
  reprocesse o conjunto inteiro é o motivo de não haver `updated_since` ali [inferência].
- **Registro (equivalente de inscrição).** O IPT se registra no Registry do GBIF com o **token compartilhado da
  organização** (pedido ao contato registrado) e uma senha do IPT; recursos "registrados" ficam visíveis ao
  GBIF e a visibilidade de um recurso registrado **não volta a privado**
  ([administração](https://ipt.gbif.org/manual/en/ipt/latest/administration);
  [gestão de recursos](https://ipt.gbif.org/manual/en/ipt/latest/manage-resources)). Equivale ao ADR-006: pedido,
  aprovação humana, credencial.
- **Exclusão e retirada total.** Dentro do arquivo, **um registro que o GBIF já tinha e que sumiu da versão nova
  é tratado como apagado**; a URL do registro fica "obsoleta" ([blog de dados do GBIF, estabilidade de
  identificadores](https://data-blog.gbif.org/post/improve-identifier-stability/)). Retirada total: "Apagar" o
  recurso, com duas opções: **do IPT e do GBIF.org**, ou **só do IPT (órfão)**
  ([manual](https://ipt.gbif.org/manual/en/ipt/latest/manage-resources), "Delete a Resource"). O manual pede
  copiar o diretório do recurso para guardar antes de apagar. Que downloads já feitos continuam acessíveis por
  DOI **[não verificado em fonte primária]**.
- **Idempotência.** Identificador de registro estável (`occurrenceID`); reenviar o mesmo arquivo é inofensivo.
- **Vários destinos.** O arquivo é público: qualquer coletor pode ler.
- **Backup.** A cópia do diretório de dados do IPT é o mecanismo documentado (mesmo manual).

### 2.4 Mukurtu Mobile → Mukurtu CMS

- **Papel.** App companheiro do CMS: cria conteúdo, guarda em fila quando está offline e "sobe" depois; o
  usuário também **seleciona no site** o que quer ver offline ([visão geral](https://mukurtu.org/mobile/);
  [fila](https://mukurtu.org/support/managing-queued-content-in-mukurtu-mobile/);
  [selecionar conteúdo](https://mukurtu.org/support/selecting-content-to-sync-to-mukurtu-mobile/)).
- **Protocolos culturais.** As permissões e papéis do usuário no site "são sincronizados para o app"; criar
  exige papel de contribuidor ou guardião de protocolo no protocolo cultural certo
  ([criar item](https://mukurtu.org/support/creating-a-digital-heritage-item-in-mukurtu-mobile/)). **O filtro de
  acesso é do servidor, não do aparelho**: o oposto da nossa regra, que filtra no aparelho antes de sair.
- **Autenticação.** Usuário, senha e URL do CMS; o app só liga a um site por vez (a barra de status mostra o
  site logado) ([login](https://mukurtu.org/support/logging-in-to-mukurtu-mobile/);
  [layout](https://mukurtu.org/support/mukurtu-mobile-layout/)). O administrador precisa ligar o recurso, que
  vem desligado por padrão "para respeitar expectativas de privacidade" dos sites antigos
  ([habilitar](https://mukurtu.org/support/enabling-and-configuring-mukurtu-mobile/)).
- **Retirada.** Tirar conteúdo sincronizado do aparelho **não apaga nada no site** e é feito pelo site
  ([remover](https://mukurtu.org/support/removing-synced-content-from-mukurtu-mobile/)). Não há "retirar do site pelo
  aparelho".
- **Plataforma e manutenção.** O Mukurtu Mobile 3 é **iOS/iPadOS**; "Android está planejado"; "desenvolvimento
  importante do Mobile 3 não está planejado até depois do lançamento do Mukurtu CMS 4"
  ([página](https://mukurtu.org/mobile/)). O FAQ atual diz que o CMS roda em Drupal 11; se o app já funciona
  com o CMS 4 **[não verificado]**. **Lição:** o app companheiro de um CMS envelhece quando o CMS muda; um app
  Android e Windows nosso precisa de contrato de Envio estável e versionado.
- Os "Hubs and Spokes" do Mukurtu são **rede de apoio e implantação** (centros regionais), não federação de
  dados ([página](https://mukurtu.org/mukurtu-hubs-and-spokes/)). Não há nada ali para o Envio.

### 2.5 Outras ferramentas

Não pesquisei Sapelli, Survey123, EarthRanger, SMART Mobile nem ODK Entities: ficam **[não pesquisado]**. As
cinco acima já cobrem os quatro padrões de envio (replicação par a par, envio de registro por `POST`, publicação
de arquivo-instantâneo, fila do app companheiro).

## 3. O que as ferramentas ensinam

1. **Quem manda tem de provar que mandou; só `201`/recibo conta** (OpenRosa: `200` é ruído).
2. **Reenvio tem de ser seguro**, e o servidor precisa saber distinguir "o mesmo, de novo" de "outro com o mesmo
   identificador" (`409`).
3. **Dar `HEAD`/pré-verificação e deixar o servidor dizer o tamanho máximo do lote** evita o envio perdido
   por limite de proxy.
4. **Revogar no servidor é imediato; revogar num sistema par a par depende de encontro.** Nossa topologia
   (aparelho fala só com o pluriverso) fica do lado fácil.
5. **Retirada nunca alcança quem já copiou** (CoMapeo, ODK, GBIF).
6. **Quem recebe como instantâneo completo ganha a exclusão de graça**, quem recebe incremento precisa de
   marca de exclusão (`deleted`, `deletedAt`). Os dois juntos (incremental + completo periódico) cobrem o furo
   de cada um.
7. **Filtrar por nível de acesso é do servidor em todas as ferramentas** (Mukurtu) ou **não existe**
   (CoMapeo). Filtrar *no aparelho* é novidade nossa, e portanto o contrato e o teste de vazamento (§7 do contrato)
   são o único mecanismo de segurança desse passo.
8. **Senha ou chave perdida = identidade perdida** (CoMapeo diz com todas as letras). Recuperação tem de ser uma
   decisão de governança, não um detalhe de código.

## 4. Fatos de viabilidade

### 4.1 Compose Multiplatform desktop, *app-image* do Windows, pen-drive

- `jpackage --type app-image` gera "somente a imagem da aplicação", sem instalador
  ([visão geral do `jpackage`](https://docs.oracle.com/en/java/javase/21/jpackage/packaging-overview.html)). O
  WiX 3.0+ é exigido para `exe` e `msi` ([mesma página](https://docs.oracle.com/en/java/javase/21/jpackage/packaging-overview.html));
  para `app-image` não aparece o requisito [inferência: a página só o lista para exe/msi].
- O plugin do Compose tem a tarefa `createDistributable` ("cria a imagem final da aplicação, sem instalador") e
  `runDistributable`; exige JDK ≥ 17; **não há compilação cruzada**: o formato de Windows tem de ser gerado em
  Windows, o `.dmg` em macOS ([documentação do Compose](https://kotlinlang.org/docs/multiplatform/compose-native-distribution.html)).
  → três *runners* de CI (Windows, macOS, Linux) para o app do Naturalistas; um (Windows) mais o Android para o
  Relatos.
- **O JRE reduzido pode faltar módulo.** O próprio guia do Compose manda declarar `modules("java.sql")` (ou
  `includeAllModules = true`) quando houver `ClassNotFoundException`
  ([mesma documentação](https://kotlinlang.org/docs/multiplatform/compose-native-distribution.html)). Com JDBC,
  `java.sql` é obrigatório [inferência: JDBC está em `java.sql`].
- **"Roda de pen-drive sem deixar rastro" exige duas correções que o padrão não faz:**
  - O Skiko, que desenha a interface do Compose, descompacta seus binários em
    `${user.home}/.skiko/` por padrão (propriedade `skiko.data.path`)
    ([`SkikoProperties.kt`](https://github.com/JetBrains/skiko/blob/master/skiko/src/jvmMain/kotlin/org/jetbrains/skiko/SkikoProperties.kt);
    [`LibraryLoader.kt`](https://github.com/JetBrains/skiko/blob/master/skiko/src/jvmMain/kotlin/org/jetbrains/skiko/LibraryLoader.kt):
    se a biblioteca estiver em `bin/` do JRE, ele a usa em vez de descompactar).
  - O driver SQLite JDBC descompacta a biblioteca nativa em `java.io.tmpdir`, e há propriedade para trocar o
    diretório ([USAGE.md do `sqlite-jdbc-crypt`](https://github.com/Willena/sqlite-jdbc-crypt/blob/master/USAGE.md)).
  - O `jpackage` aceita `--java-options` e a macro `$APPDIR` para apontar caminhos relativos à pasta do app
    ([`jpackage`, opções](https://docs.oracle.com/en/java/javase/21/docs/specs/man/jpackage.html)).
    **Juntar as duas coisas é a proposta** [inferência; não testada]: `-Dskiko.data.path=$APPDIR/…` e o
    diretório temporário do driver também dentro da pasta do app, para a máquina hospedeira não receber arquivos
    e o pen-drive funcionar em PC com perfil de usuário somente leitura.
- **SmartScreen, AppLocker, antivírus** em PC de lan house ou de escritório podem barrar um `.exe` não assinado
  **[não verificado]**. Teste em máquina real antes de prometer "roda em qualquer PC".
- ~100 MB para o *app-image* com JRE (número de #37) **[não medido]**.

### 4.2 SQLCipher no Android e no desktop JVM

- **Android.** O SQLCipher para Android (Zetetic) tem edição *Community* na Maven Central
  (`net.zetetic:sqlcipher-android`), Android API 23+, arm64/armeabi/x86/x86_64, licença BSD
  ([README](https://github.com/sqlcipher/sqlcipher-android); [licença](https://github.com/sqlcipher/sqlcipher-android/blob/master/LICENSE)).
  Integra-se por classes próprias ou por Room.
- **Desenho.** AES-256-CBC por página, cada página com IV aleatório próprio e HMAC-SHA512; chave derivada por
  PBKDF2-HMAC-SHA512 com **256 000 iterações** por padrão e sal de 16 bytes no início do arquivo;
  **os *journals* de reversão também são cifrados**
  ([projeto](https://www.zetetic.net/sqlcipher/design/)). Há `PRAGMA rekey` para trocar a senha
  ([API](https://www.zetetic.net/sqlcipher/sqlcipher-api/)). Os arquivos temporários só ficam seguros com o
  armazenamento temporário em memória na compilação; a build comunitária pode não trazê-lo **[não verificado]**.
- **Desktop JVM.** A Zetetic não publica driver JDBC comunitário nos meus achados. A opção encontrada é o
  [`sqlite-jdbc-crypt`](https://github.com/Willena/sqlite-jdbc-crypt) (Apache-2.0), que usa o
  [SQLite3 Multiple Ciphers](https://github.com/utelle/SQLite3MultipleCiphers) e tem `SQLiteMCSqlCipherConfig`
  para o esquema do SQLCipher ([USAGE.md](https://github.com/Willena/sqlite-jdbc-crypt/blob/master/USAGE.md)),
  com bibliotecas nativas para Windows, macOS e Linux dentro do JAR
  ([README](https://github.com/Willena/sqlite-jdbc-crypt/blob/master/README.adoc)). **Que um arquivo gerado
  no Android abra no desktop e vice-versa só se sabe testando [não verificado]**: o requisito do backup
  cifrado (decisão 6) depende disso, então vale um teste de ida e volta como critério de aceitação.
- **Chave por senha (pen-drive).** O PBKDF2 do SQLCipher é resistente a força bruta, mas não é *memory-hard*.
  Derivar a chave com Argon2id e entregar o resultado como chave bruta é prática melhor [recomendação minha, sem
  fonte aqui; o formato de chave bruta está no [guia da API](https://www.zetetic.net/sqlcipher/sqlcipher-api/)].
- **Android Keystore.** Guarda a chave sem permitir exportá-la; a doc do Android diz que ele "dificulta a
  extração" ([Keystore](https://developer.android.com/privacy-and-security/keystore)).

### 4.3 SQLite em exFAT / FAT32 e mídia removível

- **Dois arquivos, não um.** No modo `DELETE`, transações usam um `…-journal` e, "se os arquivos de *journal*
  forem movidos, apagados ou renomeados depois de uma queda, a recuperação automática não funciona e o banco
  pode ficar corrompido" ([*How To Corrupt*, 1.3](https://www.sqlite.org/howtocorrupt.html)). Retirar o pen-drive
  no meio de uma gravação **deixa um *journal* quente no disco**; a próxima abertura o recupera, mas um
  gerenciador de arquivos ou um antivírus que "limpe" o arquivo estraga o banco. O aviso do app tem de dizer
  "não mexa nos arquivos da pasta de dados".
- **WAL não é boa ideia.** O WAL exige memória compartilhada e todos os processos no mesmo computador, e o
  arquivo `-wal` "é parte do estado persistente do banco e deve acompanhar o banco quando ele é copiado ou
  movido; separados, transações já confirmadas podem se perder ou o banco corromper"
  ([WAL](https://www.sqlite.org/wal.html)). Copiar o `.db` do pen-drive sem o `-wal` é exatamente o que as
  pessoas fazem. `journal_mode=DELETE` (decisão 6) está certo.
- **O pen-drive pode mentir.** "A maioria dos dispositivos de armazenamento de consumo mente sobre a
  sincronização", há controladores de *flash* sem proteção contra queda de energia que corrompem arquivos
  que nem estavam abertos, e há pen-drives de capacidade falsa
  ([*How To Corrupt*, 3.1, 4.1, 4.2](https://www.sqlite.org/howtocorrupt.html)). Nenhum modo de *journal*
  conserta isso. Mitigações [inferência]: `PRAGMA integrity_check` ao abrir; cópia de segurança
  automática ao fechar, **com a API de *backup* do SQLite e não copiando o arquivo**; e recomendar pen-drive de
  marca.
- **Windows ajuda.** Desde o Windows 10 versão 1809 o padrão é "Remoção rápida": "o Windows não pode guardar
  gravações em cache" e o dispositivo pode ser removido sem "Remover com segurança"
  ([política de remoção](https://learn.microsoft.com/en-us/windows/client-management/change-default-removal-policy-external-storage-media)).
  Quem trocou a política para "Melhor desempenho" volta ao risco: o app deve avisar.
- **O sistema de arquivos.** exFAT e FAT32 não têm permissões nem arquivo de transação confiável.
  Que o SQLite se comporte bem lá depende do `FlushFileBuffers` do Windows e do controlador do pen-drive
  ([*How To Corrupt*, 3](https://www.sqlite.org/howtocorrupt.html)). A documentação do SQLite que li **não trata
  FAT/exFAT por nome** **[não verificado]**: testar (arrancar o pen-drive no meio de gravações repetidas) é
  critério de aceitação, não suposição. FAT32 não guarda arquivo de mais de 4 GB (irrelevante sem mídia no
  banco).
- **Gravar ao fechar.** Se "gravação ao fechar" (decisão 6) significa trabalhar numa cópia local e só copiar
  para o pen-drive no fim, **uma queda de energia, bateria ou remoção antes do fechamento perde a sessão
  inteira**; se significa que o SQLite confirma cada transação no pen-drive (padrão `synchronous=FULL` em
  `DELETE`), o que se perde é no máximo a transação em curso. A pesquisa recomenda a segunda leitura (ver §5).

### 4.4 Backup do Android

- `android:allowBackup="false"` **não desliga a transferência entre aparelhos em alguns fabricantes** a partir
  do Android 12; é preciso `android:dataExtractionRules` com `<device-transfer>` e `<cloud-backup>` excluindo
  o banco e as preferências ([mudanças de backup no Android 12](https://developer.android.com/about/versions/12/backup-restore);
  [*Auto Backup*](https://developer.android.com/identity/data/autobackup)). O CoMapeo faz a exclusão
  por arquivo de regras, não só pelo atributo.

## 5. Confronto com as 12 decisões de #37

Legenda: **Confirma** (a evidência apoia); **Ajusta** (apoia, com mudança concreta); **Contradiz** (a evidência
ou um documento vigente do repositório diz o contrário; vem com o conserto); **Fora do alcance** (a pesquisa não
testa).

| # | Decisão (resumo) | Veredito | Em uma linha |
|---|---|---|---|
| 1 | Só documentação nos 6 repositórios | Fora do alcance | Escopo do mapa, não é matéria de pesquisa |
| 2 | DB e Acervos web com Harvest; Relatos Android + pen-drive; Naturalistas desktop | **Confirma** | Push (ODK) e pull (IPT) convivem; Android é o que falta ao Mukurtu |
| 3 | Custódia Local e Envio; não usar "sincronizar" | **Confirma** | O campo usa "enviar" para via única e "sincronizar" para duas vias, que Envio não é |
| 4 | Unidade Federada = uma instalação | **Ajusta** | Falta dizer o que acontece ao trocar de celular ou restaurar backup |
| 5 | Só `public`, formato ADR-016, *tombstones*, "retirar tudo", pluriverso sem cópia de segurança | **Ajusta** e **contradiz o contrato §4.2** | *Tombstone* uniforme, só do já enviado; retirada é operação própria; backups do pluriverso entram na conta |
| 6 | SQLCipher, Keystore/senha, backup cifrado, backup do Android off, `DELETE`, "gravação ao fechar" | **Ajusta** | Backup do Android também fora da transferência; gravar por transação; desktop JVM não tem SQLCipher oficial; chave perdida |
| 7 | Módulo só entre web; apps recebem Pacote de Vocabulário | **Confirma** | O CoMapeo faz exatamente isso com o conjunto de categorias; acrescentar versão do pacote em cada lote |
| 8 | Pedido → Comitê → credencial por aparelho e pluriverso → revogação pelos dois lados | **Ajusta** | Entrega única da credencial, token só em cabeçalho, `lastUsed`, aviso ao aparelho revogado |
| 9 | Envio manual, incremental + completo/30 dias, lotes, `id`+`updated_at`, recibo por lote | **Ajusta** | Contador `rev` no lugar de relógio; recibo por registro; completo só aplica no fim |
| 10 | Só metadados e referência; `relatedResources` liga o arquivo | **Contradiz o contrato §6** | `relatedResources` só aponta para *registro*; precisa de campo próprio |
| 11 | Kotlin Multiplatform + Compose para os dois apps | **Confirma, com condições** | Viável; cifra no desktop e rastro no pen-drive pedem decisões extras |
| 12 | Issue `para-ponto-focal` + `fonte-primaria`; ADR *Proposta* | **Confirma** | Mesma lógica do registro no IPT; incluir recuperação de senha na pergunta |

### 5.1 Decisão 2 — forma

Confirma. O ODK envia de aparelho a servidor por `POST`; o IPT publica e o GBIF busca (é o Harvest). O
CoMapeo tem móvel e desktop sobre o mesmo núcleo ([README](https://github.com/digidem/comapeo-core)). O Mukurtu
Mobile é só iOS e adormecido ([mukurtu.org/mobile](https://mukurtu.org/mobile/)): quem queria app Android para
comunidade não tem onde se espelhar. Nenhum contra-argumento.

### 5.2 Decisão 3 — vocabulário

Confirma. "Enviar/submeter" (ODK, Kobo), "publicar" (IPT), "trocar" (CoMapeo, *exchange*) e "sincronizar"
(Mukurtu). Só as duas últimas são de duas vias; Envio é de uma via só (pluriverso não devolve nada ao aparelho,
só recibo e aviso), então "sincronizar" mentiria. O Envio também **não tem direção de volta para dados**: um
pluriverso que editasse um registro enviado seria sobrescrito no Envio seguinte (o aparelho é a fonte); isso é
regra a escrever na ADR central.

### 5.3 Decisão 4 — Unidade Federada = uma instalação

**Ajusta.** Há ganho claro: com um escritor por registro (a instalação), **não há conflito para resolver**; o
CoMapeo precisa de "vale a última edição" justamente porque tem vários escritores
([troca](https://docs.comapeo.app/docs/understanding-how-exchange-works/)). Fica fora o que o CoMapeo trata e a
decisão não: **a identidade é a chave, e a chave não se recupera**
([chave raiz](https://github.com/digidem/comapeo-core-react-native/blob/main/docs/root-key-storage-and-migration-plan.md)).
Para nós: o `id` de cada registro é `<member_id>/<record_id>` e "nunca é reaproveitado"
([contrato §3](../contrato-harvest.md)). Se o `member_id` for o da instalação, **restaurar o backup num
celular novo cria uma instalação nova**, e todos os registros ganham `id` novo, duplicando o que o pluriverso já
tem. Proposta:

- separar **`member_id`** (da comunidade/pessoa, nasce na aprovação, vai no backup cifrado) de **credencial do
  aparelho** (nasce por aparelho, não vai no backup);
- trocar de celular = restaurar o backup + **novo pedido de credencial** para o mesmo `member_id` (aprovação do
  Comitê) + revogar a credencial antiga; é compatível com o ADR-006 E5 (não se reciclam `member_id` para
  **outro** solicitante);
- o pluriverso aceita **uma credencial ativa por `member_id` e por pluriverso** (evita dois escritores).
  Duas credenciais ativas no mesmo `member_id` voltam ao problema de conflito do CoMapeo, e a decisão perde
  a vantagem que a justifica.

"Troca entre aparelhos fica fora" continua verdadeiro: a proposta não troca dados entre aparelhos vivos, só
cobre a substituição de um por outro.

### 5.4 Decisão 5 — só `public`, *tombstones*, "retirar tudo"

**Ajusta**, e **contradiz o contrato de Harvest §4.2** ("registro de nível superior não aparece na resposta, e
não aparece nem como *tombstone*"). A contradição é só aparente e se resolve assim:

- No **Harvest** o pluriverso puxa a lista; um registro que deixou de ser `public` simplesmente some, e por isso
  o contrato proíbe *tombstone* (o nível não pode vazar). O contrato, porém, já reconhece a lacuna: o cenário 7
  exige que o índice remova o registro, "pela mesma operação de `purge`", sem dizer como o pluriverso descobre.
- No **Envio** o aparelho empurra, e **empurrar "nada" não apaga nada**. É preciso mandar uma marca de exclusão
  para tudo o que o pluriverso já recebeu. O que o contrato protege é a existência de registros **nunca
  enviados**; um registro já enviado já era público. Proposta: o *tombstone* do Envio é **só `{id, rev, deleted:
  true}`, idêntico** para registro apagado, rebaixado de nível (`restricted`, `community-only`, `private`) e
  retirado por revogação de consentimento (§7, cenários 7 e 9, ADR-015 K8.3). Sem motivo, sem nível. O
  pluriverso, que já sabia do registro, nada aprende de novo.
- O aparelho precisa guardar, **por pluriverso**, o conjunto do que já enviou (`id` e `rev` enviados), senão não
  sabe para quais registros mandar *tombstone*, e não pode afirmar que "nada não público sai" quando o nível muda
  depois do envio. O CoMapeo e o Central têm o equivalente (`deleted`, `deletedAt`;
  [esquema](https://github.com/digidem/comapeo-schema/blob/main/proto/common/v1.proto),
  [Central](https://docs.getodk.org/central-api-submission-management/)).
- A **emenda ao contrato §4.2** fica pedida: "no Harvest, nunca; no Envio, só para `id` já enviado e sem
  motivo".
- *Tombstone* **só some do aparelho** depois de um recibo **e** de um Envio completo bem-sucedido (a garantia que o
  GBIF dá ao tratar "ausente do arquivo" como apagado:
  [blog de dados do GBIF](https://data-blog.gbif.org/post/improve-identifier-stability/)). Guardar
  *tombstone* para sempre cresce sem limite; apagar cedo demais deixa o aparelho **ressuscitar** o registro
  se o pluriverso nunca recebeu a exclusão.
- **"Retirar tudo" é operação própria**, não N *tombstones*: equivale ao "Apagar do IPT e do GBIF.org" do manual
  do IPT ([manual](https://ipt.gbif.org/manual/en/ipt/latest/manage-resources)) e ao `purge_by_member` do ADR-004 D4.
  Deve ser **idempotente, retomável e confirmada por recibo**, e o aparelho precisa guardar que ela está pendente
  até o recibo, senão a pessoa fecha o app achando que retirou.
- **Retirada não alcança quem já copiou.** O CoMapeo diz: remover "não apaga nem limpa os dados já sincronizados
  e guardados no aparelho" ([remover aparelho](https://docs.comapeo.app/docs/removing-a-device-from-a-project/)).
  Texto sugerido para a tela (palavras simples): *"Ao retirar, seus registros somem do pluriverso. Quem já copiou
  ou baixou antes continua com a cópia; nós não temos como pedir de volta."*
- **Sem cópia de segurança no pluriverso.** Confirma o espírito (o servidor-arquivo do CoMapeo é o oposto: é
  backup completo), mas fica um furo: o **backup operacional do próprio pluriverso** (arquivo SQLite, ADR-005) contém
  o que foi enviado. Uma retirada sem *tombstone* aplicado a esses backups ressuscita dados ao restaurar.
  Proposta: registrar, por `member_id`, as retiradas (sem conteúdo, só `id` e data) e **reaplicá-las depois de
  qualquer restauração**; e fixar um prazo máximo de guarda dos backups do pluriverso. Isso é uma exceção
  mínima à frase "o pluriverso não guarda cópia" e deve estar escrita na ADR, não implícita.

### 5.5 Decisão 6 — proteção local

**Ajusta.**

- *Keystore para chave do banco no Android:* **confirma**. É o desenho do CoMapeo (AES-GCM no `AndroidKeyStore`,
  `setUnlockedDeviceRequired`, `StrongBox` se houver, blob fora do backup)
  ([doc](https://github.com/digidem/comapeo-core-react-native/blob/main/docs/root-key-storage-and-migration-plan.md)).
  Acrescentar o que o CoMapeo aprendeu: **nunca recriar o banco em silêncio** se o Keystore for apagado; o app
  mostra erro e oferece restaurar do backup cifrado.
- *Backup automático do Android desligado:* **insuficiente como escrito**. `allowBackup="false"` não impede a
  transferência entre aparelhos em alguns fabricantes, no Android 12+
  ([Android 12](https://developer.android.com/about/versions/12/backup-restore)). Exigir
  `dataExtractionRules` excluindo banco e preferências em `cloud-backup` **e** `device-transfer`.
- *Backup = arquivo cifrado com a senha da comunidade:* **confirma**, com dois cuidados. (1) A senha da
  comunidade é de **recuperação única**: sem ela o backup é lixo, como a chave raiz do CoMapeo. A pergunta à
  Ponto-Focal (decisão 12) deve incluir "quem guarda a senha" e "o que acontece se ela se perder". (2) O backup
  se faz com a API de *backup* do SQLite ou `VACUUM INTO`, não copiando arquivo (§4.3), e o arquivo cifrado deve
  abrir nos dois sabores de SQLCipher (§4.2).
- *Pen-drive, `journal_mode=DELETE`:* **confirma** (WAL separa `-wal` do banco ao copiar:
  [WAL](https://www.sqlite.org/wal.html)). Acrescentar `locking_mode=EXCLUSIVE` para impedir duas instâncias no
  mesmo banco [inferência; ver [PRAGMA](https://www.sqlite.org/pragma.html)].
- *"Gravação ao fechar":* **ajustar a redação**. Gravar cada transação confirmada no pen-drive
  (`synchronous=FULL`, padrão em `DELETE`) e **fazer a cópia de segurança ao fechar**, não confirmar ao
  fechar. O aviso de "feche antes de remover" fica, e o Windows "Remoção rápida" (§4.3) ajuda. Teste de
  aceitação: arrancar o pen-drive em laço durante gravações.
- *Naturalistas, criptografia opcional:* **confirma**. O ODK também deixa a cifra como opção de formulário.
  Sem SQLCipher oficial na JVM, a opção é o SQLite3 Multiple Ciphers (§4.2); documentar que o formato é
  "compatível com SQLCipher" e não "SQLCipher", e testar.

### 5.6 Decisão 7 — Pacote de Vocabulário

Confirma. O CoMapeo distribui o **conjunto de categorias** como dado do projeto, atualizado de forma passiva
entre os aparelhos ([troca](https://docs.comapeo.app/docs/understanding-how-exchange-works/)); o ODK versiona
o formulário e cada submissão leva a versão com que foi preenchida ([formulários do Central](https://docs.getodk.org/central-api-form-management/)
[a parte de versão: não verificado em detalhe]). Acréscimo: **o Envio leva o identificador e a versão do
Pacote de Vocabulário usado** em cada lote, para o pluriverso interpretar termos antigos. O contrato de formato
com testes comuns é o que impede os dois apps (Kotlin) de divergirem do Módulo Compartilhado (código das unidades web).

### 5.7 Decisão 8 — inscrição de apps

**Ajusta.** O desenho (pedido → aprovação humana → credencial por aparelho → revogação) é o que o IPT faz no
registro com token da organização ([administração](https://ipt.gbif.org/manual/en/ipt/latest/administration)) e o
Central no *App User* ([contas](https://docs.getodk.org/central-api-accounts-and-users/)). O **hash-só-no-servidor**
é mais rígido que o do Central, que mostra o token ao administrador (campo `token` na resposta). Ajustes:

1. **Entrega única da credencial.** O app ainda não tem credencial quando pede. Se o pluriverso devolve o
   token a quem consultar o pedido, qualquer um que descubra o identificador do pedido o pega. Proposta: o app
   gera um segredo de retirada aleatório no pedido e guarda; depois da aprovação, o pluriverso entrega o token
   **uma vez**, a quem apresentar esse segredo, e descarta a cópia em claro (guarda só o *hash*).
2. **Token só em cabeçalho `Authorization`, nunca em URL.** O Central usa a URL do QR com o token embutido
   para o *App User* ([autenticação](https://docs.getodk.org/central-api-authentication/)), o que o põe em log
   e histórico. O CoMapeo Cloud usa `Authorization: Bearer` com comparação de tempo constante
   ([`routes.js`](https://github.com/digidem/comapeo-cloud/blob/main/src/routes.js)).
3. **`lastUsed`** por credencial, como o Central expõe: o Comitê vê aparelhos adormecidos e pode revogá-los.
4. **O aparelho revogado precisa saber por quê.** O CoMapeo notifica com o motivo escrito pelo Coordenador
   ([remover aparelho](https://docs.comapeo.app/docs/removing-a-device-from-a-project/)). Aqui, resposta
   `401`/`403`/`410` com motivo; o app mostra em palavras simples e **para de tentar**.
5. **Revogação é imediata no pluriverso e só vale no aparelho no próximo contato** (o CoMapeo tem o mesmo
   limite, bem pior): o pluriverso recusa a credencial no próximo pedido, e o aparelho só descobre ao tentar.
   Dizer isso no resumo para a gestão.
6. **"Comitê retira dados sem o aparelho"** é o `purge_by_member` do ADR-004 D4, sem carência (o Central tem
   30 dias de lixeira; para retirada a pedido da comunidade, não cabe lixeira). Registrar quem pediu e quando,
   sem conteúdo.
7. **Revogação pelo lado do aparelho** ("desligar deste pluriverso"): apaga o token local; opcionalmente
   dispara "retirar tudo" antes. São ações separadas na tela.
8. O ADR-006 E1/E3 pressupõem uma URL-BASE e um *probe*. Para apps não há URL; a decisão já dispensa o probe, e a
   ADR-006 precisa de um tipo de membro sem URL-BASE. O E4 (autenticação da decisão do Comitê) continua
   **bloqueador** para aprovar apps.

### 5.8 Decisão 9 — Envio

**Ajusta.**

- *Idempotência por `id` + `updated_at`:* **frágil**. Celulares offline têm relógio errado; a restauração de backup
  traz `updated_at` antigos; dois eventos no mesmo instante empatam. Nenhuma ferramenta estudada confia no
  relógio: o Central usa `instanceID` com cadeia `deprecatedID` e responde `409` a mesmo ID com conteúdo diferente
  ([endpoints](https://docs.getodk.org/central-api-openrosa-endpoints/)); o CoMapeo tem versões e *links* por
  documento. Proposta: cada registro leva um **`rev` inteiro** que sobe a cada alteração local; a chave de
  idempotência é `(id, rev)`; o servidor guarda o maior `rev` visto e o *hash* do conteúdo; mesmo `(id, rev)` com
  *hash* diferente = `409`; `rev` menor que o guardado = ignora (e o *tombstone* com `rev` maior vence).
  `updated_at` fica como informação e continua obrigatório no payload do contrato.
- *Recibo por lote:* **insuficiente sozinho**. O OpenRosa dá status por submissão, e lote com sucesso parcial é
  o normal. O recibo deve listar, por item, aceito / ignorado por `rev` / rejeitado com motivo (inclusive "nível
  efetivo diferente de `public`" como erro de validação, equivalente ao cenário 6 do §7 do contrato).
- *Só vale o recibo, não o `200`:* adotar a regra do OpenRosa (só `201`/`202` com envelope válido conta), porque
  portais de Wi-Fi respondem `200` ([especificação](https://docs.getodk.org/openrosa-form-submission/)).
  No nosso caso: corpo do recibo com o `batch_id` ecoado e assinatura/estrutura validada.
- *Tamanho do lote:* o servidor informa o limite máximo (`X-OpenRosa-Accept-Content-Length`) num `HEAD` ou
  resposta anterior; o app divide o lote. Como não há mídia no Envio, o lote é só de JSON e o limite raramente
  pesa; a regra continua útil por causa de *proxies*.
- *Retomada:* lote determinístico ordenado por `rev` e `batch_id` guardado; retentativa repete o mesmo lote,
  seguro porque o servidor é idempotente. Mesmo desenho do Collect/OpenRosa, que reenvia o XML a cada `POST`.
- *Completo a cada 30 dias:* **confirma o desenho**, com uma regra: o Envio completo é "tudo ou nada" como a
  publicação do IPT ([manual](https://ipt.gbif.org/manual/en/ipt/latest/manage-resources)). O pluriverso só
  aplica as **exclusões por ausência** quando recebe o manifesto final do completo; um completo interrompido não
  apaga nada. Com isso o completo também **limpa *tombstones* antigos** e conserta divergências por perda de
  recibo. Cuidado: completo vindo de backup velho **não deve ressuscitar** o que o pluriverso já retirou (veja o
  registro de retiradas na decisão 5).
- *Por pluriverso:* **confirma**: o Collect tem um *Project* por servidor com configuração própria
  ([projetos](https://docs.getodk.org/collect-projects/)), e o Mukurtu só fala com um site de cada vez. Cursor
  (`rev` já recebido) e conjunto de enviados são **por pluriverso**.
- *A pessoa aperta "Enviar":* **confirma**; o Collect também tem envio manual e "Auto send" opcional
  ([configurações](https://docs.getodk.org/collect-settings/)), e o mapa já deixou o envio automático fora.
- *Depois de enviar, o aparelho continua dono:* **diferença que importa.** No Kobo, depois de enviado o aparelho
  não edita nem apaga ([editar e apagar](https://support.kobotoolbox.org/editing_deleting_data.html)).
  Aqui a pessoa edita e retira, e isso é um Envio novo (`rev+1`). É o modelo do CoMapeo, não o do Kobo; a ADR
  deve dizer que o pluriverso é **índice derivado**.

### 5.9 Decisão 10 — mídia

**Contradiz o contrato §6 como escrito; ajusta.** A direção (só metadados e referência) confirma: o IPT publica
referências a mídia, o Central deixa os arquivos em partes do envio por serem pesados, e o CoMapeo separa
*blobs* do resto do fluxo e serve variantes
([`sync-api.js`](https://github.com/digidem/comapeo-core/blob/main/src/sync/sync-api.js)). Nenhuma ferramenta
é tão conservadora quanto a decisão; a decisão é compatível com a Custódia Local.

O problema é o meio: "liga por `relatedResources`". O contrato define `relatedResources` como
relação entre **registros** da federação: `externalRelatedResourceID` tem formato `<member_id>/<record_id>`,
`externalRelatedResourceSource` é o endpoint de *harvest* de outro membro, `relationshipType` é o vocabulário
fechado `refers to | same as | derived from`, e `relatedResourceType` ∈ {`MaterialEntity`, `Occurrence`, `Event`}
([contrato §6](../contrato-harvest.md)). Um link para um arquivo de vídeo ou áudio numa hospedagem qualquer não
se encaixa, e ampliar o vocabulário "é ato do Comitê Federado". Opções:

- **A (recomendada):** o link vai em `data`, em campo definido pelo Comitê (pendência ④ do contrato: o conteúdo
  de `data` já é do Comitê), p. ex. uma lista de arquivos com URL, tipo de mídia e o nível declarado. Não mexe no
  vocabulário fechado nem no teste de vazamento.
- B: ampliar o contrato (`relationshipType` ou um novo campo). Mais alterações em quatro documentos.

Duas exigências novas: (1) o nível efetivo do registro inclui o da mídia (quarto eixo do contrato §4.1,
gravações com participantes) e o app **não pode verificar** o acesso do arquivo hospedado fora; a tela deve
perguntar "este link está aberto a qualquer pessoa?" e registrar a resposta; (2) retirar o registro remove o
link, **não o arquivo** (que está fora do nosso alcance): dizer isso na tela de retirada. *Link rot* é risco
aceito [inferência].

### 5.10 Decisão 11 — Kotlin Multiplatform + Compose

**Confirma, com condições.** A razão é a do CoMapeo (um núcleo para móvel e desktop). O ODK, em contraste, mantém
o Collect (Android) e o Enketo (web) separados, o que explica a divergência de comportamento entre os dois.
Viabilidade (§4): *app-image* do Windows por `jpackage`/`createDistributable`, sem instalador, sem WiX
(`app-image`), sem compilação cruzada. Condições:

1. CI com um *runner* Windows para o *app-image* (e macOS/Linux para o Naturalistas).
2. O JRE reduzido pode faltar módulo; testar o *app-image* limpo e declarar `java.sql`.
3. `skiko.data.path` e o diretório temporário do driver SQLite dentro da pasta do app (§4.1), sem o que o
   pen-drive deixa arquivos no PC hospedeiro e quebra em perfil somente leitura.
4. SQLCipher oficial no Android; SQLite3 Multiple Ciphers no desktop; teste de ida e volta (§4.2).
5. Nenhuma das cinco ferramentas estudadas valida a escolha da linguagem em si; a decisão é de custo, não de
   evidência.

### 5.11 Decisão 12 — governança

Confirma. Consistente com o IPT (registro aprovado por humanos) e com o próprio ADR-006 E2 (fila de estados).
Incluir na Issue, além de custódia, responsável pela senha e aparelhos: **o que fazer se a senha se perder**
e **quem pode pedir a retirada total** (pessoa, comunidade, Comitê), já que o CoMapeo mostra que a identidade e
a senha são o ponto único de falha.

## 6. Itens em aberto e não verificados

- Cifra dos dados do CoMapeo em repouso (só a chave raiz está documentada no Keystore).
- Se o Mukurtu Mobile funciona com o Mukurtu CMS 4; comportamento do servidor do Mukurtu ao revogar usuário.
- Interoperabilidade de arquivo SQLCipher (Android) ↔ SQLite3 Multiple Ciphers (JVM); build comunitária do
  SQLCipher e armazenamento temporário em memória.
- Tamanho real do *app-image*; bloqueio de `.exe` não assinado por SmartScreen/AppLocker em PCs de terceiros.
- Comportamento do SQLite em exFAT/FAT32 com remoção abrupta: só se sabe testando.
- Downloads do GBIF depois de apagado o dataset; extensão de multimídia do Darwin Core como referência por URL.
- Quantos servidores-arquivo o CoMapeo aceita por projeto.
- Sapelli, Survey123, EarthRanger, SMART Mobile e ODK Entities não foram pesquisados.

## 7. Fontes

CoMapeo
- [`comapeo-core`](https://github.com/digidem/comapeo-core) — README, [`docs/concepts/invites.md`](https://github.com/digidem/comapeo-core/blob/main/docs/concepts/invites.md), [`src/sync/sync-api.js`](https://github.com/digidem/comapeo-core/blob/main/src/sync/sync-api.js)
- [`comapeo-cloud`](https://github.com/digidem/comapeo-cloud) — README e [`src/routes.js`](https://github.com/digidem/comapeo-cloud/blob/main/src/routes.js)
- [`comapeo-schema`](https://github.com/digidem/comapeo-schema/blob/main/proto/common/v1.proto) — campo `deleted`
- [Chave raiz e Keystore](https://github.com/digidem/comapeo-core-react-native/blob/main/docs/root-key-storage-and-migration-plan.md)
- Documentação: [remover aparelho](https://docs.comapeo.app/docs/removing-a-device-from-a-project/), [encerrar projeto](https://docs.comapeo.app/docs/ending-a-project/), [*Remote Archive*](https://docs.comapeo.app/docs/setting-up-a-remote-archive/), [como a troca funciona](https://docs.comapeo.app/docs/understanding-how-exchange-works/)

ODK e Kobo
- [OpenRosa — *Form Submission API*](https://docs.getodk.org/openrosa-form-submission/)
- Central: [OpenRosa](https://docs.getodk.org/central-api-openrosa-endpoints/), [submissões](https://docs.getodk.org/central-api-submission-management/), [contas e usuários](https://docs.getodk.org/central-api-accounts-and-users/), [autenticação](https://docs.getodk.org/central-api-authentication/)
- Collect: [projetos](https://docs.getodk.org/collect-projects/), [configurações](https://docs.getodk.org/collect-settings/), [formulários](https://docs.getodk.org/collect-forms/), [formulários cifrados](https://docs.getodk.org/encrypted-forms/)
- KoboToolbox: [KoboCollect](https://support.kobotoolbox.org/kobocollect_on_android_latest.html), [permissões](https://support.kobotoolbox.org/managing_permissions.html), [editar e apagar](https://support.kobotoolbox.org/editing_deleting_data.html), [formulários cifrados](https://support.kobotoolbox.org/encrypting_forms.html)

GBIF
- [Manual do IPT](https://ipt.gbif.org/manual/en/ipt/latest/manage-resources) e [administração](https://ipt.gbif.org/manual/en/ipt/latest/administration)
- [GBIF Data Blog — estabilidade de identificadores](https://data-blog.gbif.org/post/improve-identifier-stability/)

Mukurtu
- [Mukurtu Mobile](https://mukurtu.org/mobile/) e artigos de suporte ([fila](https://mukurtu.org/support/managing-queued-content-in-mukurtu-mobile/), [login](https://mukurtu.org/support/logging-in-to-mukurtu-mobile/), [habilitar](https://mukurtu.org/support/enabling-and-configuring-mukurtu-mobile/), [remover](https://mukurtu.org/support/removing-synced-content-from-mukurtu-mobile/), [selecionar](https://mukurtu.org/support/selecting-content-to-sync-to-mukurtu-mobile/))
- [Hubs and Spokes](https://mukurtu.org/mukurtu-hubs-and-spokes/)

Viabilidade
- [`jpackage` — visão geral](https://docs.oracle.com/en/java/javase/21/jpackage/packaging-overview.html) e [opções](https://docs.oracle.com/en/java/javase/21/docs/specs/man/jpackage.html)
- [Compose Multiplatform — distribuições nativas](https://kotlinlang.org/docs/multiplatform/compose-native-distribution.html)
- Skiko: [`SkikoProperties.kt`](https://github.com/JetBrains/skiko/blob/master/skiko/src/jvmMain/kotlin/org/jetbrains/skiko/SkikoProperties.kt), [`LibraryLoader.kt`](https://github.com/JetBrains/skiko/blob/master/skiko/src/jvmMain/kotlin/org/jetbrains/skiko/LibraryLoader.kt)
- SQLCipher: [Android](https://github.com/sqlcipher/sqlcipher-android), [projeto de segurança](https://www.zetetic.net/sqlcipher/design/), [API](https://www.zetetic.net/sqlcipher/sqlcipher-api/)
- JDBC com cifra: [`sqlite-jdbc-crypt`](https://github.com/Willena/sqlite-jdbc-crypt), [SQLite3 Multiple Ciphers](https://github.com/utelle/SQLite3MultipleCiphers)
- SQLite: [*How To Corrupt*](https://www.sqlite.org/howtocorrupt.html), [WAL](https://www.sqlite.org/wal.html), [*Atomic Commit*](https://www.sqlite.org/atomiccommit.html), [PRAGMA](https://www.sqlite.org/pragma.html)
- Windows: [política de remoção de mídia externa](https://learn.microsoft.com/en-us/windows/client-management/change-default-removal-policy-external-storage-media)
- Android: [Keystore](https://developer.android.com/privacy-and-security/keystore), [*Auto Backup*](https://developer.android.com/identity/data/autobackup), [backup no Android 12](https://developer.android.com/about/versions/12/backup-restore)
