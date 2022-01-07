import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:productcase/home/data/repository/list_product.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:productcase/home/domain/usecases/i_list_product.dart';
import 'package:productcase/home/presenter/controllers/list_product_controller.dart';

import '../../data/repository/mocks/product_fake.dart';

class ListProductMock extends Mock implements IListProducts{}


void main() {
  final fake = ProductFake.fake;
  late final IListProducts repository;
  late final ListProductController sut;

  setUpAll(() {
    repository = ListProductMock();
    sut = ListProductController(repository);
  });
  test('Should call the repository correctly', () async {
    when(() => repository()).thenAnswer((_) async => right(fake));

    await sut();

    verify(() => repository()).called(1);
  });
  test('Should return a list of products on success', () async {
    when(() => repository()).thenAnswer((_) async => right(fake));
    final result = await sut();

     expect(result.fold((l) => l, (r) => r), isA<List<Product>>());
    expect(result.fold((l) => l, (r) => r), equals(fake));
    expect(result.fold((l) => l, (r) => r.last), equals(fake.last));
  });
  test('Should return an error message on failure', () async {
    when(() => repository()).thenAnswer((_) async => left('error'));
    final result = await sut();
    expect(result.fold((l) => l, (r) => r), isA<String>());
  });
}