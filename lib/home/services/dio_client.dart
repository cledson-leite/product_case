import 'package:dio/dio.dart';
import 'package:productcase/home/data/datasources/i_client.dart';
import 'package:productcase/home/data/datasources/i_delete_client.dart';
import 'package:productcase/home/data/models/product_model.dart';
import 'package:productcase/home/data/repository/error/list_product_exception.dart';

class DioClient implements IClient, IDeleteClient {
  final Dio service;

  DioClient(this.service) {
    service.options.baseUrl =
        'https://minha-loja-d150f-default-rtdb.firebaseio.com';
  }
  @override
  Future<List<ProductModel>> list() async {
    try {
      final result = await service.get('/products.json');

      final List<ProductModel> models = [];
      if (result.data == null) return models;
      result.data.forEach((key, value) {
        models.add(ProductModel.fromMap(value, key));
      });
      return models;
    } catch (_) {
      throw UnexpectedException();
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      final result = await service.delete('/products/$id.json');
      if (result.data == null) return false;
      return result.data;
    } catch (_) {
      throw UnexpectedException();
    }
  }
}
