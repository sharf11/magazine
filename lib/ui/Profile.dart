import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:magazine/Provider/ServicesConfig.dart';
import 'package:magazine/main.dart';
import 'package:magazine/ui/AddPost.dart';
import 'package:magazine/ui/MyPosts.dart';
import 'package:magazine/ui/auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AppTheme.dart';
import '../config/GlobalFunction.dart';
import 'EditProfile.dart';
import 'Home.dart';

class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Profile>{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
        return true;
      },
      child:App.name==""? Login():Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*.05,
            right: MediaQuery.of(context).size.width*.05
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.065,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, GlobalFunction.route(EditProfile()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppTheme.primaryColor,width: 1)
                        ),
                        child: Icon(Icons.edit,color: Colors.brown,size: 20,)),
                  ),

                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.035,),
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.network(App.Image??ServicesConfig.default_image,
                height: MediaQuery.of(context).size.height*.15,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.height*.15,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width:MediaQuery.of(context).size.width*.9,
                      alignment: Alignment.center,
                      child: Text(App.name,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.05,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, GlobalFunction.route(AddPost()));
                },
                child: Row(
                  children: [
                   Icon(Icons.question_mark,size: 30,color: AppTheme.primaryColor,),
                    SizedBox(width: 10,),
                    Text("اضافة سؤال",style: TextStyle(fontSize: 16,color: Colors.brown),)
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Divider(thickness: 1,color: Colors.black26,),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, GlobalFunction.route(MyPosts()));
                },
                child: Row(
                  children: [
                    Icon(Icons.edit,color: AppTheme.primaryColor,size: 25,),
                    SizedBox(width: 10,),
                    Text("أسئلتي",style: TextStyle(fontSize: 16,color: Colors.brown),)
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.black26,),
              SizedBox(height: 10,),
              InkWell(
                onTap: ()=>confirmCloseApp(context),
                child: Row(
                  children: [
                    Icon(Icons.logout,color: AppTheme.primaryColor,size: 25,),
                    SizedBox(width: 10,),
                    Text("تسجيل الخروج",style: TextStyle(fontSize: 16,color: Colors.brown),)
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.black26,)
            ],
          ),
        ),
      ),
    );
  }
  logout(BuildContext context)async{
    GoogleSignIn _googleSignIn = GoogleSignIn();
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.remove("token");
    _googleSignIn.signOut();
    setState(() {
      App.name="";
    });
    //SystemNavigator.pop();
     //Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    // Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
  confirmCloseApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10
            ),
            height: 150.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                border: Border.all(color: Colors.black12,width: 2.0),
                color: Colors.white
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center
                ,crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(alignment: Alignment.center,child: Column(
                    children: [
                      Icon(Icons.logout,size: 37,color: AppTheme.primaryColor,),
                      SizedBox(height: 5,),
                      Text("هل تريد تسجيل الخروج",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      // Text("${title}",textAlign: TextAlign.center,)
                    ],
                  )),
                  SizedBox(height: 15,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(

                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black38,width: 1.0),
                                color:Colors.white
                            ),
                            height: MediaQuery.of(context).size.height*.04,
                            width: MediaQuery.of(context).size.width*.32,
                            alignment: Alignment.center,
                            child:   Text("الغاء",style: TextStyle(color:Colors.black,fontSize: 12),),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:AppTheme.primaryColor
                            ),
                            height: MediaQuery.of(context).size.height*.04,
                            width: MediaQuery.of(context).size.width*.32,
                            alignment: Alignment.center,
                            child:   Text("موافق",style: TextStyle(color:Colors.white,fontSize: 12),),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                            logout(context);
                          },
                        ),

                      ],
                    ),
                  )
                ],
              ),


            ],),
          ),
        ));
  }
}
