import 'dart:io';

import 'package:groceryApp/model/products.dart';
import 'package:groceryApp/screens/productDescription.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class CartDatabase {
  String hiveBox = "cartBox";

  getHivePath() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  addProduct(Product product) async {
    var box = await Hive.openBox(hiveBox);
    Map<String, dynamic> productMap = product.toMap(product);
    box.add(productMap);
  }

  deleteProduct(int i) async {
    var box = await Hive.openBox(hiveBox);
    box.deleteAt(i);
  }

  updateProduct(int i, Product product) async {
    var box = await Hive.openBox(hiveBox);
    Map<String, dynamic> productMap = product.toMap(product);
    box.putAt(i, productMap);
  }

  Future<List<Product>> getProducts() async {
    await getHivePath();
    var box = await Hive.openBox(hiveBox);
    if (box.length == 0) {
      return null;
    }
    return List.generate(
        box.length, (index) => Product.fromJson(box.getAt(index)));
  }
}
