import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truck_manager/pages/models/responseModel.dart';
import 'package:truck_manager/pages/models/userModel.dart';
import 'package:truck_manager/pages/modules/job_module.dart';
import 'package:truck_manager/pages/modules/uploadModules.dart';
import 'package:truck_manager/pages/ui/widgets/order_details_widget.dart';

import '../models/expenses_model.dart';
import '../ui/widgets/user_widget.dart';

class ExpenseModule extends GetXState {
  final ExpenseModel _expensesModel = ExpenseModel();
  final JobModule _jobModule = JobModule();
  String folder = "receipts";

  void init(UserModel user, String? tenantId) {
    // fetch jobs, drivers & truck
    fetchAllExpenses(user, tenantId);
  }

  Stream<List<ExpenseModel>> fetchAllExpenses(UserModel user, String? tenantId) {
    if (user.userRole == UserWidgetType.admin ||
        user.userRole == UserWidgetType.manager) {
      return _expensesModel
          .fetchStreamsDataWhere('tenantId',
              isEqualTo: tenantId, 
              //orderBy: 'date'
              )
          .map<List<ExpenseModel>>((snapshot) {
        return snapshot.docs
            .map<ExpenseModel>((doc) =>
                ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}))
            .toList();
      });
    } else {
      return _expensesModel
          .fetchStreamsDataWhere('userId', isEqualTo: user.id, 
         // orderBy: 'date'
          )
          .map<List<ExpenseModel>>((snapshot) {
        return snapshot.docs
            .map<ExpenseModel>((doc) =>
                ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}))
            .toList();
      });
    }
  }

//fetch Expenses By User

//fetch Expenses
  Stream<List<ExpenseModel>> fetchExpenses(String tenantId) {
    return _expensesModel
        .fetchStreamsDataWhere('tenantId', isEqualTo: tenantId,
        // orderBy: 'date'
         )
        .map<List<ExpenseModel>>((snapshot) {
      return snapshot.docs
          .map<ExpenseModel>((doc) =>
              ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}))
          .toList();
    });
  }
  //fetch Expenses By date

  Stream<List<ExpenseModel>> fetchByExpensesByState(
      String state, UserModel user, String tenantId) {
    if (user.userRole == UserWidgetType.admin ||
        user.userRole == UserWidgetType.manager) {
      return _expensesModel
          .fetchStreamsDataWhere("tenantId",isEqualTo: tenantId 
          //orderBy: 'date'
          )
          .map<List<ExpenseModel>>((snapshot) {
        var _expensesByState= snapshot.docs
            .map<ExpenseModel>((doc) =>
                ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}));
               if (state == "All"){
           return  _expensesByState.toList();
                
               }
               else {
             _expensesByState=_expensesByState.where((element) => element.state == state);
                return  _expensesByState.toList();
               }
              
      });
    } else {
      return _expensesModel
          .fetchStreamsDataWhere("userId", isEqualTo: user.id, 
          //orderBy: 'date'
          )
          .map<List<ExpenseModel>>((snapshot) {
        var __expensesByState= snapshot.docs
            .map<ExpenseModel>((doc) =>
                ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}));
           
           
               if (state == "All"){
              __expensesByState= __expensesByState.where((element)=> element.tenantId == tenantId);
           
           return  __expensesByState.toList();
                
               }
               else {
             __expensesByState=__expensesByState.where((element) => element.state == state && element.tenantId == tenantId);
                return  __expensesByState.toList();
               }
            
      });
      
    }
  }

  //fetch expenses by truck
  Stream<List<ExpenseModel>> fetchExpenseByTruckAndDate(
      String truckId, String? tenantId, DateTimeRange dateRange) {
    return _expensesModel
        .fetchStreamsDataWhere(
      'date',
      //orderBy: 'date',
      isGreaterThanOrEqualTo: dateRange.start.toIso8601String(),
      isLessThanOrEqualTo: dateRange.end.toIso8601String(),
    )
        .map<List<ExpenseModel>>((snapshot) {
      return snapshot.docs
          .map<ExpenseModel>((doc) =>
              ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}))
          .where((element) =>
              element.truckId == truckId && element.tenantId == tenantId)
          .toList();
    });
  }

//fetch expenses truck and user
  Stream<List<ExpenseModel>> fetchByTruckExpenses(
      String truckId, UserModel user, String tenantId) {
    if (user.userRole == UserWidgetType.admin ||
        user.userRole == UserWidgetType.manager) {
      return _expensesModel
          .fetchStreamsDataWhere("truckId", isEqualTo: truckId, 
          //orderBy: 'date'
          )
          .map<List<ExpenseModel>>((snapshot) {
        return snapshot.docs
            .map<ExpenseModel>((doc) =>
                ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}))
            .where((element) => element.tenantId == tenantId)
            .toList();
      });
    } else {
      return _expensesModel
          .fetchStreamsDataWhere("truckId", isEqualTo: truckId, 
          //orderBy: 'date'
          )
          .map<List<ExpenseModel>>((snapshot) {
        return snapshot.docs
            .map<ExpenseModel>((doc) =>
                ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}))
            .where((element) => element.userId == user.id && element.tenantId == tenantId)
            .toList();
      });
    }
  }

  // fetch expense where
  Stream<List<ExpenseModel>> fetchAllWhereDateRangeExpenses(
      DateTimeRange dateRange, String ?tenantId) {
    return _expensesModel
        .fetchStreamsDataWhere(
      'date',
      isEqualTo: tenantId,
      //orderBy: 'date',
      isGreaterThanOrEqualTo: dateRange.start.toIso8601String(),
      isLessThanOrEqualTo: dateRange.end.toIso8601String(),
    )
        .map<List<ExpenseModel>>((snapshot) {
      return snapshot.docs
      
          .map<ExpenseModel>((doc) =>
              ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}))
              .where((element) => element.tenantId == tenantId)
          .toList();
    });
  }

