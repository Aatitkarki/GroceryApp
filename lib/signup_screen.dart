import 'package:groceryApp/screens/logind_signup.dart';
import 'package:groceryApp/services/ApiRequest.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Signup_Screen extends StatefulWidget {
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const Signup_Screen(
      {Key key,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted})
      : super(key: key);

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.red,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.yellow, fontSize: 24.0),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => signup();
}

class signup extends State<Signup_Screen> {
  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _firstname;
  String _lastname;
  int _phone;
  String dob;
  String gender = "Male";
  int stateID;
  int cityID;
  int zipCode;
  String streetAddress;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autovalidate = false;
  bool isLoading = false;
  bool _formWasEdited = false;
  int _radioValue1 = 0;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
      gender = _radioValue1 == 0 ? "Male" : "Female";
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: Text('Signup'),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
            child: new SingleChildScrollView(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Container(
                      height: 50.0,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 7.0),
                      child: new Row(
                        children: <Widget>[
                          _verticalD(),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login_Screen()));
                            },
                            child: new Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          _verticalD(),
                          new GestureDetector(
                            onTap: () {
                              /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signup_screen()));*/
                            },
                            child: new Text(
                              'Signup',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new SafeArea(
                        top: false,
                        bottom: false,
                        child: Card(
                            elevation: 5.0,
                            child: Form(
                                key: formKey,
                                autovalidate: _autovalidate,
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        const SizedBox(height: 24.0),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              icon: Icon(
                                                Icons.person,
                                                color: Colors.black38,
                                              ),
                                              hintText: 'Enter first name',
                                              labelText: 'First Name',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54)),
                                          keyboardType: TextInputType.text,
                                          validator: (val) => val.length < 1
                                              ? 'Enter first name'
                                              : null,
                                          onSaved: (val) => _firstname = val,
                                        ),
                                        const SizedBox(height: 24.0),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              icon: Icon(
                                                Icons.perm_identity,
                                                color: Colors.black38,
                                              ),
                                              hintText: 'Enter last name',
                                              labelText: 'Last Name',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54)),
                                          keyboardType: TextInputType.text,
                                          validator: (val) => val.length < 1
                                              ? 'Enter last name'
                                              : null,
                                          onSaved: (val) => _lastname = val,
                                        ),
                                        const SizedBox(height: 24.0),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              icon: Icon(
                                                Icons.email,
                                                color: Colors.black38,
                                              ),
                                              hintText: 'Your email address',
                                              labelText: 'E-mail',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54)),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: validateEmail,
                                          onSaved: (String val) {
                                            _email = val;
                                          },
                                        ),
                                        const SizedBox(height: 24.0),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              icon: Icon(
                                                Icons.phone_android,
                                                color: Colors.black38,
                                              ),
                                              hintText: 'Your phone number',
                                              labelText: 'Phone',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54)),
                                          keyboardType: TextInputType.phone,
                                          validator: validateMobile,
                                          onSaved: (String val) {
                                            _phone = int.parse(val);
                                          },
                                        ),
                                        const SizedBox(height: 24.0),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.calendar_today,
                                              color: Colors.black38,
                                            ),
                                            SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () {
                                                showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(1900),
                                                        lastDate:
                                                            DateTime(2100))
                                                    .then((value) {
                                                  setState(() {
                                                    dob =
                                                        "${value.month}/${value.day}/${value.year}";

                                                    print(dob);
                                                  });
                                                });
                                                print(dob);
                                              },
                                              child: Card(
                                                  child: Container(
                                                      width: 100,
                                                      height: 40,
                                                      child: Center(
                                                          child: Text(
                                                              "Date of Birth")))),
                                            ),
                                            Text("$dob")
                                          ],
                                        ),
                                        const SizedBox(height: 24.0),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              icon: Icon(
                                                Icons.crop_square,
                                                color: Colors.black38,
                                              ),
                                              hintText: 'Your state Id',
                                              labelText: 'State ID',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54)),
                                          keyboardType: TextInputType.phone,
                                          validator: validateStateID,
                                          onSaved: (String val) {
                                            stateID = int.parse(val);
                                          },
                                        ),
                                        const SizedBox(height: 24.0),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              icon: Icon(
                                                Icons.crop_square,
                                                color: Colors.black38,
                                              ),
                                              hintText: 'Your city ID',
                                              labelText: 'city ID',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54)),
                                          keyboardType: TextInputType.phone,
                                          validator: validateCityID,
                                          onSaved: (String val) {
                                            cityID = int.parse(val);
                                          },
                                        ),
                                        const SizedBox(height: 24.0),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              icon: Icon(
                                                Icons.crop_square,
                                                color: Colors.black38,
                                              ),
                                              hintText: 'Your Zip code',
                                              labelText: 'Zip Code',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54)),
                                          keyboardType: TextInputType.phone,
                                          validator: validateZipCode,
                                          onSaved: (String val) {
                                            zipCode = int.parse(val);
                                          },
                                        ),
                                        const SizedBox(height: 24.0),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              icon: Icon(
                                                Icons.crop_square,
                                                color: Colors.black38,
                                              ),
                                              hintText: 'Your street Address',
                                              labelText: 'street Address',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54)),
                                          keyboardType: TextInputType.text,
                                          validator: validateStreetAddress,
                                          onSaved: (String val) {
                                            streetAddress = val;
                                          },
                                        ),
                                        const SizedBox(height: 24.0),
                                        TextFormField(
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87,
                                                    style: BorderStyle.solid),
                                              ),
                                              icon: Icon(
                                                Icons.lock,
                                                color: Colors.black38,
                                              ),
                                              hintText: 'Your password',
                                              labelText: 'Password',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54)),
                                          validator: (val) => val.length < 6
                                              ? 'Password too short.'
                                              : null,
                                          onSaved: (val) => _password = val,
                                        ),
                                        SizedBox(
                                          height: 35.0,
                                        ),
                                        Row(children: <Widget>[
                                          Icon(Icons.person,
                                              color: Colors.black54),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Gender",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          new Radio(
                                            value: 0,
                                            groupValue: _radioValue1,
                                            onChanged: _handleRadioValueChange1,
                                          ),
                                          new Text(
                                            'Male',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                          new Radio(
                                            value: 1,
                                            groupValue: _radioValue1,
                                            onChanged: _handleRadioValueChange1,
                                          ),
                                          new Text(
                                            'Female',
                                            style: new TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: 35.0,
                                        ),
                                        new Card(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: new GestureDetector(
                                                  onTap: () {
                                                    _submit();
                                                  },
                                                  child: Text(
                                                    'SIGNUP',
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        /*   const SizedBox(height:24.0),

                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('FORGOT PASSWORD?',style: TextStyle(
                                    color: Colors.blueAccent,fontSize: 13.0
                                  ),),
                                ),

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('LOGIN',style: TextStyle(
                                      color: Colors.orange,fontSize: 15.0
                                  ),),
                                ),

                              ],
                            )


*/
                                      ]),
                                )) //login,
                            ))
                  ],
                ),
        )));
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateStateID(String value) {
    if (value.length > 6 || value.length == 0) {
      return "Enter valid state ID";
    } else
      return null;
  }

  String validateCityID(String value) {
    if (value.length > 6 || value.length == 0) {
      return "Enter valid City ID";
    } else
      return null;
  }

  String validateZipCode(String value) {
    if (value.length > 7 || value.length == 0) {
      return "Enter valid Zip Code";
    } else
      return null;
  }

  String validateStreetAddress(String value) {
    if (value.length == 0) {
      return "Enter valid street Address";
    } else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length > 10 || value.length == 0) {
      return 'Mobile Number must be of 10 digit';
    }
    print("$value");
    return null;
  }
  // String validateDOB(String value){
  //   if (value== null)
  //     return 'Enter valid date of birth';
  //   else
  //     return null;

  // }
  void _submit() {
    //_performLogin();
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      if (dob == null) {
        showInSnackBar('Please select date of birth before submitting.');
      } else {
        _performLogin();
      }
    } else {
      showInSnackBar('Please fix the errors in red before submitting.');
    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  void _performLogin() async {
    Map data = {
      "service": "registerCustomer",
      "module": "customers",
      "name": "$_firstname $_lastname",
      "password": _password,
      "email": _email,
      "phone": "$_phone",
      "dob": dob,
      "state_id": "$stateID",
      "city_id": "$cityID",
      "street_address": streetAddress,
      "zip_code": "$cityID",
      "gender": gender
    };

    bool isRegistered = await ApiRequest().signup(data);
    if (isRegistered) {
      showToast("Your email is successfully reigistered");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login_Screen()));
    } else {
      showToast("Sorry cannot register right now");
    }
  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );
  void showToast(
    String msg,
  ) {
    Toast.show(msg, context, duration: 2, gravity: Toast.BOTTOM);
  }
}
