import 'dart:collection';

import 'package:groceryApp/database/cartDatabase.dart';
import 'package:groceryApp/model/products.dart';
import 'package:flutter/foundation.dart';

class CartData extends ChangeNotifier {
  CartDatabase cartDatabase = CartDatabase();
  static List<Product> _productList = [];
  int totalPrice = 0;

  int getTotalPrice() {
    int totalPrice = 0;
    for (int i = 0; i < _productList.length; i++) {
      totalPrice += _productList[i].offerPrice * _productList[i].quantity;
    }
    return totalPrice;
  }

  UnmodifiableListView<Product> get productList {
    return UnmodifiableListView(_productList);
  }

  void addToCart(Product item) {
    cartDatabase.addProduct(item);
    fetchProducts();
  }

  fetchProducts() {
    cartDatabase.getProducts().then((data) {
      if (data != null && data.length != 0) {
        _productList = data;
      }
    });
    notifyListeners();
  }

  deleteFromDatabase(int index) {
    cartDatabase.deleteProduct(index);
    notifyListeners();
  }

  updateByValue(int index, int value) {
    _productList[index].quantity = value;
    cartDatabase.updateProduct(index, _productList[index]);
    notifyListeners();
  }

  updateData(int index, bool increase) {
    if (increase) {
      _productList[index].quantity++;
    } else {
      _productList[index].quantity--;
    }
    cartDatabase.updateProduct(index, _productList[index]);

    notifyListeners();
  }

  removeFromCart(int index) {
    _productList.removeAt(index);
    notifyListeners();
  }
}
