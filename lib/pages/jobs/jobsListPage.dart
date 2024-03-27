import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truck_manager/components.dart';
import 'package:truck_manager/pages/color.dart';
import 'package:truck_manager/pages/models/jobs_model.dart';
import 'package:truck_manager/pages/models/order_model.dart';
import 'package:collection/collection.dart';
import 'package:truck_manager/pages/modules/job_module.dart';
import 'package:truck_manager/pages/modules/order_modules.dart';
import 'package:truck_manager/pages/modules/userModules.dart';
import 'package:truck_manager/pages/ui/pages/jobs/jobs_details_page.dart';
import 'package:truck_manager/pages/ui/widgets/constants.dart';
import 'package:truck_manager/pages/ui/widgets/dismiss_widget.dart';
import 'package:truck_manager/pages/ui/widgets/job_list_tile_widget.dart';
import 'package:truck_manager/pages/ui/widgets/order_details_widget.dart';

class JobsListPage extends StatefulWidget {
  const JobsListPage({super.key});

  @override
  State<JobsListPage> createState() => _JobsListPageState();
}

class _JobsListPageState extends State<JobsListPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _searchTextController;
  late final DateTimeRange dateTimeRange;
  @override
  void initState() {
    
    super.initState();
    _searchTextController = TextEditingController();
        DateTime dates = DateTime.now();


    dateTimeRange = DateTimeRange(

        start: DateTime(dates.year, dates.month, dates.day - 7),

        end: DateTime.now());

  
  }
  String getDayOfWeek(String dateString) {

// Parse the date string


    DateTime dateTime = DateTime.parse(dateString);


// List of day names


    List<String> days = [

      'Monday',

      'Tuesday',

      'Wednesday',

      'Thursday',

      'Friday',

      'Saturday',

      'Sunday'

    ];


// Get the day of the week (1-7)


    int dayIndex = dateTime.toLocal().weekday;


// Return the corresponding day name


    return days[dayIndex - 1];

  }

  String getDayOfWeekByIndex(int index) {
// List of day names


    List<String> days = [

      'Monday',

      'Tuesday',

      'Wednesday',

      'Thursday',

      'Friday',

      'Saturday',

      'Sunday'

    ];

// Return the corresponding day name
    if(index < 0 || index > 6){
      return "";
    }



    return days[index];

  }
 int getDayIndexOfWeek(String dateString) {

// Parse the date string


    DateTime dateTime = DateTime.parse(dateString);


// List of day names


    


// Get the day of the week (1-7)


    int dayIndex = dateTime.toLocal().weekday;


// Return the corresponding day name


    return dayIndex - 1;

  }

    List<Map<String, dynamic>> dailyTotals = [];
