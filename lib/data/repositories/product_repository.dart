import '../models/product_model.dart';
import '../services/product_api_service.dart';

class ProductRepository {
  final ProductApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<Product>> getProducts({
    required int limit,
    required int skip,
  }) async {
    final response = await _apiService.getProducts(
      limit: limit,
      skip: skip,
    );

    final products = response.data['products'] as List;

    return products
        .map((json) => Product.fromJson(json))
        .toList();
  }

  Future<Product> getProductDetail(int id) async {
    final response = await _apiService.getProductDetail(id);

    return Product.fromJson(response.data);
  }

  Future<List<Product>> searchProducts(String query) async {
    final response = await _apiService.searchProducts(query);

    final products = response.data['products'] as List;

    return products
        .map((json) => Product.fromJson(json))
        .toList();
  }
}