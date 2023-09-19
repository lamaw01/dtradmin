import 'package:flutter/material.dart';

import '../model/department_employee_model.dart';
import '../service/http_service.dart';

class DepartmentEmployeeProvider with ChangeNotifier {
  var _departmentEmployeeList = <DepartmentEmployeeModel>[];
  List<DepartmentEmployeeModel> get departmentEmployeeList =>
      _departmentEmployeeList;

  String fullName(DepartmentEmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  void sortEmployeeDepartmentListLastName() {
    _departmentEmployeeList.sort((a, b) {
      var valueA = a.lastName.toLowerCase();
      var valueB = b.lastName.toLowerCase();
      return valueA.compareTo(valueB);
    });
    notifyListeners();
  }

  void sortEmployeeDepartmentListId() {
    _departmentEmployeeList.sort((a, b) {
      var valueA = a.id;
      var valueB = b.id;
      return valueA.compareTo(valueB);
    });
    notifyListeners();
  }

  bool checkEmployeeDepartmentId({
    required String employeeId,
    required String departmentId,
  }) {
    for (var employeeBranch in _departmentEmployeeList) {
      if (employeeBranch.employeeId == employeeId &&
          employeeBranch.departmentId == departmentId) {
        return true;
      }
    }
    return false;
  }

  Future<void> getDepartmentEmployee() async {
    try {
      final result = await HttpService.getDepartmentEmployee();
      _departmentEmployeeList = result;
    } catch (e) {
      debugPrint('$e getDepartmentEmployee');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addDepartmentEmployee({
    required String departmentId,
    required String employeeId,
  }) async {
    try {
      await HttpService.addEmployeeDepartment(
          departmentId: departmentId, employeeId: employeeId);
    } catch (e) {
      debugPrint('$e addDepartmentEmployee');
    } finally {
      await getDepartmentEmployee();
    }
  }

  Future<void> updateDepartmentEmployee({
    required String departmentId,
    required String employeeId,
    required int id,
  }) async {
    try {
      await HttpService.updateEmployeeDepartment(
          departmentId: departmentId, employeeId: employeeId, id: id);
    } catch (e) {
      debugPrint('$e updateDepartmentEmployee');
    } finally {
      await getDepartmentEmployee();
    }
  }

  Future<void> deleteDepartmentEmployee({
    required int id,
  }) async {
    try {
      await HttpService.deleteEmployeeDepartment(id: id);
    } catch (e) {
      debugPrint('$e deleteDepartmentEmployee');
    } finally {
      await getDepartmentEmployee();
    }
  }
}
