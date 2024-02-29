import 'package:flutter/material.dart';
import 'package:truck_manager/pages/models/jobs_model.dart';
import 'package:truck_manager/pages/models/model.dart';
import 'package:truck_manager/pages/modules/expenses_modules.dart';
import 'package:truck_manager/pages/modules/job_module.dart';

import 'expenses_model.dart';

class TrucksModel extends Model {
  final ExpenseModule _expenseModule = ExpenseModule();
  final JobModule _jobModule = JobModule();
  TrucksModel({
    this.id,
    this.tankCapity,
    this.vehicleRegNo,
    this.tenantId,
    this.vehicleLoad,
    this.category,
    bool? active,
    bool? deleted,
  }) : super('trucks') {
    isActive = active ?? true;
    isDeleted = deleted ?? false;
  }
  String? vehicleRegNo;
  String? tankCapity;
  String? tenantId;
  String? vehicleLoad;
  String? id;
  String? category;
  bool isActive = true;
  bool isDeleted = false;

  TrucksModel.fromMap(Map map) : super('trucks') {
    id = map['id'];
    vehicleRegNo = map['vehicleRegNo'];
    tankCapity = map['tankCapity'];
    tenantId = map['tenantId'];
    vehicleLoad = map['vehicleLoad'];
    isActive = map['isActive'] ?? true;
    isDeleted = map['isDeleted'] ?? false;
  }

  Future<List<ExpenseModel>> fetchExpenseByTruck(String? tenantId,DateTimeRange dateTimeRange) {
    var expenses =
        _expenseModule.fetchExpenseByTruckAndDate(id!, tenantId,dateTimeRange);
    return expenses.first;
  }

  Future<List<JobModel>> fetchJobsByTruck(String? tenantId,DateTimeRange dateTimeRange) {
    var jobs = _jobModule.fetchJobsByVehicleId(id!,tenantId);
    return jobs;
  }

  List<double> reportTotal = [0, 0];
  Future<List<double>> getTotals(String? tenantId,DateTimeRange dateTimeRange) async {
    var expenses = (await fetchExpenseByTruck(tenantId,dateTimeRange)).fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + (double.tryParse(element.totalAmount!) ?? 0.0));
    

    var job = (await fetchJobsByTruck(tenantId,dateTimeRange))
        .fold<double>(0.0, (previousValue, element) => previousValue + (200.0));
        return [job, expenses];
  }

  Map<String, dynamic> asMap() {
    return {
      'vehicleRegNo': vehicleRegNo,
      'tankCapity': tankCapity,
      'tenantId': tenantId,
      'vehicleLoad': vehicleLoad,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }
}
