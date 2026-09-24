import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_detail_provider.dart';
import '../providers/view_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProductDetailProvider>()
          .loadProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Consumer<ProductDetailProvider>(
        builder: (context, provider, child) {
          switch (provider.state) {
            case ViewState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ViewState.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something went wrong'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        provider.loadProduct(widget.productId);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );

            case ViewState.empty:
              return const Center(
                child: Text('Product not found'),
              );

            case ViewState.success:
              final product = provider.product!;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        itemCount: product.images.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            product.images[index],
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(Icons.star),
                        const SizedBox(width: 4),
                        Text(product.rating.toString()),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}