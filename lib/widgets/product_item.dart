import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String imageURL, title;
  final double price;

  ProductItem({this.imageURL, this.title, this.price});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(imageURL),
    );
  }
}
