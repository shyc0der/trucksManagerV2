import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truck_manager/pages/models/jobs_model.dart';
import 'package:truck_manager/pages/modules/job_module.dart';
import 'package:truck_manager/pages/modules/userModules.dart';
import 'package:truck_manager/pages/ui/pages/jobs/jobs_page.dart';
import 'package:truck_manager/pages/orders/add_order_widget.dart';
import 'package:truck_manager/pages/ui/widgets/order_details_widget.dart';
import '../../../models/order_model.dart';
import '../../widgets/item_card_widget.dart';

class JobsMainPage extends StatefulWidget {
  const JobsMainPage({Key? key}) : super(key: key);

  @override
  State<JobsMainPage> createState() => _JobsMainPageState();
}

class _JobsMainPageState extends State<JobsMainPage> {
  final JobModule _jobModule = Get.put(JobModule());
  final UserModule _userModule = Get.find<UserModule>();
  NumberFormat doubleFormat = NumberFormat.decimalPattern('en_us');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OrderModel>>(
      // stream: _orderModules!.fetchOrders(),
      builder: (context, snapshot) {
        //displayOrders = snapshot.data ?? [];
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
            title: const Text('Jobs'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: Wrap(
              children: [
                for (var val in OrderWidgateState.values)
                  StreamBuilder<List<JobModel>>(
                      stream: _jobModule.fetchJobsByState(
                          val.value, _userModule.currentUser.value, _userModule.currentUser.value.tenantId!),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error = ${snapshot.error}');
                        }
                        if (snapshot.hasData) {
                          return ItemCardWidget(
                            label: val.value,
                            iconData: Icons.account_balance_wallet_outlined,
                            count: snapshot.data!.length,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => JobsPage(val.value)));
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })
              ],
            ),
          ),
        );
      },
      stream: null,
    );
  }
}
