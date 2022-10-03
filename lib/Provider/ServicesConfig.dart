import 'package:magazine/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesConfig{
  static String base_url="http://rqeeqa.net/api";
  static String default_image="https://st2.depositphotos.com/4111759/12123/v/950/depositphotos_121233300-stock-illustration-female-default-avatar-gray-profile.jpg";
  static Future<Map<String,String>>getHeader()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var header={ "language":pref.getString("lang")==null?"en":pref.getString("lang")!,};
    return header;
  }
  static Future<Map<String,String>>getHeaderWithToken()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var header={
      "language":pref.getString("lang")==null?"en":pref.getString("lang")!,
      "Authorization":"Bearer "+pref.getString("token")!
    };
    return header;

  }
}