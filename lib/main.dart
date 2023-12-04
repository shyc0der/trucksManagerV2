import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:truck_manager/pages/homePage.dart';
import 'package:truck_manager/theme-data.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB4M39W4hnZh7HRzJu65QXSvk-7Bt-rPCA",
      authDomain: "http://trucks-c05a8.firebaseapp.com",
      appId: "1:834602052606:android:3ed2f2a40feeb21c682eaf",
      messagingSenderId: "834602052606", 
      projectId: "trucks-c05a8",
      databaseURL: "https://trucks-c05a8.firebaseio.com",
      storageBucket: "trucks-c05a8.appspot.com",
      measurementId: "G-6CQQ394FHP",
      )
  ).whenComplete(() {});
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,      
      home:  const HomePage(),
    );
  }
}

