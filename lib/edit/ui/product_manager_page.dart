import 'package:flutter/material.dart';

class ProductManagerPage extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductManagerPage(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
          child: ListView(
        children: [
          TextFormField(
            initialValue: product['title'],
            decoration:const  InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextFormField(
            initialValue: product['type'],
            decoration:const  InputDecoration(
              labelText: 'Type',
            ),
          ),
          TextFormField(
            initialValue: product['price'].toString(),
            decoration:const  InputDecoration(
              labelText: 'Price',
            ),
          ),
          TextFormField(
            initialValue: product['rating'].toString(),
            decoration:const  InputDecoration(
              labelText: 'Rating',
            ),
          ),
          TextFormField(
            initialValue: product['filename'],
            decoration:const  InputDecoration(
              labelText: 'Url image',
            ),
          ),
          ElevatedButton(onPressed: (){}, child: Text('Update'.toUpperCase())),
          IconButton(onPressed: (){}, icon: const Icon(Icons.close)),
        ],
      )),
    );
  }
}
