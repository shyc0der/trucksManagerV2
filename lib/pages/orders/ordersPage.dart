import 'package:flutter/material.dart';


import 'package:truck_manager/pages/color.dart';


import 'package:truck_manager/pages/expenses/expensesListPage.dart';


import 'package:truck_manager/pages/jobs/jobsListPage.dart';


import 'package:truck_manager/pages/orders/ordersListPage.dart';


import 'package:truck_manager/pages/vehicles/vehicleListPage.dart';



class OrdersPage extends StatefulWidget {

  const OrdersPage({super.key});


  @override

  State<OrdersPage> createState() => _OrdersPageState();

}


class _OrdersPageState extends State<OrdersPage>

    with SingleTickerProviderStateMixin {



  int _currentIndex = 0;


  late final TabController tabController;




  late final TextEditingController searchTextController;


  @override

  void initState() {
    super.initState();
   


    searchTextController = TextEditingController();


    tabController =

        TabController(length: 4, vsync: this, initialIndex: _currentIndex);
   

    tabController.addListener(() {

      if (mounted) {

        setState(() {

          _currentIndex = tabController.index;

        });

      }

    });


  }

  @override

  void dispose() {

    tabController.dispose();


    super.dispose();

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

   appBar:  AppBar(

        // automaticallyImplyLeading: false ,


        backgroundColor: HexColor("#00877D"),


        elevation: 2,


        title: const Padding(

          padding: EdgeInsets.only(bottom: 8.0),

          child: Text(

            "Orders",

            style: TextStyle(color: Colors.white),

          ),

        ),

      ),

      body: Column(

        children: [

          Container(

            height: 30,

            decoration: const BoxDecoration(

                shape: BoxShape.rectangle,

                boxShadow: [

                  BoxShadow(offset: Offset(0.5, 0.5), color: Colors.green)

                ],

                color: Colors.white),

            child: TabBar(

              controller: tabController,

              physics: const NeverScrollableScrollPhysics(),

              labelColor: HexColor("#00877D"),

              unselectedLabelColor: Colors.black,

              tabs: const [

                Text(

                  "Orders",

                  style: TextStyle(fontSize: 11),

                ),

                Text(

                  "Jobs",

                  style: TextStyle(fontSize: 11),

                ),

                Text(

                  "Expenses",

                  style: TextStyle(fontSize: 11),

                ),

                Text(

                  "Vehicles",

                  style: TextStyle(fontSize: 11),

                ),

              ],

            ),

          ),

          Expanded(

            child: TabBarView(

              controller: tabController,

              children: const [

                OrdersListPage(),

                JobsListPage(),

                ExpensesListPage(),

                VehiclesListPage(),

              ],

            ),

          ),
    
        ],

      ),

    );

  }

}

