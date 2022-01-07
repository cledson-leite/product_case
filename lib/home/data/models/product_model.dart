import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:productcase/home/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required id,
    required title,
    required type,
    required description,
    required filename,
    required height,
    required width,
    required price,
    required rating,
    required createat,
  }) : super(
          id: id,
          title: title,
          type: type,
          description: description,
          filename: filename,
          height: height,
          width: width,
          price: price,
          rating: rating,
          createat: createat,
        );

  factory ProductModel.fromMap(Map<String, dynamic> map, String? id) {
    final String imageUrl =
        'https://firebasestorage.googleapis.com/v0/b/minha-loja-d150f.appspot.com/o/${map['filename']}?alt=media';
    return ProductModel(
      id: id ?? '',
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      filename: imageUrl ,
      height: map['height']?.toInt() ?? 0,
      width: map['width']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      rating: map['rating']?.toInt() ?? 0,
      createat: DateFormat('dd/MM/yyyy').format(DateTime.now()),
    );
  }
}
