import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:productcase/home/data/models/product_model.dart';
import 'package:productcase/home/domain/entities/product.dart';

void main() {
  test('Should return a product model when a map is provided', () {
    final result = ProductModel.fromMap(const {
      'title': "Brown eggs",
      'type': "dairy",
      'description': "Raw organic brown eggs in a basket",
      'filename': "0.jpg",
      'height': 600,
      'width': 400,
      'price': 28.1,
      'rating': 4
    }, Random().nextDouble().toString());

    expect(result, isA<Product>());
  });
}
