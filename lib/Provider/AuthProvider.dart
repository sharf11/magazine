import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:magazine/Provider/ServicesConfig.dart';
import 'package:http/http.dart'as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
class AuthProvider extends ChangeNotifier{
  bool loadingImage=false;
  late Map<String,dynamic>LoginInfo;
  late Map<String,dynamic>RegisterInfo;
  late Map<String,dynamic>updateInfo;
  late Map<String,dynamic>userInfo;
  late Map<String,dynamic>loginSocial;
  Map<String,dynamic>updateInfoTechnical={};
  Map<String,dynamic>forgetPassword={};
  int connection=0;

  Future<void> LoginWithSocial(String email,String name) async{
    String url=ServicesConfig.base_url+"/auth/login-social";
    print(url);
    var body={
      "email" : email,
      "name" : name,
    };
    print(body);
    var header=await ServicesConfig.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        connection=responce.statusCode;
        LoginInfo=json.decode(responce.body);
        print(LoginInfo);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> LoginServices(String email,String password) async{
    String url=ServicesConfig.base_url+"/auth/login";
    print(url);
    var body={
      "email" : email,
      "password" : password,
      "remember_me":"0"
    };
    print(body);
    var header=await ServicesConfig.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        connection=responce.statusCode;
        LoginInfo=json.decode(responce.body);
        print(LoginInfo);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> LoginSocial(String email,String? name,var social_id) async{
    String url=ServicesConfig.base_url+"/auth/sociallogin";
    print(url);
    var body={
      "email" : email,
      "name" : name,
      "social_id":social_id
    };
    print(body);
    var header=await ServicesConfig.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        LoginInfo=json.decode(responce.body);
        print(LoginInfo);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> forgetpassword(String email) async{
    String url=ServicesConfig.base_url+"/auth/forgot";
    print(url);
    var body={
      "email" : email,
    };
    print(body);
    var header=await ServicesConfig.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        connection=responce.statusCode;
        forgetPassword=json.decode(responce.body);
        print(forgetPassword);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> checkCode(String email,String code) async{
    String url=ServicesConfig.base_url+"/auth/checkcode";
    print(url);
    var body={
      "email" : email,
      "code":code
    };
    print(body);
    var header=await ServicesConfig.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        connection=responce.statusCode;
        forgetPassword=json.decode(responce.body);
        print(forgetPassword);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> resetPassword(String code,String password,String confirmPassword) async{
    String url=ServicesConfig.base_url+"/auth/reset";
    print(url);
    var body={
      "reset_code" : code,
      "password":password,
      "password_confirmation":confirmPassword
    };
    print(body);
    var header=await ServicesConfig.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        connection=responce.statusCode;
        forgetPassword=json.decode(responce.body);
        print(forgetPassword);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> RegisterServices(String name,String email,String password,String password_confirmation) async{
    String url=ServicesConfig.base_url+"/auth/register";
    print(url);
    var body={
      "name":name,
      "email" : email,
      "password" : password,
      "password_confirmation":password_confirmation,
    };
    print(body);
    var header=await ServicesConfig.getHeader();
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        connection=responce.statusCode;
        RegisterInfo=json.decode(responce.body);
        print(RegisterInfo);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> getUserInfo() async{
    String url=ServicesConfig.base_url+"/user";
    print(url);
    var header=await ServicesConfig.getHeaderWithToken();
    try{
      final responce=await http.get(Uri.parse(url),headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        userInfo= json.decode(utf8.decode(responce.bodyBytes))["data"];
        print(userInfo);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> editProfile(String name,String email) async{
    String url=ServicesConfig.base_url+"/profile";
    print(url);
    var body={
      "name":name,
      "email" : email
    };
    print(body);
    var header=await ServicesConfig.getHeaderWithToken();
    print(header);
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        updateInfo=json.decode(responce.body);
        print(updateInfo);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<void> editProfileTechnical(dynamic country_id,dynamic state_id,dynamic city_id,dynamic region_id,dynamic job_id,dynamic experince_years,String job) async{
    String url=ServicesConfig.base_url+"/profile/${App.Id}";
    print(url);
    print("++++++++++++++++++++++++++++++++++++");
    var body=job_id==null?{
      "country_id":country_id,
      "city_id" : city_id,
      "state_id":state_id,
      "region_id" : region_id,
      "job":job,
      "experince_years":experince_years
    }:{
      "country_id":country_id.toString(),
      "state_id":state_id,
      "city_id" : city_id,
      "region_id" : region_id,
      "sub_category_id":job_id,
      "job":job,
      "experince_years":experince_years
    };
    print(body);
    var header=await ServicesConfig.getHeaderWithToken();
    print(header);
    print("----------------------------------------------------------------------------");
    try{
      final responce=await http.post(Uri.parse(url),body:body,headers: header);
      print(responce.body);
      print(responce.body);
      print("responceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(responce.body.isNotEmpty)
      {
        updateInfoTechnical=json.decode(responce.body);
        print(updateInfoTechnical);
        notifyListeners();
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  sendImagePick(File fileImage,BuildContext context)async
  {
    if (fileImage != null) {
      try {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        Dio dio = Dio();
        dio.options.headers['Content-Type'] = 'application/json';
        dio.options.headers['Authorization'] = "Bearer "+sharedPreferences.getString("token")!;
        ///we used uri.encode to enable upload  image with arabic name
        // var url =Uri.encodeFull(createPath('user/editProfileImage'));
        var url = "${ServicesConfig.base_url}/profileImage";
        print(url);
        String fileName = basename(fileImage.path);
        // print('${fileName},,,,fileName');
        //print('${pathImage.path},,,,imagePath.path');

        FormData formData = FormData.fromMap({
          "photo": await MultipartFile.fromFile(
              fileImage.path, filename: fileName
              , contentType: MediaType('image', fileName
              .split('.')
              .last)),
        });
        print(formData.fields);
        print("ssssssssssssssssss");
        Response response = await dio.post(url, data: formData);
        print('${response.data},,,,,,,,fields');
        if (response.statusCode == 200) {
          Map<String, dynamic>map = response.data;
          FlutterToastr.show("تم تعديل صورة الملف الشخصي ", context, duration: FlutterToastr.lengthShort, position:  FlutterToastr.center);
          this.getUserInfo();
          loadingImage=false;
          notifyListeners();
        }
        else {
          return null;
        }
      }
      catch (e) {
        print('${e}imageuploaderror');
      }
    }
    else {
      FlutterToastr.show("Please Send Correct Image", context, duration: FlutterToastr.lengthShort, position:  FlutterToastr.center);
    }}
}