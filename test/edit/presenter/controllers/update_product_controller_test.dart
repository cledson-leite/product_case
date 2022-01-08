import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:productcase/edit/domain/usecases/i_update_product.dart';
import 'package:productcase/edit/presenter/controllers/update_product_controller.dart';

import '../../data/repository/mocks/body_fake.dart';

class UpdateProductMock extends Mock implements IUpdateProduct {}

void main() {
  const String id = '1';
  final body = BodyFake.fake;
  late final IUpdateProduct repository;
  late final UpdateProductController sut;

  setUpAll(() {
    repository = UpdateProductMock();
    sut = UpdateProductController(repository);
  });
  test('Should call the repository correctly', () async {
    when(() => repository(id, body)).thenAnswer((_) async => right(true));

    await sut(id, body);

    verify(() => repository(id, body)).called(1);
  });
  test('Should return true on success', () async {
    when(() => repository(id, body)).thenAnswer((_) async => right(true));
    final result = await sut(id, body);

    expect(result.fold((l) => l, (r) => r), isA<bool>());
    expect(result.fold((l) => l, (r) => r), isTrue);
  });
  test('Should return an error message on failure', () async {
    when(() => repository(id, body)).thenAnswer((_) async => left('error'));
    final result = await sut(id, body);
    expect(result.fold((l) => l, (r) => null), isA<String>());
  });
}
