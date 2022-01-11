import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:productcase/home/presenter/providers/list_products_provider.dart';
import 'package:productcase/home/presenter/providers/remove_products_provider.dart';
import 'package:productcase/home/ui/widgets/rating.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({Key? key, required this.product}) : super(key: key);

  Future<void> _showDialog(
      BuildContext context, RemoveProductProvider provider) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Deletion Confirmation',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, color: Colors.red[900]),
          ),
        ),
        content: Text(
          'This action will delete the product ${product.title}. \n\nIs this really what you want?',
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                provider.remove(product.id);
                await Provider.of<ListProductsProvider>(context, listen: false).load();
                Modular.to.pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Product deleted successfully'),
                ));
              },
              child: const Text('Confirm')),
          TextButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red[900]),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> body = {
      'title': product.title,
      'type': product.type,
      'description': product.description,
      'filename': product.filename,
      'price': product.price,
      'rating': product.rating,
    };
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.filename,
                fit: BoxFit.cover,
                height: 190,
                width: 100,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: SizedBox(
              height: 190,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Consumer<RemoveProductProvider>(
                          builder: (context, provider, _) {
                        return PopupMenuButton(
                          onSelected: (int value) {
                            if (value == 0) {
                              Modular.to.pushNamed('/update/',
                                  arguments: {'id': product.id, 'body': body});
                            } else {
                              _showDialog(context, provider);
                            }
                          },
                          itemBuilder: (_) => [
                            PopupMenuItem(
                                value: 0, child: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary,)),
                            PopupMenuItem(
                                value: 1, child: Icon(Icons.delete, color: Colors.red[900],)),
                          ],
                        );
                      })
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.type),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(product.createat),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 200,
                    child: Text(
                      product.description,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Rating(product.rating),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          'R\$ ' + product.price.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
