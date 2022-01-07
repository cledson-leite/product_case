import 'package:flutter/material.dart';
import 'package:productcase/home/presenter/providers/list_products_provider.dart';
import 'package:productcase/home/ui/widgets/product_tile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ListProductsProvider>(context, listen: false).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Case'),
      ),
      body: Consumer<ListProductsProvider>(
        builder: (ctx, provider, _) {
          if (provider.error.isNotEmpty) {
            return Center(
              child: Text(provider.error),
            );
          }
          if (provider.products.isNotEmpty) {
            return ListView.builder(
              itemCount: provider.products.length,
              itemBuilder: (ctx, ind) =>
                  ProductTile(product: provider.products[ind]),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
