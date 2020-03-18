import 'package:epasal_app/screens/order_screen.dart';
import 'package:epasal_app/screens/product_overview_screen.dart';
import 'package:epasal_app/screens/user_product_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Kushal"),
            accountEmail: Text("kushalshrestha85@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/box.png'),
            ),
          ),
          ListTile(
              title: Text("Shop"),
              leading: Icon(Icons.shopping_cart),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, ProductOverviewScreen.routeId);
              }),
          Divider(),
          ListTile(
              title: Text("Order"),
              leading: Icon(Icons.payment),
              onTap: () {
                Navigator.pushReplacementNamed(context, OrderScreen.routeId);
              }),
          Divider(),
          ListTile(
              title: Text("Manage Product"),
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, UserProductScreen.routeId);
              }),
          Divider(),
        ],
      ),
    );
  }
}
