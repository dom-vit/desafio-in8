class Product {
  final String id;
  final String nome;
  final double preco;
  final String descricao;
  final String imagem;
  final String provider;

  Product({
    required this.id,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.imagem,
    required this.provider,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      nome: json['nome'] ?? 'Sem nome',
      preco: (json['preco'] as num).toDouble(),
      descricao: json['descricao'] ?? '',
      imagem: json['imagem'] ?? '',
      provider: json['provider'] ?? 'BR',
    );
  }
}