import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo/screens/alarm.dart';
import 'package:memo/screens/home.dart';
import 'package:memo/screens/homePage.dart';
import 'package:memo/screens/notes.dart';
import 'package:memo/screens/splash_screen.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: 'splashScreen',
      routes: ({
        'splashScreen' :(context) => Splash(),
         'homePage' :(context) => Homepage(),
         'home':(context) => Home(),
          'notes':(context) => Notes(),
          'alarmingpage':(context) => Alarm(),
      }),
    );
  }
}

