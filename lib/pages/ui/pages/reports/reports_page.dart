// ignore_for_file: must_be_immutable


import 'package:collection/collection.dart';


import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:intl/intl.dart';
import 'package:truck_manager/pages/color.dart';
import 'package:truck_manager/pages/loginPage.dart';


import 'package:truck_manager/pages/models/expenses_model.dart';
import 'package:truck_manager/pages/models/fireBaseModel.dart';


import 'package:truck_manager/pages/models/trucks_model.dart';


import 'package:truck_manager/pages/modules/expenses_modules.dart';


import 'package:truck_manager/pages/modules/trucks_modules.dart';
import 'package:truck_manager/pages/modules/userModules.dart';
import 'package:truck_manager/pages/reports/filters_widgets/all_expenses_filter.dart';
import 'package:truck_manager/pages/reports/filters_widgets/all_jobs_filter.dart';
import 'package:truck_manager/pages/reports/filters_widgets/expense_per_v_filter.dart';
import 'package:truck_manager/pages/reports/filters_widgets/jobs_per_v_filter.dart';
import 'package:truck_manager/pages/reports/filters_widgets/orders_filter.dart';


import 'package:truck_manager/pages/ui/pages/reports/order_report.dart';


import 'package:truck_manager/pages/ui/pages/reports/reports_details_page.dart';
import 'package:truck_manager/pages/ui/pages/reports/reports_drawer_page.dart';


import 'package:truck_manager/pages/ui/widgets/item_card_widget.dart';


import 'expense_report.dart';
class ReportsPage extends StatefulWidget {

  const ReportsPage({super.key});


  @override

  State<ReportsPage> createState() => ReportsPageState();

}

class ReportsPageState extends State<ReportsPage> {

 
 final ExpenseModule _expenseModule = Get.put(ExpenseModule());
final UserModule userModule = Get.find<UserModule>();


  final TruckModules _truckModules = Get.put(TruckModules());


  NumberFormat doubleFormat = NumberFormat.decimalPattern('en_us');


  double jobAmount = 0;


  Map<String?, dynamic> amountsPerOrderTitle = {};
    bool isCollapsed = true;


  Map<String?, dynamic> amountsPerExpenseType = {};


  Map<String?, dynamic> amountsPerTrucksType = {};


  @override

  Widget build(BuildContext context) {

    return Scaffold(
            drawer: Drawer(

        child: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            Container(

              height: 30,

            ),


            ListTile(

              leading: const Icon(Icons.bar_chart_outlined),

              title: const Text('Reports'),

              trailing: Icon(

                  isCollapsed ? Icons.arrow_drop_down : Icons.arrow_drop_up),

              onTap: () {
                

                setState(() {

                  isCollapsed = !isCollapsed;

                });

              },

            ),


            // items


            if (!isCollapsed)

              Container(

                padding: const EdgeInsets.only(left: 15),

                height: 330,

                child: ListView(

                  // mainAxisSize: MainAxisSize.min,


                  children: [

                       ListTile(
                      title: const Text('Expenses per Vehicle'),
                      onTap: () {
                       
                        Get.to(const ReportsDrawerPage(
                          filterWidget: ExpensePerVehicleFilterWidget(),
                        ));
                      },
                    ),
                    ListTile(
                      title: const Text('All Expenses'),
                      onTap: () {
                        Get.to(const ReportsDrawerPage(
                          filterWidget: AllExpensesFilterWidget(),
                        ));
                      },
                    ),
                    ListTile(
                      title: const Text('Jobs per Vehicle'),
                      onTap: () {
                        
                        Get.to(const ReportsDrawerPage(
                          filterWidget: JobsPerVehicleFilterWidget(),
                        ));
                      },
                    ),
                    ListTile(
                      title: const Text('All Jobs'),
                      onTap: () {
                        
                        Get.to(const ReportsDrawerPage(
                          filterWidget: AllJobsFilterWidget(),
                        ));
                      },
                    ),
                    ListTile(
                      title: const Text('Orders'),
                      onTap: () {
                        
                        Get.to(const ReportsDrawerPage(
                          filterWidget: AllOrdersFilterWidget(),
                        ));
                      },
                    ),
           

                  ],

                ),

              ),


            Expanded(

              child: Align(

                alignment: FractionalOffset.bottomCenter,

                child: ListTile(

                  leading: const Icon(Icons.logout_outlined),

                  title: const Text('Logout'),

                  tileColor: Colors.greenAccent.withOpacity(.4),

                  onTap: () async {

                    // logout


                    await FirebaseUserModule.logout();


                    await Future.delayed(const Duration(seconds: 1));


                    await userModule.setCurrentUser('');


                    // navigate to login


                    await Future.delayed(const Duration(seconds: 3));


                    Get.offAll(const LoginPage());


                    // ignore: use_build_context_synchronously


                    // Navigator.push(


                    //     context,


                    //     MaterialPageRoute(


                    //         builder: ((context) => const LoginPage())));

                  },

                ),

              ),

            ),


            const SizedBox(

              height: 2,

            ),

          ],

        ),

      ), //reports pages
   
