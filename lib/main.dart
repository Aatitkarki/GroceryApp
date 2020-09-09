import 'package:groceryApp/screens/welcomeScreen.dart';
import 'package:groceryApp/services/CartData.dart';
import 'package:groceryApp/services/addressService.dart';
import 'package:groceryApp/services/connectivity.dart';
import 'package:groceryApp/services/loggedState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'enum/connectivity_status.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogged;
  @override
  void initState() {
    super.initState();
  }

  getLoggedInStatus() async {
    return await LoggedState().getLoggedState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            var cartData = CartData();
            cartData.fetchProducts();
            cartData.getTotalPrice();
            return cartData;
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            var addressService = AddressService();
            addressService.fetchAddress();
            return addressService;
          },
        ),
        StreamProvider<ConnectivityStatus>(
          create: (context) =>
              ConnectivityService().connectionStatusController.stream,
        )
      ],
      child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(
              primaryColor: Colors.white,
              primaryColorDark: Colors.white30,
              accentColor: Colors.blue),
          home: WelcomeScreen()),
    );
  }
}
