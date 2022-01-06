import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_widget.dart';

class AppModule extends Module {
    @override
    final List<Bind> binds = [];
 
    @override
    final List<ModularRoute> routes = [
      ChildRoute('/', child: (_, args) => Container()),
    ];
 
}