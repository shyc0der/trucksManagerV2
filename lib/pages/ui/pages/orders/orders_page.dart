// ignore_for_file: must_be_immutable, use_build_context_synchronously, use_super_parameters


import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:intl/intl.dart';


import 'package:truck_manager/pages/modules/order_modules.dart';


import 'package:truck_manager/pages/modules/userModules.dart';


import 'package:truck_manager/pages/ui/pages/orders/orders_details_page.dart';


import 'package:truck_manager/pages/ui/widgets/job_list_tile_widget.dart';


import '../../../models/order_model.dart';


import '../../../modules/job_module.dart';


import '../../widgets/dismiss_widget.dart';


import 'add_order_widget.dart';


class OrdersPage2 extends StatefulWidget {

  OrdersPage2(this.state, {Key? key}) : super(key: key);


  String state;


  @override

  State<OrdersPage2> createState() => _OrdersPageState();

}


class _OrdersPageState extends State<OrdersPage2> {

  // late Stream<List<OrderModel>> orders;


  // late List<OrderModel> displayOrders = [];


  late List<OrderModel> displayOrder;


  final OrderModules _orderModules = Get.find<OrderModules>();


  final UserModule _userModule = Get.find<UserModule>();


  NumberFormat doubleFormat = NumberFormat.decimalPattern('en_us');


  @override

  void initState() {

    super.initState();

  }


  Future<bool> _dismissDialog(OrderModel orderModel) async {

    JobModule jobModule2 = JobModule();

    String? jobId;


    bool? delete = await dismissWidget('${orderModel.orderNo}');


    if (delete == true) {

      // delete from server


      //fetch job id by orderid


      var res =

          await jobModule2.fetchJobsByOrderId(orderModel.id ?? '', _userModule.currentUser.value.tenantId!);


      jobId = res?.id;


      if (jobId != null) {

        await jobModule2.deleteJob(jobId, _userModule.currentUser.value.tenantId!, orderModel.id);

      } else {

        await orderModel.deleteOnline(orderModel.id ?? 'null');

      }


      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(

        content: Text("Order Deleted!"),

      ));

    }

    return delete == true;

  }


  @override

  Widget build(BuildContext context) {

    return StreamBuilder<List<OrderModel>>(

      builder: (context, snapshot) {

        return Scaffold(

          floatingActionButton: CircleAvatar(

              backgroundColor: Colors.green,

              radius: 30,

              child: IconButton(

                onPressed: () {

                  Navigator.push(

                      context,

                      MaterialPageRoute(

                          builder: (context) => const AddOrderWidget()));

                },

                icon: const Icon(Icons.add),

              )),

          appBar: AppBar(

            centerTitle: true,

            title: const Text('Orders'),

            actions: [

              IconButton(onPressed: () {}, icon: const Icon(Icons.search))

            ],

          ),

          body: StreamBuilder<List<OrderModel>>(


              stream: _orderModules.fetchOrderByState(

                  widget.state, _userModule.currentUser.value, _userModule.currentUser.value.tenantId!),

              builder: (context, snapshot) {
             
                if (snapshot.hasError) {

                  return Text('Error = ${snapshot.error}');

                }

                if (snapshot.hasData) {

                  var displayOrders = snapshot.data!;

                  return ListView.builder(

                    itemCount: displayOrders.length,

                    itemBuilder: (_, index) {

                      return JobListTile(

                        title: displayOrders[index].title ?? '',

                        orderNo: displayOrders[index].orderNo ?? '',

                        dateTime: displayOrders[index].dateCreated,

                        amount: doubleFormat.format(

                            (displayOrders[index].amount ?? 0).ceilToDouble()),

                        jobState: displayOrders[index].orderStates,

                        onDoubleTap: () async {

                          await _dismissDialog(snapshot.data![index]);

                        },

                        onTap: () {

                          Navigator.of(context).push(MaterialPageRoute(

                              builder: (_) =>

                                  OrderDetailPage(displayOrders[index])));

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

      },

      stream: null,

    );

  }

}

