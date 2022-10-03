import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magazine/config/LocalStorage.dart';
import 'package:magazine/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _Splash1State createState() => _Splash1State();
}

class _Splash1State extends State<Splash> {
  var token;
  checkLogin()async{
   token=await LocalStorage.getData("token");
   setState(() {
   });
   print(token);
   print("tokennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
   if(token !=null){
     SharedPreferences pref=await SharedPreferences.getInstance();
     App.name=pref.getString("name")!;
     App.Id=pref.getString("Id")!;
     App.type=pref.getString("type")!;
     App.Image=pref.getString("photo")!;
     print(App.name);
     print("nameeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
     setState(() {
     });
   }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), (){
      Navigator.of(context)
          .pushNamedAndRemoveUntil(token==null?"/login":"/mainPage",
              (Route<dynamic> route) => false);
      // Phoenix.rebirth(context);
    });
    return SafeArea(
      child: Scaffold(
        //  backgroundColor: AppTheme.primaryColor,
          body:  Image.asset("assets/images/splash.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
          )
      ),
    );
  }
}
