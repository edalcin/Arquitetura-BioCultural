# Arquitetura e Mecânica Operacional de Rótulos no Padrão SKOS-XL

## Contextualização e Paradigma de Reificação Lexical

O modelo Simple Knowledge Organization System (SKOS), ratificado como Recomendação pelo World Wide Web Consortium (W3C), estabeleceu uma infraestrutura padronizada para a publicação e partilha de vocabulários controlados, taxonomias e tesauros na Web Semântica. Na sua especificação base (SKOS Core), a organização do conhecimento assenta numa perspetiva estritamente concetual: as entidades nucleares são conceitos abstratos (`skos:Concept`) identificados por URIs (Uniform Resource Identifiers), aos quais são anexadas representações linguísticas diretas por intermédio de literais RDF (`rdf:PlainLiteral`) dotados de etiquetas de idioma opcionais.

Apesar da sua eficiência computacional e simplicidade sintática, a representação de termos linguísticos como literais puros impõe severas restrições ontológicas. Na arquitetura fundamental do Resource Description Framework (RDF), os literais constituem nós terminais do grafo e não podem figurar como sujeitos de novas triplas [cite: 1, 1.3]. Consequentemente, torna-se impossível atribuir metadados diretos a uma cadeia de caracteres, inviabilizando o registo de anotações sobre a proveniência do termo, datas de vigência, variantes morfológicas, estatuto gramatical ou notas de aplicação restritas à forma léxica. De igual modo, relações interterminológicas diretas — como a correspondência formal entre um nome por extenso e o respetivo acrónimo, relações de transliteração ou combinações sintáticas — não podem ser expressas no SKOS Core sem recorrer a construções externas.

Para solucionar essa limitação mantendo a integridade do modelo original, o W3C incorporou no Apêndice B da Recomendação a extensão SKOS eXtension for Labels (SKOS-XL). O SKOS-XL introduz a reificação dos rótulos terminológicos, convertendo cada etiqueta textual de um literal passivo numa entidade de primeira classe no grafo semântico (`skosxl:Label`), passível de identificação por URI ou nó anónimo (blank node). Por meio dessa reificação, o termo passa a existir ontologicamente de forma independente, permitindo a ancoragem de descrições ricas e o estabelecimento de ligações relacionais explícitas entre rótulos, sem comprometer a relação entre o rótulo e o conceito semântico que ele designa.

## Elementos Normativos e Propriedades do Padrão SKOS-XL

A extensão SKOS-XL é governada pelo espaço de nomes canónico `http://www.w3.org/2008/05/skos-xl#` (associado convencionalmente ao prefixo `skosxl:`). A sua estrutura ontológica é deliberadamente compacta e elegante, sendo composta por uma classe central e cinco propriedades formais modeladas em conformidade com a Web Ontology Language (OWL).

A classe `skosxl:Label` constitui a tipificação fundamental de todas as entidades lexicais no ecossistema SKOS-XL. A especificação estabelece formalmente que a classe `skosxl:Label` é disjunta das classes estruturais do núcleo do SKOS, nomeadamente `skos:Concept`, `skos:ConceptScheme` e `skos:Collection`. Essa separação axiomática impede a sobreposição de categorias ontológicas, garantindo que um objeto que representa uma unidade de pensamento (`skos:Concept`) não seja computacionalmente confundido com o signo linguístico que a expressa (`skosxl:Label`).

A vinculação do recurso léxico reificado à sua representação textual bruta é efetuada pela propriedade de tipo de dados (`owl:DatatypeProperty`) `skosxl:literalForm`. O domínio (`rdfs:domain`) desta propriedade é circunscrito à classe `skosxl:Label`, enquanto o seu alcance (`rdfs:range`) corresponde estritamente à classe dos literais simples de RDF (`rdf:PlainLiteral`). A especificação não postula que duas instâncias distintas de `skosxl:Label` com valores textuais idênticos devam colapsar no mesmo recurso; duas URIs de rótulo podem conter exatamente a mesma forma literal e idioma, preservando identidades e historiais de anotação completamente distintos.

A ligação entre o conceito semântico e as instâncias reificadas de termos linguísticos processa-se através de três propriedades de objeto (`owl:ObjectProperty`), concebidas como os correspondentes reificados diretos das propriedades de rotulagem do SKOS Core:

