import 'package:productcase/edit/data/datasources/i_client.dart';
import 'package:productcase/edit/domain/usecases/i_update_product.dart';
import 'package:dartz/dartz.dart';

import 'error/update_product_exception.dart';

class UpdateProduct implements IUpdateProduct {
  final IClient datasource;

  UpdateProduct(this.datasource);

  @override
  Future<Either<String, bool>> call(
      String id, Map<String, dynamic> body) async {
     try {
      final result = await datasource.list();
      return right(result);
    } catch (_) {
      return left(NotFoundException().message);
    }
  }
}