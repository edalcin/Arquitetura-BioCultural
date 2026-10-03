<#
.SYNOPSIS
    Reporta o Atraso de Modulo do BioCultTermos nas quatro Unidades Hospedeiras.

.DESCRIPTION
    Leitor de estado SOMENTE LEITURA. Nao altera nenhum repositorio, nao commita,
    nao faz push. Unica dependencia: git.

    Torna executavel o ADR-012 G4 (adocao obrigatoria e assincrona): enquanto o
    Atraso de Modulo nao for visivel, "obrigatorio" e "opcional" sao
    indistinguiveis na pratica.

    Por unidade, reporta:
      Versao Adotada  - o commit do modulo que o hospedeiro carrega hoje
      Atraso          - quantos commits publicados ela ainda nao adotou
      Copia           - estado da Copia de Trabalho (limpa / suja / nao publicada)

.PARAMETER Root
    Diretorio que contem os repositorios. Padrao: o pai deste repositorio.

.PARAMETER NoFetch
    Nao busca o remoto; compara contra o origin/main ja em cache (pode estar velho).

.EXAMPLE
    pwsh bin/termos-status.ps1
#>

[CmdletBinding()]
param(
    [string] $Root,
    [switch] $NoFetch
)

$ErrorActionPreference = 'Stop'

if (-not $Root) {
    $Root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
}

$Hosts  = @('BioCultDB', 'BioCultRelatos', 'BioCultNaturalistas', 'BioCultAcervos')
$Module = 'bioculttermos'

function Invoke-Git {
    param([string] $Dir, [string[]] $GitArgs)
    $out = & git -C $Dir @GitArgs 2>$null
    if ($LASTEXITCODE -ne 0) { return $null }
    return ($out | Out-String).Trim()
}

Write-Host ''
Write-Host 'BioCultTermos - Atraso de Modulo por Unidade Hospedeira' -ForegroundColor Cyan
Write-Host "Raiz: $Root"
Write-Host ''

# --- Rede de protecao do git (ADR-012 G3), por maquina --------------------
$expected = [ordered]@{
    'push.recurseSubmodules' = 'on-demand'
    'submodule.recurse'      = 'true'
    'status.submoduleSummary'= 'true'
    'diff.submodule'         = 'log'
}
$missing = @()
foreach ($key in $expected.Keys) {
    $actual = (& git config --global --get $key 2>$null)
    if ($LASTEXITCODE -ne 0 -or $actual -ne $expected[$key]) {
        $missing += "$key (esperado '$($expected[$key])', atual '$actual')"
    }
}
if ($missing.Count -gt 0) {
    Write-Host 'AVISO  Rede de protecao do git incompleta nesta maquina (ADR-012 G3):' -ForegroundColor Yellow
    $missing | ForEach-Object { Write-Host "         - $_" -ForegroundColor Yellow }
    Write-Host '         Corrija com o bloco em docs/gestaoBioCultTermos/fluxo-de-trabalho.md (secao 0).' -ForegroundColor Yellow
    Write-Host ''
}

# --- Referencia canonica --------------------------------------------------
$canonical = $null
$refFrom   = $null
foreach ($h in $Hosts) {
    $wc = Join-Path $Root "$h/$Module"
    if (-not (Test-Path (Join-Path $wc '.git'))) { continue }
    if (-not $NoFetch) { Invoke-Git $wc @('fetch', '--quiet', 'origin', 'main') | Out-Null }
    $sha = Invoke-Git $wc @('rev-parse', 'origin/main')
    if ($sha) { $canonical = $sha; $refFrom = $h; break }
}

if (-not $canonical) {
    Write-Host 'ERRO   Nenhuma Copia de Trabalho encontrada. Nada a comparar.' -ForegroundColor Red
    Write-Host '       Esperado ao menos um <host>/bioculttermos entre: ' + ($Hosts -join ', ')
    exit 1
}

Write-Host ("Canonico origin/main = {0}  (lido via {1})" -f $canonical.Substring(0,7), $refFrom)
Write-Host ''