- A propriedade `skosxl:prefLabel` relaciona um conceito ao seu rótulo preferido reificado no âmbito de um determinado contexto linguístico, correspondendo ao termo de referência formalmente adotado para indexação e apresentação.
- A propriedade `skosxl:altLabel` vincula o conceito a termos alternativos reificados, abrangendo formas sinónimas, variantes lexicais, termos populares ou quase-sinónimos.
- A propriedade `skosxl:hiddenLabel` designa termos reificados destinados exclusivamente à indexação computacional e recuperação por motores de busca, permanecendo ocultos em interfaces normais de navegação, sendo aplicada primordialmente a grafias incorretas, formas arcaicas ou variantes desaconselhadas.

Para suportar relações de granularidade fina entre termos, o padrão introduz o predicado `skosxl:labelRelation`. Definido como uma propriedade de objeto simétrica (`owl:SymmetricProperty`), possui tanto o domínio quanto o alcance restritos à classe `skosxl:Label`. De acordo com a documentação do W3C, `skosxl:labelRelation` atua primordialmente como uma raiz taxonómica ou padrão de desenho conceitual, destinado a ser especializado por engenheiros de ontologias em subpropriedades com semântica aplicada, tais como relações de acronímia, tradução interlinguística direta ou derivação morfológica.

| Identificador do Elemento | Tipo OWL / RDF | Domínio (`rdfs:domain`) | Alcance (`rdfs:range`) | Restrição de Cardinalidade / Característica |
|---|---|---|---|---|
| `skosxl:Label` | `owl:Class` | — | — | Subclasse de restrição com cardinalidade exatamente 1 em `skosxl:literalForm`. |
| `skosxl:literalForm` | `owl:DatatypeProperty` | `skosxl:Label` [cite: 2, 6, 10] | `rdf:PlainLiteral` [cite: 2, 4, 6, 10] | Cardinalidade estrita de exatamente 1 por instância. |
| `skosxl:prefLabel` | `owl:ObjectProperty` | Não restringido formalmente | `skosxl:Label` [cite: 2, 8, 12] | Máximo de 1 valor por código de idioma por conceito (via integridade). |
| `skosxl:altLabel` | `owl:ObjectProperty` | Não restringido formalmente | `skosxl:Label` [cite: 2, 8, 12] | Múltiplas instâncias permitidas por conceito. |
| `skosxl:hiddenLabel` | `owl:ObjectProperty` | Não restringido formalmente | `skosxl:Label` [cite: 2, 8, 12] | Múltiplas instâncias permitidas por conceito. |
| `skosxl:labelRelation` | `owl:ObjectProperty` | `skosxl:Label` [cite: 2, 6, 8] | `skosxl:Label` [cite: 2, 6, 8] | `owl:SymmetricProperty`; raiz extensível para subpropriedades. |

## Mecanismos de Inferência, Dumbing-Down e Condições de Integridade

A interoperabilidade entre sistemas que adotam o paradigma reificado do SKOS-XL e aplicações que operam exclusivamente com a sintaxe literal do SKOS Core é formalmente assegurada por um mecanismo axiomático de degradação semântica denominado *dumbing-down*. Este mecanismo apoia-se em cadeias de subpropriedades de OWL 2 (property chains), eliminando a necessidade de replicação manual redundante de literais no repositório de dados.

A Recomendação do W3C define os axiomas normativos S55, S56 e S57, estipulando que a composição de qualquer uma das três propriedades de rotulagem do SKOS-XL com o predicado de conteúdo `skosxl:literalForm` implica logicamente a asserção da propriedade homóloga no SKOS Core:

```
skosxl:prefLabel ∘ skosxl:literalForm ⊑ skos:prefLabel
skosxl:altLabel ∘ skosxl:literalForm ⊑ skos:altLabel
skosxl:hiddenLabel ∘ skosxl:literalForm ⊑ skos:hiddenLabel
```

Desta formalização deduz-se que, perante um motor de inferência com suporte a regras OWL, a existência de uma tripla que liga um conceito *C* a uma entidade *L* via `skosxl:prefLabel`, combinada com a declaração de que *L* possui o valor literal *V* via `skosxl:literalForm`, acarreta a dedução automática da tripla direta ⟨*C* `skos:prefLabel` *V*⟩. Esse comportamento confere compatibilidade retroativa integral a aplicações de consumo léxico superficial e ferramentas legadas de consulta SPARQL.

