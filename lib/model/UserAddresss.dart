class UserAddress{
  String address;
  String city;
  String state;
  String district;
  int pinCode;
  String country;
  String landmark;
  int mobileNumber;

  UserAddress({this.address,this.city,this.country,this.district,this.landmark,this.mobileNumber,this.pinCode,this.state});

  factory UserAddress.fromMap(Map<dynamic,dynamic> map){
    return UserAddress(
      address: map["address"],
      city: map["city"],
      state: map["state"],
      district: map["district"],
      pinCode: map["pinCode"],
      country: map["country"],
      landmark: map["landmark"],
      mobileNumber: map["mobileNumber"],
    );
  }

  Map <String,dynamic> toMap(){
    return {
      "address":address,
      "city":city,
      "state":state,
      "district":district,
      "pinCode":pinCode,
      "country":country,
      "landmark":landmark,
      "mobileNumber":mobileNumber
    };
  }
}