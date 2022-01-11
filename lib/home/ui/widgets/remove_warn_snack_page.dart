import 'package:flutter/material.dart';
    
class RemoveWarnSnackPage extends StatelessWidget {

  const RemoveWarnSnackPage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner())
      ,
    );
  }
}