Simultaneamente, a extensão SKOS-XL herda de modo estrito as restrições axiais de consistência e integridade do SKOS Core através das suas propriedades deduzidas. Duas condições centrais regem a validade lógica do grafo combinado SKOS+XL:

A primeira condição refere-se à disjunção par a par (*pairwise disjointness*) entre os predicados léxicos. As propriedades `skos:prefLabel`, `skos:altLabel` e `skos:hiddenLabel` são mutuamente exclusivas para uma mesma forma literal dentro do mesmo conceito. Em termos práticos, um conceito não pode associar-se, via `skosxl:prefLabel` e simultaneamente via `skosxl:altLabel` ou `skosxl:hiddenLabel`, a instâncias de rótulos cujos valores em `skosxl:literalForm` coincidam na sequência de caracteres e na etiqueta de idioma, sob pena de gerar uma violação formal de consistência ontológica.

A segunda condição impõe a regra de unicidade linguística para o termo preferido. Um conceito semântico não pode conter mais de uma asserção de `skos:prefLabel` para o mesmo código de idioma. Como resultado da regra de inferência S55, se duas instâncias distintas de `skosxl:Label` forem declaradas como `skosxl:prefLabel` de um mesmo conceito e ambas possuírem formas literais com a mesma etiqueta linguística, o grafo deduzirá dois termos preferidos para esse idioma, incorrendo numa quebra das regras de integridade do SKOS.

## Avaliação de Obrigatoriedade e Restrições Estruturais

A análise formal da obrigatoriedade no âmbito do SKOS-XL requer uma diferenciação analítica rigorosa entre a adesão ao modelo conceitual global e a conformidade sintático-estrutural no nível das instâncias de dados.

No plano do modelo conceitual global, o uso do SKOS-XL é estritamente opcional. A especificação foi desenhada como um módulo de extensão para cenários que demandam sofisticação terminológica superior àquela provida pelo SKOS Core. Sob a perspetiva da lógica formal de Mundo Aberto (Open World Assumption — OWA), adotada pelo RDF e por OWL, a omissão completa de rótulos num determinado conceito não invalida ontologicamente o documento RDF. Todavia, na prática da gestão de vocabulários controlados e nos testes de conformidade de ferramentas especializadas (como qSKOS e Skosify), a presença de pelo menos um rótulo preferido por conceito no idioma primário do esquema constitui um requisito funcional indispensável para indexação, busca e legibilidade humana.

No plano da conformidade de instâncias, a ativação do padrão SKOS-XL estabelece uma regra de obrigatoriedade estrutural inderrogável, formalizada pelo axioma normativo S53: a classe `skosxl:Label` é definida como uma subclasse de uma restrição de cardinalidade exatamente igual a 1 sobre a propriedade `skosxl:literalForm`.

Essa restrição acarreta duas imposições técnicas fundamentais:

A primeira imposição determina que toda e qualquer instância declarada como pertencente à classe `skosxl:Label` é obrigada a possuir uma propriedade `skosxl:literalForm` explicitamente associada. A criação de uma URI ou nó anónimo do tipo `skosxl:Label` desprovido de forma literal gera uma instância ontologicamente incompleta e inválida perante a Recomendação.

A segunda imposição proíbe que uma única instância de `skosxl:Label` possua mais de uma asserção de `skosxl:literalForm`. Essa restrição de unicidade textual tem implicações diretas na modelagem multilíngue: é vedado associar literais em idiomas distintos à mesma URI de rótulo. Caso um conceito requeira rótulos em português, inglês e francês, o engenheiro de ontologias é obrigado a criar três instâncias individuais e distintas de `skosxl:Label`, cada uma contendo a sua respetiva forma literal e etiqueta de idioma unívoca vinculada via `skosxl:literalForm`.

## Interoperabilidade e Alinhamento com a Norma ISO 25964

