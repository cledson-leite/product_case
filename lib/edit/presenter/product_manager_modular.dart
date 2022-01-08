import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:productcase/edit/data/repository/update_product.dart';
import 'package:productcase/edit/presenter/controllers/update_product_controller.dart';
import 'package:productcase/edit/presenter/providers/update_products_provider.dart';
import 'package:productcase/edit/services/dio_client.dart';
import 'package:productcase/edit/ui/product_manager_page.dart';
import 'package:provider/provider.dart';

class ProductManagerModular extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => Dio()),
    Bind.factory((i) => DioClient(i())),
    Bind.factory((i) => UpdateProduct(i())),
    Bind.factory((i) => UpdateProductController(i())),
    Bind.factory((i) => UpdateProductProvider(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => ChangeNotifierProvider(
        create: (_) => Modular.get<UpdateProductProvider>(),
        child: ProductManagerPage(args.data['id'], args.data['body']),
      ),
    ),
  ];
}
