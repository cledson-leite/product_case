class IListProductException implements Exception{
  final String message = '';

}

class NotFoundException implements IListProductException {

  @override
  final String message = 'No products found';

}

class UnexpectedException implements IListProductException {

  @override
  final String message =
      'An unexpected failure has occurred. Please try soon...';
      
}