O surgimento do SKOS-XL representou um passo decisivo na unificação entre as normas internacionais clássicas de documentação terminológica e o ecossistema de dados ligados (Linked Data). Historicamente, as diretrizes para tesauros monolíngues (ISO 2788) e multilíngues (ISO 5964) — unificadas e expandidas pela norma ISO 25964 (*Thesauri and interoperability with other vocabularies*) — assentaram na separação formal entre a noção de conceito de tesauro (*ThesaurusConcept*) e a entidade do termo linguístico (*ThesaurusTerm*).

No modelo orientado a objetos da ISO 25964, o termo é estruturado como um objeto autônomo dotado de propriedades e tipificações complexas, distinguindo termos preferidos (*PreferredTerm*), termos simples não preferidos (*SimpleNonPreferredTerm*) e termos não preferidos compostos (*SplitNonPreferredTerm*), além de comportar anotações de validade cronológica e notas de aplicação léxica. O SKOS Core revelava-se estruturalmente incapaz de transpor esse modelo com fidelidade semântica plena, justamente por tratar os rótulos como literais.

O SKOS-XL estabelece uma ponte conceitual e técnica com o modelo da ISO 25964, conforme formalizado pelo grupo de trabalho conjunto ISO TC46/SC9/WG8 e especialistas do W3C. As correspondências entre os modelos refletem um alinhamento ontológico estreito:

| Construto do Modelo ISO 25964-1 | Construto Correspondente no Padrão SKOS-XL | Função e Semântica no Modelo de Dados |
|---|---|---|
| `iso-thes:ThesaurusConcept` | `skos:Concept` | Unidade conceitual de significado abstrato dentro do vocabulário. |
| `iso-thes:ThesaurusTerm` | `skosxl:Label` | Entidade lexical reificada que representa o termo verbal ou textual. |
| `iso-thes:PreferredTerm` | `skosxl:prefLabel` | Relação de designação primária do conceito no contexto de um idioma. |
| `iso-thes:SimpleNonPreferredTerm` | `skosxl:altLabel` | Relação com formas sinónimas ou variantes de entrada não preferidas. |
| `iso-thes:lexicalValue` | `skosxl:literalForm` | Atribuição da cadeia de caracteres bruta e código linguístico ao termo. |
| Relações Interterminológicas (ex.: USE / UF, siglas) | Subpropriedades de `skosxl:labelRelation` | Relacionamentos semânticos e morfológicos diretos entre instâncias de rótulos. |

Essa harmonização permitiu que sistemas de referência globais — como o tesauro agrícola AGROVOC da FAO, os vocabulários do Getty Research Institute (como o Art & Architecture Thesaurus — AAT) e o vocabulário económico STW — estruturassem os seus grafos de conhecimento garantindo conformidade com a ISO 25964 e interoperabilidade em redes abertas de dados ligados [cite: 1, 49, 5.2].

## Conclusões

O padrão SKOS-XL resolve com rigor formal o desafio da representação lexical em grafos de conhecimento, suprimindo as restrições da modelagem baseada em literais puros sem desestruturar o núcleo conceitual do SKOS. Ao promover os rótulos à categoria de recursos reificados de primeira classe por meio da classe `skosxl:Label`, a extensão viabiliza a atribuição direta de metadados, o rastreamento de proveniência terminológica e a especialização de relações lexicais avançadas através do predicado extensível `skosxl:labelRelation`.

A arquitetura do vocabulário normativo articula-se em três propriedades de objeto fundamentais (`skosxl:prefLabel`, `skosxl:altLabel` e `skosxl:hiddenLabel`), associadas à propriedade de dados obrigatória `skosxl:literalForm`. A conformidade estrutural impõe uma restrição de cardinalidade estrita de exatamente um valor em `skosxl:literalForm` por instância de rótulo, exigindo a instanciação de recursos independentes para cada variação idiomática de um termo.

A integração harmónica com o SKOS Core é preservada por intermédio dos axiomas de cadeias de propriedades de OWL 2 (S55 a S57), que viabilizam a inferência automatizada (*dumbing-down*) de literais convencionais para clientes semânticos simplificados. Com essa base conceitual sólida, o SKOS-XL permanece como a especificação de referência para a transposição de tesauros compatíveis com a norma ISO 25964 e para a implementação de sistemas modernos de engenharia ontológica e organização do conhecimento.

---

*Fonte: [Gemini — Entendendo os Rótulos no SKOS-XL](https://gemini.google.com/share/ac0c73f3fa86)*
