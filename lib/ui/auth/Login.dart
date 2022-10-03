import 'package:flutter/services.dart';
import 'package:magazine/ui/Custom/CustomAppBar.dart';
import 'package:magazine/ui/auth/ForgetPassword.dart';
import 'package:magazine/ui/auth/Register.dart';
import 'package:magazine/config/GlobalFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../AppTheme.dart';
import '../../Provider/AuthProvider.dart';
import '../../config/LocalStorage.dart';
import '../../main.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<Login> {
  bool passVisibility = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  FocusNode passwordNode = new FocusNode();
  String message = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        confirmCloseApp(context);
        return true;
      },
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .12,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        color: AppTheme.primaryColor),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .05,
                        right: MediaQuery.of(context).size.width * .05),
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * .02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                confirmCloseApp(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .05,
                          right: MediaQuery.of(context).size.width * .05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.zero,
                              height: MediaQuery.of(context).size.height * .05,
                              color: Colors.white),
                          Text(
                            "اسم المستخدم",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(passwordNode);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'ادخل اسم المستخدم';
                                }
                                // else if(loginValdite['Message']=="Password is incorrect.");
                                return null;
                              },
                              //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    right: 15, left: 15, top: 0, bottom: 0),
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.black12)),
                                focusedBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.black12)),
                                focusedErrorBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red)),
                                errorBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red)),
                                hintText: "اسم المستخدم",
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 12),
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              controller: username,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "كلمة المرور",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              focusNode: passwordNode,
                              obscureText: passVisibility,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'ادخل كلمة المرور';
                                }
                                // else if(loginValdite['Message']=="Password is incorrect.");
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    right: 15, left: 15, top: 0, bottom: 0),
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.black12)),
                                focusedBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.black12)),
                                focusedErrorBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red)),
                                errorBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red)),
                                hintText: "كلمة المرور",
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 12),
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                suffixIcon: InkWell(
                                  child: Icon(
                                    passVisibility
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black38,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      passVisibility = !passVisibility;
                                    });
                                  },
                                ),
                              ),
                              controller: password,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      GlobalFunction.route(ForgetPassword()));
                                },
                                child: Text(
                                  "نسيت كلمة المرور",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: AppTheme.yellowColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          message == ""
                              ? SizedBox()
                              : Container(
                                  padding: EdgeInsets.only(bottom: 25),
                                  alignment: Alignment.center,
                                  child: Text(
                                    message,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ),
                          GestureDetector(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                await authProvider.LoginServices(
                                    username.text, password.text);
                                if (authProvider.connection == 200) {
                                  print(authProvider.LoginInfo["user"]["id"]);
                                  print(
                                      "---------------------------------------------------------------");
                                  LocalStorage.SaveData(
                                      "token", authProvider.LoginInfo["token"]);
                                  LocalStorage.SaveData(
                                      "Id",
                                      authProvider.LoginInfo["user"]["id"]
                                          .toString());
                                  LocalStorage.SaveData("name",
                                      authProvider.LoginInfo["user"]["name"]);
                                  LocalStorage.SaveData("type",
                                      authProvider.LoginInfo["user"]["type"]);
                                  LocalStorage.SaveData("photo",
                                      authProvider.LoginInfo["user"]["photo"]);
                                  setState(() {
                                    App.Id = authProvider.LoginInfo["user"]
                                            ["id"]
                                        .toString();
                                    App.name =
                                        authProvider.LoginInfo["user"]["name"];
                                    App.type =
                                        authProvider.LoginInfo["user"]["type"];
                                    App.Image =
                                        authProvider.LoginInfo["user"]["photo"];
                                  });
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "/mainPage", (route) => false);
                                } else {
                                  setState(() {
                                    loading = false;
                                    message = authProvider.LoginInfo["message"];
                                  });
                                }
                                setState(() {
                                  loading = false;
                                });
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * .065,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: loading
                                    ? Colors.black12
                                    : AppTheme.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.05),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        2, 2), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.05),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        -2, -2), // changes position of shadow
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "او قم بتسجيل الدخول بواسطة ",
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () => _handleSignIn(),
                                  child: Image.asset(
                                    "assets/images/google.png",
                                    height: 50,
                                    width: 50,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                  onTap: () => faceLogin(),
                                  child: Image.asset(
                                    "assets/images/facebook.png",
                                    height: 50,
                                    width: 50,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context, GlobalFunction.route(Register()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ليس لديك الحساب ؟ ",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "انشاء حساب",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/mainPage", (route) => false);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * .065,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.05),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        2, 2), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.05),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        -2, -2), // changes position of shadow
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "تخطي",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> _handleSignIn() async {
    final loginProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      setState(() {
        loading = true;
      });
      await _googleSignIn.signIn();
      if (_googleSignIn.currentUser != null) {
        GoogleSignInAccount? user = await _googleSignIn.signIn();
        GoogleSignInAuthentication googleSignInAuthentication =
            await user!.authentication;
        print(_googleSignIn.currentUser!.displayName);
        print('''name:${_googleSignIn.currentUser!.email}''');
        print(googleSignInAuthentication.idToken);
        print(googleSignInAuthentication.accessToken);
        await loginProvider.LoginWithSocial(_googleSignIn.currentUser!.email,
            _googleSignIn.currentUser!.displayName!);
        print(loginProvider.LoginInfo);
        print(loginProvider.connection.toString());
        print("sssssssssssssssssssssssssssssssssss");
        setState(() {
          loading = false;
        });

        if (loginProvider.connection == 200) {
          print(loginProvider.LoginInfo["token"]);
          print(loginProvider.LoginInfo["user"]["id"].toString());
          print(loginProvider.LoginInfo["user"]["name"]);
          print("============================================================");
          LocalStorage.SaveData("token", loginProvider.LoginInfo["token"]);
          LocalStorage.SaveData(
              "Id", loginProvider.LoginInfo["user"]["id"].toString());
          LocalStorage.SaveData(
              "name", loginProvider.LoginInfo["user"]["name"]);
          LocalStorage.SaveData(
              "type", loginProvider.LoginInfo["user"]["type"]);
          LocalStorage.SaveData(
              "photo", loginProvider.LoginInfo["user"]["photo"]);
          setState(() {
            App.Id = loginProvider.LoginInfo["user"]["id"].toString();
            App.name = loginProvider.LoginInfo["user"]["name"];
            App.type = loginProvider.LoginInfo["user"]["type"];
            App.Image = loginProvider.LoginInfo["user"]["photo"];
          });
          Navigator.pushNamedAndRemoveUntil(
              context, "/mainPage", (route) => false);
        } else {
          setState(() {
            loading = false;
            message = loginProvider.LoginInfo["message"];
          });
        }
      }

      // await loginProvider.LoginSocial(_googleSignIn.currentUser!.email, _googleSignIn.currentUser!.displayName, _googleSignIn.currentUser!.id);

      setState(() {
        loading = false;
      });
    } catch (error) {
      FlutterToastr.show(error.toString(), context,
          duration: FlutterToastr.lengthShort, position: FlutterToastr.bottom);
      setState(() {
        loading = false;
      });
    }
  }

  faceLogin() async {
    final loginProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      loading = true;
    });
    await FacebookAuth.instance.logOut();
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email']);
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      print("userData ${userData.toString()}");
      final firstName = userData['name'].toString().split(" ");
      print("GAMAL" + LoginStatus.values.toString());
      await loginProvider.LoginWithSocial(
          userData.containsKey("email") ? userData['email'].toString() : "",
          userData['name'].toString().split(" ")[0].toString());
      print(loginProvider.LoginInfo);
      print(loginProvider.connection.toString());
      print("sssssssssssssssssssssssssssssssssss");
    }
    if (loginProvider.connection == 200) {
      print(loginProvider.LoginInfo["token"]);
      print(loginProvider.LoginInfo["user"]["id"].toString());
      print(loginProvider.LoginInfo["user"]["name"]);
      print("============================================================");
      LocalStorage.SaveData("token", loginProvider.LoginInfo["token"]);
      LocalStorage.SaveData(
          "Id", loginProvider.LoginInfo["user"]["id"].toString());
      LocalStorage.SaveData("name", loginProvider.LoginInfo["user"]["name"]);
      LocalStorage.SaveData("type", loginProvider.LoginInfo["user"]["type"]);
      LocalStorage.SaveData("photo", loginProvider.LoginInfo["user"]["photo"]);
      setState(() {
        App.Id = loginProvider.LoginInfo["user"]["id"].toString();
        App.name = loginProvider.LoginInfo["user"]["name"];
        App.type = loginProvider.LoginInfo["user"]["type"];
        App.Image = loginProvider.LoginInfo["user"]["photo"];
      });
      Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
    } else {
      setState(() {
        loading = false;
        message = loginProvider.LoginInfo["message"];
      });
    }
    // you are logged`
  }
}

confirmCloseApp(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 150.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  border: Border.all(color: Colors.black12, width: 2.0),
                  color: Colors.white),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Icon(
                                Icons.warning_amber_sharp,
                                size: 45,
                                color: Colors.red,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "هل تريد اغلاق التطبيق",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              // Text("${title}",textAlign: TextAlign.center,)
                            ],
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black38, width: 1.0),
                                    color: Colors.white),
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                width: MediaQuery.of(context).size.width * .32,
                                alignment: Alignment.center,
                                child: Text(
                                  "الغاء",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppTheme.primaryColor),
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                width: MediaQuery.of(context).size.width * .32,
                                alignment: Alignment.center,
                                child: Text(
                                  "موافق",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              onTap: () async {
                                SystemNavigator.pop();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ));
}
