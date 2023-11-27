import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:truck_manager/components.dart';
import 'package:truck_manager/pages/color.dart';

class JobsListPage extends StatefulWidget {
  const JobsListPage({super.key});

  @override
  State<JobsListPage> createState() => _JobsListPageState();
}

class _JobsListPageState extends State<JobsListPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _searchTextController;
  @override
  void initState() {
    
    super.initState();
    _searchTextController = TextEditingController();
  }

  List<String> statuses = [
    "All",
    "Pending",
    "Approved",
    "Rejected",
    "Closed",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: Container(
              height: 210,
              padding: const EdgeInsets.only(top:10 ,bottom: 15),
              decoration: BoxDecoration(
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text("KES 289,000.00", 
                    style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
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
                                        switch (val.floor()) {
                                          case 1:
                                            return const Text('M');
                                          case 2:
                                            return const Text('T');
                                          case 3:
                                            return const Text('W');
                                          case 4:
                                            return const Text('T');
                                          case 5:
                                            return const Text('F');
                                          case 6:
                                            return const Text('S');
                                          case 7:
                                            return const Text('S');
                                          default:
                                          return const Text('');
                                        }
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
                                  const FlSpot(0, 5),
                                  const FlSpot(1, 5),
                                  const FlSpot(2, 9),
                                  const FlSpot(3, 6),
                                  const FlSpot(4, 9),
                                  const FlSpot(5, 8),
                                  const FlSpot(6, 6),
                                  const FlSpot(7, 7),
                                  const FlSpot(8, 7),
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
                  itemCount: statuses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return KnackBar(
                      title: statuses[index],
                      colors: HexColor("#00877D"),
                      size: 12,
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
              SizedBox(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.expand_less,
                    color: Colors.amber,
                  ),
                ),
              )
            ],
          ),
        ),
        //SEARCH BUTTON
        // LISTVIEW
        ItemListTile(
            title: "Transport",
            orderNo: "ORD-08042023-006",
            dateTime: DateTime.now(),
            amount: "29,000")
      ],
    );
  }
}
