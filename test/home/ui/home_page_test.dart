import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:productcase/home/domain/usecases/i_list_product.dart';
import 'package:productcase/home/presenter/providers/list_products_provider.dart';
import 'package:productcase/home/ui/home_page.dart';
import 'package:productcase/home/ui/widgets/product_tile.dart';
import 'package:provider/provider.dart';

import '../data/repository/mocks/product_fake.dart';

class ListProductControllerMock extends Mock implements IListProducts {}

void main() {
  final List<Product> fake = ProductFake.fake;
  late final IListProducts controller;

  setUpAll(() {
    controller = ListProductControllerMock();
  });

  Future<void> _initializerTester(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ListProductsProvider(controller),
        child: const MaterialApp(home: HomePage()),
      ),
    );
  }

  testWidgets('Should display an initial screen with the wait', (tester) async {
    when(() => controller()).thenAnswer((_) async => right(fake));
    await _initializerTester(tester);
    expect(find.text('Product Case'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('Should display a centralized error text in case of failure',
      (tester) async {
    when(() => controller()).thenAnswer((_) async => left('Error default'));
    await _initializerTester(tester);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('Error default'), findsOneWidget);
  });
  testWidgets('Should show a tile view list of products on success', (tester) async {
    await mockNetworkImages(() async {
      when(() => controller()).thenAnswer((_) async => right(fake));
      await _initializerTester(tester);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final BuildContext context = tester.element(find.byType(HomePage));
      Provider.of<ListProductsProvider>(context, listen: false).load();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final products = Provider.of<ListProductsProvider>(context, listen: false).products;
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ProductTile), findsNWidgets(products.length));
    });
  });
}
