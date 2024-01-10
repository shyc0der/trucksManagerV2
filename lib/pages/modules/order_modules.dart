// ignore_for_file: no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truck_manager/pages/models/jobs_model.dart';
import 'package:truck_manager/pages/models/order_model.dart';
import 'package:truck_manager/pages/models/responseModel.dart';
import 'package:truck_manager/pages/models/userModel.dart';
import 'package:truck_manager/pages/ui/widgets/order_details_widget.dart';
import 'package:truck_manager/pages/ui/widgets/user_widget.dart';

import 'job_module.dart';

class OrderModules extends GetxController {
  final OrderModel _orderModel = OrderModel();
  final JobModule _jobModule = JobModule();
  RxList<OrderModel> orders = <OrderModel>[].obs;

  Stream<List<OrderModel>> fetchAllOrders(String? tenantId) {
    return _orderModel
        .fetchStreamsDataWhere('tenantId', isEqualTo: tenantId)
        .map<List<OrderModel>>((streams) {
      var _orders = streams.docs
          .map<OrderModel>(
              (doc) => OrderModel.from({'id': doc.id, ...doc.data() as Map}))
          .toList();
      orders.clear();
      orders.addAll(_orders);
      return _orders;
    });
  }

  void init(UserModel user, String? tenantId) {
    // fetch jobs, drivers & truck
    //fetchOrders(user, tenantId);
    fetchOrderByState("All",user, tenantId);
    print(orders);
    print(user.asMap());
    print("hhhhhhhhhhhhhh");
  }

  //fetch orders
  Stream<List<OrderModel>> fetchOrders(UserModel user, String? tenantId) {
    if (user.userRole == UserWidgetType.admin ||
        user.userRole == UserWidgetType.manager) {
      return _orderModel
          .fetchStreamsDataWhere(
        'tenantId', isEqualTo: tenantId,
        // orderBy: 'dateCreated'
      )
          .map<List<OrderModel>>((snapshot) {
        var _orders = snapshot.docs.map<OrderModel>((doc) {
          return OrderModel.from({...(doc.data() as Map), 'id': doc.id});
        }).toList();
        orders.clear();
        orders.addAll(_orders);
        return _orders;
      });
    } else {
      return _orderModel
          .fetchStreamsDataWhere(
        'userId',
        isEqualTo: user.id,
      )
          .map<List<OrderModel>>((snapshot) {
        var _orders = snapshot.docs
            .map<OrderModel>(
                (e) => OrderModel.from({'id': e.id, ...e.data() as Map}))
            .toList();
        orders.clear();
        orders.addAll(_orders);
        return _orders;
      });
    }
  }

  //FETCH ORDER BY ID
  Stream<OrderModel> fetchOrderById(String orderId) {
    return _orderModel
        .fetchStreamsDataById(orderId)
        .map((doc) => OrderModel.from({'id': doc.id, ...doc.data() as Map}));
  }

  //FETCH ORDER BY ,
  Stream<List<OrderModel>> fetchOrderByState(
      String state, UserModel user, String? tenantId) {
    if (user.userRole == UserWidgetType.admin ||
        user.userRole == UserWidgetType.manager) {
      return _orderModel
          .fetchStreamsDataWhere(
        'tenantId', isEqualTo: tenantId,
        //orderBy: 'dateCreated'
      )
          .map<List<OrderModel>>((snapshot) {
        var datas = snapshot.docs.map<OrderModel>((doc) => OrderModel.from({
              'id': doc.id,
              ...doc.data() as Map,
            }));
        if (state == "All") {
          return datas.toList();
        } else {
          datas = datas.where((element) => element.state == state);

          return datas.toList();
        }
      });
    } else {
      return _orderModel
          .fetchStreamsDataWhere(
        'userId', isEqualTo: user.id,
        //orderBy: 'dateCreated'
      )
          .map<List<OrderModel>>((snapshot) {
        var datas = snapshot.docs.map<OrderModel>(
            (e) => OrderModel.from({'id': e.id, ...e.data() as Map}));
        if (state == "All") {
          return datas.toList();
        } else {
          datas = datas.where((element) => element.state == state);

          return datas.toList();
        }
      });
    }
  }

  Future<OrderModel> fetchFutureOrderById(
    String orderId,
  ) async {
    var orders = await _orderModel.fetchDataById(orderId);

    return OrderModel.from({'id': orders.id, ...orders.data() as Map});
  }

  //fetch orders
  Stream<List<OrderModel>> fetchAllWhereOrderByDate(
      DateTimeRange dateRange, String ? tenantId) {
    return _orderModel
        .fetchStreamsDataWhere2(
      'dateCreated',
      // orderBy: 'dateCreated',
      isGreaterThanOrEqualTo: dateRange.start.toIso8601String(),
      isLessThanOrEqualTo: dateRange.end.toIso8601String(),
    )
        .map<List<OrderModel>>((snapshot) {
      var _orders = snapshot.docs
          .map<OrderModel>((doc) {
            return OrderModel.from({...(doc.data() as Map), 'id': doc.id});
          })
          .where((element) => element.tenantId == tenantId)
          .toList();
      //orders.clear();
      //orders.addAll(_orders);
      return _orders;
    });
  }


