import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:productcase/edit/data/datasources/i_client.dart';
import 'package:productcase/edit/data/repository/error/update_product_exception.dart';
import 'package:productcase/edit/data/repository/update_product.dart';

import 'mocks/body_fake.dart';

class ClientMock extends Mock implements IClient {}

void main() {
  const String id = '1';
  final Map<String, dynamic> body = BodyFake.fake;
  late final IClient datasource;
  late final UpdateProduct sut;

  setUpAll(() {
    datasource = ClientMock();
    sut = UpdateProduct(datasource);
  });

  tearDown(() {
    clearInteractions(datasource);
    reset(datasource);
  });
  test('Should call the datasource correctly', () async {
    when(() => datasource.list()).thenAnswer((_) async => true);

    await sut(id, body);

    verify(() => datasource.list()).called(1);
  });
  test('Should return a list product entity on success', () async {
    when(() => datasource.list()).thenAnswer((_) async => true);

    final result = await sut(id, body);

    expect(result.fold((l) => l, (r) => r), isA<bool>());
    expect(result.fold((l) => l, (r) => r), isTrue);
  });
  test('Should returns NotFoundException error message on failure', () async {
    when(() => datasource.list()).thenThrow(Error());

    final result = await sut(id, body);

    expect(result.fold((l) => l, (r) => r), NotFoundException().message);
  });
}
