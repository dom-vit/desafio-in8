import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/products_page.dart';
import 'providers/cart_provider.dart'; 

void main() {
  runApp(
    // fica no topo p/ ser acessado por todas as pags
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce In8',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true, // deixa mais moderno com cara de celular
      ),
      home: const ProductsPage(),
    );
  }
}