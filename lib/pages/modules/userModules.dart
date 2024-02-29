// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truck_manager/pages/models/fireBaseModel.dart';
import 'package:truck_manager/pages/models/responseModel.dart';
import 'package:truck_manager/pages/models/userModel.dart';
import 'package:truck_manager/pages/modules/uploadModules.dart';
import 'package:truck_manager/pages/ui/widgets/user_widget.dart';

class UserModule extends GetxController {
  final UserModel userModel = UserModel();
  Rx<UserModel> currentUser = Rx(UserModel());
  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isSuperUser = false.obs;
  RxBool isSuperCustomer = false.obs;
  String folder = "idNo";

  Future<UserModel> getUserById(String userId) async {
    final userMap = await userModel.fetchDataById(userId);
    return UserModel.fromMap({'id': userMap.id, ...(userMap.data() ?? {})});
  }

  UserModel? getStreamUserById(String? userId) {
    final _users = users.where((user) => user.id == userId).toList();

    if (_users.isNotEmpty) {
      return _users.first;
    }
    return null;
  }

  Future<void> setCurrentUser(String userId) async {
    final user = await getUserById(userId);

    currentUser.value = user;

    isSuperUser.value = user.userRole == UserWidgetType.admin ||
        user.userRole == UserWidgetType.manager;
    // isSuperUser.value = user.userRole != UserWidgetType.customer;
  }

  Stream<List<UserModel>> fetchUsers(String tenantId) {
    return userModel.fetchStreamsDataWhere(
      'tenantId', isEqualTo: tenantId,
    ).map<List<UserModel>>((streams) {
      var _users = streams.docs
          .map<UserModel>(
              (doc) => UserModel.fromMap({'id': doc.id, ...doc.data() as Map}))
          .toList();
      users.clear();
      users.addAll(_users);
      return _users;
    });
  }

  bool isCustomer = false;
  Stream<List<UserModel>> fetchUsersWhere(isCustomer, isDriver,String ? tenantId) {
   
    if (isCustomer == true) {
      return userModel
          .fetchStreamsDataWhere('role', isEqualTo: 'customer')
          .map<List<UserModel>>((streams) {
        var _users = streams.docs
            .map<UserModel>((doc) =>
                UserModel.fromMap({'id': doc.id, ...doc.data() as Map}))
                .where((element) => element.tenantId == tenantId)
            .toList();
        users.clear();
        users.addAll(_users);
        return _users;
      });
    }
    if (isDriver == true) {
      return userModel
          .fetchStreamsDataWhere('role', isEqualTo: 'driver')
          .map<List<UserModel>>((streams) {
        var _users = streams.docs
            .map<UserModel>((doc) =>
                UserModel.fromMap({'id': doc.id, ...doc.data() as Map}))
                .where((element) => element.tenantId == tenantId)
            .toList();
        users.clear();
        users.addAll(_users);
        return _users;
      });
    } else {
      
      return userModel
          .fetchStreamsDataWhereNotEqual('role', isNotEqualTo: 'customer')
          .map<List<UserModel>>((streams) {
        var _users = streams.docs
            .map<UserModel>((doc) =>
                UserModel.fromMap({'id': doc.id, ...doc.data() as Map}))
                .where((element) => element.tenantId == tenantId)
            .toList();
        users.clear();
        users.addAll(_users);
        return _users;
      });
    }
  }

  Stream<List<UserModel>> fetchDrivers(String tenantId) {
    return userModel
        .fetchStreamsDataWhere('role', isEqualTo: 'driver')
        .map<List<UserModel>>((streams) {
      var _users = streams.docs
          .map<UserModel>(
              (doc) => UserModel.fromMap({'id': doc.id, ...doc.data() as Map}))
              .where((element) => element.tenantId == tenantId)
          .toList();
      users.clear();
      users.addAll(_users);
      return _users;
    });
  }

  Future<List<UserModel>> fetchListUsers(String tenantId) async {
    final user = await userModel.fetchData();

    final useList = user
        .map((doc) => UserModel.fromMap({'id': doc.id, ...doc.data()}))
        .where((element) => element.tenantId == tenantId)
        .toList();

    return useList;
  }

//fetch user by truck

  Future<UserModel> fetchTruckByUser(String driverId) async {
    var user = await userModel.fetchDataById(driverId);
    return UserModel.fromMap({'id': user.id, ...user.data() as Map});
  }

  //fetch users Name
  Future<Map<String, dynamic>> fetchUsersName(String tenantId) async {
    final Map<String, dynamic> _map = {};
    var _users = await userModel.fetchWhereData("role",
        isEqualTo: 'driver');
               
    for (var user in _users) {
      
      if (user.id != "c9AP9R06ugY54uHMmhscoTarpix2") {
        
        _map.addAll({user.id: user.data()});
      }
    }

    // Map<String, dynamic> _test = await _map.remove((key, value) => key == 'c9AP9R06ugY54uHMmhscoTarpix2');
    return _map;
  }

  Future<Map<String, String>> fetchCustomersEmail(bool isCustomer) async {
    final Map<String, String> _map = {};
    if (isCustomer == true) {
      final _customers =
          await userModel.fetchWhereData('role', isEqualTo: 'customer');
      for (var customer in _customers) {
        print(customer.data());
        _map.addAll({customer.id: customer.data()['email']});
      }
      return _map;
    } else {
      final _customers = await userModel.fetchData();
      for (var customer in _customers) {
        _map.addAll({customer.id: customer.data()['email']});
      }
      return _map;
    }
  }

  Future<UserModel> fetchCustomerById(String customerId) async {
    final _docSnapshot = await userModel.fetchDataById(customerId);
    return UserModel.fromMap(
        {'id': _docSnapshot.id, ...(_docSnapshot.data() ?? {})});
  }

  // add user
  Future<ResponseModel> addUser(
      UserModel user, XFile? image, String password) async {
    // save firebase user
    String? imagePath;

    if (image != null) {
      imagePath = await uploadPics(image, folder);
      user.receiptPath = imagePath;
    }
    final _res = await FirebaseUserModule.createUser(
        user.email.toString(), password, user.tenantId.toString());
    
    if (_res.status == ResponseType.success) {
      // save user
      userModel.saveOnlineWithId(_res.body.toString(), user.asMap());
      return ResponseModel(ResponseType.success, 'User created');
    } else {
      return _res;
    }
  }

  Future<ResponseModel> createUser(String userId, UserModel user) async {
    await userModel.saveOnlineWithId(userId, user.asMap());

    return ResponseModel(ResponseType.success, "Sucessfully Added");
  }

  // update user
  Future<ResponseModel> updateUser(String id, Map<String, dynamic> map,
      {XFile? image}) async {
    String? imagePath;
    if (image != null) {
      imagePath = await uploadPics(image, folder);
      map['receiptPath'] = imagePath;
    }
    await userModel.updateOnline(id, map);
    return ResponseModel(ResponseType.success, 'user updated');
  }

  Future<ResponseModel> addCustomer(UserModel customerModel) async {
    await userModel.saveOnline(customerModel.asMap());
    return ResponseModel(ResponseType.success, 'Customer Created');
  }

  Future<ResponseModel> updateCustomers(
      String id, Map<String, dynamic> map) async {
    await userModel.updateOnline(id, map);
    return ResponseModel(ResponseType.success, 'Customer Updated');
  }
}