Constants constants = Constants();

    final JobModule jobModule = Get.find<JobModule>();
  final OrderModules orderModules = Get.find<OrderModules>();
 final UserModule userModule = Get.find<UserModule>();
  NumberFormat doubleFormat = NumberFormat.decimalPattern('en_us');
  String? fetchOrder(String? orderId) {
    var res = orderModules.getOrderByJobId(orderId!);

    return res?.title;
  }

  double? fetchAmount(String? orderId) {
    var res = orderModules.getOrderByJobId(orderId!);

    return res?.amount;
  }
  String state = "All";
   Future<bool> _dismissDialog(JobModel jobModel) async {
    bool? delete = await dismissWidget('with Order NO.${jobModel.orderNo}','Job');

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
  @override
  Widget build(BuildContext context) {
    return 
Obx(() => StreamBuilder<List<OrderModel>>(
      stream: orderModules.fetchAllWhereOrderByDate(
                  
                          dateTimeRange, userModule.currentUser.value.tenantId),
      builder: (context, snapshot) {
        var data = snapshot.data ?? [];
         var totalAmount = data.fold<double>(0.0,
                  
                            (amount, order) => amount + (order.amount ?? 0.0));
                        
                                                                        var newFormat =
                  
                                                      DateFormat("yyyy-MM-dd");
                  
                  
                                                  var datast = groupBy(
                  
                                                      data,
                  
                                                      (OrderModel orderModel) =>
                  
                                                          newFormat.format(
                  
                                                              orderModel
                  
                                                                  .dateCreated));
                  
                  
                                                  Map<int, double> availableDays = datast.map((key, value) => MapEntry<int, double>(getDayIndexOfWeek(key), value.fold(0, (previousValue, element) => previousValue + (element.amount ?? 0))));
                  
                                               dailyTotals.clear();
                                               for (var i = 0; i < 7; i++) {
                                                if(availableDays.keys.contains(i)){
                                                  dailyTotals.add({
                                                         'day': getDayOfWeekByIndex(i),
                                                         'amount': availableDays[i]
                                                     });
                                                }else{
                                                  dailyTotals.add({
                                                         'day': getDayOfWeekByIndex(i),
                                                         'amount': 0.0
                                                     });
                                                }
                                                 
                                                   
                                                 }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Container(
                  height: 210,
                  padding: const EdgeInsets.only(top:10 ,bottom: 15),
                  decoration: 
                  BoxDecoration(
                    color: const  Color.fromARGB(255, 252, 226, 192),
                    borderRadius: BorderRadius.circular(8)
                  ),
                 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("This week's Jobs",
                         style: TextStyle(fontSize: 12,color: Colors.black,),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child:  Text(totalAmount.toString(), 
                        style: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                     const Padding(
                       padding: EdgeInsets.symmetric(horizontal: 10),
                       child: Row(
                        children: [
                          Icon(Icons.arrow_upward,size: 13, color: Colors.green,),   
                          SizedBox(width: 1,)   ,              
                         Text("10%",
                          style: TextStyle(fontSize: 11,color: Colors.green,fontWeight: FontWeight.bold),
                         ),
                        ],
                       ),
                     ),
                      Expanded(
        
                        child: LineChart(
                          LineChartData(
                              minY: 0,
                              gridData: const FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: const AxisTitles(),
                                  leftTitles: const AxisTitles(),
                                  rightTitles: const AxisTitles(),
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                         getTitlesWidget: (val, title) {
                                                  int index = val.floor() - 1;
                                                  if (index == -1 || index == 7) {
                  
                                                    return const Text('');
                  
                                                  }
                                                  var day = dailyTotals[index] as Map?;
                                                  return Text((day?['day'])
                                                          ?.toString()
                                                          .substring(0, 1) ??
                                                      "");
                  
                                                }))),
                              lineBarsData: [
                                LineChartBarData(
                                  dotData: const FlDotData(show: false),
                                    isCurved: true,
                                    color: Colors.orange,
                                    
                                    belowBarData: BarAreaData(
                                        show: true,
                                        gradient: const LinearGradient(
                                          
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color.fromARGB(255, 247, 210, 155),
                                              // Color.fromARGB(255, 91, 203, 254),
                                              // Color.fromARGB(255, 184, 216, 247),
                                              Color.fromARGB(255, 252, 226, 192)
                                            ])),
                                    spots: [
                                    
                                            dailyTotals.isNotEmpty ? FlSpot(0, dailyTotals[0]['amount']) : const FlSpot(0, 0),
                  
                                            for (int i = 0; i < dailyTotals.length; i++)
                                              FlSpot(i+1, dailyTotals[i]['amount']),
                  
                                            dailyTotals.isNotEmpty ? FlSpot(dailyTotals.length+1, dailyTotals[dailyTotals.length-1]['amount']) : const FlSpot(1, 0),
                                    ])
                              ]),
                          // curve: Curves.bounceIn,
                          duration: const Duration(seconds: 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // SCROLLABLE VERTICAL CONTAINER
            Padding(
              padding: const EdgeInsets.only(bottom: 9.0),
              child: SizedBox(
                  height: 45,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: OrderWidgateState.values.length,
                      itemBuilder: (BuildContext context, int index) {
                        return KnackBar(
                          title: OrderWidgateState.values[index].value,
                          colors: HexColor("#00877D"),
                          size: 12,
                          onPressed: () {
                              setState(() {
                                state = OrderWidgateState.values[index].value;
                              });
                          }
                        );
                      })),
            ),
        
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 8,bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchTextController,
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          setState(() {});
                        } else {
                          setState(() {});
                        }
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        prefixIcon: Icon(Icons.search_outlined),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                          focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                          
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                        hintText: 'Search ...'),
                    ),
                  ),
                 const SizedBox(width: 1.5,),
                  SizedBox(
        height: 48,
                    child: Container(
                      decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
            border: const Border(
                top: BorderSide(color: Colors.grey,width: 1),
                bottom: BorderSide(color: Colors.grey,width: 1),
                left: BorderSide(color: Colors.grey,width: 1),
                right: BorderSide(color: Colors.grey,width: 1),
                              ),
        
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(0, 3), 
              )
            ]          
         
          ),
                      child: IconButton(
                      
                        onPressed: () {},
                      
                        icon: const Icon(
                      
                          Icons.expand_less,
                      
                          color: Colors.amber,
                      
                        ),
                      
                      ),
                    ),
        
                  )
        
                ],
              ),
            ),
        
            //SEARCH BUTTON
            // LISTVIEW
               StreamBuilder<List<JobModel>>(
                stream: jobModule.fetchJobsByState(
                    state,
                    userModule.currentUser.value,
                    userModule.currentUser.value.tenantId!),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error = ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    var displayJobs = snapshot.data!;
                    
                        
                        return Expanded(
                          child: ListView.builder(
                            itemCount: displayJobs.length,
                            itemBuilder: (_, index) {
                               return FutureBuilder<OrderModel>(
                                future: orderModules.fetchFutureOrderById(displayJobs[index].orderId ?? ''),
                                builder: (context, snaps) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    child: JobListTile(
                                      title:  snaps.data?.title ??  "",
                                      orderNo:
                                          constants.truckNumber(displayJobs[index].vehicleId!),
                                      dateTime: displayJobs[index].dateCreated,
                                      amount: doubleFormat.format(
                                          (snaps.data?.amount ?? 0)
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
                                    ),
                                  );
                                }
                              );
                            },
                          ),
                        );
                    
                    
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
                
        
          
        
          ],
        );
      }
    )
);
  }
}
