import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: product.thumbnail,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return const SizedBox(
              width: 60,
              height: 60,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          },
          errorWidget: (context, url, error) {
            return const SizedBox(
              width: 60,
              height: 60,
              child: Icon(Icons.broken_image),
            );
          },
        ),
      ),
      title: Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
    );
  }
}
