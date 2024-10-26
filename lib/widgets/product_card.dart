import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  // final Product product;
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Text(product.id.toString()),
        title:
            Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing:
            Text('₹${product.price}', style: TextStyle(color: Colors.green)),
      ),
    );
  }
}
