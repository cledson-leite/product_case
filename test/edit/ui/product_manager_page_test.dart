import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:productcase/edit/domain/usecases/i_update_product.dart';
import 'package:productcase/edit/presenter/providers/update_products_provider.dart';
import 'package:productcase/edit/ui/product_manager_page.dart';
import 'package:provider/provider.dart';

import '../data/repository/mocks/body_fake.dart';

class UpdateProductControllerMock extends Mock implements IUpdateProduct {}

void main() {
  final Map<String, dynamic> body = BodyFake.fake;
  late final IUpdateProduct controller;

  setUpAll(() {
    controller = UpdateProductControllerMock();
  });

  Future<void> _initializerTester(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => UpdateProductProvider(controller),
        child: MaterialApp(home: ProductManagerPage(body)),
      ),
    );
  }

  testWidgets('Should display an initial screen', (tester) async {
    await _initializerTester(tester);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.text('Title'), findsOneWidget);
    expect(find.text(body['title']), findsOneWidget);
    expect(find.text('Type'), findsOneWidget);
    expect(find.text(body['type']), findsOneWidget);
    expect(find.text('Price'), findsOneWidget);
    expect(find.text(body['price'].toString()), findsOneWidget);
    expect(find.text('Url image'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.close), findsOneWidget);
  });
}
