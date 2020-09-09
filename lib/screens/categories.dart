import 'package:groceryApp/screens/productsCategory.dart';
import 'package:groceryApp/services/ApiRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List productCategory;
  String baseImageUrl = "http://mycrmportal.ml/mystore/assets/images/";
  loadApiData() async {
    Map productCatApi = {
      "service": "getList",
      "module": "productcategory",
      "record_id": "",
      "order_by": "name",
      "order_value": "",
      "limit": "",
      "start": "",
      "conditions": "",
    };

    productCategory = await ApiRequest().getData(productCatApi);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: productCategory == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                    child: GridView.builder(
                        physics: ClampingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: productCategory.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductsCategoryScreen(
                                              id:
                                                  int.parse(
                                                      productCategory[i]["id"]),
                                              title: productCategory[i]
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
                                        imageUrl: baseImageUrl +
                                            "productcategory/category_image/${productCategory[i]["category_image"]}",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            CupertinoActivityIndicator()),
                                  )),
                                  Container(
                                    color: Colors.black26,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      productCategory[i]["name"],
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
              ],
            ),
    );
  }
}
