import 'package:epasal_app/provider/cart_provider.dart';
import 'package:epasal_app/screens/cart_scereen.dart';
import 'package:epasal_app/widgets/app_drawer.dart';
import 'package:epasal_app/widgets/badge.dart';
import 'package:epasal_app/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favourites, All }

class ProductOverviewScreen extends StatefulWidget {
  static const String routeId = "/product_overview_screen";

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Pasal"),
        actions: <Widget>[
          PopupMenuButton(
            elevation: 5.0,
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  //show fav
                  _showFavourites = true;
                } else {
                  //show not fav
                  _showFavourites = false;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Show Favourites"),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeId);
              },
            ),
            builder: (_, cart, child) {
              return Badge(
                child: child,
                value: cart.itemCount.toString(),
              );
            },
          ),
        ],
      ),
      body: ProductGrid(
        isShowFavourite: _showFavourites,
      ),
      drawer: AppDrawer(),
    );
  }
}
