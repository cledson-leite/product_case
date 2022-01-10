import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:productcase/home/domain/usecases/i_remove_product.dart';
import 'package:productcase/home/presenter/providers/remove_products_provider.dart';

class RemoveProductControllerMock extends Mock implements IRemoveProduct {}

void main() {
  const String id = '1';
  late final IRemoveProduct controller;
  late final RemoveProductProvider sut;

  setUpAll(() {
    controller = RemoveProductControllerMock();
    sut = RemoveProductProvider(controller);
  });

  test('Should call the controller correctly', () async {
    when(() => controller(id)).thenAnswer((_) async => right(true));
    await sut.remove(id);
    verify(() => controller(id)).called(1);
  });
  test('Should return true when the remove method is called',
      () async {
    expect(sut.isRemoved, isA<bool>());
    expect(sut.isRemoved, isTrue);
  });
  test('Should throw an error message to view on failure', () async {
    when(() => controller(id)).thenAnswer((_) async => left('error default'));
    expect(sut.error, isEmpty);
    await sut.remove(id);
    expect(sut.error, isNotEmpty);
  });
}
