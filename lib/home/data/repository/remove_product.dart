import 'package:dartz/dartz.dart';
import 'package:productcase/home/data/datasources/i_delete_client.dart';
import 'package:productcase/home/domain/usecases/i_remove_product.dart';

import 'error/list_product_exception.dart';

class RemoveProduct implements IRemoveProduct {
  final IDeleteClient datasource;

  RemoveProduct(this.datasource);

  @override
  Future<Either<String, bool>> call(String id) async {
     try {
      final result = await datasource.delete(id);
      if (!result) return left(NotFoundException().message);
      return right(result);
    } catch (err) {
      return left(UnexpectedException().message);
    }
  }
}
