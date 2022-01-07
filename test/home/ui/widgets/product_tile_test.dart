import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:productcase/home/domain/usecases/i_list_product.dart';
import 'package:productcase/home/presenter/providers/list_products_provider.dart';
import 'package:productcase/home/ui/widgets/product_tile.dart';
import 'package:provider/provider.dart';

import '../../data/repository/mocks/product_fake.dart';

class ListProductControllerMock extends Mock implements IListProducts {}

void main() {
  final List<Product> fake = ProductFake.fake;
  late final IListProducts controller;

  setUpAll(() {
    controller = ListProductControllerMock();
  });

  testWidgets('Should show tile product', (tester) async {
    await mockNetworkImages(() async {
      when(() => controller()).thenAnswer((_) async => right(fake));
      final product = fake.first;
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ListProductsProvider(controller),
          child: MaterialApp(
              home: ProductTile(
            product: product,
          )),
        ),
      );
      expect(find.byType(Image), findsOneWidget);
      expect(find.image(NetworkImage(product.filename)), findsOneWidget);
      expect(find.text(product.title), findsOneWidget);
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
}
