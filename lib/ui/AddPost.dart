import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:magazine/ui/Custom/CustomAppBar.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import '../Provider/MainProvider.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController post=new TextEditingController();
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    final mainProvider= Provider.of<MainProvider>(context, listen: true);
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            CustomAppBar(Title: "اضافة محتوي"),
            SizedBox(height: 20,),
            Container(
              width: w*.9,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.all(Radius.circular(10)),

              ),

              child: TextFormField(
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value){
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                validator: (value){
                  if(value!.isEmpty){
                    return '';
                  }
                  // else if(loginValdite['Message']=="Password is incorrect.");
                  return null;
                },
                autofocus: true,
                //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                decoration: InputDecoration(
             //     suffixIcon: Icon(Icons.send,),
                  contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black12)
                  ),
                  focusedBorder:  new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black12)
                  ),
                  focusedErrorBorder:new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red)
                  ),
                  errorBorder:new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red)
                  ),
                  hintText:"اكتب المحتوي المراد نشره" ,
                  errorStyle: TextStyle(color: Colors.red,fontSize: 12),
                  hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                ),
                minLines: 3,maxLines: 4,
                controller: post,
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: ()async{
                setState(() {
                  loading=true;
                });
                await mainProvider.createPosts(post.text);
                if(mainProvider.connection==200){
                  FlutterToastr.show("تم اضافة السؤال بنجاح", context);
                  Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                }else{
                  FlutterToastr.show("حدث خطا اثناء الاضافة", context);
                }
                setState(() {
                  loading=false;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height*.065,
                width: MediaQuery.of(context).size.width*.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:loading?Colors.black12: AppTheme.primaryColor
                ),
                alignment: Alignment.center,
                child: Text("اضافة",style: TextStyle(fontSize: 16,color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
