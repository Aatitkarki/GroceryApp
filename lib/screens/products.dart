import 'package:groceryApp/model/Photos.dart';
import 'package:groceryApp/model/products.dart';
import 'package:groceryApp/screens/productDescription.dart';
import 'package:groceryApp/services/ApiRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  final int id;
  final String title;

  const ProductsScreen({@required this.id, @required this.title});
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> productsList;
  int cartSizeNo = 0;
  String baseImageUrl = "http://mycrmportal.ml/mystore/assets/images/";
  void getProducts() async {
    Map data1 = {"category_id": "${widget.id}"};
    Map products = {
      "service": "getList",
      "module": "products",
      "record_id": "",
      "order_by": "name",
      "order_value": "",
      "limit": "",
      "start": "",
      "fields": "",
      "conditons": "$data1",
    };
    productsList = await ApiRequest().getProductInfo(products);
    setState(() {});
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: productsList == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: productsList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDescription(
                                            data: productsList[index],
                                            index: index,
                                            image: productsList[index]
                                                .productImage,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Card(
                                child: Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Opacity(
                                        opacity: 0.9,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: baseImageUrl +
                                                "products/product_image/${productsList[index].productImage}",
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            placeholder: (context, url) =>
                                                CupertinoActivityIndicator(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "₹${productsList[index].offerPrice}",
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "₹${productsList[index].originalPrice}",
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "20% OFF",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    backgroundColor:
                                                        Colors.green,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              productsList[index].productName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Card(
                                                      elevation: 5,
                                                      child: Icon(
                                                        Icons.add_shopping_cart,
                                                        color: Colors.red,
                                                        size: 30,
                                                      )),
                                                  onTap: () {
                                                    setState(() {
                                                      if (cartSizeNo > 0) {
                                                        cartSizeNo--;
                                                      }
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "Add to Cart",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
