import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String type;
  final String description;
  final String imageUrl;
  final int height;
  final int width;
  final double price;
  final int rating;

  const Product({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.price,
    required this.rating,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      type,
      description,
      imageUrl,
      height,
      width,
      price,
      rating,
    ];
  }
}
