import 'dart:developer';

import 'package:flutter/material.dart';

// import '../model/department_employee_model.dart';
import '../model/employee_model.dart';
import '../model/employee_of_department.dart';
import '../service/http_service.dart';

class DepartmentEmployeeProvider with ChangeNotifier {
  var _employeeUnassigendDepartmentList = <EmployeeModel>[];
  List<EmployeeModel> get employeeUnassigendDepartmentList =>
      _employeeUnassigendDepartmentList;

  var _employeeAssignedDepartment = <EmployeeOfDepartmentModel>[];
  List<EmployeeOfDepartmentModel> get employeeAssignedDepartment =>
      _employeeAssignedDepartment;

  String fullNameEmp(EmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  String fullNameEmpOfDepartment(EmployeeOfDepartmentModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  void removeEmployeeAssignedDuplicate() {
    _employeeUnassigendDepartmentList.removeWhere((e) {
      bool result = false;
      for (final d in _employeeAssignedDepartment) {
        if (d.employeeId == e.employeeId) {
          return true;
        }
      }
      return result;
    });
  }

  List<String> assignedListToAdd() {
    var listString = <String>[];
    for (int i = 0; i < _employeeUnassigendDepartmentList.length; i++) {
      if (_employeeUnassigendDepartmentList[i].isSelected) {
        listString.add(_employeeUnassigendDepartmentList[i].employeeId);
        log('true ${_employeeUnassigendDepartmentList[i].lastName}');
      }
    }
    return listString;
  }

  List<String> unAssignedListToAdd() {
    var listString = <String>[];
    for (int i = 0; i < _employeeAssignedDepartment.length; i++) {
      if (_employeeAssignedDepartment[i].isSelected) {
        listString.add(_employeeAssignedDepartment[i].employeeId);
        log('true ${_employeeAssignedDepartment[i].lastName}');
      }
    }
    return listString;
  }

  Future<void> getEmployeeAssignedDepartment({
    required String departmentId,
  }) async {
    try {
      final result = await HttpService.getEmployeeAssignedDepartment(
        departmentId: departmentId,
      );
      _employeeAssignedDepartment = result;
    } catch (e) {
      debugPrint('$e getEmployeeAssignedDepartment');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addEmployeeDepartmentMulti({
    required String departmentId,
    required List<String> employeeId,
  }) async {
    log(employeeId.toString());
    try {
      await HttpService.addEmployeeDepartmentMulti(
          departmentId: departmentId, employeeId: employeeId);
    } catch (e) {
      debugPrint('$e addEmployeeDepartmentMulti');
    } finally {
      await getEmployeeBranchUnassigned();
      await getEmployeeAssignedDepartment(departmentId: departmentId);
      removeEmployeeAssignedDuplicate();
      // await getEmployeeUnassignedDepartment(departmentId: departmentId);
      // removeAssignedDuplicate();
    }
  }

  Future<void> deleteEmployeeDepartmentMulti({
    required String departmentId,
    required List<String> employeeId,
  }) async {
    log(employeeId.toString());
    try {
      await HttpService.deleteEmployeeDepartmentMulti(
          departmentId: departmentId, employeeId: employeeId);
    } catch (e) {
      debugPrint('$e deleteEmployeeDepartmentMulti');
    } finally {
      // await getEmployeeUnassignedDepartment(departmentId: departmentId);
      await getEmployeeBranchUnassigned();
      await getEmployeeAssignedDepartment(departmentId: departmentId);
      removeEmployeeAssignedDuplicate();
      // removeAssignedDuplicate();
    }
  }

  Future<void> getEmployeeBranchUnassigned() async {
    try {
      final result = await HttpService.getEmployee();
      _employeeUnassigendDepartmentList = result;
    } catch (e) {
      debugPrint('$e getEmployee');
    } finally {
      notifyListeners();
    }
  }
}
