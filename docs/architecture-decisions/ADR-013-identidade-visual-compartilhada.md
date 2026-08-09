# ADR-013: Identidade Visual Compartilhada via Preset Tailwind no Módulo Compartilhado

## Status

**Aceito** — Agosto 2026

## Contexto

A identidade visual da Arquitetura BioCultural é exigida como **idêntica em todas as unidades
federadas**. A exigência está escrita em vários lugares:

- `BioCultRelatos/CLAUDE.md:52-55` — "Tipografia, componentes e layouts devem espelhar BioCultDB
  exatamente."
- `constitution.md §III` (BioCultNaturalistas, BioCultAcervos) — "Visual identity MUST be identical
  to BioCultDB. Color theme Tailwind 'forest' (forest-50 a forest-900), mesma tipografia,
  componentes, layouts."

Exigida em todo lugar, **garantida em lugar nenhum**. E, com apenas duas ferramentas implementadas,
já havia falhado:

| | BioCultDB | BioCultTermos |
|---|---|---|
| paleta `forest` | `tailwind.config.js`, tons 50–900 | `tailwind.config.js`, tons 50–**950** |
| `.btn` | `px-4 py-2` (`frontend/src/shared/styles/main.css:33`) | `px-6 py-3` (`frontend/src/styles/input.css:8`) |
| layout EJS | `backend/src/shared/views/layout.ejs`, centralizado | replicado por contexto (`public/`, `admin/`) |

Duas cópias, três divergências. O gatilho desta decisão foi a criação da home page inicial de
BioCultRelatos, BioCultNaturalistas e BioCultAcervos: executada por cópia, ela produziria **cinco**
`tailwind.config.js` e cinco blocos `@layer components`, sem nada que os mantivesse iguais.

É o mesmo problema que o ADR-012 acabou de resolver para o código — cópia que envelhece até virar
bifurcação — deslocado para a camada de apresentação. E com o mesmo desfecho previsível: em seis
meses ninguém sabe qual `.btn` é o verdadeiro.

## Requisitos

### Funcionais

- Um lugar só define cores, tipografia e componentes visuais da arquitetura.
- Uma unidade nova nasce visualmente consistente sem copiar nada.
- A correção de um token chega a todas as unidades pelo mesmo caminho de qualquer outra mudança.

### Não-Funcionais

- Nenhuma dependência nova: sem registry, sem serviço, sem repositório novo — princípio de
  simplicidade e de imagem Docker mínima da federação.
- Preferir mecanismo nativo da ferramenta já em uso.
- Não alterar o comportamento visual do que já está em produção.

## Opções Consideradas

### Opção 1: Copiar o tema do BioCultDB para cada unidade nova

**Prós:**
- Zero infraestrutura, imediato.

**Contras:**
- Cinco cópias de um tema que já divergiu com duas. Cria o problema do ADR-012 na apresentação.
- A exigência de identidade continua sendo prosa em `CLAUDE.md`, sem mecanismo.

### Opção 2: Segundo Módulo Compartilhado, só de design system

**Prós:**
- Responsabilidade limpa: tokens de design num módulo de design.

**Contras:**
- Repositório novo, submodule novo em quatro hospedeiros, ADR de distribuição novo, entrada nova no
  leitor de Atraso de Módulo — tudo isso para cerca de 40 linhas de tokens.
- Duplica a máquina de propagação que o ADR-012 acabou de construir.

### Opção 3: Pacote npm privado com o tema

**Prós:**
- Versionamento semântico explícito do design system.

**Contras:**
- Acrescenta um registry ao stack, contra o requisito não-funcional.
- Recria a discussão de "quando cada unidade atualiza", que o ADR-012 G4 já resolveu para o módulo.

### Opção 4: Preset Tailwind dentro do Módulo Compartilhado existente

**Prós:**
- `presets` é recurso **nativo** do Tailwind para exatamente este caso. Zero dependência nova.
- As quatro Unidades Hospedeiras já carregam o `bioculttermos/` como submodule: os tokens propagam
  pelo mecanismo do ADR-012, com Atraso de Módulo medido, sem nenhuma infraestrutura nova.
- O `tailwind.config.js` de uma unidade cai para 8 linhas, e o `main.css` para 4.

**Contras:**
- Desvio de responsabilidade: um módulo de vocabulário controlado passa a hospedar tokens de design.

**Escolhida.**

## Decisão

### V1 — Os tokens visuais vivem no Módulo Compartilhado

Dois arquivos, no repositório `BioCultTermos`:

- `tailwind.preset.cjs` — a paleta `forest`, como preset Tailwind.
- `frontend/src/styles/biocult-base.css` — `@layer base` e `@layer components` compartilhados
  (`.btn*`, `.card`, `.form-*`, `.badge`).

O `.cjs` é deliberado: o config do BioCultDB é CommonJS e o do BioCultTermos é ESM. CommonJS é o
único formato que os dois carregam sem ginástica.

### V2 — Toda unidade consome, nenhuma redefine

`tailwind.config.js` da unidade:

