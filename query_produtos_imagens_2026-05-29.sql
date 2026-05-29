/* =====================================================================
   QUERY: Produtos para o site "Banco de Imagens" (M. Ferretti)
   Objetivo: extrair CÓDIGO, DESCRIÇÃO, EAN, FORNECEDOR e MARCA dos
             produtos ATIVOS e PARA VENDA (filial '01').
   Banco: SQL Server / T-SQL  |  ERP Protheus
   Atualizada: 2026-05-29
   ---------------------------------------------------------------------
   CAMPOS (origem na memória BankReader):
     B1_COD     -> CÓDIGO do produto        (confirmado)
     B1_DESC    -> DESCRIÇÃO do produto      (confirmado)
     B1_CODBAR  -> EAN / código de barras    (SUPOSIÇÃO; se vazio, usar B1_EANUNB)
     A2_NREDUZ  -> FORNECEDOR (nome reduzido) via B1_PROC/B1_LOJPROC -> SA2010
     B1_ZZMARCA -> MARCA (código, ex.: 'UNI')

   FILTROS DE "ATIVO E PARA VENDA":
     B1_MSBLQL <> '1'                -> exclui bloqueio de tela padrao Protheus
     RTRIM(B1_ZZFORAL) = 'EM LINHA'  -> mantem SO os ativos (exclui 'FORA LINHA' e 'SUSPENSO')
     B1_ZZMARCA <> 'BRI'             -> exclui BRINDES (marca 'BRI')
     D_E_L_E_T_ = ' '                -> exclui registros deletados
   (B1_ZZFORAL e TEXTO com valores: 'EM LINHA', 'FORA LINHA', 'SUSPENSO'.)
   (Obs.: existe tambem B1_ZZMSBLQ = "Bloqueio Ferretti", que NAO e filtrado.)
   ===================================================================== */

/* ---------------------------------------------------------------------
   VERSÃO 1 — SELECT simples (exportar para Excel/CSV)
   --------------------------------------------------------------------- */
SELECT
    RTRIM(SB1.B1_COD)      AS codigo,
    RTRIM(SB1.B1_DESC)     AS descricao,
    RTRIM(SB1.B1_CODBAR)   AS ean,           -- assumido: código de barras EAN
    RTRIM(SA2.A2_NREDUZ)   AS fornecedor,
    RTRIM(SB1.B1_ZZMARCA)  AS marca
FROM SB1010 SB1
LEFT JOIN SA2010 SA2
       ON SA2.A2_FILIAL   = ''
      AND SA2.A2_COD      = SB1.B1_PROC
      AND SA2.A2_LOJA     = SB1.B1_LOJPROC
      AND SA2.D_E_L_E_T_  = ' '
WHERE SB1.B1_FILIAL   = '01'
  AND SB1.D_E_L_E_T_  = ' '
  AND SB1.B1_MSBLQL  <> '1'              -- exclui bloqueio de tela padrao
  AND RTRIM(SB1.B1_ZZFORAL) = 'EM LINHA' -- mantem so ativos (exclui fora de linha e suspenso)
  AND SB1.B1_ZZMARCA <> 'BRI'            -- exclui brindes
ORDER BY SA2.A2_NREDUZ, SB1.B1_ZZMARCA, SB1.B1_COD;


/* ---------------------------------------------------------------------
   VERSÃO 2 — Gera as linhas JÁ PRONTAS para colar no arquivo produtos.js
   Copie a coluna de resultado e cole entre os [ ] da const PRODUTOS.
   (escapa aspas duplas para não quebrar o JavaScript)
   --------------------------------------------------------------------- */
SELECT
    '  { codigo: "'    + RTRIM(SB1.B1_COD) +
    '", descricao: "'  + REPLACE(RTRIM(SB1.B1_DESC), '"', '') +
    '", ean: "'        + RTRIM(SB1.B1_CODBAR) +
    '", fornecedor: "' + REPLACE(RTRIM(ISNULL(SA2.A2_NREDUZ, '')), '"', '') +
    '", marca: "'      + REPLACE(RTRIM(SB1.B1_ZZMARCA), '"', '') + '" },'  AS linha_js
FROM SB1010 SB1
LEFT JOIN SA2010 SA2
       ON SA2.A2_FILIAL   = ''
      AND SA2.A2_COD      = SB1.B1_PROC
      AND SA2.A2_LOJA     = SB1.B1_LOJPROC
      AND SA2.D_E_L_E_T_  = ' '
WHERE SB1.B1_FILIAL   = '01'
  AND SB1.D_E_L_E_T_  = ' '
  AND SB1.B1_MSBLQL  <> '1'
  AND RTRIM(SB1.B1_ZZFORAL) = 'EM LINHA'
  AND SB1.B1_ZZMARCA <> 'BRI'
ORDER BY SA2.A2_NREDUZ, SB1.B1_ZZMARCA, SB1.B1_COD;
