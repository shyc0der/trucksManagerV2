import 'package:flutter/material.dart';


import 'package:truck_manager/pages/color.dart';
import 'package:truck_manager/pages/expenseTypes/expenseTypesList.dart';
import 'package:truck_manager/pages/jobTypes/jobTypesList.dart';


import 'package:truck_manager/pages/users/customersListPage.dart';
import 'package:truck_manager/pages/users/usersListPage.dart';





class UsersPage2 extends StatefulWidget {

  const UsersPage2({super.key});


  @override

  State<UsersPage2> createState() => _UsersPage2State();

}


class _UsersPage2State extends State<UsersPage2>

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

            "Users",

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

                  "Customers",

                  style: TextStyle(fontSize: 11),

                ),

                Text(

                  "Users",

                  style: TextStyle(fontSize: 11),

                ),
                Text(

                  "Expense Types",

                  style: TextStyle(fontSize: 11),

                ),
                Text(

                  "Job Types",

                  style: TextStyle(fontSize: 11),

                ),



              ],

            ),

          ),

          Expanded(

            child: TabBarView(

              controller: tabController,

              children: const [

                CustomersListPage(),

                UsersListPage(),

                ExpenseTypesPage(),

                JobTypesPage(),


              ],

            ),

          ),
    
        ],

      ),

    );

  }

}

