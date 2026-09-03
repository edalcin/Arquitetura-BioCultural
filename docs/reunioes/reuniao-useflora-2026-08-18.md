# Reunião com o Comitê Gestor do USEFLORA — 18/08/2026

> **Nota de proveniência.** Este documento é um **sumário de reunião**, não uma ata aprovada. As contribuições abaixo estão **parafraseadas** a partir de um resumo automático da gravação e **não foram revisadas pelos participantes**. A reunião ocorreu em 18 de agosto de 2026 e atendeu a uma demanda do Comitê Gestor do USEFLORA, que quis entender melhor e acompanhar o progresso da proposta de arquitetura.

## Objetivo da reunião

Apresentar e discutir a arquitetura federada de dados em desenvolvimento — governança, segurança, padrões semânticos (SKOS-XL / termos do BioCultDB) e tratamento diferenciado de fontes de conhecimento tradicional (artigos científicos, acervos, relatos e naturalistas) — e definir encaminhamentos para governança, indicação de ponto-focal no USEFLORA e próximos passos para incorporação das demandas das comunidades.

## Principais pontos apresentados

- Evolução da arquitetura:
  - Migração e unificação de ferramentas (antigo etnoDB e etnoPapers incorporados no BioCultDB / BioCultPapers).
  - Quatro fontes tratadas de forma independente e federada, com ponto de encontro (Pluriverso) para buscas distribuídas sem centralizar dados.
  - Apoio de IA para extração de evidências de PDFs e curadoria (fluxo de ingestão → curadoria pendente → aprovação/rejeição).
- Padrões e semântica:
  - Adoção do padrão SKOS-XL para organização de termos, conceitos e rótulos; dicionário vivo que permite termos locais/indígenas e mapeamento sem perder variações linguísticas.
  - Sistema de rótulos/etiquetas (chave-valor) para classificar registros (público, restrito, sagrado, privado etc.), com metadados compatíveis com leitura por máquinas (W3C).
  - Manual integrado para orientar curadores sobre distinção termo vs. conceito, relações semânticas e tratamento de termos sinônimos/variantes.
- Governança e soberania dos dados:
  - Arquitetura concebida para respeitar governança dos provedores: cada instância (ex.: BioCultDB de uma instituição ou comunidade) mantém controle físico e decisório (possibilidade de armazenamento local, backup em pen-drive).
  - Registros de acesso (logs) e rastreabilidade para repartição de benefícios e auditoria de uso.
  - Consentimento livre, prévio e informado (CLPI) tratado como ciclo revogável, não apenas formulário estático.
- Segurança e privacidade:
  - Controle de níveis de acesso por rótulos; mecanismos para garantir que conteúdos sensíveis não sejam expostos via Pluriverso público.
  - Atendimento à exigência de não centralizar dados sensíveis em instâncias externas, preservando soberania das comunidades/instituições.
- Diferença entre evidência e conhecimento:
  - Arquitetura distingue "evidências" (p.ex., citações em artigos, coleções etnobotânicas, relatos de naturalistas) e "conhecimento" vivo das comunidades, exigindo tratamento e modelagem diferenciados.
- Implementação prática:
  - Demonstração de telas: painel com 27 referências (testes com dados do USEFLORA [não verificado — a fonte usa "eFlora", grafia possivelmente afetada pela transcrição automática; não é possível confirmar se se refere aos dados do USEFLORA ou a outra base]), curadoria de termos, visualizações por campo semântico (ex.: tipo de uso — medicinal, forma de preparo, indicação terapêutica), e histórico de origem automática (IA).
  - Funcionalidade de consulta via chat/IA integrada.

## Principais dúvidas, comentários e contribuições

- Foi solicitado esclarecimento sobre a autonomia das instâncias federadas frente aos requisitos mínimos da federação; foi explicado que a adesão à federação é voluntária e que cada instância pode possuir campos e extensões próprias, mantendo uma estrutura mínima comum.
- Foi reforçada a importância de compatibilidade com rótulos locais e etiquetas que representam autoridade comunitária.
- Questionou-se como termos sensíveis seriam tratados no sistema integrado (prompt/IA e exposição); foi confirmado que rótulos de sensibilidade são aplicados no banco e controlam a exposição, inclusive no Pluriverso.
- Foi enfatizada a necessidade de discussões no comitê gestor para decisões que não terão resposta imediata.
- Foi perguntado sobre a operacionalização da governança para bases de dados secundárias e primárias, sobre infraestrutura para comunidades (uso de pen-drive e sincronização "quando houver conexão") e sobre como viabilizar a capacitação das comunidades para a gestão das próprias instâncias.
- Foi observada a importância de definir princípios que todos os bancos da federação aceitarão.
- Foram trazidas experiências e referências (ex.: TKDL na Índia, banco de dados do Peru) como modelos de distinção público/privado/confidencial, e foi ressaltada a complexidade do consentimento, do reconhecimento de povos e da rastreabilidade para indústria e academia.
- Foi destacada a dimensão cultural do uso de plantas (alimentício, ritual, cura) e o risco de apropriação indevida.
- Foi manifestado apoio ao esclarecimento sobre governança e interesse em avançar nas modalidades de domesticação e manejo, por serem especificidades relevantes.
- Foi destacada a relevância dos avanços apresentados e a necessidade de clarificar "quem faz o quê" na governança, com sinalização de disposição para contribuições técnicas e feedbacks por e-mail.

