import 'package:dartz/dartz.dart';

abstract class IUpdateProduct {
  Future<Either<String, bool>> call(String id, Map<String, dynamic> body);
}
