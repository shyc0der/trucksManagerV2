// ignore_for_file: use_build_context_synchronously, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truck_manager/components.dart';
import 'package:truck_manager/pages/models/expenseType.dart';
import 'package:truck_manager/pages/modules/expense_type_module.dart';
import 'package:truck_manager/pages/modules/userModules.dart';
import 'package:truck_manager/pages/ui/widgets/dismiss_widget.dart';
import 'package:truck_manager/pages/ui/widgets/input_fields.dart';

class ExpenseTypesPage extends StatefulWidget {
  const ExpenseTypesPage({Key? key}) : super(key: key);

  @override
  _ExpenseTypesPageState createState() => _ExpenseTypesPageState();
}

//Displays Expenses
class _ExpenseTypesPageState extends State<ExpenseTypesPage> {
  final ExpenseTypeModule _expenseModule = ExpenseTypeModule();
  final UserModule userModule = Get.find<UserModule>();



  Future<bool> _dismissDialog(ExpenseType expense) async {
    bool? delete = await dismissWidget('${expense.name}');
    bool shouldDelete = delete == true;
   
    

    var ifExists = await _expenseModule.checkIfExpenseTypeExists(
        expense.name ?? '', userModule.currentUser.value.tenantId!);

    if (ifExists == true) {
      shouldDelete = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Expense Type Can Not Be Deleted Since Its Already Used!"),
      ));
    }

    if (shouldDelete) {
      //if Expense Type does exists one cannnot delete an expense Type that is already tied to an expense

      await _expenseModule.deleteExpenseTpe(expense.id ?? '');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Expense Type Deleted!"),
      ));

      // delete from server
    }

    return shouldDelete;
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     
      floatingActionButton: CircleAvatar(
        backgroundColor: Colors.green,
        radius: 30,
        child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: AddExpenseTypeWidget(),
                    );
                  });
            },
            icon: const Icon(Icons.add)),
      ),
      body: StreamBuilder<List<ExpenseType?>>(
          stream: _expenseModule
              .fetchExpenseType(userModule.currentUser.value.tenantId!),
          builder: (context, snapshot) {
            var expenseTypes = snapshot.data ?? [];
            return Column(
              children: [
                 Padding(
                                  
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                                  
                                        child: Container(
                                  
                                          height: 130,
                                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                                  
                                          width: MediaQuery.of(context).size.height * 0.50,
                                  
                                          decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 243, 216, 234),
                        borderRadius: BorderRadius.circular(8)),
                                  
                                          child:  Padding(
                                  
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  
                                            child: 
                                            Column(
                                  
                        crossAxisAlignment: CrossAxisAlignment.start,
                                  
                        children: [
                                  
                          const Text(
                            "Expense Types",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                                  
                          Text(
                            expenseTypes.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                                  
                          ),
                                  
                        ],
                                  
                                            ),
                                  
                                          ),
                                  
                                        ),
                                  
                                      ),
                Expanded(
                  child: ListView.builder(
                    itemCount: (snapshot.data ?? []).length,
                    itemBuilder: (BuildContext context, int index) {
                      var expenseType = snapshot.data![index]!;
                      return GestureDetector(
                        onDoubleTap: () async {
                          // dismissDialog
                           _dismissDialog(expenseType);
                        },
                        key: ValueKey('$index-${expenseType.name}'),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                            child: ItemListTile(
                                      title:  expenseType.name ?? '',
                                      description: expenseType.name ?? '',
                                     
                                    ),
                            
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}

//ADD EXPENSES
class AddExpenseTypeWidget extends StatefulWidget {
  const AddExpenseTypeWidget({Key? key}) : super(key: key);

  @override
  _AddExpenseTypeWidgetState createState() => _AddExpenseTypeWidgetState();
}

class _AddExpenseTypeWidgetState extends State<AddExpenseTypeWidget> {
  ExpenseTypeModule expenseModule = ExpenseTypeModule();
  late final TextEditingController _addExpenseTypeController;
  final UserModule userModule = Get.find<UserModule>();

  bool _addExpenseError = false;

  @override
  void initState() {
    super.initState();
    _addExpenseTypeController = TextEditingController();
  }

  @override
  void dispose() {
    _addExpenseTypeController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add Expense Type',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          const SizedBox(
            height: 15,
          ),
          InputField(
              "Expense Type", _addExpenseTypeController, _addExpenseError,
              onChanged: (String val) {
            if (val.isNotEmpty) {
              setState(() {
                _addExpenseError = false;
              });
            }
          }),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // cancel
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('cancel')),
              ElevatedButton(
                  onPressed: () {
                    // check if input is empty
                    if (_addExpenseTypeController.text.isEmpty) {
                      setState(() {
                        _addExpenseError = true;
                      });
                    } else {
                      // proceed saving
                      expenseModule.addExpenseType(ExpenseType(
                        tenantId: userModule.currentUser.value.tenantId!,
                        name: _addExpenseTypeController.text,
                      ));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add'))
            ],
          )
        ],
      ),
    );
  }
}