## Questões operacionais e propostas de encaminhamento

- Definição de um ponto-focal no USEFLORA: foi solicitado que o USEFLORA designe um ponto-focal para receber novidades, sistematizar demandas e encaminhar decisões que dependem do comitê gestor e/ou das comunidades.
- Avançar governança em três camadas (conforme proposto):
  - Governança da arquitetura (prioridades, evolução tecnológica);
  - Governança das ferramentas (curadoria, interoperabilidade, padrões);
  - Governança dos dados (decisões das comunidades sobre publicação, rótulos, revogação do consentimento).
- Consolidação de princípios mínimos comuns: elaborar e acordar um conjunto de princípios mínimos que as instâncias que optarem pela federação devem aceitar (p.ex.: registro de logs, respeito a rótulos de sensibilidade, suporte ao CLPI como ciclo).
- Planejamento de capacitação e infraestrutura: explorar soluções leves de sincronização (ex.: sincronização via laptop/pen-drive quando houver conexão) para garantir soberania e autonomia das comunidades com baixa conectividade.
- Priorizar fontes secundárias (artigos e acervos) como campo inicial de lapidação da arquitetura, por ser o recorte inicial do projeto, consolidando o modelo antes de ampliar para dados primários, de maior complexidade ética e operacional.
- Registro e documentação: continuar mantendo repositório público com documentação técnica, manuais e exemplos; incentivar que participantes submetam comentários e issues no repositório.

## Riscos, lacunas e pontos a aprofundar

- Governança operacional: falta de definição clara sobre composição e processo decisório do comitê de governança (quem decide o quê e em que prazo); foi proposto que esse seja tema priorizado pelo ponto-focal.
- Escopo de integração de dados primários: relatos e conhecimentos vivos exigem cuidado ético adicional; necessidade de metodologia para validação comunitária e operacionalização do CLPI como ciclo.
- Infraestrutura e capacitação: garantir autonomia tecnológica das comunidades (hardware, conectividade, capacitação em curadoria e uso das instâncias).
- Interação IA / privacidade: necessidade de revisar prompts e processos automáticos de extração para evitar exposição involuntária de informações sensíveis.
- Legislação e propriedade intelectual: desdobrar interface com marcos legais (ex.: legislação nacional, experiências internacionais como TKDL) e risco de uso indevido por terceiros (indústria/academia).

## Observações finais

- Houve consenso quanto à importância de princípios inegociáveis (soberania dos dados, rastreabilidade, CLPI como ciclo, respeito às designações comunitárias) e ao caráter voluntário da federação (cada instância decide se participa e quais campos expõe).
- Foi proposto iniciar o amadurecimento prático na camada de fontes secundárias (artigos, acervos) antes de ampliar para dados primários e relatos diretos das comunidades.
- A documentação técnica e o código continuam abertos em repositório público (licenças devem ser respeitadas), e houve incentivo à colaboração via issues, testes e envio de contribuições escritas.

## Encaminhamentos com responsável e prazo

- **USEFLORA (coordenação)** — indicar ponto-focal para centralizar comunicações e demandas (prazo sugerido: 2 semanas).
- **Eduardo Dalcin** — continuar a implementação e os testes do BioCultDB; disponibilizar atualizações no repositório; evidenciar guia de curadoria e exemplos (contínuo; próxima atualização técnica em 2–4 semanas).
- **Laura Madeira** — enviar por e-mail propostas de governança operacional.
- **Comitê Gestor do USEFLORA** — consolidar os princípios mínimos da federação e validar a proposta de governança em reunião subsequente (prazo sugerido: 4–6 semanas).
- **Participantes técnicos** — submeter testes e notas técnicas sobre extração de dados, prompts e sensibilidade de dados (prazo: 3 semanas).

## Onde cada encaminhamento foi registrado

- As pendências de arquitetura decorrentes desta reunião estão registradas em `docs/proximosPassos.md`.
- As pautas que dependem das comunidades (incluindo a indicação do ponto-focal e a consolidação de princípios mínimos) estão registradas em `docs/conhecimento/pauta-comunidades.md`.
- A demanda por sincronização offline (laptop/pen-drive) para comunidades com baixa conectividade está registrada como nota de retificação em `docs/architecture-decisions/ADR-011-absorcao-biocultpapers.md`.
