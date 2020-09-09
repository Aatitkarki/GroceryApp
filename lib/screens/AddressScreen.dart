import 'package:groceryApp/screens/addressAdding.dart';
import 'package:groceryApp/services/addressService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressService>(builder: (context, addressData, child) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text("Address"),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              addressData.addressList.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "No Address added yet!",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: addressData.addressList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pop(context, index);
                                showToast("Address Selected",
                                    duration: 2, gravity: Toast.BOTTOM);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Card(
                                  shadowColor: Colors.black,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(Icons.radio_button_unchecked),
                                          GestureDetector(
                                              onTap: () {
                                                addressData
                                                    .deleteAddress(index);
                                                addressData.remove(index);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                      Wrap(
                                        children: <Widget>[
                                          Text(
                                              "${addressData.addressList[index].address},${addressData.addressList[index].city},${addressData.addressList[index].district},${addressData.addressList[index].state},${addressData.addressList[index].country}")
                                        ],
                                      ),
                                      Text(
                                          "Landmark: ${addressData.addressList[index].landmark}"),
                                      Text(
                                          "ZipCode: ${addressData.addressList[index].pinCode}"),
                                      Text(
                                          "MobileNumber: ${addressData.addressList[index].mobileNumber}")
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressAddingScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Add New",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          ));
    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
