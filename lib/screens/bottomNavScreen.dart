import 'package:groceryApp/Cart_Screen.dart';
import 'package:groceryApp/screens/cartScreen.dart';
import 'package:groceryApp/screens/homepage.dart';
import 'package:groceryApp/screens/setting_screen.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// class MenuScreen extends StatefulWidget {
//   @override
//   _MenuScreenState createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   PersistentTabController _controller;
//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController(initialIndex: 1);
//   }
//   List<Widget> _buildScreens() {
//     return [

//       CartScreen(),
//       HomePage(),
//       Setting_Screen()
//     ];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.add_shopping_cart),
//         title: ("Cart"),
//         activeColor: Colors.teal,
//         inactiveColor: Colors.grey,
//         isTranslucent: false,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: ("Home"),
//         activeColor: Colors.blue,
//         inactiveColor: Colors.grey,
//         isTranslucent: false,

//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.settings),
//         title: ("Setting"),
//         activeColor: Colors.teal,
//         inactiveColor: Colors.grey,
//         isTranslucent: false,
//       ),

//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       controller: _controller,
//         screens: _buildScreens(),
//         items:
//             _navBarsItems(), // Redundant here but defined to demonstrate for other than custom style
//         confineInSafeArea: true,
//         backgroundColor: Colors.white,
//         handleAndroidBackButtonPress: true,
//         onItemSelected: (int) {
//           setState(
//               () {}); // This is required to update the nav bar if Android back button is pressed
//         },
//         itemCount: 2,
//         navBarStyle:
//             NavBarStyle.style1 // Choose the nav bar style with this property
//         );
//   }
// }

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Widget> widgets = [
    CartScreen(),
    HomePage(),
    Setting_Screen(),
  ];
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgets[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(
                'Settings',
              )),
        ],
      ),
    );
  }
}
