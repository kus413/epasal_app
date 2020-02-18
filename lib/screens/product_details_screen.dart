import 'package:epasal_app/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static const String routeId = "/product_details_screen";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;

    // We get single [product item from the provider

    final loadedProduct =
        Provider.of<Products>(context).items.firstWhere((prod) {
      return prod.id == id;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
