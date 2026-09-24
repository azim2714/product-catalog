import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repositories/product_repository.dart';
import 'data/services/product_api_service.dart';
import 'presentation/providers/product_list_provider.dart';
import 'presentation/screens/product_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          ProductListProvider(ProductRepository(ProductApiService())),
      child: const MainApp(),
    ),
  );
}

//testing
// Future<void> getProducts() async {
//   final repository = ProductRepository(
//     ProductApiService(),
//   );

//   try {
//     final products = await repository.getProducts(
//       limit: 20,
//       skip: 0,
//     );

//     print('Found ${products.length} products');

//     if (products.isNotEmpty) {
//       print('First product: ${products.first.title}');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const ProductListScreen(),
    );
  }
}
