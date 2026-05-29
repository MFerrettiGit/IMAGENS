# Banco de Imagens — M. Ferretti

Site simples para a equipe de vendas pesquisar produtos e **baixar a foto** de cada um.
Mostra **CÓDIGO**, **DESCRIÇÃO** e **EAN**, com barra de pesquisa.

## Como usar (equipe de vendas)
Abra o link, digite na busca (código, descrição ou EAN) e clique em **Baixar imagem**.
Clicar na foto abre ela em tela cheia.

## Como atualizar (administração)

### 1. Produtos (texto)
Edite o arquivo [`produtos.js`](produtos.js). Cada produto é uma linha:

```js
{ codigo: "12345", descricao: "NOME DO PRODUTO", ean: "7891234567890" },
```

### 2. Fotos
Salve cada foto na pasta [`imagens/`](imagens/) com o **nome igual ao CÓDIGO** do produto:

```
imagens/12345.jpg
```

Formatos aceitos: `.jpg`, `.jpeg`, `.png`, `.webp`. Se o produto não tiver foto,
o card mostra "Sem imagem" — é só adicionar o arquivo depois.

### 3. Publicar
Commit + push na branch `main`. O site é servido por **GitHub Pages**.

---
Estrutura:
- `index.html` — o site (visual, busca e download).
- `produtos.js` — a lista de produtos.
- `imagens/` — as fotos (nomeadas pelo código).
