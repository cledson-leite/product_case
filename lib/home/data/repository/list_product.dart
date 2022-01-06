import 'package:productcase/home/data/datasources/i_client.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:dartz/dartz.dart';
import 'package:productcase/home/domain/usecases/i_list_product.dart';

import 'error/list_product_exception.dart';

class ListProduct implements IListProducts {
  final IClient datasource;

  ListProduct(this.datasource);

  @override
  Future<Either<String, List<Product>>> call() async {
     try {
      final result = await datasource.list();
      if (result.isEmpty) return left(NotFoundException().message);
      return right(result);
    } catch (err) {
      return left(UnexpectedException().message);
    }
  }
}
