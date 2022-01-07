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
        title: const Text(
          'Product Case',
          style: TextStyle(
            fontFamily: 'Anton',
            fontSize: 24,
            wordSpacing: 10,
            letterSpacing: 2
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ListProductsProvider>(
        builder: (ctx, provider, _) {
          if (provider.error.isNotEmpty) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red[600]!,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    provider.error,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[900]),
                  ),
                ),
              ),
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
