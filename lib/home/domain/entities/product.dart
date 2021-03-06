import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String type;
  final String description;
  final String filename;
  final double price;
  final int rating;
  final String createat;

  const Product({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.filename,
    required this.price,
    required this.rating,
    required this.createat, 
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      type,
      description,
      filename,
      price,
      rating,
      createat,
    ];
  }
}
