import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/department_employee_model.dart';
import '../model/employee_of_department.dart';
import '../service/http_service.dart';

class DepartmentEmployeeProvider with ChangeNotifier {
  var _departmentEmployeeList = <DepartmentEmployeeModel>[];
  List<DepartmentEmployeeModel> get departmentEmployeeList =>
      _departmentEmployeeList;

  var _employeeUnassignedDepartment = <EmployeeOfDepartmentModel>[];
  List<EmployeeOfDepartmentModel> get employeeUnassignedDepartment =>
      _employeeUnassignedDepartment;

  var _employeeAssignedDepartment = <EmployeeOfDepartmentModel>[];
  List<EmployeeOfDepartmentModel> get employeeAssignedDepartment =>
      _employeeAssignedDepartment;

  String fullName(DepartmentEmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  String fullNameEmpOfDepartment(EmployeeOfDepartmentModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  void removeAssignedDuplicate() {
    for (int i = 0; i < _employeeUnassignedDepartment.length; i++) {
      for (int j = 0; j < _employeeAssignedDepartment.length; j++) {
        if (_employeeUnassignedDepartment[i].employeeId ==
            _employeeAssignedDepartment[j].employeeId) {
          _employeeUnassignedDepartment.removeAt(i);
        }
      }
    }
  }

  List<String> assignedListToAdd() {
    var listString = <String>[];
    for (int i = 0; i < _employeeUnassignedDepartment.length; i++) {
      if (_employeeUnassignedDepartment[i].isSelected) {
        listString.add(_employeeUnassignedDepartment[i].employeeId);
        log('true ${_employeeUnassignedDepartment[i].lastName}');
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
    for (var employeeDepartment in _departmentEmployeeList) {
      if (employeeDepartment.employeeId == employeeId &&
          employeeDepartment.departmentId == departmentId) {
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

  Future<void> getEmployeeUnassignedDepartment({
    required String departmentId,
  }) async {
    try {
      final result = await HttpService.getEmployeeUnassignedDepartment(
        departmentId: departmentId,
      );
      _employeeUnassignedDepartment = result;
    } catch (e) {
      debugPrint('$e getEmployeeUnassignedDepartment');
    } finally {
      notifyListeners();
    }
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
      await getEmployeeAssignedDepartment(departmentId: departmentId);
      await getEmployeeUnassignedDepartment(departmentId: departmentId);
      removeAssignedDuplicate();
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
      await getEmployeeUnassignedDepartment(departmentId: departmentId);
      await getEmployeeAssignedDepartment(departmentId: departmentId);
      removeAssignedDuplicate();
    }
  }
}
