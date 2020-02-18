import 'package:cached_network_image/cached_network_image.dart';
import 'package:epasal_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String imageURL, title;
  final String id;

  ProductItem({this.imageURL, this.title, this.id});

  @override
  Widget build(BuildContext context) {
    //Circular grid boarder
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
          // Navigation to other page
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetails.routeId,
                  arguments: id);

//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => ProductDetails(title),
//                ),
//              );
            },
            child: CachedNetworkImage(
              imageUrl: imageURL,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(title, textAlign: TextAlign.center),
            leading: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
          )),
    );
  }
}
