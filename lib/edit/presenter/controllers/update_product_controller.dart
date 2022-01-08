import 'package:dartz/dartz.dart';
import 'package:productcase/edit/data/repository/error/update_product_exception.dart';
import 'package:productcase/edit/domain/usecases/i_update_product.dart';

class UpdateProductController implements IUpdateProduct {
  final IUpdateProduct repository;

  UpdateProductController(this.repository);

  @override
  Future<Either<String, bool>> call(String id, Map<String, dynamic> body) async {
    try {
      final result = await repository(id, body);
      return result;
    } catch (erro) {
      return left(erro.toString());
    }
  }
}
