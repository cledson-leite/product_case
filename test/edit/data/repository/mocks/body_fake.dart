import 'package:intl/intl.dart';

class BodyFake {
  static final fake = {
    'title': "Brown eggs",
    'type': "dairy",
    'description': "Raw organic brown eggs in a basket",
    'filename': "0.jpg",
    'height': 600,
    'width': 400,
    'price': 28.1,
    'rating': 4,
    'createat': DateFormat('dd/MM/yyyy').format(DateTime.now()),
  };
}