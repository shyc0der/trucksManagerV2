import 'package:truck_manager/pages/models/expenseType.dart';
import 'package:truck_manager/pages/modules/expenses_modules.dart';

class ExpenseTypeModule {
  final ExpenseType _expenseType = ExpenseType();
  final ExpenseModule _expenseModule = ExpenseModule();
  Future<bool> addExpenseType(ExpenseType expenseType) async {
    await _expenseType.saveOnline(expenseType.asMap());
    return true;
  }

  Stream<List<ExpenseType>> fetchExpenseType(String tenantId) {
    return _expenseType
        .fetchStreamsDataWhere(
      'tenantId',
      isEqualTo: tenantId,
    )
        .map((snapshots) {
      return snapshots.docs
          .map<ExpenseType>((doc) =>
              ExpenseType.fromMap({'id': doc.id, ...doc.data() as Map}))
          .toList();
    });
  }

  Future<List<String>> fetchExpenseTypesAsString(String tenantId) async {
    return (await _expenseType.fetchWhereData('tenantId', isEqualTo: tenantId))
        .map((snapshot) => snapshot.data()['name'].toString())
        .toList();
  }

  Future<void> deleteExpenseTpe(String id) async {
    await _expenseType.deleteOnline(id);
  }

  Future<bool> checkIfExpenseTypeExists(String name, String tenantId) async {
    bool test;
    var expensesType =
        await _expenseModule.fetchAllExpensesByExpenseTypes(name, tenantId);

    if (expensesType == [] || expensesType.isEmpty) {
      test = false;
    } else {
      test = true;
    }

    return test;
  }
}
