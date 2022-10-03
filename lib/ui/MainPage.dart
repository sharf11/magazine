import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:magazine/AppTheme.dart';
import 'package:magazine/config/GlobalFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magazine/main.dart';
import 'package:magazine/ui/Notifications.dart';
import 'package:magazine/ui/PostDetails.dart';
import 'package:provider/provider.dart';

import '../Provider/MainProvider.dart';
import '../Provider/ServicesConfig.dart';
import 'AddPost.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _state();
  }
}
class _state extends State<MainPage>{
  TextEditingController post =new TextEditingController();
  bool loading=true;
  ScrollController _scrollController =new ScrollController();
  bool loadingScroll=false;
  int page=1;
  LoadingScroll() async {
    loadingScroll=true;

    setState(() {
      page=page+1;
    });
    var mainProvider= Provider.of<MainProvider>(context, listen: false);
    await mainProvider.getPosts(page);
    setState(() {
      loadingScroll=false;
    });
  }
  loadData()async{
    final mainProvider= Provider.of<MainProvider>(context, listen: false);
    await mainProvider.getPosts(page);
    setState(() {
      loading=false;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        LoadingScroll();
      }
    });
  }
  bool loadingSend=false;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    final mainProvider= Provider.of<MainProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: ()async{
        confirmCloseApp(context);
        return true;
      },
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
             Container(
               //height: MediaQuery.of(context).size.height*.13,
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
                   bottom: MediaQuery.of(context).size.height*.015
               ),
               child: Column(
                 children: [
                   SizedBox(height: MediaQuery.of(context).size.height*.04,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
             /*          GestureDetector(
                         onTap: (){
                           Navigator.push(context, GlobalFunction.routeBottom(AddPost()));
                         },
                         child: Container(
                           width: 40,height: 40,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(100),
                             color: Colors.white
                           ),
                           child: Icon(Icons.question_mark,color: AppTheme.primaryColor,),
                         ),
                       ),*/
                       Image.asset("assets/images/rqeeqa 2.png",height: 65,width: 65,),
                  /**/     /*GestureDetector(
                         onTap: (){
                           Navigator.push(context, GlobalFunction.routeBottom(Notifications()));
                         },
                         child: Container(
                           width: 40,height: 40,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(100),
                               color: Colors.white
                           ),
                           child: Icon(Icons.notifications,color: AppTheme.primaryColor,),
                         ),
                       ),*/
                    //   Text("الرئيسية",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
                     ],
                   ),
                   SizedBox(height: MediaQuery.of(context).size.height*.01,),
                 ],
               ),
             ),
             App.name==""? SizedBox():Container(
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
                         await mainProvider.createPosts(post.text);
                         await mainProvider.getPosts(1);
                         setState(() {
                           post.text="";
                           loadingSend=false;
                         });
                        },
                        child: Icon(Icons.send,color:loadingSend? Colors.black12:AppTheme.primaryColor,)),
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
                    hintText:"قم بطرح سؤالك من هنا " ,
                    errorStyle: TextStyle(color: Colors.red,fontSize: 12),
                    hintStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 12),
                  ),
                  minLines: 3,maxLines: 4,
                  controller: post,
                ),
              ),
           /*   GestureDetector(
                onTap: (){
                  Navigator.push(context, GlobalFunction.routeBottom(AddPost()));
                },
                 child: Container(
                 //  height: MediaQuery.of(context).size.height * .2,
                   width: MediaQuery.of(context).size.width*.9,
                   margin: EdgeInsets.only(
                     left: MediaQuery.of(context).size.width*.05,
                     right: MediaQuery.of(context).size.width*.05,
                   ),
                   padding: EdgeInsets.only(
                     left: MediaQuery.of(context).size.width*.025,
                     right: MediaQuery.of(context).size.width*.025,
                     top: 10,bottom: 10
                   ),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     border: Border.all(color: Colors.black12,width: 1),
                     color: Colors.white,
                   ),
                   child: Row(
                     children: [
                       Icon(Icons.edit,color: Colors.black38,size: 20,),
                       SizedBox(width: 10,),
                       Text("قم باضافة سؤالك",style: TextStyle(color: Colors.black54,fontSize: 12),)
                     ],
                   ),
                 ),
               ),*/
             /* Container(
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CarouselSlider.builder(
                  itemCount:3,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12,width: 1)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .2,
                            width: MediaQuery.of(context).size.width*.9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset("assets/images/splash.png",
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height * .2,
                                width: MediaQuery.of(context).size.width*.9,
                              ),
                            ),
                          ),
                        ),
                      ),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 600),
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    aspectRatio: .7,
                    initialPage: 2,
                  ),
                ),
              ),*/
            loading? Expanded(child: Center(child: CircularProgressIndicator.adaptive(),),):mainProvider.posts.length==0?
            Expanded(child: Center(child: Text("لا يوجد اسئلة",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black38),),),):Expanded(child: ListView.builder(
              itemCount: mainProvider.posts.length,
                controller: _scrollController,
              padding: EdgeInsets.only(top: 15),
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                   Navigator.push(context, GlobalFunction.route(PostDetails(id: mainProvider.posts[index].id,)));
                  },
                  onLongPress: (){
                    if(App.type=="admin"){
                      confirmDelete(context, mainProvider.posts[index].id);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12,width: 1)
                    ),
                    margin:EdgeInsets.only(
                      left: w*.05,right: w*.05,bottom: h*.015
                    ) ,
                    padding: EdgeInsets.only(
                        left: w*.02,right: w*.02,top: h*.01,bottom: h*.01
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
                                   child: Image.network(mainProvider.posts[index].user.photo??ServicesConfig.default_image,width: 35,height: 35,fit: BoxFit.fill,),
                                 ),
                                 SizedBox(width: 10,),
                                 Text(mainProvider.posts[index].user.name,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.brown),)
                                 ,SizedBox(width: 5,),
                                 mainProvider.posts[index].user.type=="admin"?Icon(Icons.check_circle,color: Colors.green,size: 20,):SizedBox()
                               ],
                             ),
                             Padding(
                               padding: const EdgeInsets.all(5.0),
                               child: Text(mainProvider.posts[index].createdAt,style: TextStyle(fontSize: 10,color: Colors.black45),),
                             )
                           ],
                         ),
                        SizedBox(height: 5,),
                        Container(
                          width: w,

                          child: Text(mainProvider.posts[index].content,maxLines: 4,overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                if(mainProvider.posts[index].youLiked==false){
                                  mainProvider.AddLike(mainProvider.posts[index].id);
                                  setState(() {
                                    mainProvider.posts[index].youLiked=true;
                                    mainProvider.posts[index].likesCount++;
                                  });
                                }
                                else{
                                  setState(() {
                                    mainProvider.posts[index].youLiked=false;
                                    mainProvider.posts[index].likesCount--;
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
                                    Text(mainProvider.posts[index].likesCount.toString()),
                                    Icon(mainProvider.posts[index].youLiked?Icons.favorite:Icons.favorite_outline,color: mainProvider.posts[index].youLiked?Colors.red:Colors.black38,)
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
                                  Text(mainProvider.posts[index].comments!.length.toString()),
                                  Icon(Icons.comment,color: Colors.black45,)
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })),
              loadingScroll?Container(width: w*.9,height: 50,color:Colors.white,child: Align(alignment: Alignment.topCenter,child: CircularProgressIndicator(),))
                  :SizedBox(height: 0,)
            ],
          ),
        )
      ),
    );
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
                      Icon(Icons.warning_amber_sharp,size: 45,color: Colors.red,),
                      SizedBox(height: 3,),
                      Text("هل تريد اغلاق التطبيق",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
                            SystemNavigator.pop();
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
                          await   mainProvider.delete(id,context);
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