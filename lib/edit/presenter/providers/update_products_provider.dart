import 'package:flutter/material.dart';
import 'package:productcase/edit/domain/usecases/i_update_product.dart';

class UpdateProductProvider extends ChangeNotifier {
  final IUpdateProduct controller;

  UpdateProductProvider(this.controller);
  bool update = false;
  String error = '';
  
  int _rating = 0;

  int get rating => _rating;
  set rating(int value){
    _rating = value;
    notifyListeners();
  }

  Future<void> put(String id, Map<String, dynamic> body) async {
    final result = await controller(id, body);
    result.fold(
      (l) => error = l,
      (r) => update = r,
    );
    notifyListeners();
  }
}
