import 'package:dartz/dartz.dart';

abstract class IRemoveProduct {
  Future<Either<String, bool>> call(String id);
}
