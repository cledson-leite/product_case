import 'dart:math';

import 'package:productcase/home/data/models/product_model.dart';

class ProductFake {
  static final fake = [
    ProductModel.fromMap(const {
      'title': "Brown eggs",
      'type': "dairy",
      'description': "Raw organic brown eggs in a basket",
      'imageUrl': "0.jpg",
      'height': 600,
      'width': 400,
      'price': 28.1,
      'rating': 4
    }, Random().nextDouble().toString()),
  ];
}