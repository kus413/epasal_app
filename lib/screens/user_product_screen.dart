import 'package:epasal_app/provider/products_provider.dart';
import 'package:epasal_app/screens/edit_product_screen.dart';
import 'package:epasal_app/widgets/app_drawer.dart';
import 'package:epasal_app/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeId = '/user_product_screen';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeId);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (ctx, index) => UserProductItem(
              productData.items[index].title,
              productData.items[index].imageURL,
              productData.items[index].id),
        ),
      ),
    );
  }
}
