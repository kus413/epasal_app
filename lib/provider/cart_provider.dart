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

  //this is used to remove item from the cart
  void removeFromCart(String id) {
    _items.remove(id);
    notifyListeners();
  }

  double getTotalAmount() {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  //This removes single item form cart
  void removeSingleItemFromCart(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(id, (existingCartItem) {
        return CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        );
      });
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }
}
