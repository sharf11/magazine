import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/io_client.dart';
import 'package:magazine/Provider/MainProvider.dart';
import 'package:magazine/Provider/ServicesConfig.dart';
import 'package:magazine/ui/Splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppTheme.dart';
import 'Provider/AuthProvider.dart';
import 'config/Routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  static int type=1;
  @override
  _MyAppState createState() => _MyAppState();


}
class _MyAppState extends State<MyApp>{

  late Locale local;
  final GlobalKey<NavigatorState> navKey = GlobalKey();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  var title = '';
  var body = {};
  var lang;
  void firebaseCloudMessaging_Listeners() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var android = new AndroidInitializationSettings('mipmap/launcher_icon');
    var ios;/* = new IOSInitializationSettings();*/
    var platform = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    if (Platform.isIOS) iOS_Permission();
    await messaging
        .getToken(
      vapidKey:
      "BIzkpc07ZYbnBYtYkbLI4yXsNIGM_51KQUhKvDWMIge1cH74in7pZhXaf6gnzSohljMqoHbQfwYMWzqdzdquk1c",
    )
        .then((token) {
      sharedPreferences.setString(
          "fcmToken", token!);
      print(token);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.notification}');
      showNotification(message.notification);
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  showNotification(RemoteNotification?  msg) async {
    print("enter show notification");
    var android = new AndroidNotificationDetails(
        "1", "channelName",channelDescription: "channelDescription");
    var iOS ;/* = new IOSNotificationDetails();*/
    var platform = new NotificationDetails(android: android, iOS: iOS);


    title = msg!.title!;
    body =  {"body":msg.body};
    setState(() {});


    await flutterLocalNotificationsPlugin.show(
        0,
        "${msg.title}",
        "${msg.body}",
        platform);
  }

  void iOS_Permission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }
  @override
  void initState() {
    setState(() {
      //  appPushNotifications.notificationSetup(navKey);
    });
    firebaseCloudMessaging_Listeners();
    iOS_Permission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider(),),
          ChangeNotifierProvider.value(value: MainProvider(),),
        ],
        child: MaterialApp(
                /* localizationsDelegates: translator.delegates,
        locale: local,
        supportedLocales: translator.locals(),*/
                navigatorKey: navKey,
                routes: Routes.routes,
                debugShowCheckedModeBanner: false,
                home: App(),
              ),
            );
  }

}
class App extends StatelessWidget {
  static String name ="";
  static String  Id="0";
  static String  Image=ServicesConfig.default_image;
  static String  type="user";

  static String AppLang="";
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType();

    // ignore: invalid_use_of_protected_member
    state!.setState(() => state.local = newLocale);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.routes,
      theme: ThemeData(
          fontFamily: 'cairo',
          accentColor: AppTheme.primaryColor
      ),
      home: Splash(),
    );
  }
}


