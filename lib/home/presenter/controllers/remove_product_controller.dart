import 'package:productcase/home/data/repository/error/list_product_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:productcase/home/domain/usecases/i_remove_product.dart';

class RemoveProductController implements IRemoveProduct {
  final IRemoveProduct repository;

  RemoveProductController(this.repository);

  @override
  Future<Either<String, bool>> call(String id) async {
    try {
      final result = await repository(id);
      return result;
    } on IListProductException catch (erro) {
      return left(erro.toString());
    }
  }
}
