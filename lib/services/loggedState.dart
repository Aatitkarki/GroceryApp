import 'package:shared_preferences/shared_preferences.dart';
class LoggedState{
  
  void setLoggedState(bool value)async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool('loggedState', value);
  }

  Future<bool> getLoggedState()async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    final bool loggedData = myPrefs.getBool('loggedState')==null?false:myPrefs.getBool('loggedState');
    print(loggedData);
    return loggedData;
  }
}