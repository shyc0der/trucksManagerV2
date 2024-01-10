import 'package:get/get.dart';
import 'package:truck_manager/pages/modules/order_modules.dart';
import 'package:truck_manager/pages/modules/userModules.dart';
import '../../modules/trucks_modules.dart';

class Constants {
  UserModule userModule = Get.find<UserModule>();
  TruckModules truckModules = Get.find<TruckModules>();
  OrderModules orderModules = Get.find<OrderModules>();

  String driverName(String userId) {
    var driver = userModule.getStreamUserById(userId);

    var name = '${driver?.firstName ?? ''}  ${driver?.lastName ?? ''}';
    return name;
  }

  String truckNumber(String truckId) {
    var truck = truckModules.getTruckById(truckId);
    var truckNo = truck?.vehicleRegNo ?? '';
    return truckNo;
  }

  String? fetchOrder(String? orderId) {
   // print(orderId);
    var res = orderModules.getOrderByJobId(orderId!);
    //print(res?.asMap());
    return res?.title;
  }
}
