import 'package:flutter/material.dart';

import '../model/branch_employee.dart';
import '../service/http_service.dart';

class BranchEmployeeProvider with ChangeNotifier {
  var _branchEmployeeList = <BranchEmployeeModel>[];
  List<BranchEmployeeModel> get branchEmployeeList => _branchEmployeeList;

  String fullName(BranchEmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  void sortBranchListLastName() {
    _branchEmployeeList.sort((a, b) {
      var valueA = a.lastName.toLowerCase();
      var valueB = b.lastName.toLowerCase();
      return valueA.compareTo(valueB);
    });
    notifyListeners();
  }

  void sortBranchListId() {
    _branchEmployeeList.sort((a, b) {
      var valueA = a.id;
      var valueB = b.id;
      return valueA.compareTo(valueB);
    });
    notifyListeners();
  }

  bool checkEmployeeBranchId({
    required String employeeId,
    required String branchId,
  }) {
    for (var employeeBranch in _branchEmployeeList) {
      if (employeeBranch.employeeId == employeeId &&
          employeeBranch.branchId == branchId) {
        return true;
      }
    }
    return false;
  }

  Future<void> getEmployeeBranch() async {
    try {
      final result = await HttpService.getEmployeeBranch();
      _branchEmployeeList = result;
    } catch (e) {
      debugPrint('$e getBranchEmployee');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addEmployeeBranch({
    required String employeeId,
    required String branchId,
  }) async {
    try {
      await HttpService.addEmployeeBranch(
        employeeId: employeeId,
        branchId: branchId,
      );
    } catch (e) {
      debugPrint('$e addEmployeeBranch');
    } finally {
      await getEmployeeBranch();
    }
  }

  Future<void> updateEmployeeBranch({
    required String employeeId,
    required String branchId,
    required int id,
  }) async {
    try {
      await HttpService.updateEmployeeBranch(
        employeeId: employeeId,
        branchId: branchId,
        id: id,
      );
    } catch (e) {
      debugPrint('$e updateEmployeeBranch');
    } finally {
      await getEmployeeBranch();
    }
  }

  Future<void> deleteEmployeeBranch(
    int id,
  ) async {
    try {
      await HttpService.deleteEmployeeBranch(id: id);
    } catch (e) {
      debugPrint('$e deleteEmployeeBranch');
    } finally {
      await getEmployeeBranch();
    }
  }
}
