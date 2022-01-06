import 'dart:math';

import 'package:productcase/home/domain/entities/product.dart';

class ProductFake {
  static final fake = [
    Product(
      id: Random().nextDouble().toString(),
      title:"Brown eggs",
      type: "dairy",
      description: "Raw organic brown eggs in a basket",
      imageUrl: "0.jpg",
      height: 600,
      width: 400,
      price: 28.1,
      rating: 4
    ),
  ];
}