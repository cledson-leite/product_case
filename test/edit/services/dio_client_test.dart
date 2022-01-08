import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:productcase/edit/data/repository/error/update_product_exception.dart';
import 'package:productcase/edit/services/dio_client.dart';

import '../data/repository/mocks/body_fake.dart';

void main() {
  const String id = '1';
  final Map<String, dynamic> body = BodyFake.fake;
  late final Dio dio;
  late final DioAdapter service;
  late final DioClient sut;

  setUpAll(() async {
    dio = Dio(BaseOptions(
        baseUrl: 'https://minha-loja-d150f-default-rtdb.firebaseio.com'));
    service = DioAdapter(dio: dio);
    sut = DioClient(service.dio);
  });
  test('Should return a true on success', () async {
    service.onPut(
      '/products/$id.json',
      (server) => server.reply(200, true),
      data: jsonEncode(body),
    );
    await dio.put(
      '/products/$id.json',
      data: jsonEncode(body),
    );
    final result = await sut.list(id, body);
    expect(result, isA<bool>());
    expect(result, isTrue);
  });
  test('Should return error on failure', () async {
    service.onPut(
      '/products/$id.json',
      (server) => server.throws(
        404,
        DioError(
          requestOptions: RequestOptions(
            path: '/products/$id.json',
          ),
        ),
      ),
      data: jsonEncode(body),
    );
    expect(()  =>  sut.list(id, body), throwsA(isA<NotFoundException>()));
  });
}
