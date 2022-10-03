import 'package:magazine/ui/auth/ResetPassword.dart';
import 'package:magazine/config/GlobalFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../AppTheme.dart';
import '../Custom/CustomAppBar.dart';

class Verification extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Verification>{
  final formKey=GlobalKey<FormState>();
  TextEditingController n1=new TextEditingController();
  TextEditingController n2=new TextEditingController();
  TextEditingController n3=new TextEditingController();
  TextEditingController n4=new TextEditingController();
  final nod0 = FocusNode();
  final nod1 = FocusNode();
  final nod2 = FocusNode();
  final nod3 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child:Column(
            children: [
              CustomAppBar(Title: "التفعيل"),
              Padding(
                padding:  EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*.05,
                    right: MediaQuery.of(context).size.width*.05
                ),
                child: Column(
                  children: [

                    SizedBox( height: MediaQuery.of(context).size.height*.02,),
                    Text("التفعيل",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: AppTheme.primaryColor),),
                    Padding(
                      padding:  EdgeInsets.all(MediaQuery.of(context).size.height*.01),
                      child: Text("ادخل كود التفعيل الذي تم ارساله لك عبر البريد الالكتروني",textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox( height: MediaQuery.of(context).size.height*.025,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*.67,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*.1,
                        left: MediaQuery.of(context).size.width*.05,
                        right: MediaQuery.of(context).size.width*.05,
                      ),
                      child:  Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * .125,
                                  child: TextFormField(

                                    autofocus: true,
                                    focusNode: nod0,
                                    maxLength: 1,
                                    onChanged:(val) {
                                      if(val.isEmpty){

                                      }else
                                        FocusScope.of(context).requestFocus(nod1);
                                    },
                                    //  onFieldSubmitted:
                                    validator: (value) {
                                      if (value!.isEmpty) return '';
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style:  TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold,color: AppTheme.primaryColor),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
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
                                      counterStyle: TextStyle(fontSize: 0),
                                    ),
                                    controller: n1,

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .125,
                                  child: TextFormField(

                                    maxLength: 1,
                                    onChanged: (val) {
                                      if(val.isEmpty){
                                        print("00000000000000000000000000000000");
                                        FocusScope.of(context).requestFocus(nod0);
                                      }else
                                        FocusScope.of(context).requestFocus(nod2);
                                    },
                                    focusNode: nod1,
                                    validator: (value) {
                                      if (value!.isEmpty) return '';
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style:  TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold,color: AppTheme.primaryColor),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 0),
                                      counterStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
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
                                    ),
                                    controller: n2,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .125,
                                  child: TextFormField(
                                    maxLength: 1,
                                    onChanged: (val) {
                                      if(val.isEmpty){
                                        FocusScope.of(context).requestFocus(nod1);
                                      }else
                                        FocusScope.of(context).requestFocus(nod3);
                                    },
                                    focusNode: nod2,
                                    validator: (value) {
                                      if (value!.isEmpty) return '';
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style:  TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold,color: AppTheme.primaryColor),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      counterStyle: TextStyle(fontSize: 0),
                                      errorStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
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
                                    ),
                                    controller: n3,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .125,
                                  child: TextFormField(
                                    maxLength: 1,
                                    validator: (value) {
                                      if (value!.isEmpty) return '';
                                      return null;
                                    },
                                    focusNode: nod3,
                                    onChanged: (val) {
                                      if(val.isEmpty){
                                        FocusScope.of(context).requestFocus(nod2);
                                      }else
                                        FocusScope.of(context).requestFocus(FocusNode());
                                    },
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold,color: AppTheme.primaryColor),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 0),
                                      counterStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
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
                                    ),
                                    controller: n4,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*.02,),
                            Row(
                              children: [
                                Text("اعادة ارسال الكود",style: TextStyle(color: AppTheme.primaryColor,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*.06,),
                            GestureDetector(
                              onTap: ()async{
                                if(formKey.currentState!.validate()){
                                  Navigator.push(context, GlobalFunction.route(ResetPassowrd()));

                                }
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height*.065,
                                width: MediaQuery.of(context).size.width*.8,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: AppTheme.primaryColor, ),
                                alignment: Alignment.center,
                                child: Text("تاكيد",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}