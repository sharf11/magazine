import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:magazine/Models/PostModel.dart';
import 'package:magazine/Provider/ServicesConfig.dart';
import 'package:magazine/ui/Custom/CustomAppBar.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import '../Provider/MainProvider.dart';
import '../main.dart';

class PostDetails extends StatefulWidget {
  var  id;
  PostDetails({required this.id});
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  TextEditingController comment =new TextEditingController();
  bool loading=true;
  loadData()async{
    final mainProvider= Provider.of<MainProvider>(context, listen: false);
    await mainProvider.getPostDetails(widget.id);
    setState(() {
      loading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  bool loadingSend=false;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    final mainProvider= Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
      body: loading?Center(child: CircularProgressIndicator.adaptive()):Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(Title: "تفاصيل المقال"),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12.withOpacity(.075),
                //    border: Border.all(color: Colors.black12,width: 1)
                ),
                margin:EdgeInsets.only(
                    left: w*.05,right: w*.05,bottom: h*.015
                ) ,
                padding: EdgeInsets.only(
                    left: w*.03,right: w*.03,top: h*.015,bottom: h*.015
                ),
                child:Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.network(mainProvider.postDetails.user.photo??ServicesConfig.default_image,width: 35,height: 35,fit: BoxFit.fill),
                            ),
                            SizedBox(width: 10,),
                            Text(mainProvider.postDetails.user.name,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.brown),)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(mainProvider.postDetails.createdAt,style: TextStyle(fontSize: 10,color: Colors.black45),),
                        )
                      ],
                    ),
                    Container(
                      width: w,
                      child: Text(mainProvider.postDetails.content,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            if(mainProvider.postDetails.youLiked==false){
                              mainProvider.AddLike(mainProvider.postDetails.id);
                              setState(() {
                                mainProvider.postDetails.youLiked=true;
                                mainProvider.postDetails.likesCount++;
                              });
                            }
                            else{
                              setState(() {
                                mainProvider.postDetails.youLiked=false;
                                mainProvider.postDetails.likesCount--;
                              });
                            }
                          },
                          child: Container(
                            width: w*.4,
                            height: h*.045,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12,width: .5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.only(left: w*.1,right: w*.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(mainProvider.postDetails.likesCount.toString()),
                                Icon(Icons.favorite,color: Colors.red)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: w*.4,
                          height: h*.045,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12,width: .5),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.only(left: w*.1,right: w*.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(mainProvider.postDetails.comments!.length.toString()),
                              Icon(Icons.comment,color: Colors.black45,)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              App.name==""? SizedBox(): Container(
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
                  //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: ()async{
                          setState(() {
                            loadingSend=true;
                          });
                          await mainProvider.addComment(comment.text);
                          loadData();
                          if(mainProvider.connection==400){
                            FlutterToastr.show("تم اضافة التعليق", context);
                            setState(() {
                              loadingSend=false;
                              comment.text="";
                            });
                          }else{
                            FlutterToastr.show("هناك خطأ ما", context);
                          }
                        },
                        child: Icon(Icons.send,)),
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
                    hintText:"اكتب التعليق الخاص بك" ,
                    errorStyle: TextStyle(color: Colors.red,fontSize: 12),
                    hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                  ),
                  minLines: 3,maxLines: 4,
                  controller: comment,
                ),
              ),
              SizedBox(height: 10,),
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: mainProvider.postDetails.comments!.length,
                  padding: EdgeInsets.only(top: 0),
                  itemBuilder: (context,index)
               {
                 return GestureDetector(
                   onLongPress: (){
                     if(App.type=="admin"){
                       confirmDelete(context, mainProvider.postDetails.comments![index].id);
                     }
                   },
                   child: Container(
                     padding: EdgeInsets.only(left: w*.05,right: w*.05),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                           Row(
                             children: [
                               ClipRRect(
                                 borderRadius: BorderRadius.circular(1000),
                                 child: Image.network(mainProvider.postDetails.comments![index].user.photo??ServicesConfig.default_image,width: 25,height: 25,fit: BoxFit.fill),
                               ),
                               SizedBox(width: 10,),
                               Text(mainProvider.postDetails.comments![index].user.name,style: TextStyle(fontSize: 13,color: Colors.brown),)
                               ,SizedBox(width: 5,),
                               mainProvider.postDetails.comments![index].user.type=="admin"?Icon(Icons.check_circle,color: Colors.green,size: 17,):SizedBox()


                             ],
                           ),
                           Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: Text(mainProvider.postDetails.comments![index].createdAt,style: TextStyle(fontSize: 10,color: Colors.black45),),
                           )
                         ],),
                         SizedBox(height: 3,),
                         Container(
                           width: w,
                           padding: EdgeInsets.only(left: 10,right: 10),
                           child: Text(mainProvider.postDetails.comments![index].content,
                             style: TextStyle(fontSize: 11.5),
                           ),
                         ),
                         mainProvider.postDetails.comments!.length-1==index? SizedBox(height: 0,):Divider(thickness: .5,color: Colors.black12,)
                       ],
                     ),
                   ),
                 );
               }),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
  confirmDelete(BuildContext context,var id) {
    final mainProvider= Provider.of<MainProvider>(context, listen: false);
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
                      Icon(Icons.delete_outline,size: 45,color: Colors.red,),
                      SizedBox(height: 3,),
                      Text("تـأكيد مسح هذا العنصر",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
                           await mainProvider.delete(id,context);
                            loadData();
                            Navigator.pop(context);
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
