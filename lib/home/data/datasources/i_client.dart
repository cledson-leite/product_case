import 'package:productcase/home/data/models/product_model.dart';

abstract class IClient {
  Future<List<ProductModel>> list();
}
