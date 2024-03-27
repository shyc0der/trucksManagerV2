// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truck_manager/pages/models/jobs_model.dart';
import 'package:truck_manager/pages/modules/job_module.dart';
import 'package:truck_manager/pages/modules/order_modules.dart';
import 'package:truck_manager/pages/modules/userModules.dart';
import 'package:truck_manager/pages/ui/pages/jobs/jobs_details_page.dart';
import 'package:truck_manager/pages/ui/widgets/constants.dart';
import 'package:truck_manager/pages/ui/widgets/dismiss_widget.dart';
import 'package:truck_manager/pages/ui/widgets/job_list_tile_widget.dart';

class JobsPage extends StatefulWidget {
  JobsPage(this.state, {Key? key}) : super(key: key);
  String state;

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  final JobModule jobModule = Get.find<JobModule>();
  final OrderModules orderModules = Get.find<OrderModules>();
 final UserModule userModule = Get.find<UserModule>();

  NumberFormat doubleFormat = NumberFormat.decimalPattern('en_us');

  Future<bool> _dismissDialog(JobModel jobModel) async {
    bool? delete = await dismissWidget(' with Order NO.${jobModel.orderNo}','Job');

    if (delete == true) {
      // delete from server

      await jobModule.deleteJob(
          jobModel.id!, jobModel.orderId ?? 'null', userModule.currentUser.value.tenantId!);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Job Deleted!"),
      ));
    }

    return delete == true;
  }

  String? fetchOrder(String? orderId) {
    var res = orderModules.getOrderByJobId(orderId!);

    return res?.title;
  }

  double? fetchAmount(String? orderId) {
    var res = orderModules.getOrderByJobId(orderId!);

    return res?.amount;
  }

  // void _changeView(int val) {
  //   switch (val) {
  //     case 1:
  //       setState(() {
  //         displayJobs = displayJob
  //             .where(
  //                 (element) => element.jobStates == OrderWidgateState.Pending)
  //             .toList();
  //       });
  //       break;
  //     case 2:
  //       setState(() {
  //         displayJobs = displayJob
  //             .where((element) => element.jobStates == OrderWidgateState.Open)
  //             .toList();
  //       });
  //       break;
  //     case 3:
  //       setState(() {
  //         displayJobs = displayJob
  //             .where((element) => element.jobStates == OrderWidgateState.Closed)
  //             .toList();
  //       });
  //       break;
  //     default:
  //       setState(() {
  //         displayJobs = displayJob;
  //       });
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Jobs'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: 
        StreamBuilder<List<JobModel>>(
            stream: jobModule.fetchJobsByState(
                widget.state,
                userModule.currentUser.value,
                userModule.currentUser.value.tenantId!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error = ${snapshot.error}');
              }
              if (snapshot.hasData) {
                var displayJobs = snapshot.data!;
                return ListView.builder(
                  itemCount: displayJobs.length,
                  itemBuilder: (_, index) {
                    return JobListTile(
                      title: constants.fetchOrder(displayJobs[index].orderId) ??
                          '',
                      orderNo:
                          constants.truckNumber(displayJobs[index].vehicleId!),
                      dateTime: displayJobs[index].dateCreated,
                      amount: doubleFormat.format(
                          (fetchAmount(displayJobs[index].orderId) ?? 0)
                              .ceilToDouble()),
                      jobState: displayJobs[index].jobStates,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => JobDetailPage(displayJobs[index])));
                      },
                      onDoubleTap: () async {
                         userModule.currentUser.value.role == "admin" ?
                                        await _dismissDialog(snapshot.data![index]) :
                                        ();
                        
                      },
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  
  
    //   bottomNavigationBar: BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     onTap: _changeView,
    //     currentIndex: 0,
    //     items: const [
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.list_outlined), label: 'All'),
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.outbox_outlined), label: 'Pending'),
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.outbox_outlined), label: 'Open'),
    //       BottomNavigationBarItem(
    //           icon: Icon(Icons.done_all_outlined), label: 'Closed'),
    //     ],
    //   ),
    // );
  }
}
