import 'package:groceryApp/model/Photos.dart';

class Product {
  final String productName;
  final String productImage;
  final int originalPrice;
  final int offerPrice;
  final int productId;
  int quantity;
  final String description;
  //final List<Photo> photos;

  Product({
    this.productImage,
    this.productName,
    this.offerPrice,
    this.originalPrice,
    this.description,
    this.quantity,
    this.productId,
    // this.photos
  });

  factory Product.fromJson(Map<dynamic, dynamic> parsedJson) {
    //var list = parsedJson["photos"] as List;
    // List<Photo> imageList = list.map((e) => Photo.fromJson(e)).toList();
    return Product(
      productName: parsedJson["name"],
      productImage: parsedJson["product_image"],
      originalPrice: parsedJson["price"].runtimeType == String
          ? int.parse(parsedJson["price"])
          : parsedJson["price"],
      offerPrice: parsedJson["offer_price"].runtimeType == String
          ? int.parse(parsedJson["offer_price"])
          : parsedJson["offer_price"],
      description: parsedJson["description"],
      productId: parsedJson["id"].runtimeType == String
          ? int.parse(parsedJson["id"])
          : parsedJson["id"],
      quantity: parsedJson["quantity"] == null ? 0 : parsedJson["quantity"],

      // photos: imageList
    );
  }
  Map<String, dynamic> toMap(Product product) {
    return {
      "name": product.productName,
      "product_image": product.productImage,
      "price": product.originalPrice,
      "offer_price": product.offerPrice,
      "description": product.description,
      "id": product.productId,
      "quantity": product.quantity
    };
  }
}
