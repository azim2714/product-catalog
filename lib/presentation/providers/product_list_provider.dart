import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';
import 'view_state.dart';

class ProductListProvider extends ChangeNotifier {
  final ProductRepository repository;

  ProductListProvider(this.repository);

  ViewState state = ViewState.loading;

  List<Product> products = [];

  String? errorMessage;

  Future<void> loadProducts() async {
    try {
      state = ViewState.loading;
      notifyListeners();

      products = await repository.getProducts(
        limit: 20,
        skip: 0,
      );

      if (products.isEmpty) {
        state = ViewState.empty;
      } else {
        state = ViewState.success;
      }
    } catch (e) {
      errorMessage = e.toString();
      state = ViewState.error;
    }

    notifyListeners();
  }
}