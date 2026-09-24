import 'package:flutter/material.dart';

import 'data/repositories/product_repository.dart';
import 'data/services/product_api_service.dart';

void main() async {
  await getProducts();
  runApp(const MainApp());
}

Future<void> getProducts() async {
  final repository = ProductRepository(
    ProductApiService(),
  );

  try {
    final products = await repository.getProducts(
      limit: 20,
      skip: 0,
    );

    print('Found ${products.length} products');

    if (products.isNotEmpty) {
      print('First product: ${products.first.title}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
