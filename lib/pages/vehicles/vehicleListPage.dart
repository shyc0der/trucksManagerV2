import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:truck_manager/components.dart';

import 'package:truck_manager/pages/models/trucks_model.dart';

import 'package:truck_manager/pages/modules/trucks_modules.dart';

import 'package:truck_manager/pages/modules/userModules.dart';
import 'package:truck_manager/pages/ui/pages/trucks/add_truck_widget.dart';
import 'package:truck_manager/pages/ui/pages/trucks/truck_details_page.dart';


class VehiclesListPage extends StatefulWidget {

  const VehiclesListPage({super.key});


  @override

  State<VehiclesListPage> createState() => _VehiclesListPageState();

}


class _VehiclesListPageState extends State<VehiclesListPage>

    with SingleTickerProviderStateMixin {
  late final TextEditingController _searchTextController;
  UserModule userModule = Get.find<UserModule>();

  TruckModules _truckModules = Get.find<TruckModules>();
  @override

  void initState() {

    super.initState();

    _searchTextController = TextEditingController();

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(
      
         floatingActionButton: CircleAvatar(

          backgroundColor: Colors.green,

          radius: 30,

          child: IconButton(

            onPressed: () {

              Navigator.push(

                  context,

                  MaterialPageRoute(

                      builder: (context) => const AddTruckWidget()));

            },

            icon: const Icon(Icons.add),

          )),

      body: 
       FutureBuilder<List<TrucksModel>>(
          
                  future: _truckModules
                      .fetchTrucks(userModule.currentUser.value.tenantId!),
          
                  builder: (context, snapshot) {
          
                    var trucks = snapshot.data ?? [];
          
                    if (snapshot.hasError) {
          
                      return Text('Error = ${snapshot.error}');
          
                    }
          
                    if (snapshot.hasData) {
          
                      var displayJobs = snapshot.data!;
          
                      return   Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                        child: Column(
                                  
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                    children: [
                                  
                                      //Container with vehicles
                                  
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
                            "My Vehicles",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                                  
                          Text(
                            trucks.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                                  
                          ),
                                  
                        ],
                                  
                                            ),
                                  
                                          ),
                                  
                                        ),
                                  
                                      ),
                                  
                                      //Row With search
                                      Padding(
                                  
                                        padding: const EdgeInsets.only(top: 12.0, left: 8, bottom: 2),
                                  
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
                                            const SizedBox(
                        width: 1.5,
                                            ),
                                  
                                            SizedBox(
                        height: 48,
                                  
                        child: Container(
                                  
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                              border: const Border(
                                top: BorderSide(color: Colors.grey, width: 1),
                                bottom: BorderSide(color: Colors.grey, width: 1),
                                left: BorderSide(color: Colors.grey, width: 1),
                                right: BorderSide(color: Colors.grey, width: 1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                                  
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
                                  
                                    Expanded(
                                  
                          child: ListView.builder(
                                  
                            itemCount: displayJobs.length,
                                  
                            itemBuilder: (_, index) {
                                  
                              return Padding(
                                  
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                  
                                child: ItemListTile(
                                  title: trucks[index].vehicleRegNo ?? '',
                                  description: trucks[index].category ?? 'Truck',
                                  onTap: () {
                                     
                                  
                                          Navigator.of(context).push(MaterialPageRoute(
                                  
                                              builder: (_) => TruckDetailsPage(trucks[index])));
                                  }
                                ),
                                  
                              );
                                  
                            },
                                  
                          ),
                                  
                        )
                                  
                                      //List View
                                     
                                  
                                    ],
                                  
                                  ),
                      );
       
                     
                    } else {
          
                      return const Center(
          
                        child: CircularProgressIndicator(),
          
                      );
          
                    }
          
                  })
     
    );

  }

}

