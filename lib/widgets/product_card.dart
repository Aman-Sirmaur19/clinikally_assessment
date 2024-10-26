import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Icon(Icons.shopping_bag_rounded, size: 50), // Placeholder for image
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('₹${product.price}',
                style: const TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
