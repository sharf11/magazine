import 'dart:io';

import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magazine/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magazine/Provider/AuthProvider.dart';
import 'package:magazine/Provider/ServicesConfig.dart';
import 'package:magazine/config/LocalStorage.dart';
import 'package:magazine/main.dart';
import 'package:magazine/ui/Custom/CustomAppBar.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<EditProfile>{
  TextEditingController name =new TextEditingController();
  TextEditingController email =new TextEditingController();
  TextEditingController phone =new TextEditingController();
  bool loading=true;
  bool loadingBtn=false;
 late String photo;
  loadData()async{
    final mainProvider= Provider.of<AuthProvider>(context, listen: false);
   await  mainProvider.getUserInfo();
   print(mainProvider.userInfo);
    setState(() {
      photo=mainProvider.userInfo["photo"]??"";
      name.text=mainProvider.userInfo["name"];
      email.text=mainProvider.userInfo["email"];
      App.Image=mainProvider.userInfo["photo"];
      App.name=mainProvider.userInfo["name"];
      loading=false;
    });
    LocalStorage.SaveData("photo", mainProvider.userInfo["photo"]);
    LocalStorage.SaveData("name", mainProvider.userInfo["name"]);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
bool  loadingImage=false;
  @override
  Widget build(BuildContext context) {
    final mainProvider= Provider.of<AuthProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushNamedAndRemoveUntil(context, "/profile", (route) => false);
        return true;
      },
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child:Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*.12,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      color: AppTheme.primaryColor
                  ),
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*.05,
                      right: MediaQuery.of(context).size.width*.05
                  ),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height*.02
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.05,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamedAndRemoveUntil(context, "/profile", (route) => false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                            ),
                          ),
                          Text("تعديل الملف الشخصي",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.arrow_back_ios,color: AppTheme.primaryColor,),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    ],
                  ),
                ),
             loading?  Container(
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               child: Center(
                 child: CircularProgressIndicator.adaptive(),
               ),
             ):Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*.05,
                      right: MediaQuery.of(context).size.width*.05
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                   loadingImage? Container(height: 100,width: 100,child: Center(child: CircularProgressIndicator.adaptive(),),):  Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width*.42,
                            width: MediaQuery.of(context).size.width*.42,
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width*.05,
                            top: MediaQuery.of(context).size.width*.05,
                            child: GestureDetector(
                              onTap: ()=>pickImage(context),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.network(photo==""?ServicesConfig.default_image:photo,
                                  height: MediaQuery.of(context).size.width*.35,
                                  width: MediaQuery.of(context).size.width*.35,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          /*   Positioned(
                        left: MediaQuery.of(context).size.width*.17,
                        top: MediaQuery.of(context).size.width*.3,
                        child:Container(
                          child: Icon(Icons.add_a_photo,size: 30,color: Colors.white,),
                        )
                      )*/
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("الاسم : "),
                            SizedBox(height: 5,),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'ادخل الاسم بالكامل';
                                }
                                return null;
                              },
                              //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                              decoration: InputDecoration(
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
                                    borderSide: BorderSide(color: Colors.black12)
                                ),
                                errorBorder:new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red)
                                ),
                                hintText:"الاسم بالكامل" ,
                                errorStyle: TextStyle(fontSize: 0),
                                hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                              ),
                              controller: name,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*.02,),
                            Text("البريد االالكتروني "),
                            SizedBox(height: 5,),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'ادخل البريد الالكتروني ';
                                }
                                return null;
                              },
                              //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                              decoration: InputDecoration(
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
                                    borderSide: BorderSide(color: Colors.black12)
                                ),
                                errorBorder:new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red)
                                ),
                                hintText:"البريد الالكتروني" ,
                                errorStyle: TextStyle(fontSize: 0),
                                hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                              ),
                              controller: email,
                            ),
                        /*    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                            Text("رقم الهاتف"),
                            SizedBox(height: 5,),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'ادخل رقم الهاتف';
                                }
                                return null;
                              },
                              //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                              decoration: InputDecoration(
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
                                    borderSide: BorderSide(color: Colors.black12)
                                ),
                                errorBorder:new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.red)
                                ),
                                hintText:"رقم الهاتف" ,
                                errorStyle: TextStyle(fontSize: 0),
                                hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                              ),
                              controller: phone,
                            ),*/
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.04,),
                      GestureDetector(
                        onTap: ()async{
                          setState(() {
                            loadingBtn=true;
                          });
                         await mainProvider.editProfile(name.text, email.text);
                         FlutterToastr.show("تم تعديل البيانات بنجاح", context,position: 1);
                         setState(() {
                           loadingBtn=false;
                         });
                         loadData();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*.065,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:loadingBtn? Colors.black12:AppTheme.primaryColor
                          ),
                          alignment: Alignment.center,
                          child: Text("حفظ",style: TextStyle(fontSize: 16,color: Colors.white),),
                        ),
                      )

                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
  late File selectedImage;
  pickImage(BuildContext context ) async {
    setState(() {
      loadingImage=true;
    });
    final userProvider= Provider.of<AuthProvider>(context, listen: false);
    var imagePicker = new  ImagePicker();
    var profileImage=await imagePicker.pickImage(source:  ImageSource.gallery);

    setState(() {
      selectedImage = File(profileImage!.path);
    });
    await  userProvider.sendImagePick(selectedImage,context);
    setState(() {
      loadingImage=false;
    });
   loadData();
  }
}