import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: product.thumbnail,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return const SizedBox(
                width: 64,
                height: 64,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return const SizedBox(
                width: 64,
                height: 64,
                child: Icon(Icons.broken_image),
              );
            },
          ),
        ),
        title: Text(
          product.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }
}