// ignore_for_file: unused_field, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, avoid_print


import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:intl/intl.dart';


import 'package:printing/printing.dart';
import 'package:truck_manager/pages/color.dart';


import 'package:truck_manager/pages/modules/job_module.dart';


import 'package:truck_manager/pages/modules/order_modules.dart';


import 'package:truck_manager/pages/modules/userModules.dart';


import 'package:truck_manager/pages/ui/pages/jobs/jobs_details_page.dart';


import 'package:truck_manager/pages/ui/widgets/order_details_widget.dart';





import '../../../models/jobs_model.dart';


import '../../../models/order_model.dart';


import '../../reports/invoice_quotation_module.dart';


import '../../widgets/driver_customer_Detail_widget.dart';


import '../../widgets/update_state_widget.dart';


class OrderDetailPage extends StatefulWidget {

  const OrderDetailPage(this.order, {Key? key}) : super(key: key);


  final OrderModel order;


  @override

  OrderDetailPageState createState() => OrderDetailPageState();

}


class OrderDetailPageState extends State<OrderDetailPage> {

  final OrderModules _orderModules = Get.put(OrderModules());


  final UserModule _userModule = Get.put(UserModule());


  final JobModule _jobModule = JobModule();


  String _orderState = '';


  NumberFormat doubleFormat = NumberFormat.decimalPattern('en_us');


  OrderWidgateState orderState = OrderWidgateState.Pending;


  @override

  void initState() {

    super.initState();


    orderState = widget.order.orderStates;


    _orderState = orderState.value;

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        centerTitle: true,
        backgroundColor: HexColor("#00877D"),

        title: const Text('Order Details',style:  TextStyle(color: Colors.white)),

      ),

      body: 
      OrderDetailWidget(
        orderId: widget.order.id ?? "",
        orderNo: widget.order.orderNo ?? "",
      
        title: widget.order.title ?? '',
      
        amount:
      
            'Ksh. ${doubleFormat.format((widget.order.amount ?? 0).ceilToDouble())}',
      
        date: widget.order.dateCreated.toString().substring(0, 16),
      
        orderState: orderState,
      
        update: () async {
      
          OrderWidgateState? state = await changeDialogState();
        
      
      
          if (state != null) {
      
            if (state == OrderWidgateState.Declined) {
      
              await _orderModules.updateOrderState(
      
                  widget.order.id!, state);
      
      
              setState(() {
      
                _orderState = state.value;
      
      
                orderState = state;
      
              });
      
            }
             else {
          // Handle the case where state is null (dialog was closed without setting a result)
          print('Dialog closed without setting a result.');
        }
      
      
            List<String>? _res;
      
      
            if (state == OrderWidgateState.Approved) {
      
              _res = await Get.dialog(
      
                  const Dialog(child: DriverVehicleGetDetails()));
      
      
              if (_res != null && _res.isNotEmpty) {
      
                print(
      
                  _res[1],
      
                );
      
      
                print(_res[0]);
      
      
                final job = JobModel(
      
                    createdBy: _userModule.currentUser.value.id,
      
                    customerId: widget.order.customerId,
      
                    vehicleId: _res[1],
      
                    driverId: _res[0],
      
                    orderNo: widget.order.orderNo,
      
                    tenantId: _userModule.currentUser.value.tenantId,
      
                    lpoNumber: _res[2],
      
                    orderId: widget.order.id,
      
                    jobState: OrderWidgateState.Pending);
      
      
                await _jobModule.addJob(job);
      
      
                await _orderModules.updateOrder(
      
                    widget.order.id ?? '', {'userId': _res[0]});
      
      
                await _orderModules.updateOrderState(
      
                    widget.order.id!, state);
      
      
                setState(() {
      
                  _orderState = state.value;
      
      
                  orderState = state;
      
                });
      
              }
      
            }
      
          }
      
        },
      
        onCancel: () {
      
          Navigator.pop(context);
      
        },
      
        onClose: () async {
      
          JobModel? job = await _jobModule.fetchJobsByOrderId(
      
              widget.order.id ?? '',
              _userModule.currentUser.value.tenantId!);
      
      
          if (job != null) {
      
            await Navigator.push(
      
                context,
      
                MaterialPageRoute(
      
                    builder: (context) => JobDetailPage(job)));
      
          }
      
        },
      
        goToJob: () async {
      
          JobModel? job = await _jobModule.fetchJobsByOrderId(
      
              widget.order.id ?? '',
              _userModule.currentUser.value.tenantId!);
      
      
          if (job != null) {
      
            await Navigator.push(
      
                context,
      
                MaterialPageRoute(
      
                    builder: (context) => JobDetailPage(job)));
      
          } else {
      
            Get.dialog(const Dialog());
      
          }
      
        },
      
      ),

    );

  }


 
}

