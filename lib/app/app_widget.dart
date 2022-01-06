import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Case',
      theme: ThemeData(
        fontFamily: 'Lato',
      ).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: const Color(0xff33691E),
                secondary: const Color(0xffffffff),
                surface: const Color(0xffB2FF59),
              )),
    ).modular();
  }
}
