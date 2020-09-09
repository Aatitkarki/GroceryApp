import 'package:groceryApp/screens/products.dart';
import 'package:groceryApp/services/ApiRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsCategoryScreen extends StatefulWidget {
  final int id;
  final String title;

  const ProductsCategoryScreen({@required this.id, @required this.title});
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsCategoryScreen> {
  List individualProducts;
  String baseImageUrl = "http://mycrmportal.ml/mystore/assets/images/";
  void getProducts() async {
    Map data1 = {"category_id": "${widget.id}"};
    Map subCategoryDatas = {
      "service": "getList",
      "module": "subcategory",
      "record_id": "",
      "order_by": "name",
      "order_value": "",
      "limit": "",
      "start": "",
      "fields": "",
      "conditons": "$data1",
    };
    individualProducts = await ApiRequest().getData(subCategoryDatas);
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
        // backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: individualProducts == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Container(
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: individualProducts.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductsScreen(
                                          id: int.parse(
                                              individualProducts[index]["id"]),
                                          title: individualProducts[index]
                                              ["name"])));
                            },
                            child: Card(
                              elevation: 5,
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  Positioned.fill(
                                      child: Opacity(
                                    opacity: 0.9,
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          CupertinoActivityIndicator(),
                                      imageUrl: baseImageUrl +
                                          "subcategory/category_image/${individualProducts[index]["category_image"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                                  Container(
                                    color: Colors.black26,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          individualProducts[index]["name"],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "20 % discount",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
