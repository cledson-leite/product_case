import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String title;
  String type;
  String description;
  String filename;
  double price;
  int rating;
  String createat;

  Product({
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
