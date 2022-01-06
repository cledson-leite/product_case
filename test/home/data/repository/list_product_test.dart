import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:productcase/home/data/datasources/i_client.dart';
import 'package:productcase/home/data/repository/error/list_product_exception.dart';
import 'package:productcase/home/data/repository/list_product.dart';
import 'package:productcase/home/domain/entities/product.dart';

import 'mocks/product_fake.dart';

class ClientMock extends Mock implements IClient {}

void main() {
  final fake = ProductFake.fake;
  late final IClient datasource;
  late final ListProduct sut;

  setUpAll(() {
    datasource = ClientMock();
    sut = ListProduct(datasource);
  });

  tearDown(() {
    clearInteractions(datasource);
    reset(datasource);
  });
  test('Should call the datasource correctly', () async {
    when(() => datasource.list()).thenAnswer((_) async => fake);

    await sut();

    verify(() => datasource.list()).called(1);
  });
  test('Should return a list product entity on success', () async {
    when(() => datasource.list()).thenAnswer((_) async => fake);

    final result = await sut();

    expect(result.fold((l) => l, (r) => r), isA<List<Product>>());
    expect(result.fold((l) => l, (r) => r), equals(fake));
    expect(result.fold((l) => l, (r) => r.last), equals(fake.last));
  });
  test('Should returns NotFoundException error message on empty return', () async {
    when(() => datasource.list()).thenAnswer((_) async => []);

    final result = await sut();

    expect(result.fold((l) => l, (r) => r), NotFoundException().message);
  });
  test('Should return unexpected error message on failure', () async {
    when(() => datasource.list()).thenThrow(Error());

    final result = await sut();

    expect(result.fold((l) => l, (r) => r), UnexpectedException().message);
  });
}
