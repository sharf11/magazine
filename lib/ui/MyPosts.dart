import 'package:magazine/AppTheme.dart';
import 'package:magazine/config/GlobalFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magazine/ui/Custom/CustomAppBar.dart';
import 'package:magazine/ui/PostDetails.dart';
import 'package:provider/provider.dart';

import '../Provider/MainProvider.dart';

class MyPosts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<MyPosts>{
  bool loading=true;
  loadData()async{
    final mainProvider= Provider.of<MainProvider>(context, listen: false);
    await mainProvider.getMyPosts();
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
  @override
  Widget build(BuildContext context) {
    final mainProvider= Provider.of<MainProvider>(context, listen: true);
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Scaffold(
        body:Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            child: Column(
              children: [
          CustomAppBar(Title: "مقالاتي"),
                loading?Expanded(child: Center(child: CircularProgressIndicator.adaptive(),)) :
                mainProvider.myposts.length==0?Expanded(child: Center(child: Text("لا يوجد اسئلة",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black38),),),):
                Expanded(child: ListView.builder(
                    itemCount: mainProvider.myposts.length,
                    padding: EdgeInsets.only(top: 0),
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(PostDetails(id: mainProvider.myposts[index].id,)));
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

                              Container(
                                width: w,
                                child: Text(mainProvider.myposts[index].content,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
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
                                        Text(mainProvider.myposts[index].likes.length.toString()),
                                        Icon(Icons.favorite,color:Colors.red)
                                      ],
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
                                        Text(mainProvider.myposts[index].comments!.length.toString()),
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
                    }))
              ],
            ),
          ),
        )
    );
  }
}