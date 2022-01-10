import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:productcase/home/domain/usecases/i_list_product.dart';
import 'package:productcase/home/domain/usecases/i_remove_product.dart';
import 'package:productcase/home/presenter/providers/list_products_provider.dart';
import 'package:productcase/home/presenter/providers/remove_products_provider.dart';
import 'package:productcase/home/ui/widgets/product_tile.dart';
import 'package:provider/provider.dart';

import '../../data/repository/mocks/product_fake.dart';

class ListProductControllerMock extends Mock implements IListProducts {}
class RemoveProductControllerMock extends Mock implements IRemoveProduct {}

void main() {
  final List<Product> fake = ProductFake.fake;
  late final IListProducts controller;
  late final IRemoveProduct controllerRemove;

  setUpAll(() {    
    controller = ListProductControllerMock();
    controllerRemove = RemoveProductControllerMock();
  });

  Future<void> _initializerTester(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ListProductsProvider(controller),
            ),
            ChangeNotifierProvider(
              create: (_) => RemoveProductProvider(controllerRemove),
            ),
          ],
          child: MaterialApp(
              home: ProductTile(
            product: fake.first,
          ))),
    );
  }

  testWidgets('Should show tile product', (tester) async {
    await mockNetworkImages(() async {
      when(() => controller()).thenAnswer((_) async => right(fake));
      final product = fake.first;
      await _initializerTester(tester);
      expect(find.byType(Image), findsOneWidget);
      expect(find.image(NetworkImage(product.filename)), findsOneWidget);
      expect(find.text(product.title), findsOneWidget);
      expect(find.byType(PopupMenuButton), findsOneWidget);
      expect(find.text(product.createat), findsOneWidget);
      expect(find.text(product.type), findsOneWidget);
      expect(find.textContaining(product.price.toStringAsFixed(2)),
          findsOneWidget);
      expect(find.text(product.description), findsOneWidget);
      expect(
          find.byIcon(Icons.star_outline), findsNWidgets(5 - product.rating));
      expect(find.byIcon(Icons.star), findsNWidgets(product.rating));
    });
  });
  testWidgets('Should show delete confirmation if remove method is called',
      (tester) async {
    await mockNetworkImages(() async {
      await _initializerTester(tester);
      final menu = find.byType(PopupMenuButton);
      await tester.tap(menu);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.widgetWithIcon(IconButton, Icons.edit), findsOneWidget);
      expect(find.widgetWithIcon(IconButton, Icons.delete), findsOneWidget);

      final delete = find.widgetWithIcon(IconButton, Icons.delete);
      await tester.tap(delete);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Confirm'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Cancel'), findsOneWidget);
    });
  });
}
