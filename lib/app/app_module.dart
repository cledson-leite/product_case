import 'package:flutter_modular/flutter_modular.dart';
import 'package:productcase/home/presenter/home_modular.dart';

class AppModule extends Module {
    @override
    final List<Bind> binds = [];
 
    @override
    final List<ModularRoute> routes = [
      ModuleRoute('/', module: HomeModular()),
    ];
 
}