import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  // busca os produtos
  Future<List<Product>> getProdutos({String search = ''}) async {
    final uri = Uri.parse(
      search.isEmpty ? '$baseUrl/products' : '$baseUrl/products?search=$search',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => Product.fromJson(e)).toList();
      }
      throw Exception('Erro ${response.statusCode}');
    } catch (e) {
      throw Exception('Falha na conexão: $e');
    }
  }

  // envia o pedido p/ o NestJS salvar no Postgres
  Future<bool> enviarPedido(List<Product> produtos, double total) async {
    final uri = Uri.parse('$baseUrl/orders');

    try {
        final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
            // DTO exige esses campos:
            'clienteNome': 'Cliente In8', 
            'clienteEmail': 'cliente@in8.com.br',
            'total': total,
            'produtos': produtos.map((p) => {
            'nome': p.nome,
            'preco': p.preco,
            'quantidade': 1, // Seu DTO ProdutoPedidoDto exige quantidade
            }).toList(),
        }),
        );

        print('Status: ${response.statusCode}');
        print('Resposta: ${response.body}');

        // O NestJS por padrão retorna 201 para sucesso no POST
        return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
        print('Erro na requisição: $e');
        return false;
    }
    }
}