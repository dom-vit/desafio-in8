import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // IMPORTANTE: P/ usar o context.read e context.watch
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../providers/cart_provider.dart'; 
import 'cart_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ApiService api = ApiService();
  List<Product> todosProdutos = [];
  bool loading = true;
  String queryPesquisa = '';
  String filtroProvider = 'TODOS'; 

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  void carregarProdutos() async {
    setState(() => loading = true);
    try {
      final data = await api.getProdutos(search: queryPesquisa);
      setState(() {
        todosProdutos = data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listaFiltrada = todosProdutos.where((p) {
      if (filtroProvider == 'TODOS') return true;
      return p.provider.toUpperCase() == filtroProvider;
    }).toList();

    // SelectionArea envolve tudo para permitir copiar textos no navegador
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catálogo'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          actions: [
            // BARRA DE PESQUISA
            SizedBox(
              width: 150,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Buscar...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  queryPesquisa = value;
                  carregarProdutos(); 
                },
              ),
            ),
            // ÍCONE DO CARRINHO COM CONTADOR
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                      );
                  },
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${context.watch<CartProvider>().items.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            // FILTROS RADIOS
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'TODOS',
                    groupValue: filtroProvider,
                    onChanged: (val) => setState(() => filtroProvider = val!),
                  ),
                  const Text('Ambos'),
                  Radio<String>(
                    value: 'BR',
                    groupValue: filtroProvider,
                    onChanged: (val) => setState(() => filtroProvider = val!),
                  ),
                  const Text('Brasil'),
                  Radio<String>(
                    value: 'EU',
                    groupValue: filtroProvider,
                    onChanged: (val) => setState(() => filtroProvider = val!),
                  ),
                  const Text('Europa'),
                ],
              ),
            ),
            
            Expanded(
              child: loading 
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: listaFiltrada.length,
                    itemBuilder: (context, index) {
                      final p = listaFiltrada[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                p.imagem, 
                                width: 50, 
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => const Icon(Icons.image),
                              ),
                            ),
                            title: Text(p.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    p.descricao, 
                                    maxLines: 2, 
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text(
                                          'R\$ ${p.preco.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: Colors.green, 
                                              fontWeight: FontWeight.bold, 
                                              fontSize: 16
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                              color: Colors.indigo.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(color: Colors.indigo.withOpacity(0.3)),
                                          ),
                                          child: Text(
                                              p.provider == 'BR' ? '🇧🇷 Brasil' : '🇪🇺 Europa',
                                              style: const TextStyle(
                                                fontSize: 10, 
                                                fontWeight: FontWeight.bold,
                                                color: Colors.indigo
                                              ),
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                context.read<CartProvider>().addItem(p);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${p.nome} no carrinho!'),
                                    duration: const Duration(milliseconds: 500),
                                  ),
                                );
                              },
                              child: const Text("Comprar"),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}