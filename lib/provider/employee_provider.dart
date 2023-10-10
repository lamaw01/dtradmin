import 'package:dtradmin/model/branch_model.dart';
import 'package:flutter/material.dart';

import '../model/employee_model.dart';
import '../service/http_service.dart';

class EmployeeProvider with ChangeNotifier {
  var _employeeList = <EmployeeModel>[];
  List<EmployeeModel> get employeeList => _employeeList;

  String fullName(EmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  var _branchOfEmployeeList = <BranchModel>[];
  List<BranchModel> get branchOfEmployeeList => _branchOfEmployeeList;

  bool checkEmployeeId(String employeeId) {
    for (var employee in _employeeList) {
      if (employee.employeeId == employeeId) {
        return true;
      }
    }
    return false;
  }

  Future<void> getEmployee() async {
    try {
      final result = await HttpService.getEmployee();
      _employeeList = result;
    } catch (e) {
      debugPrint('$e getEmployee');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addEmployee({
    required String employeeId,
    required String firstName,
    required String lastName,
    required String middleName,
    required String weekSchedId,
    required int active,
  }) async {
    try {
      await HttpService.addEmployee(
        employeeId: employeeId,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        weekSchedId: weekSchedId,
        active: active,
      );
    } catch (e) {
      debugPrint('$e getEmployee');
    } finally {
      await getEmployee();
    }
  }

  Future<void> updateEmployee({
    required String employeeId,
    required String firstName,
    required String lastName,
    required String middleName,
    required String weekSchedId,
    required int active,
    required int id,
  }) async {
    try {
      await HttpService.updateEmployee(
        employeeId: employeeId,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        weekSchedId: weekSchedId,
        active: active,
        id: id,
      );
    } catch (e) {
      debugPrint('$e updateEmployee');
    } finally {
      await getEmployee();
    }
  }

  Future<void> deleteEmployee({
    required int id,
  }) async {
    try {
      await HttpService.deleteEmployee(
        id: id,
      );
    } catch (e) {
      debugPrint('$e deleteEmployee');
    } finally {
      await getEmployee();
    }
  }

  Future<void> getBranchOfEmployee({
    required String employeeId,
  }) async {
    try {
      var result = await HttpService.getBranchOfEmployee(
        employeeId: employeeId,
      );
      _branchOfEmployeeList = result;
    } catch (e) {
      debugPrint('$e getBranchOfEmployee');
    }
  }
}
