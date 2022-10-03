import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AppTheme.dart';
import 'MainPage.dart';
import 'Profile.dart';
import 'Notifications.dart';
class Home extends StatefulWidget {
  int index;
  Home({required this.index});
  @override
  _State createState() => _State(index: this.index);
}
class _State extends State<Home> {
  int index;
  _State({required this.index});
  int _currentIndex=2;
  List<Widget>itemsUi=[
    Profile(),
    Notifications(),
    MainPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _currentIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body:Directionality(
            textDirection: TextDirection.rtl,
            child: itemsUi[_currentIndex]) ,
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            backgroundColor: AppTheme.primaryColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.cyan,
            selectedFontSize: 12,
            unselectedItemColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                // print('${index}index');
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/user.png"),size: 22,),
                  label: "حسابي"),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/Notification.png"),size: 22,),
                  label: "الاشعارات"),
              BottomNavigationBarItem(
                  icon:ImageIcon(AssetImage("assets/images/home.png"),size: 22,),
                  label:  "الرئيسية"),


            ]),);
  }
}