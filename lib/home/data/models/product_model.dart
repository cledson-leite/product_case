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
    required price,
    required rating,
    required createat,
  }) : super(
          id: id,
          title: title,
          type: type,
          description: description,
          filename: filename,
          price: price,
          rating: rating,
          createat: createat,
        );

  factory ProductModel.fromMap(Map<String, dynamic> map, String? id) {
    final String imageUrl =
        'https://firebasestorage.googleapis.com/v0/b/minha-loja-d150f.appspot.com/o/${map['filename']}?alt=media';
    final String filename = map['filename'];
    final String url = filename.endsWith('jpg') ? imageUrl : map['filename'];
    return ProductModel(
      id: id,
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      filename: url,
      price: map['price'],
      rating: map['rating'],
      createat: map['createat'] ?? DateFormat('dd/MM/yyyy').format(DateTime.now()),
    );
  }
}
