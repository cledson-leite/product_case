import 'package:productcase/home/data/repository/error/list_product_exception.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:dartz/dartz.dart';
import 'package:productcase/home/domain/usecases/i_list_product.dart';

class ListProductController implements IListProducts {
  final IListProducts repository;

  ListProductController(this.repository);

  @override
  Future<Either<String, List<Product>>> call() async {
    try {
      final result = await repository();
      return result;
    } on IListProductException catch (erro) {
      return left(erro.toString());
    }
  }
}
