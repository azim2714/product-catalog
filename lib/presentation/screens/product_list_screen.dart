import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_list_provider.dart';
import '../providers/view_state.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/services/product_api_service.dart';
import '../providers/product_detail_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductListProvider>().loadProducts();
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      context.read<ProductListProvider>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Catalog')),
      body: Consumer<ProductListProvider>(
        builder: (context, provider, child) {
          switch (provider.state) {
            case ViewState.loading:
              return const Center(child: CircularProgressIndicator());

            case ViewState.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something went wrong'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: provider.loadProducts,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );

            case ViewState.empty:
              return const Center(child: Text('No products found'));

            case ViewState.success:
              return ListView.builder(
                controller: _scrollController,
                itemCount:
                    provider.products.length + (provider.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= provider.products.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final product = provider.products[index];

                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => ProductDetailProvider(
                              ProductRepository(ProductApiService()),
                            ),
                            child: ProductDetailScreen(productId: product.id),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
          }
        },
      ),
    );
  }
}
