// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers


import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:intl/intl.dart';


import 'package:truck_manager/pages/models/jobs_model.dart';


import 'package:truck_manager/pages/models/trucks_model.dart';


import 'package:truck_manager/pages/modules/expenses_modules.dart';


import 'package:truck_manager/pages/modules/job_module.dart';


import 'package:truck_manager/pages/modules/order_modules.dart';


import 'package:truck_manager/pages/modules/userModules.dart';


import 'package:truck_manager/pages/ui/pages/jobs/jobs_details_page.dart';


import 'package:truck_manager/pages/ui/widgets/constants.dart';


import 'package:truck_manager/pages/ui/widgets/expenses_list_tile_widget.dart';


import 'package:truck_manager/pages/ui/widgets/job_list_tile_widget.dart';


import 'package:truck_manager/pages/ui/widgets/truck_widget.dart';




import '../../../models/expenses_model.dart';


import '../expenses/add_expense_widget.dart';


import '../expenses/expense_details_page.dart';


class TruckDetailsPage extends StatefulWidget {

  const TruckDetailsPage(this.trucksModel, {Key? key}) : super(key: key);


  final TrucksModel? trucksModel;


  @override

  State<TruckDetailsPage> createState() => _TruckDetailsPageState();

}


class _TruckDetailsPageState extends State<TruckDetailsPage>

    with SingleTickerProviderStateMixin {

  late final TabController _tabController;


  final OrderModules _orderModules = OrderModules();

final UserModule userModule = Get.find<UserModule>();

  NumberFormat doubleFormat = NumberFormat.decimalPattern('en_us');


  Constants constants = Constants();


  @override

  void initState() {

    super.initState();


    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);


    _tabController.addListener(() {

      setState(() {});

    });

  }


  Future<double> getTotalJobAmount(String truckId) async {

    double amounts = 0;


    var trucks = await _orderModules.fetchOrderByTruckId(truckId, userModule.currentUser.value.tenantId!);


    for (var truck in trucks) {

      amounts += truck.amount ?? 0;

    }


    return amounts;

  }


  @override

  void dispose() {

    _tabController.dispose();


    super.dispose();

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
     
        centerTitle: true,

        title: const Text('Truck Details'),
        leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        // Navigate back when the IconButton is pressed.
        Navigator.pop(context);
      },
    ),

      ),

      body: Column(

        children: [

          // truck info


          FutureBuilder<double>(

              future: getTotalJobAmount(widget.trucksModel!.id!),

              builder: (context, snapshot) {

                return TruckWidget(

                    registration: widget.trucksModel!.vehicleRegNo ?? '',


                    //TO:DO CALCULATE AMOUNTS PER VEHICLE


                    jobsAmount: doubleFormat

                        .format((snapshot.data ?? 0).ceilToDouble()),

                    expensesAmount: 'Ksh. 50,000',

                    addExpense: () async {

                      await showDialog(

                          context: context,

                          builder: (BuildContext context) {

                            return Dialog(

                              child: AddExpenseWidget(

                                truckId: widget.trucksModel!.id ?? "null",

                              ),

                            );

                          });

                    });

              }),


          BottomNavigationBar(

            currentIndex: _tabController.index,

            onTap: (int val) {

              setState(() {

                _tabController.index = val;

              });

            },

            items: const [

              BottomNavigationBarItem(

                  icon: Icon(Icons.account_balance_wallet_outlined),

                  label: 'Expenses'),

              BottomNavigationBarItem(

                  icon: Icon(Icons.local_shipping_outlined), label: 'Jobs'),

            ],

          ),


          Expanded(

            child: TabBarView(

              controller: _tabController,

              children: [

                _ListOfExpenses(widget.trucksModel?.id, userModule.currentUser.value.tenantId!),

                _ListOfJobs(widget.trucksModel?.id, userModule.currentUser.value.tenantId! ),

              ],

            ),

          )

        ],

      ),

    );

  }

}


class _ListOfJobs extends StatelessWidget {

  _ListOfJobs(this.jobId, this.tenantId, {Key? key}) : super(key: key);


  String? jobId;


  String? tenantId;


  final OrderModules _orderModules = Get.find<OrderModules>();


  double? fetchAmount(String? orderId) {

    var res = _orderModules.getOrderByJobId(orderId!);


    return res?.amount;

  }


  final JobModule _jobModule = JobModule();

  Constants constants = Constants();


  @override

  Widget build(BuildContext context) {

    return FutureBuilder<List<JobModel>>(

        future: _jobModule.fetchJobsByTruck(jobId!, tenantId!),

        builder: (context, snapshot) {

          if (snapshot.hasError) {

            return Center(

              child: Text('Error ${snapshot.error}'),

            );

          }


          if (snapshot.hasData) {

            return ListView.builder(

              itemCount: (snapshot.data ?? []).length,

              itemBuilder: (_, index) {

                return JobListTile(

                  title:

                      constants.fetchOrder(snapshot.data![index].orderId) ?? '',

                  orderNo: snapshot.data![index].orderNo ?? '',

                  dateTime: snapshot.data![index].dateCreated,

                  amount: ((fetchAmount(snapshot.data![index].orderId) ?? 0)

                      .toString()),

                  jobState: snapshot.data![index].jobStates,

                  onTap: () {

                    Navigator.of(context).push(MaterialPageRoute(

                        builder: (_) => JobDetailPage(snapshot.data![index])));

                  },

                );

              },

            );

          }


          return const Center(

            child: CircularProgressIndicator(),

          );

        });

  }

}


class _ListOfExpenses extends StatelessWidget {

  _ListOfExpenses(this.truckId, this.tenantId, {Key? key}) : super(key: key);


  String? truckId;


  String? tenantId;


  final ExpenseModule _expenseModule = ExpenseModule();


  UserModule userModule = Get.find<UserModule>();


  NumberFormat doubleFormat = NumberFormat.decimalPattern('en_us');


  Constants constants = Constants();


  @override

  Widget build(BuildContext context) {

    return StreamBuilder<List<ExpenseModel>>(

        stream: _expenseModule.fetchByTruckExpenses(

            truckId!, userModule.currentUser.value, tenantId!),

        builder: (context, snapshot) {

          List<ExpenseModel> _expenses = snapshot.data ?? [];


          return ListView.builder(

            itemCount: _expenses.length,

            itemBuilder: (_, index) {

              return ExpensesListTile(

                title: _expenses[index].expenseType ?? '',

                truckNumber:

                    constants.truckNumber(_expenses[index].truckId ?? ''),

                driverName: constants.driverName(_expenses[index].userId ?? ''),

                dateTime: _expenses[index].date,

                amount: doubleFormat.format(

                    double.tryParse(_expenses[index].totalAmount ?? '0')),

                expenseState: _expenses[index].expensesState,

                onTap: () {

                  Navigator.of(context).push(MaterialPageRoute(

                      builder: (_) => ExpenseDetailsPage(_expenses[index])));

                },

              );

            },

          );

        });

  }

}

