import 'package:flutter/material.dart';
import 'package:productcase/home/domain/entities/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(product.filename),
        Text(product.title),
        Text(product.type),
        Text(product.createat),
        Text(product.description),
        Visibility(
          visible: product.rating >= 1,
          replacement: const Icon(Icons.star_outline),
          child: const Icon(Icons.star),
        ),
        Visibility(
          visible: product.rating >= 2,
          replacement: const Icon(Icons.star_outline),
          child: const Icon(Icons.star),
        ),
        Visibility(
          visible: product.rating >= 3,
          replacement: const Icon(Icons.star_outline),
          child: const Icon(Icons.star),
        ),
        Visibility(
          visible: product.rating >= 4,
          replacement: const Icon(Icons.star_outline),
          child: const Icon(Icons.star),
        ),
        Visibility(
          visible: product.rating >= 5,
          replacement: const Icon(Icons.star_outline),
          child: const Icon(Icons.star),
        ),
        Text(product.price.toStringAsFixed(2)),
      ],
    );
  }
}
