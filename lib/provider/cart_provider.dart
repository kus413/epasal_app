import 'package:flutter/material.dart';

class CartItem {
  final String id, title;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return _items;
  }

  void addToCart(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      //update the current item quantity
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price,
              title: existingCartItem.title));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1)); //CartItem
    }
    notifyListeners();
  }

  // this gives total items in the cart
  int get itemCount {
    return _items == null ? 0 : _items.length;
  }
}
