import 'package:flutter/material.dart';
import 'package:truck_manager/components.dart';
import 'package:truck_manager/pages/color.dart';

class OrdersPage extends StatefulWidget{
  @override
  State<OrdersPage> createState() => _OrdersPageState();
    
}
class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin{
  List<String> statuses = [
    "All",
    "Pending",
    "Approved",
    "Rejected",
    "Closed",
  ];
   int _currentIndex=0;
  late final TabController tabController;
    late final TextEditingController _searchTextController;
   
    @override
  void initState() {
        super.initState();
    _searchTextController = TextEditingController();
    tabController = TabController(length: 4, vsync: this, initialIndex: _currentIndex);
tabController.addListener(() { 
  if(mounted){
    setState(() {
      _currentIndex=tabController.index;
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
      appBar: AppBar(
        backgroundColor: HexColor("#00877D"),
        elevation: 2,
      title: const Padding(
        padding:  EdgeInsets.only(bottom: 8.0),
        child:  Text("Dashboard",style: TextStyle(color: Colors.white),),
      ),  
      
      ),
      body: Column(
        children: [
                   Container(
                   height: 50,
                   
                  decoration: const BoxDecoration(shape: BoxShape.rectangle,
                  boxShadow:[ 
                    BoxShadow(offset: Offset(0.5, 0.5),
                    color: Colors.green
                    )],
                  
                  color:  Colors.white
                  
                  ),
                          
                   
                     child: TabBar(
                              indicator: const BoxDecoration(), 
                              controller: tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              labelColor: HexColor("#00877D"),
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                                          child: Container(
                                                            decoration: tabController.index != 0 ? null : BoxDecoration(
                                                              border: Border(bottom: BorderSide(color: HexColor("#00877D"), width: 2), )
                                                            ),
                                                            child: const Text(
                                                              "Orders",
                                                              style: TextStyle(fontSize: 15),
                                                            ),
                                                          ),
                                         ),
                                  ),   
                 Align(
                  alignment: Alignment.bottomLeft,
                   child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Container(
                          decoration: tabController.index != 1 ? null :  BoxDecoration(
                            border: Border(bottom: BorderSide(color: HexColor("#00877D"), width: 2), )
                          ),
                          child: const Text(
                            "Jobs",style: TextStyle(fontSize: 15),
                          ),
                        ),
                                         ),
                 ), 
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: tabController.index != 2 ? null :  BoxDecoration(
                          border: Border(bottom: BorderSide(color: HexColor("#00877D"), width: 2), )
                        ),
                        child: const Text(
                          "Expenses"
                        ),
                      ),
                    ), 
                                       Align(
                                        alignment: Alignment.bottomLeft,
                                         child: Padding(
                                                               padding: const EdgeInsets.symmetric(vertical: 2,),
                                                               child: Container(
                                                                 decoration: tabController.index != 3 ? null :  BoxDecoration(
                                                                   border: Border(bottom: BorderSide(color: HexColor("#00877D"), width: 2), )
                                                                 ),
                                                                 child: const Text(
                                                                   "Vehicles"
                                                                 ),
                                                               ),
                                         ),
                                       ),
                                  
                              ],
                              ),
                   ),
     
        ],
      

      ),

  
     );
  }

}

    //  Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container( height: 200, color: HexColor("#00877D"),
          
    //       ),
    //       // SCROLLABLE VERTICAL CONTAINER
    //       Padding(
    //         padding: const EdgeInsets.only(bottom: 9.0),
    //         child: SizedBox(
    //           height: 50,
    //           child:
    //           ListView.builder(
    //             scrollDirection: Axis.horizontal,
    //             itemCount: statuses.length,
    //             itemBuilder: (BuildContext context,int index)
    //           { 
            
    //             return                 
    //                KnackBar(
    //                 title : statuses[index],
    //                 colors: HexColor("#00877D"),
    //                 size: 20,
    //                 );             
                
    //           }
    //           )
                     
    //         ),
    //       ),

    //       Padding(
    //         padding: const EdgeInsets.only(top: 12.0,left: 8),
    //         child:
    //          Row(
    //           mainAxisAlignment: MainAxisAlignment.start,  
    //           mainAxisSize: MainAxisSize.min, 
    //           children: [
    //       Expanded(
    //         child: TextField(
    //           controller: _searchTextController,
    //           onChanged: (val){
    //             if(val.isNotEmpty){
    //               setState(() {
                   
    //               });
    //             }else{
    //               setState(() {
                  
    //               });
    //             }
    //           },
    //           decoration: const InputDecoration(
    //             prefixIcon: Icon(Icons.search_outlined),
    //             border: OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(7))
              
    //             ),
    //             labelText: 'Search'
    //           ),
    //                   ),
    //                   ),
    //             SizedBox(child:
    //              IconButton(
    //                onPressed: (){},
    //                icon: const Icon(
    //                              Icons.expand_less,
    //                              color: Colors.amber,
    //                            ),),) 
    //           ],
    //         ),
    //       ),
    //      //SEARCH BUTTON
    //       // LISTVIEW 
    // ItemListTile(title: "Transport",
    //  orderNo: "ORD-08042023-006", 
    //  dateTime: DateTime.now(), 
    //  amount: "29,000")

    //     ],
    //   ),
  