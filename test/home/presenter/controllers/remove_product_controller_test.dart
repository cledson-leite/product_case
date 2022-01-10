import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:productcase/home/domain/usecases/i_remove_product.dart';
import 'package:productcase/home/presenter/controllers/remove_product_controller.dart';

class RemoveProductMock extends Mock implements IRemoveProduct {}

void main() {
  const String id = '1';
  late final IRemoveProduct repository;
  late final RemoveProductController sut;

  setUpAll(() {
    repository = RemoveProductMock();
    sut = RemoveProductController(repository);
  });
  test('Should call the repository correctly', () async {
    when(() => repository(id)).thenAnswer((_) async => right(true));

    await sut(id);

    verify(() => repository(id)).called(1);
  });
  test('Should return a list of products on success', () async {
    when(() => repository(id)).thenAnswer((_) async => right(true));
    final result = await sut(id);

    expect(result.fold((l) => l, (r) => r), isA<bool>());
    expect(result.fold((l) => l, (r) => r), isTrue);
  });
  test('Should return an error message on failure', () async {
    when(() => repository(id)).thenAnswer((_) async => left('error'));
    final result = await sut(id);
    expect(result.fold((l) => l, (r) => r), isA<String>());
  });
}
