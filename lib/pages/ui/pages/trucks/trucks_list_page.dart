// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truck_manager/pages/color.dart';

import 'package:truck_manager/pages/models/expenses_model.dart';

import 'package:truck_manager/pages/models/trucks_model.dart';

import 'package:truck_manager/pages/modules/trucks_modules.dart';

import 'package:truck_manager/pages/modules/userModules.dart';

import 'package:truck_manager/pages/ui/pages/trucks/add_truck_widget.dart';

import 'package:truck_manager/pages/ui/pages/trucks/truck_details_page.dart';

import 'package:truck_manager/pages/ui/widgets/item_card_widget.dart';

import '../../../modules/expenses_modules.dart';


class TrucksListPage extends StatelessWidget {

  TrucksListPage({Key? key}) : super(key: key);


  final ExpenseModule _expenseModule = Get.put(ExpenseModule());
  UserModule userModule = Get.find<UserModule>();
  TruckModules _truckModules = Get.find<TruckModules>();
 

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      floatingActionButton: CircleAvatar(

          backgroundColor: HexColor("#00877D"),

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

      body: Align(

        alignment: Alignment.topCenter,

        child: SingleChildScrollView(

          child: FutureBuilder<List<TrucksModel?>>(

              future: _truckModules.fetchTrucks(userModule.currentUser.value.tenantId!),

              builder: (context, snapshot) {

                var trucks = snapshot.data ?? [];

                return Wrap(

                  children: [

                    for (var truck in trucks)

                      StreamBuilder<List<ExpenseModel>>(

                          stream: _expenseModule.fetchByTruckExpenses(
                              truck!.id!,
                              userModule.currentUser.value,
                              userModule.currentUser.value.tenantId!),

                          builder: (context, snapshot) {

                            if (snapshot.hasError) {

                              return Text('Error = ${snapshot.error}');

                            }

                            if (snapshot.hasData) {

                              return ItemCardWidget(

                                label: truck.vehicleRegNo ?? '',

                                iconData: Icons.local_shipping_outlined,

                                count: snapshot.data!.length,

                                onTap: () {

                                  Navigator.of(context).pop();

                                  Navigator.of(context).push(MaterialPageRoute(

                                      builder: (_) => TruckDetailsPage(truck)));

                                },

                              );

                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                          })

                  ],

                );

              }),

        ),

      ),

    );

  }

}

