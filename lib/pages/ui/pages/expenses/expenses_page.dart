// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:intl/intl.dart';


import 'package:truck_manager/pages/modules/expenses_modules.dart';


import 'package:truck_manager/pages/modules/trucks_modules.dart';


import 'package:truck_manager/pages/modules/userModules.dart';


import 'package:truck_manager/pages/ui/pages/expenses/expense_details_page.dart';


import 'package:truck_manager/pages/ui/widgets/constants.dart';


import 'package:truck_manager/pages/ui/widgets/expenses_list_tile_widget.dart';



import '../../../models/expenses_model.dart';


import '../../widgets/dismiss_widget.dart';


class ExpensesPage extends StatefulWidget {

  ExpensesPage(this.state, {Key? key}) : super(key: key);


  String state;


  @override

  State<ExpensesPage> createState() => _ExpensesPageState();

}


class _ExpensesPageState extends State<ExpensesPage> {

  final ExpenseModule expenseModule = Get.put(ExpenseModule());


  UserModule userModule = Get.put(UserModule());


  TruckModules truckModules = Get.put(TruckModules());


  NumberFormat doubleFormat = NumberFormat.decimalPattern('en_us');


  Constants constants = Constants();


  @override

  void initState() {

    super.initState();

  }


  Future<bool> _dismissDialog(ExpenseModel expenseModel) async {

    bool? delete = await dismissWidget('${expenseModel.expenseType}','Expense');


    if (delete == true) {

      await expenseModule.deleteExpenses(expenseModel.id!);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(

        content: Text("Expenses Deleted!"),

      ));

    }

    return delete == true;

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        centerTitle: true,

        title: const Text('Expenses'),

        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],

      ),

      body: 
      StreamBuilder<List<ExpenseModel>>(

          stream: expenseModule.fetchByExpensesByState(

              widget.state, userModule.currentUser.value, userModule.currentUser.value.tenantId!),

          builder: (context, snapshot) {

            if (snapshot.hasError) {

              return Text('Error = ${snapshot.error}');

            }

            if (snapshot.hasData) {

              var displayExpenses = snapshot.data!;

              return ListView.builder(

                itemCount: displayExpenses.length,

                itemBuilder: (_, index) {

                  return ExpensesListTile(

                    title: displayExpenses[index].expenseType ?? '',

                    truckNumber: constants

                        .truckNumber(displayExpenses[index].truckId ?? ''),

                    driverName: constants

                        .driverName(displayExpenses[index].userId ?? ''),

                    dateTime: displayExpenses[index].date,

                    amount: doubleFormat.format((double.tryParse(

                        displayExpenses[index].totalAmount ?? '0'))),

                    expenseState: displayExpenses[index].expensesState,

                    onDoubleTap: (() async {
                       userModule.currentUser.value.role == "admin" ?
                        await _dismissDialog(snapshot.data![index]) :
                                        ();


                    }),

                    onTap: () {

                      Navigator.of(context).push(MaterialPageRoute(

                          builder: (_) =>

                              ExpenseDetailsPage(displayExpenses[index])));

                    },

                  );

                },

              );

            } else {

              return const Center(

                child: CircularProgressIndicator(),

              );

            }

          }),

    );

  }

}

