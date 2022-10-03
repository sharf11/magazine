import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static void SaveData(var key,var value)async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.setString(key, value);
  }
  static void removeData(var key)async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.remove(key);
  }
  static Future<String?> getData(var key)async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return  pref.getString(key);
  }
  static Logout() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.remove("name");
    pref.remove("Id");
    pref.remove("token");
  }
}