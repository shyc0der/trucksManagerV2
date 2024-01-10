import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:truck_manager/pages/homePage.dart';

import 'package:truck_manager/pages/models/fireBaseModel.dart';

import 'package:truck_manager/pages/models/model.dart';
import 'package:truck_manager/pages/modules/expense_type_module.dart';

import 'package:truck_manager/pages/modules/job_module.dart';

import 'package:truck_manager/pages/modules/order_modules.dart';

import 'package:truck_manager/pages/modules/trucks_modules.dart';

import 'package:truck_manager/pages/modules/userModules.dart';

import 'package:truck_manager/pages/ui/pages/home_page.dart';
import 'package:truck_manager/pages/ui/reports/expenses_per_vehicle.dart';
import 'package:truck_manager/pages/ui/reports/expenses_reports.dart';
import 'package:truck_manager/pages/ui/reports/jobs_per_vehicle_report.dart';
import 'package:truck_manager/pages/ui/reports/jobs_reports.dart';
import 'package:truck_manager/pages/ui/reports/orders_reports.dart';

import 'package:truck_manager/theme-data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Model.initiateDbs("trucks-c05a8");
  

  Get.put(OrderModules());

  Get.put(UserModule());

  Get.put(JobModule());

  Get.put(TruckModules());
  Get.put(OrderReportController());
  Get.put(ExpensesPerVehicleReportController());
  Get.put(ExpensesReportController());
  Get.put(JobsPerVehicleReportController());
  Get.put(AllJobsReportController());
  Get.put(ExpenseTypeModule());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final UserModule userModule = Get.put(UserModule());

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2));
    return StreamBuilder<User?>(
        stream: FirebaseUserModule.userLoginState(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const GetMaterialApp(
                  home: Material(
                      child: Center(child: LinearProgressIndicator())));

            case ConnectionState.none:
              return const GetMaterialApp(
                  home: Material(child: Text('no connection')));

            default:
              if (snapshot.data != null) {
               
                userModule.setCurrentUser(snapshot.data!.uid.toString());

                return GetMaterialApp(
                    theme: themeData, home: const HomePage2());
              } else {
                return GetMaterialApp(theme: themeData, home: const HomePage());
              }
          }
        });
  }
}
