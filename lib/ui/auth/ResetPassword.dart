import 'package:magazine/AppTheme.dart';
import 'package:magazine/ui/Custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPassowrd extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<ResetPassowrd>{
  TextEditingController password2 =new TextEditingController();
  TextEditingController password=new TextEditingController();
  FocusNode passwordNode =new FocusNode();
  final formKey=GlobalKey<FormState>();
  bool ishidden=true;
  bool ishidden2=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(Title: "اعادة ضبط كلمة المرور"),
              Padding(
                padding:  EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*.05,
                    right: MediaQuery.of(context).size.width*.05
                ),
                child: Column(
                  children: [
                    SizedBox( height: MediaQuery.of(context).size.height*.03,),
                    Text("انشاء كلمة مرور جديدة",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: AppTheme.primaryColor),),
                    SizedBox( height: MediaQuery.of(context).size.height*.01,),
                    Text("قم بانشاء كلمة المرور جديدة قوية ",textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.bold),),
                    SizedBox( height: MediaQuery.of(context).size.height*.025,),
                    Form(
                      key: formKey,
                      child: Container(
                        width: MediaQuery.of(context).size.width*.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("كلمة المرور الجديدة ",style: TextStyle(color: Colors.black38,fontSize: 12,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(10)),

                              ),
                              child: TextFormField(

                                onFieldSubmitted: (value){
                                  FocusScope.of(context).requestFocus(passwordNode);
                                },
                                obscureText: ishidden,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'ادخل كلمة المرور الجديدة';
                                  }
                                  // else if(loginValdite['Message']=="Password is incorrect.");
                                  return null;
                                },
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
                                      borderSide: BorderSide(color: Colors.red)
                                  ),
                                  errorBorder:new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.red)
                                  ),
                                  hintText: "كلمة المرور الجديدة",
                                  errorStyle: TextStyle(color: Colors.red,fontSize: 12),
                                  hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                                  suffixIcon:InkWell(
                                    child: Icon(ishidden?Icons.visibility:Icons.visibility_off,color: Colors.black38,),
                                    onTap: (){
                                      setState(() {
                                        ishidden=!ishidden;
                                      });
                                    },
                                  ) ,
                                ),
                                controller: password,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*.025,),
                            Text("تاكيد كلمة المرور الجديدة ",style: TextStyle(color: Colors.black38,fontSize: 12,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,), Container(
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(10)),

                              ),
                              child: TextFormField(

                                onFieldSubmitted: (value){
                                  FocusScope.of(context).requestFocus(FocusNode());
                                },
                                focusNode: passwordNode,
                                obscureText: ishidden2,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'ادخل تاكيد كلمة المرور الجديدة ';
                                  }
                                  // else if(loginValdite['Message']=="Password is incorrect.");
                                  return null;
                                },
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
                                      borderSide: BorderSide(color: Colors.red)
                                  ),
                                  errorBorder:new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.red)
                                  ),
                                  hintText: "تاكيد كلمة المرور الجديدة",
                                  errorStyle: TextStyle(color: Colors.red,fontSize: 12),
                                  hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                                  suffixIcon:InkWell(
                                    child: Icon(ishidden2?Icons.visibility:Icons.visibility_off,color: Colors.black38,),
                                    onTap: (){
                                      setState(() {
                                        ishidden2=!ishidden2;
                                      });
                                    },
                                  ) ,
                                ),
                                controller: password2,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*.03,),
                            GestureDetector(
                              onTap: (){
                                if(formKey.currentState!.validate()){
                                  Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                                }
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height*.065,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppTheme.primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12.withOpacity(0.05),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(2, 2), // changes position of shadow
                                    ),
                                    BoxShadow(
                                      color: Colors.black12.withOpacity(0.05),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(-2, -2), // changes position of shadow
                                    ),
                                  ],
                                ),
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