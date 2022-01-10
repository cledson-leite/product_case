import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:productcase/home/data/datasources/i_delete_client.dart';
import 'package:productcase/home/data/repository/error/list_product_exception.dart';
import 'package:productcase/home/data/repository/remove_product.dart';

class DeleteClientMock extends Mock implements IDeleteClient {}

void main() {
  const String id = '1';
  late final IDeleteClient datasource;
  late final RemoveProduct sut;

  setUpAll(() {
    datasource = DeleteClientMock();
    sut = RemoveProduct(datasource);
  });

  tearDown(() {
    clearInteractions(datasource);
    reset(datasource);
  });
  test('Should call the datasource correctly', () async {
    when(() => datasource.delete(id)).thenAnswer((_) async => true);

    await sut(id);

    verify(() => datasource.delete(id)).called(1);
  });
  test('Should return a list product entity on success', () async {
    when(() => datasource.delete(id)).thenAnswer((_) async => true);

    final result = await sut(id);

    expect(result.fold((l) => l, (r) => r), isA<bool>());
    expect(result.fold((l) => l, (r) => r), isTrue);
  });
  test('Should returns NotFoundException error message on false return',
      () async {
    when(() => datasource.delete(id)).thenAnswer((_) async => false);

    final result = await sut(id);

    expect(result.fold((l) => l, (r) => r), NotFoundException().message);
  });
  test('Should return unexpected error message on failure', () async {
    when(() => datasource.delete(id)).thenThrow(Error());

    final result = await sut(id);

    expect(result.fold((l) => l, (r) => r), UnexpectedException().message);
  });
}
