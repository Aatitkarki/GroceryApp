import 'package:groceryApp/services/CartData.dart';
import 'package:groceryApp/model/products.dart';
import 'package:groceryApp/services/ApiRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProductDescription extends StatefulWidget {
  final Product data;
  final int index;
  final String image;
  // final int id;
  // final String title;
//final String imageName;
  const ProductDescription({this.data, this.image, this.index});
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductDescription> {
  //CartData cartData = CartData();
  String baseImageUrl = "http://mycrmportal.ml/mystore/assets/images/";
  //int cartSizeNo = 0;
  bool checkData(Product data) {
    List<Product> dataList = Provider.of<CartData>(context).productList;
    print(dataList.length);
    for (int i = 0; i < dataList.length; i++) {
      if (data.productId == dataList[i].productId) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    print(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                color: Colors.pink,
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.data.productName,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 250,
                  width: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      imageUrl: baseImageUrl +
                          "products/product_image/${widget.image}",
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          CupertinoActivityIndicator(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  widget.data.description,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  "Cost per Unit: ₹${widget.data.offerPrice}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                SizedBox(height: 10),
                Text(
                  "Total Quantity: ${widget.data.quantity}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                SizedBox(height: 10),
                Text(
                  "Total Cost: ₹${widget.data.offerPrice * widget.data.quantity}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Card(
                                elevation: 5,
                                child: Icon(
                                  Icons.remove,
                                  size: 30,
                                )),
                            onTap: () {
                              setState(() {
                                if (widget.data.quantity > 1) {
                                  widget.data.quantity--;
                                }
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          Text(
                            "${widget.data.quantity}",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                              child: Card(
                                  elevation: 5,
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                  )),
                              onTap: () {
                                setState(() {
                                  if (widget.data.quantity >= 0) {
                                    widget.data.quantity++;
                                  }
                                });
                              }),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Card(
                          color: Colors.red,
                          child: FlatButton(
                              onPressed: () {
                                if (checkData(widget.data)) {
                                  Provider.of<CartData>(context).updateByValue(
                                    widget.index,
                                    widget.data.quantity,
                                  );
                                  showToast(
                                    "Item Data Updated",
                                  );
                                } else {
                                  Provider.of<CartData>(context)
                                      .addToCart(widget.data);
                                  showToast("Item Added to Cart");
                                }
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Add to Cart",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showToast(
    String msg,
  ) {
    Toast.show(msg, context, duration: 2, gravity: Toast.BOTTOM);
  }
}
