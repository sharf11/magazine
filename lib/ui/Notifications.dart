import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AppTheme.dart';
import '../Provider/MainProvider.dart';
import '../config/GlobalFunction.dart';
import 'PostDetails.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  bool loading=true;
  loadData()async{
    final mainProvider= Provider.of<MainProvider>(context, listen: false);
    await mainProvider.getNotifications();
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
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
        return true;
      },
      child: Scaffold(
          body: Container(
            child: Column(
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
                              Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                            ),
                          ),
                          Text("الاشعارات",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
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
              loading? Expanded(child: Center(child: CircularProgressIndicator.adaptive(),),):mainProvider.notifications.length==0?
              Expanded(child: Center(child: Text("لا يوجد اشعارات",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black38),),),):Expanded(child: ListView.builder(
                    itemCount: mainProvider.notifications.length,
                    padding: EdgeInsets.only(top: 0),
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(PostDetails(id: mainProvider.notifications[index].postId,)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black12,width: 1),

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
                               children: [
                                 Icon(Icons.notifications,color: Colors.red,),
                                 Container(
                                   width: w-80,
                                   child: Text(mainProvider.notifications[index].message,
                                     style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
                                   ),
                                 ),
                               ],
                             )
                            ],
                          ),
                        ),
                      );
                    }))
              ],
            ),
          )
      ),
    );
  }
}