  Map<String, double> fetchOrderByWeekDays(
      DateTimeRange dateRange, String tenantId) {
    Map<String, double> dailyTotals = {
      'Monday': 0,
      'Tuesday': 0,
      'Wednesday': 0,
      'Thursday': 0,
      'Friday': 0,
      'Saturday': 0,
      'Sunday': 0,
    };
    _orderModel
        .fetchStreamsDataWhere2(
      'dateCreated',
      // orderBy: 'dateCreated',
      isGreaterThanOrEqualTo: dateRange.start.toIso8601String(),
      isLessThanOrEqualTo: dateRange.end.toIso8601String(),
    )
        .map<List<OrderModel>>((snapshot) {
      var _orders = snapshot.docs
          .map<OrderModel>((doc) {
            return OrderModel.from({...(doc.data() as Map), 'id': doc.id});
          })
          .where((element) => element.tenantId == tenantId)
          .toList();
      //orders.clear();
      //orders.addAll(_orders);
      
      for (OrderModel order in _orders) {
        String dayOfWeek = DateFormat('EEEE').format(order.dateCreated);

        dailyTotals[dayOfWeek] =
            ((dailyTotals[dayOfWeek] ?? 0) + (order.amount ?? 0));

        print(dailyTotals);
        print("hjjjjjjaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      }

      // Update the total for the corresponding day

      return _orders;
    });

    return dailyTotals;
  }

  OrderModel? getOrderByJobId(String? _orderId) {
    final _orders = orders.where((order) => order.id == _orderId).toList();
    print("jjj");
    print(orders);
    if (_orders.isNotEmpty) {
      return _orders.first;
    }
  }

  Future<OrderModel> getOrderById(String _orderId) async {
    final _orderMap = await _orderModel.fetchDataById(_orderId);
    return OrderModel.from({'id': _orderMap.id, ...(_orderMap.data() ?? {})});
  }

  //fetch jobs by user
  Future<List<OrderModel>?> fetchOrdersByUser(
      UserModel userModel, String tenantId) async {
    var _res = await _orderModel.fetchWhereData(
      'userId',
      isEqualTo: userModel.id,
      //orderBy: 'dateCreated'
    );
    var ret = _res
        .map((documentSnapshot) {
          return OrderModel.from(
              {'id': documentSnapshot.id, ...documentSnapshot.data()});
        })
        .where((element) => element.tenantId == tenantId)
        .toList();

    return ret;
  }

//get order by jobid
  Future<OrderModel> fetchOrderByJobId(String _jobId) async {
    final jobs = await _jobModule.fetchJobById(_jobId);
    final _orderMap = await _orderModel.fetchDataById(jobs?.orderId ?? "");
    return OrderModel.from({'id': _orderMap.id, ...(_orderMap.data() ?? {})});
  }

  //FETCH DRIVER PER JOB
  //FETCH VEHICLE PER JOB
  //add orders
  Future<ResponseModel> addOrder(OrderModel orderModel) async {
    var _res = await _orderModel.saveOnline(orderModel.asMap());
    orderModel.id = _res.id;
    // final quotationModule = InvoiceQuotationModule.fromOrder(orderModel, isInvoice: false);
    // quotationModule.generatePdf();
    // send pdf

    return ResponseModel(ResponseType.success, 'Order Created');
  }

  //update orders
  Future<ResponseModel> updateOrder(String id, Map<String, dynamic> map) async {
    await _orderModel.updateOnline(id, map);
    return ResponseModel(ResponseType.success, 'Order Updated Successfully');
  }

  //update order State
  Future<bool> updateOrderState(
      String orderid, OrderWidgateState orderState) async {
    await _orderModel.updateOnline(orderid, {
      'state': orderState.value,
      if (orderState == OrderWidgateState.Approved ||
          orderState == OrderWidgateState.Declined)
        'dateApproved': DateTime.now().toIso8601String(),
      if (orderState == OrderWidgateState.Declined)
        'dateClosed': DateTime.now().toIso8601String(),
      if (orderState == OrderWidgateState.Closed)
        'dateClosed': DateTime.now().toIso8601String(),
    });
    if (orderState == OrderWidgateState.Closed) {
      // final invoiceModule = InvoiceQuotationModule.fromOrderId(orderid, isInvoice: false);
      // invoiceModule.generatePdf();
      // send pdf
    }
    return true;
  }
    Future<List<OrderModel>> fetchAllJobsByTitle(
      String jobType, String tenantId) async {
    var expenses = (await _orderModel.fetchWhereData(
            'title',  isEqualTo: jobType, 
            //orderBy: 'date'
            )).map<OrderModel>((snapshot) {
      return OrderModel.from({'id': snapshot.id, ...snapshot.data()});
    }).where((element) => element.tenantId == tenantId)
    .toList();

    return expenses;
  }

//fetch order amount from a specific vehicle
  Future<List<OrderModel>> fetchOrderByTruckId(
      String truckId, String tenantId) async {
    String? ordersId;
    List<OrderModel> orders = [];
    OrderModel orderModel;

    List<JobModel> jobs = await _jobModule.fetchJobsByTruck(truckId, tenantId);

    for (var order in jobs) {
      ordersId = order.orderId;
      orderModel = await getOrderById(ordersId!);
      orders.add(orderModel);
    }

    return orders;
  }

//amount by type
  var map = Map();
  Stream<List<OrderModel>> fetchOrderByTitle(String tenantId) {
    return _orderModel
        .fetchStreamsDataWhere(
      'tenantId', isEqualTo: tenantId,
      // orderBy: 'dateCreated',
    )
        .map<List<OrderModel>>((snapshot) {
      var _orders = snapshot.docs.map<OrderModel>((doc) {
        return OrderModel.from({...(doc.data() as Map), 'id': doc.id});
      }).toList();

      orders.clear();
      orders.addAll(_orders);
      return _orders;
    });
  }
}
