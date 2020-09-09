import 'package:groceryApp/Cart_Screen.dart';
import 'package:groceryApp/screens/categories.dart';
import 'package:groceryApp/services/ApiRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List bannerData;
  String baseImageUrl = "http://mycrmportal.ml/mystore/assets/images/";
  loadApiData() async {
    Map bannerApi = {
      "service": "getList",
      "module": "banner",
      "record_id": "",
      "order_by": "name",
      "order_value": "",
      "limit": "",
      "start": "",
      "conditions": "",
    };
    bannerData = await ApiRequest().getData(bannerApi);
  }

  @override
  void initState() {
    loadApiData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ShapeBorder shapeBorder;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        title: Text("Grocery store"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new Card(
              child: UserAccountsDrawerHeader(
                accountName: new Text("Naomi A. Schultz"),
                accountEmail: new Text("NaomiASchultz@armyspy.com"),
                onDetailsPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Account_Screen()));
                },
                decoration: new BoxDecoration(
                  backgroundBlendMode: BlendMode.difference,
                  color: Colors.white30,

                  /* image: new DecorationImage(
               //   image: new ExactAssetImage('assets/images/lake.jpeg'),
                  fit: BoxFit.cover,
                ),*/
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://www.fakenamegenerator.com/images/sil-female.png")),
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.favorite),
                      title: new Text("favname"),
                      onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: name,)));
                      }),
                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.history),
                      title: new Text("Order History "),
                      onTap: () {
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=> Oder_History(toolbarname: ' Order History',)));
                      }),
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.settings),
                      title: new Text("Setting"),
                      onTap: () {
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=> Setting_Screen(toolbarname: 'Setting',)));
                      }),
                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.help),
                      title: new Text("Help"),
                      onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Help_Screen(toolbarname: 'Help',)));
                      }),
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: new Text(
                    "Logout",
                    style:
                        new TextStyle(color: Colors.redAccent, fontSize: 17.0),
                  ),
                  onTap: () {
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => Login_Screen()));
                  }),
            )
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Item_Screen(
                      //               toolbarname: 'Fruits & Vegetables',
                      //             )));
                    },
                    child: new Text(
                      'Best value',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Item_Screen(
                      //               toolbarname: 'Fruits & Vegetables',
                      //             )));
                    },
                    child: new Text(
                      'Top sellers',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Item_Screen(
                          //               toolbarname: 'Fruits & Vegetables',
                          //             )));
                        },
                        child: new Text(
                          'All',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        color: Colors.black26,
                        onPressed: () {},
                      )
                    ],
                  )
                ]),
            bannerData == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                : Container(
                    height: 180,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bannerData.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width - 10,
                            child: Card(
                              shape: shapeBorder,
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: CachedNetworkImage(
                                      imageUrl: baseImageUrl +
                                          "banner/banner_image/${bannerData[index]["banner_image"]}",
                                      fit: BoxFit.fitWidth,
                                      placeholder: (context, url) =>
                                          CupertinoActivityIndicator(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      constraints: BoxConstraints.expand(height: 50),
                      child: TabBar(tabs: [
                        Tab(
                          text: "Categories",
                        ),
                        Tab(text: "Popular"),
                        Tab(text: "Whats New"),
                      ]),
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(children: [
                          Container(child: Categories()),
                          Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ), //Categories()
          ],
        ),
      ),
    );
  }
}
