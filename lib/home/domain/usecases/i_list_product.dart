import 'package:dartz/dartz.dart';
import 'package:productcase/home/domain/entities/product.dart';

abstract class IListProducts {
  Future<Either<String, List<Product>>> call();
}
