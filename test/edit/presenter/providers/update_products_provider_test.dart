import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:productcase/edit/domain/usecases/i_update_product.dart';
import 'package:productcase/edit/presenter/providers/update_products_provider.dart';

import '../../data/repository/mocks/body_fake.dart';

class UpdateProductControllerMock extends Mock implements IUpdateProduct {}

void main() {
  const String id = '1';
  final Map<String, dynamic> body = BodyFake.fake;
  late final IUpdateProduct controller;
  late final UpdateProductProvider sut;

  setUpAll(() {
    controller = UpdateProductControllerMock();
    sut = UpdateProductProvider(controller);
  });

  test('Should call the controller correctly', () async {
    when(() => controller(id, body)).thenAnswer((_) async => right(true));
    await sut.put(id, body);
    verify(() => controller(id, body)).called(1);
  });
  test('Should return true when method update is called',
      () async {
    expect(sut.update, isA<bool>());
  });
  test('Should updated is true when put method is called', () async {
    when(() => controller(id, body)).thenAnswer((_) async => right(true));
    await sut.put(id, body);
    expect(sut.update, isTrue);
  });
  test('Should throw an error message to view on failure', () async {
    when(() =>  controller(id, body)).thenAnswer((_) async => left('error default'));
    expect(sut.error, isEmpty);
    await sut.put(id, body);
    expect(sut.error, isNotEmpty);
  });
}
