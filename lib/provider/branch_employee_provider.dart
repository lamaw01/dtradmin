import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/employee_model.dart';
import '../model/employee_of_branch_model.dart';
import '../service/http_service.dart';

class BranchEmployeeProvider with ChangeNotifier {
  var _employeeAssignedBranch = <EmployeeOfBranchModel>[];
  List<EmployeeOfBranchModel> get employeeAssignedBranch =>
      _employeeAssignedBranch;

  var _employeeUnassigendBranchList = <EmployeeModel>[];
  List<EmployeeModel> get employeeUnassigendBranchList =>
      _employeeUnassigendBranchList;

  String fullNameEmp(EmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  String fullNameEmpOfBranch(EmployeeOfBranchModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  void removeEmployeeAssignedDuplicate() {
    _employeeUnassigendBranchList.removeWhere((e) {
      bool result = false;
      for (final d in _employeeAssignedBranch) {
        if (d.employeeId == e.employeeId) {
          return true;
        }
      }
      return result;
    });
  }

  List<String> assignedListToAdd() {
    var listString = <String>[];
    for (int i = 0; i < _employeeUnassigendBranchList.length; i++) {
      if (_employeeUnassigendBranchList[i].isSelected) {
        listString.add(_employeeUnassigendBranchList[i].employeeId);
      }
    }
    return listString;
  }

  List<String> unAssignedListToAdd() {
    var listString = <String>[];
    for (int i = 0; i < _employeeAssignedBranch.length; i++) {
      if (_employeeAssignedBranch[i].isSelected) {
        listString.add(_employeeAssignedBranch[i].employeeId);
      }
    }
    return listString;
  }

  Future<void> getEmployeeAssignedBranch({
    required String branchId,
  }) async {
    try {
      final result = await HttpService.getEmployeeAssignedBranch(
        branchId: branchId,
      );
      _employeeAssignedBranch = result;
    } catch (e) {
      debugPrint('$e getEmployeeAssignedBranch');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addEmployeeBranchMulti({
    required String branchId,
    required List<String> employeeId,
  }) async {
    log(employeeId.toString());
    try {
      await HttpService.addEmployeeBranchMulti(
          branchId: branchId, employeeId: employeeId);
    } catch (e) {
      debugPrint('$e addEmployeeBranchMulti');
    } finally {
      await getEmployeeBranchUnassigned();
      await getEmployeeAssignedBranch(branchId: branchId);
      removeEmployeeAssignedDuplicate();
    }
  }

  Future<void> deleteEmployeeBranchMulti({
    required String branchId,
    required List<String> employeeId,
  }) async {
    log(employeeId.toString());
    try {
      await HttpService.deleteEmployeeBranchMulti(
          branchId: branchId, employeeId: employeeId);
    } catch (e) {
      debugPrint('$e deleteEmployeeBranchMulti');
    } finally {
      await getEmployeeBranchUnassigned();
      await getEmployeeAssignedBranch(branchId: branchId);
      removeEmployeeAssignedDuplicate();
    }
  }

  Future<void> getEmployeeBranchUnassigned() async {
    try {
      final result = await HttpService.getEmployee();
      _employeeUnassigendBranchList = result;
    } catch (e) {
      debugPrint('$e getEmployee');
    } finally {
      notifyListeners();
    }
  }
}
