import 'package:flutter/material.dart';
import 'package:productcase/home/domain/usecases/i_remove_product.dart';

class RemoveProductProvider extends ChangeNotifier {
  final IRemoveProduct controller;

  RemoveProductProvider(this.controller);

  bool isRemoved = false;
  String error = '';

  Future<void> remove(String id) async {
    final result = await controller(id);
    result.fold(
      (l) => error = l,
      (r) => isRemoved = r,
    );
    notifyListeners();
  }
}
