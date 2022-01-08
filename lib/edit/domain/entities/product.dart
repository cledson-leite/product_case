import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String title;
  final String type;
  final String description;
  final String filename;
  final int height;
  final int width;
  final double price;
  final int rating;
  final String createat;

  const Product({
    required this.title,
    required this.type,
    required this.description,
    required this.filename,
    required this.height,
    required this.width,
    required this.price,
    required this.rating,
    required this.createat, 
  });

  @override
  List<Object> get props {
    return [
      title,
      type,
      description,
      filename,
      height,
      width,
      price,
      rating,
      createat,
    ];
  }
}