```js
module.exports = {
  presets: [require('./bioculttermos/tailwind.preset.cjs')],
  content: [ /* caminhos da unidade */ ]
};
```

`main.css` da unidade:

```css
@import "../../../../bioculttermos/frontend/src/styles/biocult-base.css";
@tailwind base;
@tailwind components;
@tailwind utilities;
```

O `@import` **precede** as diretivas: o postcss-import ignora `@import` que apareça depois de outras
regras. A ordem das camadas no CSS final não depende dessa posição — `@layer` do Tailwind é diretiva
de build, não cascade layer. Isso foi descoberto na implementação: com o `@import` no fim, o build
passava sem erro e silenciosamente não incluía componente nenhum.

Redefinir cor, `.btn`, `.card` ou qualquer token no repositório de uma unidade passa a ser violação
desta ADR. Abaixo do `@import`, a unidade acrescenta apenas o que for genuinamente seu.

### V3 — O escopo é token, não markup

O que é compartilhado: paleta, `@layer base`, `@layer components`.
O que **não** é: os arquivos EJS. Cada unidade mantém seu próprio layout e suas próprias views.

A linha é deliberada. Markup difere legitimamente entre unidades — o BioCultNaturalistas não tem
contexto de Curadoria, o BioCultAcervos ainda não tem contexto nenhum definido — e um layout
compartilhado parametrizado até caber em todos seria mais complexo que as ~50 linhas de EJS que
economizaria. Token divergente é bug; markup divergente é, quase sempre, a unidade sendo ela mesma.

### V4 — Migração das duas unidades existentes é trabalho separado

Nem o BioCultDB nem o próprio BioCultTermos consomem os arquivos novos ainda. Os dois têm CSS de
componentes próprio e divergente entre si, e migrá-los é refatoração de UI em produção — merece
verificação própria, não carona nesta decisão. Os arquivos novos são **puramente aditivos**: nenhum
pixel do que está em execução muda.

Na migração, o `.btn` canônico é o do BioCultDB (`px-4 py-2`), que é a unidade em produção; a
variante maior do BioCultTermos vira `.btn-lg`, já definida no arquivo compartilhado.

## Relações

- **Depende do ADR-012** — a propagação dos tokens é a propagação do Módulo Compartilhado: adoção
  obrigatória e assíncrona (G4), Atraso de Módulo medido por `bin/termos-status.ps1`.
- **Especializa o ADR-007 F4** — "soberania é de dados, nunca de código". A identidade visual é
  código: é intencionalmente a mesma em todas as unidades, e isso não toca a soberania sobre o
  vocabulário de cada uma.
- Não altera nenhuma decisão anterior.

## Consequências

### Positivas

- A exigência de identidade visual deixa de ser prosa em `CLAUDE.md` e passa a ser mecanismo.
- Unidade nova nasce consistente: 8 linhas de config, 4 de CSS, nenhum token copiado.
- A correção de um token chega às quatro unidades pelo caminho já auditado do ADR-012.
- A divergência existente entre BioCultDB e BioCultTermos passa a ter um alvo canônico para
  convergir, em vez de duas opiniões igualmente válidas.

### Negativas

- **Desvio de responsabilidade**: um módulo de vocabulário controlado hospeda tokens de design. É o
  ponto fraco reconhecido desta decisão.
  - *Mitigação*: registrada no cabeçalho de `tailwind.preset.cjs`, com o caminho de saída — se a
    identidade visual crescer para além de tokens (componentes versionados, ícones, tipografia
    própria), extraia para um Módulo Compartilhado próprio e consuma-o do mesmo jeito. O custo dessa
    extração futura é baixo justamente porque o mecanismo de consumo já é o padrão da federação.
- Acopla o build de CSS de qualquer unidade à presença do submodule inicializado. Um
  `git clone` sem `--recursive` quebra o `npm run build:css` com `MODULE_NOT_FOUND`.
  - *Mitigação*: nenhuma nova necessária — o `Dockerfile.unidade` já exige o submodule checado out
    (ADR-010 G3 valida o SHA antes de buildar), e a mensagem de erro do Node nomeia o arquivo
    ausente.

## Referências

- [ADR-007: Distribuição do Módulo BioCultTermos via Git Submodule Compartilhado](ADR-007-shared-bioculttermos-module.md) — F4
- [ADR-012: Manutenção do Código do BioCultTermos](ADR-012-manutencao-codigo-bioculttermos.md) — mecanismo de propagação
- `BioCultTermos/tailwind.preset.cjs` — os tokens
- `BioCultTermos/frontend/src/styles/biocult-base.css` — os componentes
- `BioCultRelatos/` — primeira unidade a consumir, implementação de referência

## Data de Revisão

Revisar quando o BioCultDB migrar para o preset (V4) — momento em que a divergência de `.btn` é
efetivamente resolvida e em que se saberá se o escopo "token sim, markup não" (V3) se sustentou, ou
se a duplicação de layout EJS entre cinco unidades passou a doer o bastante para mudar a linha.
