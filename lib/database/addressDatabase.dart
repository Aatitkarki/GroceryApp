import 'dart:io';

import 'package:groceryApp/model/UserAddresss.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class AddressDatabase {
  String hiveBox = "address";

  getHivePath() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  addAddress(UserAddress userAddress) async {
    var box = await Hive.openBox(hiveBox);
    Map<String, dynamic> address = userAddress.toMap();
    box.add(address);
  }

  // updateAddress(int i, UserAddress userAddress)async{
  //   var box = await Hive.openBox(hiveBox);
  //   Map<String,dynamic> address = userAddress.toMap();
  //   box.putAt(i, address);
  //   await getAddress();
  // }

  deleteAddress(int i) async {
    var box = await Hive.openBox(hiveBox);
    box.deleteAt(i);
  }

  Future<List<UserAddress>> getAddress() async {
    await getHivePath();
    var box = await Hive.openBox(hiveBox);
    if (box.length == 0) {
      return null;
    }
    return List.generate(
        box.length, (index) => UserAddress.fromMap(box.getAt(index)));
  }
}
