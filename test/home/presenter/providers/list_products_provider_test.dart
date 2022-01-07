import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:productcase/home/domain/usecases/i_list_product.dart';
import 'package:productcase/home/presenter/providers/list_products_provider.dart';

import '../../data/repository/mocks/product_fake.dart';

class ListProductsProviderControllerMock extends Mock implements IListProducts {
}

void main() {
  final fake = ProductFake.fake;
  late final IListProducts controller;
  late final ListProductsProvider sut;

  setUpAll(() {
    controller = ListProductsProviderControllerMock();
    sut = ListProductsProvider(controller);
  });

  test('Should call the controller correctly', () async {
    when(() => controller()).thenAnswer((_) async => right(fake));
    await sut.load();
    verify(() => controller()).called(1);
  });
  test('Should return a list of products when method get products is called',
      () async {
    expect(sut.products, isA<List<Product>>());
  });
  test('Should update product list when load method is called', () async {
    when(() => controller()).thenAnswer((_) async => right(fake));
    expect(sut.products == fake, isFalse);
    await sut.load();
    expect(sut.products.last == fake.last, isTrue);
  });
  test('Should throw an error message to view on failure', () async {
    when(() => controller()).thenAnswer((_) async => left('error default'));
    expect(sut.error, isEmpty);
    await sut.load();
    expect(sut.error, isNotEmpty);
  });
}
