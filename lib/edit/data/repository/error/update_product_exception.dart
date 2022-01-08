class IUpdateProductException implements Exception{
  final String message = '';

}

class NotFoundException implements IUpdateProductException {

  @override
  final String message = 'No products found';

}




