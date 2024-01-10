import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:truck_manager/pages/color.dart';


import 'package:truck_manager/pages/loginPage.dart';


import 'package:truck_manager/pages/models/fireBaseModel.dart';
import 'package:truck_manager/pages/modules/expenses_modules.dart';
import 'package:truck_manager/pages/modules/job_module.dart';


import 'package:truck_manager/pages/modules/order_modules.dart';
import 'package:truck_manager/pages/modules/trucks_modules.dart';


import 'package:truck_manager/pages/modules/userModules.dart';
import 'package:truck_manager/pages/orders/ordersPage.dart';
import 'package:truck_manager/pages/reports/filters_widgets/all_expenses_filter.dart';
import 'package:truck_manager/pages/reports/filters_widgets/all_jobs_filter.dart';
import 'package:truck_manager/pages/reports/filters_widgets/expense_per_v_filter.dart';
import 'package:truck_manager/pages/reports/filters_widgets/jobs_per_v_filter.dart';
import 'package:truck_manager/pages/reports/filters_widgets/orders_filter.dart';


import 'package:truck_manager/pages/ui/pages/reports/reports_page.dart';

import 'package:truck_manager/pages/users/usersPage.dart';




import 'reports/reports_drawer_page.dart';


class HomePage2 extends StatefulWidget {

  const HomePage2({super.key});


  @override

  State<HomePage2> createState() => _HomePageState();

}


class _HomePageState extends State<HomePage2>

    with SingleTickerProviderStateMixin {

  late final TabController _tabController;


  final UserModule userModule = Get.find<UserModule>();
  final OrderModules _orderModules = Get.put(OrderModules());
  final JobModule _jobModule = Get.put(JobModule());

  final ExpenseModule _expenseModule = Get.put(ExpenseModule());

  final TruckModules _truckModules = Get.put(TruckModules());






  @override

  void initState() {

    super.initState();

    //tenantId = getTenantId();


  _orderModules.init(userModule.currentUser.value, userModule.currentUser.value.tenantId);

     _orderModules.init(userModule.currentUser.value, userModule.currentUser.value.tenantId);


    _jobModule.init(userModule.currentUser.value);

    _truckModules.init(userModule.currentUser.value.tenantId);

    _expenseModule.init(userModule.currentUser.value, userModule.currentUser.value.tenantId);

   
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);


    _tabController.addListener(() {

      setState(() {});

    });




    // initPlatformState();

  }


  // Future<void> initPlatformState() async {


  //   _setPath();


  //   if (!mounted) return;


  // }


  // void _setPath() async {


  //   path = (await getExternalStorageDirectory())!.path;


  // }


  @override

  void dispose() {

    _tabController.dispose();


    super.dispose();
     

  }


  bool isCollapsed = true;


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
   
  

      // appBar: AppBar(

      //   centerTitle: true,

      //   actions: <Widget>[

      //     IconButton(

      //         onPressed: () async {

      //           // options = DownloaderUtils(


      //           //   progress: ProgressImplementation(),


      //           //   file: File('$path/trucksApp.apk'),


      //           //   onDone: () => print('COMPLETE'),


      //           //   progressCallback: ((count, total) {


      //           //     final progress = (count / total) * 100;


      //           //     print('DownLoading: $progress');


      //           //   }),


      //           //   deleteOnCancel: true,


      //           // );


      //           // core = await Flowder.download('https://drive.google.com/file/d/1fDWE2SBKfJiJl9WusApTuMZlV5qOcJZl/view?usp=share_link', options);

      //         },

      //         icon: const Icon(Icons.update_outlined)),

      //   ],

      //   title: Text(userModule.currentUser.value.role == 'driver'

      //       ? '${userModule.currentUser.value.firstName} ${userModule.currentUser.value.lastName}'

      //       : 'Truck Manager'),

      // ),


      body: TabBarView(controller: _tabController, children: [

        // reports page


        const OrdersPage(),


        // users page


       const  UsersPage2(),


        //if(_userModule.isSuperUser.value)


        ReportsPage(),

      ]),


      bottomNavigationBar: BottomNavigationBar(
         type: BottomNavigationBarType.fixed,

        currentIndex: _tabController.index,

        onTap: (int val) {

          setState(() {

            _tabController.index = val;

          });

        },

        items: const [

          BottomNavigationBarItem(

              icon: Icon(Icons.work_history_outlined), label: 'DashBoard'),

          BottomNavigationBarItem(

              icon: Icon(Icons.person_add_alt_1_outlined), label: 'Manage'),

          BottomNavigationBarItem(

              icon: Icon(Icons.pie_chart_outline), label: 'Reports'),BottomNavigationBarItem(

              icon: Icon(Icons.person_outline_outlined), label: 'Account'),

        ],

      ),

    );

  }

}

