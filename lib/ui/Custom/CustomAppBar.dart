import 'package:magazine/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  String Title="";
  CustomAppBar({required this.Title});
  @override
  Widget build(BuildContext context) {
   return Container(
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
                 Navigator.pop(context);
               },
               child: Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Icon(Icons.arrow_back_ios,color: Colors.white,),
               ),
             ),
             Text(this.Title,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
             Padding(
               padding: const EdgeInsets.all(5.0),
               child: Icon(Icons.arrow_back_ios,color: AppTheme.primaryColor,),
             ),
           ],
         ),
         SizedBox(height: MediaQuery.of(context).size.height*.02,),
       ],
     ),
   );
  }
}