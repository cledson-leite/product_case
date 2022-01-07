import 'package:flutter/cupertino.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:productcase/home/domain/usecases/i_list_product.dart';

class ListProductsProvider extends ChangeNotifier {
  final IListProducts controller;

  ListProductsProvider(this.controller);

  final List<Product> _items = [];

  List<Product> get products => [..._items];
  
  Future<void> load() async {
    _items.clear();
    final result = await controller();
    result.fold(
      (l) => throw l,
      (r) => r..forEach((product) => _items.add(product)),
    );
    notifyListeners();
  }
}
