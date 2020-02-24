import 'package:flutter/material.dart';
import 'package:epasal_app/provider/order_provider.dart' as oi;

class OrderItem extends StatelessWidget {
  final oi.OrderItem order;
  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("\$ ${order.amount}"),
            subtitle: Text("\$ ${order.amount}"),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
