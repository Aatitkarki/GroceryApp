import 'package:groceryApp/constants/constantvalue.dart';
import 'package:groceryApp/screens/AddressScreen.dart';
import 'package:groceryApp/model/UserAddresss.dart';
import 'package:groceryApp/services/addressService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddressAddingScreen extends StatefulWidget {
  @override
  _AddressAddingScreenState createState() => _AddressAddingScreenState();
}

class _AddressAddingScreenState extends State<AddressAddingScreen> {
  String errorField = "noError";
  TextEditingController addressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController districtController = new TextEditingController();
  TextEditingController pincodeController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController landmarkController = new TextEditingController();
  TextEditingController mobileNumberController = new TextEditingController();

  storeAddress() {
    UserAddress address = UserAddress(
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        country: countryController.text.trim(),
        district: districtController.text.trim(),
        landmark: landmarkController.text.trim(),
        mobileNumber: int.parse(mobileNumberController.text.trim()),
        pinCode: int.parse(pincodeController.text.trim()),
        state: stateController.text.trim());
    Provider.of<AddressService>(context).addAddress(address);
    addressController.clear();
    cityController.clear();
    stateController.clear();
    districtController.clear();
    pincodeController.clear();
    countryController.clear();
    landmarkController.clear();
    mobileNumberController.clear();
  }

  validAddress() {
    if (addressController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        districtController.text.isEmpty ||
        pincodeController.text.isEmpty ||
        countryController.text.isEmpty ||
        landmarkController.text.isEmpty ||
        mobileNumberController.text.isEmpty) {
      errorField = "emptyField";
      return false;
    } else {
      if (pincodeController.text.length > 6 ||
          mobileNumberController.text.length > 10) {
        errorField = "longNumber";
        return false;
      } else {
        errorField = "noError";
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Add New Address",
          style: kTitleStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 120,
                  child: TextField(
                    controller: addressController,
                    style: kAddressInputStyle,
                    decoration: InputDecoration(
                        hintText: "Enter your Address",
                        fillColor: Colors.grey[300],
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: GreyTextField(
                        controller: cityController,
                        text: "Enter city",
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: GreyTextField(
                        controller: stateController,
                        text: "Enter State",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: GreyTextField(
                        controller: districtController,
                        text: "Enter district",
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: GreyTextField(
                        controller: pincodeController,
                        text: "Enter PinCode",
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GreyTextField(
                    controller: countryController, text: "Enter Country"),
                SizedBox(
                  height: 20,
                ),
                GreyTextField(
                    controller: landmarkController, text: "Enter Landmark"),
                SizedBox(
                  height: 20,
                ),
                GreyTextField(
                  controller: mobileNumberController,
                  text: "Enter Mobile Number",
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if (validAddress()) {
                      storeAddress();
                      showToast("New Address Added",
                          duration: 2, gravity: Toast.BOTTOM);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightGreen),
                    child: Center(
                      child: Text(
                        "Save Address",
                        style: kAddressInputStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}

class GreyTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String text;
  GreyTextField({
    @required this.controller,
    @required this.text,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: kAddressInputStyle,
      keyboardType:
          textInputType == null ? TextInputType.multiline : textInputType,
      decoration: InputDecoration(
          hintText: text,
          fillColor: Colors.grey[300],
          filled: true,
          // contentPadding: EdgeInsets.symmetric(vertical: 40,horizontal: 10),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
