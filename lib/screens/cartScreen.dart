import 'package:groceryApp/constants/constantvalue.dart';
import 'package:groceryApp/screens/orderConfirmation.dart';
import 'package:groceryApp/services/ApiRequest.dart';
import 'package:groceryApp/services/CartData.dart';
import 'package:groceryApp/model/products.dart';
import 'package:groceryApp/screens/AddressScreen.dart';
import 'package:groceryApp/services/addressService.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String couponCode = "";
  String baseImageUrl = "http://mycrmportal.ml/mystore/assets/images/";
  bool promoApplied = false;
  int deliveryFee = 50;
  int tax = 0;
  int packagingCharge = 0;
  double totalPayable = 0;
  bool gotAddress = false;
  int addressIndex;
  TextEditingController promoCodeController;

  List<Map<String, dynamic>> cartList = [];
  getTotalPayable(BuildContext context) {
    int totalPrice = Provider.of<CartData>(context).getTotalPrice();
    double discountAmount = (15 / 100 * totalPrice);
    totalPayable = totalPrice - discountAmount + deliveryFee;
  }

  getAddress() async {
    var data = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddressScreen()));
    if (data != null) {
      setState(() {
        addressIndex = data;
        gotAddress = true;
      });
    } else {
      gotAddress = false;
    }
  }

  getCartData() {
    List<Product> productList = CartData().productList;
    for (int i = 0; i < productList.length; i++) {
      cartList.add({
        "product_id": Provider.of<CartData>(context).productList[i].productId,
        "price": Provider.of<CartData>(context).productList[i].offerPrice,
        "qty": Provider.of<CartData>(context).productList[i].quantity,
      });
    }
  }

  bool isCartInputValid() {
    if (gotAddress == false) {
      showToast("Please Select a Address", duration: 2);
      return false;
    }
    return true;
  }

  callOrder() async {
    getCartData();
    int totalPrice = CartData().getTotalPrice();
    double discountAmount = (15 / 100 * totalPrice);

    Map<String, dynamic> postData = {
      "service": "createOrder",
      "module": "orders",
      "customer_id": "1",
      "subtotal": "$totalPrice",
      "coupon_code": couponCode,
      "coupon_discount": "$discountAmount",
      "after_discount": "${totalPrice - discountAmount}",
      "gst": "0",
      "grand_total": "${totalPrice - discountAmount + deliveryFee}",
      "shipping_cost": "$deliveryFee",
      "payment_type": "Online",
      "cart": "$cartList"
    };
    print(cartList);

    await ApiRequest().orderProduct(postData);
  }

  @override
  void initState() {
    promoCodeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("the widget is rebuilding");
    getTotalPayable(context);
    Size size = MediaQuery.of(context).size;
    return Consumer<CartData>(builder: (context, cartData, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          // resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            //backgroundColor: Colors.white,
            title: Text(
              "Cart",
              style: kTitleStyle,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: CartData().productList.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "There is no products in Cart",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                : Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        gotAddress == false
                            ? GestureDetector(
                                onTap: () async {
                                  await getAddress();
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color(0xfff9c124),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      "Select Address",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                child: Consumer<AddressService>(
                                  builder: (context, addressData, child) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.green),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Wrap(
                                              children: <Widget>[
                                                Text(
                                                    "${addressData.addressList[addressIndex].address},${addressData.addressList[addressIndex].city},${addressData.addressList[addressIndex].district},${addressData.addressList[addressIndex].state},${addressData.addressList[addressIndex].country}")
                                              ],
                                            ),
                                            Text(
                                                "Landmark: ${addressData.addressList[addressIndex].landmark}"),
                                            Text(
                                                "ZipCode: ${addressData.addressList[addressIndex].pinCode}"),
                                            Text(
                                                "MobileNumber: ${addressData.addressList[addressIndex].mobileNumber}"),
                                            GestureDetector(
                                              onTap: () async {
                                                await getAddress();
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    "Change Address",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Icon(Icons.location_on)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        Container(
                          height: 280,
                          child: ListView.builder(
                              itemCount: cartData.productList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          //width: size.width *0.8,
                                          child: Expanded(
                                            child: Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          "${cartData.productList[index].productName}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18.0,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                          "₹${cartData.productList[index].quantity * cartData.productList[index].offerPrice}",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "Quantity: ",
                                                          style: kTitleStyle,
                                                        ),
                                                        Text(
                                                          "${cartData.productList[index].quantity} * 1 kg",
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "Unit Price: ",
                                                          style: kTitleStyle,
                                                        ),
                                                        Text(
                                                          "₹${cartData.productList[index].offerPrice}",
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                        height: 3,
                                                        width: double.infinity,
                                                        color: Colors.black45),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          cartData
                                                              .deleteFromDatabase(
                                                                  index);
                                                          cartData
                                                              .removeFromCart(
                                                                  index);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 30,
                                                                ),
                                                                Text("Remove",
                                                                    style: kTitleStyle
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.red))
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .yellow),
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        if (cartData.productList[index].quantity >
                                                                            1) {
                                                                          cartData
                                                                              .productList[index]
                                                                              .quantity--;
                                                                        }
                                                                      });
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .remove,
                                                                        size:
                                                                            30,
                                                                        color: Colors
                                                                            .amber
                                                                            .shade500),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "${cartData.productList[index].quantity}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .yellow),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      if (cartData
                                                                              .productList[index]
                                                                              .quantity >=
                                                                          0) {
                                                                        //cartData.productList[index].quantity++;
                                                                        cartData.updateData(
                                                                            index,
                                                                            true);
                                                                      }
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .add,
                                                                        size:
                                                                            30,
                                                                        color: Colors
                                                                            .amber
                                                                            .shade500),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          width: double.infinity,
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Do You Have Any Promo Code?",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "* You can simply apply promo code to get discount",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DottedBorder(
                                    strokeCap: StrokeCap.butt,
                                    strokeWidth: 2,
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(40),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                            child: TextField(
                                          controller: promoCodeController,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            hintText: "Enter Promo Code",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                          ),
                                        )),
                                        GestureDetector(
                                          onTap: () {
                                            if (promoCodeController.text ==
                                                "INSTA15") {
                                              couponCode =
                                                  promoCodeController.text;
                                              setState(() {
                                                promoApplied = true;
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 20),
                                            decoration: BoxDecoration(
                                              color: Color(0xfff9c124),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Apply Now",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                DottedBorder(
                                    strokeCap: StrokeCap.butt,
                                    strokeWidth: 2,
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Discount Status",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              promoApplied
                                                  ? "Applied"
                                                  : "Not Applied",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: promoApplied
                                                      ? Colors.black
                                                      : Colors.grey),
                                            ),
                                            Text(promoApplied ? "-₹" : "-₹0",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: promoApplied
                                                        ? Colors.black
                                                        : Colors.grey)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Delivery Fee",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: promoApplied
                                                      ? Colors.black
                                                      : Colors.grey),
                                            ),
                                            Text("₹$deliveryFee",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: promoApplied
                                                        ? Colors.black
                                                        : Colors.grey)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Tax",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: promoApplied
                                                      ? Colors.black
                                                      : Colors.grey),
                                            ),
                                            Text("₹$tax",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: promoApplied
                                                        ? Colors.black
                                                        : Colors.grey)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Packaging Charge",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: promoApplied
                                                      ? Colors.black
                                                      : Colors.grey),
                                            ),
                                            Text("₹$packagingCharge",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: promoApplied
                                                        ? Colors.black
                                                        : Colors.grey)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Total Payable",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text("₹$totalPayable",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {},
                                child: Text("Online"),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black),
                                child: GestureDetector(
                                  onTap: () {
                                    if (isCartInputValid()) {
                                      callOrder();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OrderPage(
                                                    addressIndex: addressIndex,
                                                  )));
                                    }
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "₹$totalPayable",
                                        style: kWhiteTextStyle,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Place Order",
                                        style: kWhiteTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ));
    });
  }

  void showToast(
    String msg, {
    int duration,
  }) {
    Toast.show(msg, context, duration: duration, gravity: Toast.BOTTOM);
  }
}
