/* =====================================================================
   QUERY: Produtos para o site "Banco de Imagens" (M. Ferretti)
   Objetivo: extrair CÓDIGO, DESCRIÇÃO e EAN dos produtos (filial '01')
   Banco: SQL Server / T-SQL  |  ERP Protheus
   Data: 2026-05-29
   ---------------------------------------------------------------------
   CAMPOS (origem na memória BankReader):
     B1_COD    -> CÓDIGO do produto        (confirmado)
     B1_DESC   -> DESCRIÇÃO do produto      (confirmado)
     B1_CODBAR -> EAN / código de barras    (SUPOSIÇÃO — não estava na
                  memória; padrão Protheus. Se vier vazio, troque por
                  B1_EANUNB no SELECT abaixo.)
   ===================================================================== */

/* ---------------------------------------------------------------------
   VERSÃO 1 — SELECT simples (exportar para Excel/CSV)
   --------------------------------------------------------------------- */
SELECT
    RTRIM(B1_COD)            AS codigo,
    RTRIM(B1_DESC)           AS descricao,
    RTRIM(B1_CODBAR)         AS ean        -- assumido: código de barras EAN
FROM SB1010
WHERE B1_FILIAL   = '01'
  AND D_E_L_E_T_  = ' '          -- ignora registros deletados (soft-delete)
  AND B1_MSBLQL  <> '1'          -- ignora produtos bloqueados/inativos (opcional)
ORDER BY B1_COD;


/* ---------------------------------------------------------------------
   VERSÃO 2 — Gera as linhas JÁ PRONTAS para colar no arquivo produtos.js
   Copie a coluna de resultado e cole entre os [ ] da const PRODUTOS.
   (escapa aspas duplas na descrição para não quebrar o JavaScript)
   --------------------------------------------------------------------- */
SELECT
    '  { codigo: "'   + RTRIM(B1_COD) +
    '", descricao: "' + REPLACE(RTRIM(B1_DESC), '"', '') +
    '", ean: "'       + RTRIM(B1_CODBAR) + '" },'   AS linha_js
FROM SB1010
WHERE B1_FILIAL   = '01'
  AND D_E_L_E_T_  = ' '
  AND B1_MSBLQL  <> '1'
ORDER BY B1_COD;
