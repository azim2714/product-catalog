import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';
import 'view_state.dart';

class ProductDetailProvider extends ChangeNotifier {
  final ProductRepository repository;

  ProductDetailProvider(this.repository);

  ViewState state = ViewState.loading;

  Product? product;

  String? errorMessage;

  Future<void> loadProduct(int id) async {
    try {
      state = ViewState.loading;
      errorMessage = null;
      product = null;

      notifyListeners();

      product = await repository.getProductDetail(id);

      state = ViewState.success;
    } catch (e) {
      errorMessage = e.toString();
      state = ViewState.error;
    }

    notifyListeners();
  }
}