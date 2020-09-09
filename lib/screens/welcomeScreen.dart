import 'package:groceryApp/screens/bottomNavScreen.dart';
import 'package:groceryApp/screens/logind_signup.dart';
import 'package:groceryApp/services/loggedState.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    getLoggedStatus();
  }

  getLoggedStatus() async {
    bool logged = await LoggedState().getLoggedState();
    logged
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MenuScreen()))
        : Navigator.pushReplacement(
            //MenuScreen
            context,
            MaterialPageRoute(builder: (context) => MenuScreen()));
    // context, MaterialPageRoute(builder: (context) => Login_Screen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
