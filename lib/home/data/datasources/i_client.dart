import 'package:productcase/home/domain/entities/product.dart';

abstract class IClient {
  Future<List<Product>> list();
}
