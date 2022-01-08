import 'package:dartz/dartz.dart';

abstract class IUpdateProduct {
  Future<Either<String, bool>> call();
}
