import 'package:dio/dio.dart';

import '../../core/network/api_client.dart';

class ProductApiService {
  final Dio _dio = ApiClient.dio;

  Future<Response> getProducts({
    required int limit,
    required int skip,
  }) {
    return _dio.get(
      '/products',
      queryParameters: {
        'limit': limit,
        'skip': skip,
      },
    );
  }

  Future<Response> getProductDetail(int id) {
    return _dio.get('/products/$id');
  }

  Future<Response> searchProducts(String query) {
    return _dio.get(
      '/products/search',
      queryParameters: {
        'q': query,
      },
    );
  }
}