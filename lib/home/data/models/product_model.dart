import 'dart:convert';

import 'package:productcase/home/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required id,
    required title,
    required type,
    required description,
    required imageUrl,
    required height,
    required width,
    required price,
    required rating,
  }) : super(
    id: id,
    title: title,
    type: type,
    description: description,
    imageUrl: imageUrl,
    height: height,
    width: width,
    price: price,
    rating: rating,
  );

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      height: map['height']?.toInt() ?? 0,
      width: map['width']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      rating: map['rating']?.toInt() ?? 0,
    );
  }
}
