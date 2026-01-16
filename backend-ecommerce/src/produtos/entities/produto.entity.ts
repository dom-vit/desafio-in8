// O formato que o Flutter vai receber
// no nest ja tem o Product, trazer ele no flutter pro compilador aceitar

export interface ProdutoPadrao {
  id: string;
  nome: string;
  preco: number;
  descricao: string;
  imagem: string;
  provider: 'BR' | 'EU';
}

// O que vem do Fornecedor 1 (Brasil)
export interface FornecedorBR {
  id: string;
  nome: string;
  preco: number;
  descricao: string;
  imagem: string;
}

// O que vem do Fornecedor 2 (Europa)
export interface FornecedorEU {
  id: string;
  name: string; // Mudou de nome para name
  price: string; // Vem como texto (string)
  description: string;
  gallery: string[]; // Vem como uma lista de imagens
}
