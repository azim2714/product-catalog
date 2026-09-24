import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';
import 'view_state.dart';

class ProductListProvider extends ChangeNotifier {
  final ProductRepository repository;

  ProductListProvider(this.repository);

  static const int _pageSize = 20;

  ViewState state = ViewState.loading;

  List<Product> products = [];

  String? errorMessage;

  int _skip = 0;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  // Search query for filtering products
  String _searchQuery = '';

  bool get isSearching => _searchQuery.isNotEmpty;

  Future<void> searchProducts(String query) async {
    _searchQuery = query;

    if (query.trim().isEmpty) {
      await loadProducts();
      return;
    }

    try {
      state = ViewState.loading;
      errorMessage = null;
      notifyListeners();

      final results = await repository.searchProducts(query.trim());

      products = results;

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

  Future<void> loadProducts() async {
    try {
      state = ViewState.loading;
      errorMessage = null;
      _skip = 0;
      _hasMore = true;

      notifyListeners();

      final newProducts = await repository.getProducts(
        limit: _pageSize,
        skip: _skip,
      );

      products = newProducts;

      if (products.isEmpty) {
        state = ViewState.empty;
      } else {
        state = ViewState.success;
      }

      if (newProducts.length < _pageSize) {
        _hasMore = false;
      }
    } catch (e) {
      errorMessage = e.toString();
      state = ViewState.error;
    }

    notifyListeners();
  }

  Future<void> loadMore() async {
    if (isSearching) {
      return; // Don't load more when searching
    }

    if (_isLoadingMore || !_hasMore) {
      return;
    }

    _isLoadingMore = true;
    notifyListeners();

    try {
      final nextSkip = _skip + _pageSize;

      final newProducts = await repository.getProducts(
        limit: _pageSize,
        skip: nextSkip,
      );

      products.addAll(newProducts);
      _skip = nextSkip;

      if (newProducts.length < _pageSize) {
        _hasMore = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    _isLoadingMore = false;
    notifyListeners();
  }
}
