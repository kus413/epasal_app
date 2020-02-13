class Product {
  final String id, title, description, imageURL;
  final double price;
  bool isFavourite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.imageURL,
      this.price,
      this.isFavourite});
}
