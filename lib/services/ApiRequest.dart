import 'dart:convert';

import 'package:groceryApp/screens/logind_signup.dart';
import 'package:groceryApp/model/products.dart';
import 'package:groceryApp/services/loggedState.dart';
import 'package:groceryApp/signup_screen.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
  String url = "http://mycrmportal.ml/mystore/rest";
  Future<List> getData(Map data) async {
    var response = await http.post(url, body: data);
    List productCategory;
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      productCategory = decodedData["Response"];
    } else {
      productCategory = [];
    }
    return productCategory;
  }

  Future<List<Product>> getProductInfo(Map data) async {
    var response = await http.post(url, body: data);
    List decodedProducts;
    List<Product> productList;
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      decodedProducts = decodedData["Response"];
      productList = decodedProducts.map((e) => Product.fromJson(e)).toList();
    } else {
      productList = [];
    }
    return productList;
  }

  Future<void> orderProduct(Map data) async {
    var response = await http.post(url, body: data);
    print(response.body);
  }

  Future<bool> signup(Map data) async {
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      if (decodedData["ResponseMessage"] ==
          "Customer Registered successfully") {
        return true;
      }
    }
    return false;
  }

  Future<bool> login(Map data) async {
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print(response.body);
      if (decodedData["ResponseMessage"] == "Customer Logged in successfully") {
        LoggedState().setLoggedState(true);
        return true;
      }
    }
    return false;
  }
}
