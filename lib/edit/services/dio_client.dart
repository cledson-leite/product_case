import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:productcase/edit/data/datasources/i_client.dart';
import 'package:productcase/edit/data/repository/error/update_product_exception.dart';

class DioClient implements IClient {
  final Dio service;

  DioClient(this.service) {
    service.options.baseUrl =
        'https://minha-loja-d150f-default-rtdb.firebaseio.com';
  }
  @override
  Future<bool> list(String id, Map<String, dynamic> body) async {
    try {
      await service.put(
        '/products/$id.json',
        data: jsonEncode(body),
      );
      return true;
    } catch (_) {
      throw NotFoundException();
    }
  }
}
