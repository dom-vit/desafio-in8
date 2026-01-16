import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  // lista privada dos itens no carrinho
  final List<Product> _items = [];

  // Getter para acessar os itens : nao permite mudar a lista diretamente
  List<Product> get items => _items;

  //valor total do carrinho
  double get totalValue => _items.fold(0, (sum, item) => sum + item.preco);

  // Add um produto e avisa o Flutter para atualizar a tela
  void addItem(Product product) {
    _items.add(product);
    notifyListeners(); // Essencial para o ícone de contador e total atualizarem
  }

  // Remove um item (caso queira implementar o botão de remover depois)
  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  // esvazia o carrinho após finalizar o pedido 
  void clear() {
    _items.clear();
    notifyListeners();
  }
}