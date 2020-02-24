import 'package:cached_network_image/cached_network_image.dart';
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
        Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: loadedProduct.imageURL,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "\$ ${loadedProduct.price}",
              style: TextStyle(fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "${loadedProduct.description}",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
              softWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
