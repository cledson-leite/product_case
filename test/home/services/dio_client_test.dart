import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:productcase/home/data/models/product_model.dart';
import 'package:productcase/home/data/repository/error/list_product_exception.dart';
import 'package:productcase/home/services/dio_client.dart';

import 'mocks/api_response_fake.dart';

void main() {
  final response = ApiResponseFake.response;
  late final Dio dio;
  late final DioAdapter service;
  late final DioClient sut;

  setUpAll(() async {
    dio = Dio(BaseOptions(
        baseUrl: 'https://minha-loja-d150f-default-rtdb.firebaseio.com/'));
    service = DioAdapter(dio: dio);
    sut = DioClient(service.dio);
  });
  test('Should return a list of models on success', () async {
    service.onGet('/products.json', (server) => server.reply(200, response));
    await dio.get('/products.json');
    final result = await sut.list();
    final List<ProductModel> model = [];
    response.forEach((key, value) {
      model.add(ProductModel.fromMap(value, key));
    });
    expect(result, isA<List<ProductModel>>());
    expect(result.last, equals(model.last));
    expect(result.last.id, model.last.id);
  });
  test('Should return an empty list on null return', () async {
    service.onGet('/products.json', (server) => server.reply(200, null));
    await dio.get('/products.json');
    final result = await sut.list();
    expect(result, []);
  });
  test('Should return error on failure', () async {
    service.onGet(
      '/products.json',
      (server) => server.throws(
        404,
        DioError(
          requestOptions: RequestOptions(
            path: '/products.json',
          ),
        ),
      ),
    );
    expect(() async => await sut.list(), throwsA(isA<UnexpectedException>()));
  });
}