//fetch expenses by date and
  // fetch expense by job
  Stream<List<ExpenseModel>> fetchByJobExpenses(
      String jobId, String tenantId, UserModel user) {
    if (user.userRole == UserWidgetType.admin ||
        user.userRole == UserWidgetType.manager) {
      var expenses = _expensesModel
          .fetchStreamsDataWhere('jobId', isEqualTo: jobId, 
          //orderBy: 'date'
          )
          .map<List<ExpenseModel>>((snapshot) {
        return snapshot.docs
            .map<ExpenseModel>((doc) =>
                ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}))
            .where((element) => element.tenantId == tenantId)
            .toList();
      });
      return expenses;
    } else {
      var expenses = _expensesModel
          .fetchStreamsDataWhere('jobId', isEqualTo: jobId, 
          //orderBy: 'date'
          )
          .map<List<ExpenseModel>>((snapshot) {
        return snapshot.docs
            .map<ExpenseModel>((doc) =>
                ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}))
            .where((element) =>
                element.userId == user.id && element.tenantId == tenantId)
            .toList();
      });
      return expenses;
    }
  }

  Stream<List<ExpenseModel>> fetchByJobExpensesNoUser(
      String jobId, String tenantId) {
    var expenses = _expensesModel
        .fetchStreamsDataWhere('jobId', isEqualTo: jobId, 
        //orderBy: 'date'
        ).map<List<ExpenseModel>>((snapshot) {
      return snapshot.docs
          .map<ExpenseModel>((doc) =>
              ExpenseModel.fromMap({'id': doc.id, ...doc.data() as Map}))
          .where((element) => element.tenantId == tenantId)
          .toList();
    });

    return expenses;
  }

  Future<List<ExpenseModel>> fetchAllExpensesByJob(
      String jobId, String tenantId) async {
    var expenses = (await _expensesModel.fetchWhereData('jobId', 
    isEqualTo: jobId, 
    //orderBy: 'date'
    ))
        .map<ExpenseModel>((snapshot) {
      return ExpenseModel.fromMap({'id': snapshot.id, ...snapshot.data()});
    }).where((element) => element.tenantId == tenantId)
    .toList();

    return expenses;
  }

  ///fetch expense by expenseType
  Future<List<ExpenseModel>> fetchAllExpensesByExpenseTypes(
      String expenseType, String tenantId) async {
    var expenses = (await _expensesModel.fetchWhereData(
            'expenseType',  isEqualTo: expenseType, 
            //orderBy: 'date'
            )).map<ExpenseModel>((snapshot) {
      return ExpenseModel.fromMap({'id': snapshot.id, ...snapshot.data()});
    }).where((element) => element.tenantId == tenantId)
    .toList();

    return expenses;
  }

//fetch expense by Order
  Future<List<ExpenseModel>> fetchByExenpseByOrder(
      String orderId, String tenantId) async {
    var job = await _jobModule.fetchJobsByOrderId(orderId, tenantId);
    if (job == null) {
      return [];
    }
    var expense = await fetchAllExpensesByJob(job.id!, tenantId);
    return expense;
  }

  // add
  Future<bool> addExpense(ExpenseModel expense, XFile? image) async {
    // save image to server then get image path
    String? imagePath;
    if (image != null) {
      imagePath = await uploadPics(image, folder);
      expense.receiptPath = imagePath;
    }

    await _expensesModel.saveOnline(expense.asMap());
    return true;
  }

//UPDATE EXPENSE
  Future<ResponseModel> updateExpense(String id, Map<String, dynamic> map,
      {XFile? image}) async {
    String? imagePath;
    if (image != null) {
      imagePath = await uploadPics(image, folder);
      map['receiptPath'] = imagePath;
    }

    await _expensesModel.updateOnline(id, map);
    return ResponseModel(ResponseType.success, 'Expense Updated');
  }

  Future<bool> updateExpenseState(
      String expenseId, OrderWidgateState expenseSate) async {
    await _expensesModel.updateOnline(expenseId, {
      'state': expenseSate.value,
      if (expenseSate == OrderWidgateState.Open ||
          expenseSate == OrderWidgateState.Rejected)
        'dateApproved': DateTime.now().toIso8601String(),
      if (expenseSate == OrderWidgateState.Rejected)
        'dateClosed': DateTime.now().toIso8601String(),
      'dateRejected': DateTime.now().toIso8601String(),
      if (expenseSate == OrderWidgateState.Closed)
        'dateClosed': DateTime.now().toIso8601String(),
    });
    return true;
  }

  Future<void> deleteExpenses(String id) async {
    await _expensesModel.deleteOnline(id);
  }

  Future<List<ExpenseModel>?> fetchExpensesByUser(
      UserModel userModel, String tenantId) async {
    final _res = (await _expensesModel.fetchWhereData('userId', 
            isEqualTo: userModel.id,
            //orderBy: 'dateCreated'
            )).map((documentSnapshot) {
      return ExpenseModel.fromMap(
          {'id': documentSnapshot.id, ...documentSnapshot.data()});
    }).where((element) => element.tenantId == tenantId)
    .toList();
    return _res;
  }
}
