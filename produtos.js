/* ==========================================================================
   LISTA DE PRODUTOS DO BANCO DE IMAGENS — M. Ferretti
   --------------------------------------------------------------------------
   Cada produto tem 5 campos:
     codigo      -> CÓDIGO do produto (também é o nome do arquivo da foto)
     descricao   -> DESCRIÇÃO do produto
     ean         -> código de barras (EAN)
     fornecedor  -> nome do fornecedor (usado para separar/filtrar no site)
     marca       -> marca do produto   (usada para separar/filtrar no site)

   A FOTO de cada produto deve ser salva na pasta "imagens/" com o nome igual
   ao CÓDIGO. Ex.: produto codigo "12345"  ->  imagens/12345.jpg
   (também aceita .jpeg, .png ou .webp automaticamente)

   Para atualizar: cole aqui o resultado da VERSÃO 2 da query do Protheus.
   ========================================================================== */

const PRODUTOS = [
  // ---- EXEMPLOS (pode apagar quando colar os produtos reais) ----
  { codigo: "00001", descricao: "PRODUTO EXEMPLO 1", ean: "7890000000017", fornecedor: "FORNECEDOR A", marca: "UNI" },
  { codigo: "00002", descricao: "PRODUTO EXEMPLO 2", ean: "7890000000024", fornecedor: "FORNECEDOR A", marca: "DET" },
  { codigo: "00003", descricao: "PRODUTO EXEMPLO 3", ean: "7890000000031", fornecedor: "FORNECEDOR B", marca: "UNI" },
];
