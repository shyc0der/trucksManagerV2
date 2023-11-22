import 'package:flutter/material.dart';
import 'package:truck_manager/pages/homePage.dart';
import 'package:truck_manager/pages/loginPage.dart';
import 'package:truck_manager/pages/ordersPage.dart';
import 'package:truck_manager/pages/siginInPage.dart';
import 'package:truck_manager/theme-data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,      
      home:  OrdersPage(),
    );
  }
}

