import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:productcase/home/data/repository/remove_product.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:productcase/home/presenter/providers/remove_products_provider.dart';
import 'package:productcase/home/ui/widgets/rating.dart';
import 'package:provider/provider.dart';

// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _remove() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(''),
          content: const Text(''),
          actions: [
            Consumer<RemoveProductProvider>(builder: (context, provider, _) {
              return TextButton(
                  onPressed: () {
                    provider.remove(product.id);
                    Modular.to.pushReplacementNamed('/');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Product deleted successfully'),
                    ));
                  },
                  child: const Text('Confirm'));
            }),
            TextButton(
                onPressed: () {
                  Modular.to.navigate('/');
                },
                child: const Text('Cancel')),
          ],
        ),
      );
    }

    final Map<String, dynamic> body = {
      'title': product.title,
      'type': product.type,
      'description': product.description,
      'filename': product.filename,
      'price': product.price,
      'rating': product.rating,
    };
    return GestureDetector(
      child: Card(
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
                  height: 170,
                  width: 100,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PopupMenuButton(
                          itemBuilder: (_) => [
                            PopupMenuItem(
                                child: IconButton(
                                    onPressed: () {
                                      Modular.to.pushNamed('/update/',
                                          arguments: body);
                                    },
                                    icon: const Icon(Icons.edit))),
                            PopupMenuItem(
                                child: IconButton(
                                    onPressed: _remove,
                                    icon: const Icon(Icons.delete))),
                          ],
                        )
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
      ),
    );
  }
}
