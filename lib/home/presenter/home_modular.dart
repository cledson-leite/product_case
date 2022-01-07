import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:productcase/home/data/repository/list_product.dart';
import 'package:productcase/home/presenter/controllers/list_product_controller.dart';
import 'package:productcase/home/presenter/providers/list_products_provider.dart';
import 'package:productcase/home/services/dio_client.dart';
import 'package:productcase/home/ui/home_page.dart';
import 'package:provider/provider.dart';

class HomeModular extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => Dio()),
    Bind.factory((i) => DioClient(i())),
    Bind.factory((i) => ListProduct(i())),
    Bind.factory((i) => ListProductController(i())),
    Bind.factory((i) => ListProductsProvider(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => ChangeNotifierProvider(
        create: (_) => Modular.get<ListProductsProvider>(),
        child: const HomePage(),
      ),
    ),
  ];
}
