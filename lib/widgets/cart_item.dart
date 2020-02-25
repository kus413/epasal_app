import 'package:epasal_app/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id, title, productId;
  final double price;
  final int quantity;

  CartItem({this.id, this.title, this.productId, this.price, this.quantity});

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(DateTime.now().toString()),
      onDismissed: (direction) {
        cartItem.removeFromCart(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Are you sure?"),
                content: Text("Do you want to remove from the cart?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  )
                ],
              );
            });
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
        padding: EdgeInsets.all(20.0),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: FittedBox(child: Text("$price"))),
            ),
            title: Text(title),
            subtitle: Text("Total Price:${price * quantity}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