$rows = @()
foreach ($h in $Hosts) {
    $hostDir = Join-Path $Root $h
    $wc      = Join-Path $hostDir $Module

    if (-not (Test-Path $hostDir)) {
        $rows += [pscustomobject]@{ Unidade=$h; Estado='-'; Adotada='-'; Atraso='-'; Copia='repo ausente' }
        continue
    }
    if (-not (Test-Path (Join-Path $wc '.git'))) {
        $rows += [pscustomobject]@{ Unidade=$h; Estado='-'; Adotada='-'; Atraso='-'; Copia='sem Copia de Trabalho' }
        continue
    }

    # Estado operacional, DERIVADO - nao ha flag a manter. Uma unidade so consegue
    # validar a adocao de uma versao nova se tiver como buildar e executar o modulo
    # (ADR-010 G3 exige o build com BUILD_INFO). Sem Dockerfile.unidade, bump e
    # escrituracao, nao adocao verificada.
    $operational = Test-Path (Join-Path $hostDir 'docker/Dockerfile.unidade')
    $estado = if ($operational) { 'operacional' } else { 'sem app' }

    # Versao Adotada = o SHA que o hospedeiro registra, nao o HEAD da copia.
    $adopted = $null
    $entry = Invoke-Git $hostDir @('ls-tree', 'HEAD', $Module)
    if ($entry -match '\s([0-9a-f]{40})\s') { $adopted = $Matches[1] }
    if (-not $adopted) { $adopted = Invoke-Git $wc @('rev-parse', 'HEAD') }

    $behind = Invoke-Git $wc @('rev-list', '--count', "$adopted..$canonical")
    if ($null -eq $behind) { $behind = '?' }

    $notes = @()
    if (Invoke-Git $wc @('status', '--porcelain')) { $notes += 'alteracoes nao commitadas' }
    $ahead = Invoke-Git $wc @('rev-list', '--count', 'origin/main..HEAD')
    if ($ahead -and $ahead -ne '0') { $notes += "$ahead commit(s) NAO PUBLICADO(S)" }
    $head = Invoke-Git $wc @('rev-parse', 'HEAD')
    if ($head -and $adopted -and $head -ne $adopted) { $notes += 'copia difere da Versao Adotada' }
    $branch = Invoke-Git $wc @('rev-parse', '--abbrev-ref', 'HEAD')
    if ($branch -eq 'HEAD') { $notes += 'DETACHED HEAD' }
    if ($notes.Count -eq 0) { $notes += 'limpa' }

    $rows += [pscustomobject]@{
        Unidade = $h
        Estado  = $estado
        Adotada = $adopted.Substring(0,7)
        Atraso  = $behind
        Copia   = ($notes -join '; ')
    }
}

$rows | Format-Table -AutoSize

$late      = @($rows | Where-Object { $_.Atraso -match '^[1-9]' -and $_.Estado -eq 'operacional' })
$lateIdle  = @($rows | Where-Object { $_.Atraso -match '^[1-9]' -and $_.Estado -eq 'sem app' })
$dirty = @($rows | Where-Object { $_.Copia -match 'NAO PUBLICADO|DETACHED' })

Write-Host ''
if ($dirty.Count -gt 0) {
    Write-Host 'ACAO   Copia de Trabalho com trabalho preso (publique antes de qualquer bump):' -ForegroundColor Red
    $dirty | ForEach-Object { Write-Host "         - $($_.Unidade): $($_.Copia)" -ForegroundColor Red }
}
if ($late.Count -gt 0) {
    Write-Host 'ACAO   Atraso de Modulo aberto - a adocao e obrigatoria (ADR-012 G4):' -ForegroundColor Yellow
    $late | ForEach-Object { Write-Host "         - $($_.Unidade): $($_.Atraso) commit(s) atras" -ForegroundColor Yellow }
    Write-Host '         Zere com: git submodule update --remote --merge bioculttermos' -ForegroundColor Yellow
}
if ($lateIdle.Count -gt 0) {
    Write-Host 'NOTA   Atraso em unidade sem app - o bump aqui e escrituracao, nao adocao' -ForegroundColor DarkGray
    Write-Host '       verificada: sem docker/Dockerfile.unidade nao ha como buildar nem exercitar' -ForegroundColor DarkGray
    Write-Host '       o modulo (ADR-010 G3). Zere junto com o primeiro build da unidade.' -ForegroundColor DarkGray
    $lateIdle | ForEach-Object { Write-Host "         - $($_.Unidade): $($_.Atraso) commit(s) atras" -ForegroundColor DarkGray }
}
if ($late.Count -eq 0 -and $dirty.Count -eq 0) {
    Write-Host 'OK     Nenhum Atraso de Modulo e nenhum trabalho preso.' -ForegroundColor Green
}
Write-Host ''
