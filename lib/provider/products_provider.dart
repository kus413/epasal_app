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
            "https://images.rolex.com/2019/catalogue/images/upright-bba-with-shadow/m326935-0007.png?impolicy=upright-grid-card&imwidth=585",
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

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return items.firstWhere((prod) {
      return prod.id == id;
    });
  }

  void addProduct() {
    _items.add(Product(
        id: "four",
        title: "OnePlus",
        price: 67000,
        description: "Fastest Phone",
        imageURL:
            "https://i.gadgets360cdn.com/products/large/1557831009_635_OnePlus_7_Main_DB.jpg",
        isFavourite: false));
    notifyListeners();
  }
}
