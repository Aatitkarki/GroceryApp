import 'dart:collection';

import 'package:groceryApp/database/addressDatabase.dart';
import 'package:groceryApp/model/UserAddresss.dart';
import 'package:flutter/foundation.dart';

class AddressService extends ChangeNotifier {
  final AddressDatabase addressDatabase = AddressDatabase();
  List<UserAddress> _addressList = [];

  UnmodifiableListView<UserAddress> get addressList {
    return UnmodifiableListView(_addressList);
  }

  // int get addressCount{
  //   return _addressList.length;
  // }

  fetchAddress() {
    addressDatabase.getAddress().then((addresses) {
      if (addresses != null && addresses.length != 0) {
        _addressList = addresses;
      }
      notifyListeners();
    });
  }

  addAddress(UserAddress address) {
    addressDatabase.addAddress(address);
    fetchAddress();
  }

  void deleteAddress(int id) {
    addressDatabase.deleteAddress(id);
    notifyListeners();
  }

  void remove(int id) {
    _addressList.removeAt(id);
    notifyListeners();
  }
}
