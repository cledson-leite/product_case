import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:productcase/edit/presenter/product_manager_modular.dart';
import 'package:productcase/edit/ui/product_manager_page.dart';
import 'package:productcase/home/domain/entities/product.dart';
import 'package:productcase/home/ui/widgets/rating.dart';

// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({Key? key, required this.product}) : super(key: key);

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
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('/update/', arguments: {'id': product.id, 'body': body});
      },
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
