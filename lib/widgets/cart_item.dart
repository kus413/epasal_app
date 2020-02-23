import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(DateTime.now().toString()),
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
                  child: FittedBox(child: Text("\$1000"))),
            ),
            title: Text("Watch"),
            subtitle: Text("Total Price:\$100"),
            trailing: Text("2x"),
          ),
        ),
      ),
    );
  }
}
