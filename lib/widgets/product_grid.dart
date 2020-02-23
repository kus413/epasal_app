import 'package:epasal_app/provider/products_provider.dart';
import 'package:epasal_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool isShowFavourite;

  ProductGrid({this.isShowFavourite});

  @override
  Widget build(BuildContext context) {
    final productProvide = Provider.of<Products>(context);
    final loadedProducts =
        isShowFavourite ? productProvide.favourites : productProvide.items;
    return GridView.builder(
        itemCount: loadedProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 2),
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider.value(
            value: loadedProducts[i],
            child: ProductItem(),
          );
        });
  }
}
