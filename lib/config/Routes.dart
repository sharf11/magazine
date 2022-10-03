import 'package:flutter/cupertino.dart';
import '../ui/Home.dart';
import '../ui/Splash.dart';
import '../ui/auth/Login.dart';

class Routes{
  static Map <String,WidgetBuilder> routes={
    '/splash':(BuildContext context)=>new Splash(),
    '/login':(BuildContext context)=>new Login(),
    '/mainPage':(BuildContext context)=>new Home(index: 2),
    '/profile':(BuildContext context)=>new Home(index: 0),

  };
}