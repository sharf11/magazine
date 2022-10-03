import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:magazine/Models/NotificationsModel.dart';
import 'package:magazine/Models/PostModel.dart';
import 'package:http/http.dart'as http;
import '../main.dart';
import 'ServicesConfig.dart';

class MainProvider extends ChangeNotifier{
  List<PostModel>myposts=[];
  List<PostModel>posts=[];
 late  PostModel postDetails;
  List<NotificationsModel>notifications=[];
  int connection=0;
  Map<String,dynamic>info={};
  SetPost(PostModel postDetail){
    postDetails=postDetail;
    notifyListeners();
  }
  Future<void>createPosts(String content)async {
    var url=ServicesConfig.base_url+"/posts";
    print(url);
    var body={
      "content":content
      };
    var header=await ServicesConfig.getHeaderWithToken();
    print(header);
    try
    {
      final response = await http.post(Uri.parse(url),body: body,headers: header);
      print(response.body);
      print("--------------------------------------");
      connection=response.statusCode;
      notifyListeners();
      if(response.statusCode==200 && response.body!=null)
      {
        print("enter");
        print(json.decode(utf8.decode(response.bodyBytes)));

        info = json.decode(utf8.decode(response.bodyBytes));
        print(info);
        print("infoinfoinfoinfoinfoinfoinfoinfoinfo");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void>addComment(String comment)async {
    var url=ServicesConfig.base_url+"/posts/comment";
    print(url);
    var body={
      "content":comment,
      "post_id":postDetails.id.toString()
    };
    var header=await ServicesConfig.getHeaderWithToken();
    print(header);
    try
    {
      final response = await http.post(Uri.parse(url),body: body,headers: header);
      print(response.statusCode);
      print("--------------------------------------");
      connection=response.statusCode;
      notifyListeners();
      if(response.statusCode==200 && response.body!=null)
      {
        print("enter");
        print(json.decode(utf8.decode(response.bodyBytes)));

        info = json.decode(utf8.decode(response.bodyBytes));
        print(info);
        print("infoinfoinfoinfoinfoinfoinfoinfoinfo");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void>AddLike(var id)async {
    var url=ServicesConfig.base_url+"/posts/like";
    print(url);
    var body={
      "id":id.toString()
      };
    var header=await ServicesConfig.getHeaderWithToken();
    print(header);
    try
    {
      final response = await http.post(Uri.parse(url),body: body,headers: header);
      print(response.body);
      print("--------------------------------------");
      if(response.statusCode==200 && response.body!=null)
      {
        print("enter");
        print(json.decode(utf8.decode(response.bodyBytes)));

        info = json.decode(utf8.decode(response.bodyBytes));
        print(info);
        print("infoinfoinfoinfoinfoinfoinfoinfoinfo");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void>getMyPosts()async {
    var url=ServicesConfig.base_url+"/posts/my-posts";
    print(url);
    var header=App.name==""?await ServicesConfig.getHeader(): await ServicesConfig.getHeaderWithToken();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      print("--------------------------------------");
      if(response.statusCode==200 && response.body!=null)
      {
        print("enter ");
        print(json.decode(utf8.decode(response.bodyBytes))["data"]);

        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"]["data"];
        print(slideritems.length);
        print("++++++++++++++++++++++++++++++++++++++++++++");
        myposts = slideritems.map((e) => PostModel.fromJson(e)).toList();
        print(myposts.length);
        print("mypostsmypostsmypostsmypostsmyposts");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void>getPosts(int page)async {
    var url=ServicesConfig.base_url+"/posts?page=$page";
    print(url);
    var header=App.name==""?await ServicesConfig.getHeader(): await ServicesConfig.getHeaderWithToken();
    print(header);
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      print("--------------------------------------");
      if(response.statusCode==200 && response.body!=null)
      {
        print("enter ");
        print(json.decode(utf8.decode(response.bodyBytes))["data"]);

        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"]["data"];
        print(slideritems.length);
        print("++++++++++++++++++++++++++++++++++++++++++++");
        posts = slideritems.map((e) => PostModel.fromJson(e)).toList();
        print(posts.length);
        if(posts.length>0){
          SetPost(posts[0]);
        }
        print("postspostspostspostspostspostspostsposts");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void>getNotifications()async {
    var url=ServicesConfig.base_url+"/posts/notifications";
    print(url);
    var header=App.name==""?await ServicesConfig.getHeader(): await ServicesConfig.getHeaderWithToken();
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      print("--------------------------------------");
      if(response.statusCode==200 && response.body!=null)
      {
        print("enter ");
        print(json.decode(utf8.decode(response.bodyBytes))["data"]);

        List slideritems = json.decode(utf8.decode(response.bodyBytes))["data"]["data"];
        print(slideritems.length);
        print("++++++++++++++++++++++++++++++++++++++++++++");
        notifications = slideritems.map((e) => NotificationsModel.fromJson(e)).toList();
        print(notifications.length);
        print("notificationsnotificationsnotificationsnotificationsnotifications");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }



  Future<void>delete(int  id,BuildContext context)async {
    var url=ServicesConfig.base_url+"/posts/delete/$id";
    print(url);
    var header=await ServicesConfig.getHeaderWithToken();
    print(header);
    print("*************************************************************************************************");
    try
    {
      final response = await http.post(Uri.parse(url),headers: header);
      print(response.body);
      print("--------------------------------------");
      if(response.statusCode==200 && response.body!=null)
      {
        info=json.decode(utf8.decode(response.bodyBytes));
        print(info);
        //notifyListeners();
        FlutterToastr.show("تم المسح بنجاح", context);
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  Future<void>getPostDetails(int id)async {
    var url=ServicesConfig.base_url+"/posts/$id";
    print(url);
    var header=App.name==""?await ServicesConfig.getHeader(): await ServicesConfig.getHeaderWithToken();
    print(header);
    print("********************************************************************");
    try
    {
      final response = await http.get(Uri.parse(url),headers: header);
      print(response.body);
      print("--------------------------------------");
      if(response.statusCode==200 && response.body!=null)
      {
        print("enter ");
        print(json.decode(utf8.decode(response.bodyBytes))["data"]);

        Map<String,dynamic> content = json.decode(utf8.decode(response.bodyBytes))["data"]["data"];
        print(content);
        print("++++++++++++++++++++++++++++++++++++++++++++");
        postDetails =  PostModel.fromJson(content);
        print(postDetails);
        print("postDetailspostDetailspostDetailspostDetailspostDetails");
        notifyListeners();
      }
    }
    catch(e)
    {
      print(e);
    }
  }

}