import 'package:epasal_app/provider/product.dart';
import 'package:flutter/material.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: "first",
        title: "Watch",
        price: 2000.0,
        description: "Best watch you will find",
        imageURL:
            "https://images-na.ssl-images-amazon.com/images/I/910D0vQR2HL._UL1500_.jpg",
        isFavourite: false),
    Product(
        id: "second",
        title: "Shoe",
        price: 1500.0,
        description: "Run Shoe",
        imageURL:
            "https://storage.googleapis.com/pricemandu.com/images/products/full/85101d2d4bde158f9c2266cfa080afabbc0f0634.jpg",
        isFavourite: false),
    Product(
        id: "third",
        title: "Laptop",
        price: 199999.0,
        description: "Best gaming experience",
        imageURL:
            "https://dev.wpmad.com/wp-content/uploads/2019/05/MSI-GT75-Titan-8RF-046UK-Gaming-Laptop-Coffeelake-Intel-Core-i7-8750H-2.2GHz-16GB-RAM-256GB-SSD-1TB-HDD-17.3-Full-HD-No-DVD-NVIDIA-GTX-1070-8GB-WIFI-Windows-10-Home-Ultra.jpg",
        isFavourite: false),
    Product(
        id: "four",
        title: "OnePlus",
        price: 67000,
        description: "Fastest Phone",
        imageURL:
            "https://i.gadgets360cdn.com/products/large/1557831009_635_OnePlus_7_Main_DB.jpg",
        isFavourite: false),
  ];

  // return all items
  List<Product> get items {
    return [..._items];
  }

  // this returns only favourite product from the list
  List<Product> get favourites {
    return _items.where((prodItem) {
      return prodItem.isFavourite;
    }).toList();
  }

  //return specific items
  Product findById(String id) {
    return _items.firstWhere((prod) {
      return prod.id == id;
    });
  }

  //------------ this function adds the product-----------

  void addProduct(Product product) {
    Product newProduct = Product(
      title: product.title,
      price: product.price,
      description: product.description,
      imageURL: product.imageURL,
      id: DateTime.now().toString(),
    );
    _items.insert(0, newProduct);
    notifyListeners();
  }

  //------------ this function updates the current product-----------
  void updateProduct(String id, Product upProduct) {
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = upProduct;
      notifyListeners();
    }
  }

  //------------ this function delete current product----------
  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
