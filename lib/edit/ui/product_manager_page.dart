import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:productcase/edit/presenter/providers/update_products_provider.dart';
import 'package:provider/provider.dart';

class ProductManagerPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final String id;
  const ProductManagerPage(this.id, this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Text('Manager Product',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Anton',
                fontSize: 24,
                wordSpacing: 10,
                letterSpacing: 2),
          ),),
      body: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 10),
        child: Form(
            key: key,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // autofocus: true,
                    initialValue: product['title'],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Title',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      product['title'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: product['type'],
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Type',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      product['type'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    initialValue: product['description'],
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    onSaved: (value) {
                      product['description'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: product['price'].toStringAsFixed(2),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefix: const Text('R\$  '),
                        labelText: 'Price',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field';
                      }
                      final decimal = value.split('.')[1];
                      if (decimal.length != 2) {
                        return 'the value must be in reais';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      product['price'] = double.parse(value!);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: product['filename'],
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Url image',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    onSaved: (value) {
                      product['filename'] = value;
                    },
                  ),
                ),
                Consumer<UpdateProductProvider>(
                    builder: (context, provider, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _rating(provider, context, 1),
                      _rating(provider, context, 2),
                      _rating(provider, context, 3),
                      _rating(provider, context, 4),
                      _rating(provider, context, 5),
                    ],
                  );
                }),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () async {
                      final bool isValid = key.currentState!.validate();
                      if (isValid) {
                        key.currentState!.save();
                        product['rating'] = Provider.of<UpdateProductProvider>(
                                context,
                                listen: false)
                            .rating;
                        product['createat'] =
                            DateFormat('dd/MM/yyyy').format(DateTime.now());
                       await Provider.of<UpdateProductProvider>(context,
                                listen: false)
                            .put(id, product);
                        Modular.to.pushNamed('/');
                      }
                    },
                    child: Text('Update'.toUpperCase())),
              ],
            )),
      ),
    );
  }

  IconButton _rating(
      UpdateProductProvider provider, BuildContext context, int position) {
    return IconButton(
      onPressed: () {
        provider.rating = position;
      },
      icon: Visibility(
        visible: provider.rating < position,
        replacement: Icon(
          Icons.star,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Icon(
          Icons.star_outline,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