        appBar:  AppBar(

        // automaticallyImplyLeading: false ,


        backgroundColor: HexColor("#00877D"),


        elevation: 2,


        title: const Padding(

          padding: EdgeInsets.only(bottom: 8.0),

          child: Text(

            "Reports",

            style: TextStyle(color: Colors.white),

          ),

        ),

      ),

      body: Column(
      
        children: [
      
          Padding(
      
            padding: const EdgeInsets.symmetric(vertical: 15),
      
            child: Text(
      
              "Reports",
      
              style: Theme.of(context).textTheme.headline5,
      
            ),
      
          ),
      
          Align(
      
            alignment: Alignment.topCenter,
      
            child: Wrap(
      
              children: [
      
                // jobs
      
      
                ItemCardWidget(
      
                  label: 'Orders',
      
                  iconData: Icons.work_outline,
      
                  onTap: () {
      
                    Navigator.of(context).push(MaterialPageRoute(
      
                        builder: (_) => const OrderReportPage()));
      
                  },
      
                ),
      
      
                // expenses
      
      
                StreamBuilder<List<ExpenseModel>>(
      
                    stream: _expenseModule.fetchExpenses(userModule.currentUser.value.tenantId!),
      
                    builder: (context, snapshot) {
      
                      return ItemCardWidget(
      
                        label: 'Expenses',
      
                        iconData: Icons.account_balance_wallet_outlined,
      
                        onTap: () {
      
                          var data = snapshot.data ?? [];
      
      
                          var totalAmount = data.fold<double>(
      
                              0.0,
      
                              (amount, expense) =>
      
                                  amount +
      
                                  (double.tryParse(expense.totalAmount!) ?? 0.0));
      
      
                          amountsPerExpenseType
      
                              .addAll({'All': totalAmount.ceilToDouble()});
      
      
                          var newMap = groupBy(
      
                              data,
      
                              (ExpenseModel expenseModel) =>
      
                                  expenseModel.expenseType);
      
      
                          newMap.forEach((key, value) {
      
                            var tes = value.fold<double>(
      
                                0.0,
      
                                (previousValue, expense) =>
      
                                    previousValue +
      
                                    (double.tryParse(expense.totalAmount!) ??
      
                                        0.0));
      
      
                            amountsPerExpenseType.addAll({key: tes});
      
                          });
      
      
                          Navigator.of(context).push(MaterialPageRoute(
      
                              builder: (_) => const ExpenseReportPage()));
      
                        },
      
                      );
      
                    }),
      
      
                // trucks
      
      
                FutureBuilder<List<TrucksModel>>(
      
                    future: _truckModules.fetchTrucks(userModule.currentUser.value.tenantId!),
      
      
                    //expenses per truck
      
      
                    builder: (context, snapshot) {
      
                      var data = snapshot.data!;
      
      
                      return ItemCardWidget(
      
                        label: 'Trucks',
      
                        iconData: Icons.local_shipping_outlined,
      
                        onTap: () {
      
                          Navigator.of(context).push(MaterialPageRoute(
      
                              builder: (_) => ReportsDetailsPage(
      
                                    title: 'Trucks',
      
                                    items: [
      
                                      for (int i = 0; i < data.length; i++)
      
                                        ReportItemModel(
      
                                          label: data[i].vehicleRegNo!,
      
      
                                          amount: data[i].reportTotal[0],
      
      
                                          //data[i].getTotalExpense(DateTimeRange(start: DateTime.now().subtract(const Duration(days: 30)),
      
      
                                          // end: DateTime.now())),
      
      
                                          expense: data[i].reportTotal[1],
      
                                        ),
      
                                    ],
      
                                  )));
      
                        },
      
                      );
      
                    }),
      
      
                // users
      
      
                ItemCardWidget(
      
                  label: 'Drivers',
      
                  iconData: Icons.people_alt_outlined,
      
                  onTap: () {
      
                    Navigator.of(context).push(MaterialPageRoute(
      
                        builder: (_) => const ReportsDetailsPage(
      
                              title: 'Drivers',
      
                              items: [],
      
                            )));
      
                  },
      
                ),
      
              ],
      
            ),
      
          ),
      
        ],
      
      ),
    );

  }

}

