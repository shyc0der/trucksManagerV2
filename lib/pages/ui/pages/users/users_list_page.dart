// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:truck_manager/pages/models/order_model.dart';

import 'package:truck_manager/pages/models/userModel.dart';

import 'package:truck_manager/pages/modules/expenses_modules.dart';

import 'package:truck_manager/pages/modules/job_module.dart';

import 'package:truck_manager/pages/modules/order_modules.dart';

import 'package:truck_manager/pages/modules/userModules.dart';

import 'package:truck_manager/pages/ui/pages/users/addCustomer.dart';

import 'package:truck_manager/pages/ui/pages/users/add_user_widget.dart';

import 'package:truck_manager/pages/ui/widgets/user_widget.dart';

import '../../widgets/dismiss_widget.dart';


class UsersListPage extends StatelessWidget {

  UsersListPage(

    this.isCustomer,

    this.isDriver, {

    super.key,

  });

  //final Stream<List<UserModel?>> users;

  final UserModule userModule = Get.find<UserModule>();


  bool isCustomer = false;

  bool isDriver = false;

  Future<bool> _dismissDialog(UserModel userModel) async {

    ExpenseModule expenseModule = ExpenseModule();

    JobModule jobModule = JobModule();

    OrderModules orderModules = OrderModules();

    OrderModel orderModel = OrderModel();

    String? expenseId;


    bool? _delete =

        await dismissWidget('${userModel.firstName}, ${userModel.lastName}','User');


    if (_delete == true) {

      // delete from server

      //fetch expenses by user

      var userExpenses =
          await expenseModule.fetchExpensesByUser(userModel, userModule.currentUser.value.tenantId! );

      var userJobs = await jobModule.fetchJobsByUser(userModel, userModule.currentUser.value.tenantId!);

      var userOrders =
          await orderModules.fetchOrdersByUser(userModel, userModule.currentUser.value.tenantId!);


      if (userExpenses!.isNotEmpty == false) {

        // throw error

      } else {

        userExpenses.forEach((element) async {

          expenseId = element.id;

          await expenseModule.deleteExpenses(expenseId!);

        });

      }

      //delete Jobs

      if (userJobs!.isNotEmpty == false) {

      } else {

        userJobs.forEach((element) async {

          await jobModule.deleteJob(element.id!, userModule.currentUser.value.tenantId!, element.orderId);

        });

      }

      //delete Orders
      if (userOrders!.isNotEmpty == false) {

      } else {

        userOrders.forEach((element) async {

          var jobsByOrder =
              await jobModule.fetchJobsByOrderId(element.id ?? '', userModule.currentUser.value.tenantId!);
          if (jobsByOrder?.id != null) {
            await jobModule.deleteJob(
                jobsByOrder!.id!, userModule.currentUser.value.tenantId!, orderModel.id);
          } else {
            await orderModel.deleteOnline(element.id ?? 'null');
          }
        });

      }
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       content: Text("User Deleted!"),
      //     ));

    }

    return _delete == true;

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Align(

        alignment: Alignment.topCenter,

        child: SingleChildScrollView(

          child: StreamBuilder<List<UserModel?>>(

              stream: userModule.fetchUsersWhere(isCustomer, isDriver,userModule.currentUser.value.tenantId),

              builder: (context, snapshot) {

                var user = snapshot.data ?? [];

                user.sort(

                  (a, b) => a!.userRole.myCompare(b!.userRole),

                );

                return Wrap(

                  children: [

                    for (var us in user)

                      GestureDetector(

                        onLongPress: () async {

                        userModule.currentUser.value.role == "admin" ?
                                        await _dismissDialog(us) :
                                        ();

                        },

                        onTap: () {

                          Navigator.push(

                              context,

                              MaterialPageRoute(

                                  builder: ((context) => isCustomer == true

                                      ? AddCustomer(

                                          customer: us,

                                          isEditing: true,

                                        )

                                      : AddUserWidget(

                                          user: us, isEditing: true))));

                        },

                        child: UserWidget(

                          userType: us!.userRole,

                          name: us.firstName,

                          lname: us.lastName,

                          email: us.email,

                          phoneNo: us.phoneNo,

                          onLongPress: us.onLongPress,

                          onTap: us.onTap,

                        ),

                      )

                  ],

                );

              }),

        ),

      ),

    );

  }

}

