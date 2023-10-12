import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/branch_employee.dart';
import '../model/employee_of_branch_model.dart';
import '../service/http_service.dart';

class BranchEmployeeProvider with ChangeNotifier {
  var _branchEmployeeList = <BranchEmployeeModel>[];
  List<BranchEmployeeModel> get branchEmployeeList => _branchEmployeeList;

  var _employeeOfBranchList = <EmployeeOfBranchModel>[];
  List<EmployeeOfBranchModel> get employeeOfBranchList => _employeeOfBranchList;

  var _employeeUnassignedBranch = <EmployeeOfBranchModel>[];
  List<EmployeeOfBranchModel> get employeeUnassignedBranch =>
      _employeeUnassignedBranch;

  var _employeeAssignedBranch = <EmployeeOfBranchModel>[];
  List<EmployeeOfBranchModel> get employeeAssignedBranch =>
      _employeeAssignedBranch;

  String fullName(BranchEmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  String fullNameEmpOfBranch(EmployeeOfBranchModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  void removeAssignedDuplicate() {
    for (int i = 0; i < _employeeUnassignedBranch.length; i++) {
      for (int j = 0; j < _employeeAssignedBranch.length; j++) {
        if (_employeeUnassignedBranch[i].employeeId ==
            _employeeAssignedBranch[j].employeeId) {
          _employeeUnassignedBranch.removeAt(i);
        }
      }
    }
  }

  List<String> assignedListToAdd() {
    var listString = <String>[];
    for (int i = 0; i < _employeeUnassignedBranch.length; i++) {
      if (_employeeUnassignedBranch[i].isSelected) {
        listString.add(_employeeUnassignedBranch[i].employeeId);
        log('true ${_employeeUnassignedBranch[i].lastName}');
      }
    }
    return listString;
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

  Future<void> getEmployeeOfBranch({
    required String branchId,
  }) async {
    try {
      final result = await HttpService.getEmployeeOfBranch(
        branchId: branchId,
      );
      _employeeOfBranchList = result;
    } catch (e) {
      debugPrint('$e getEmployeeOfBranch');
    } finally {
      notifyListeners();
    }
  }

  Future<void> getEmployeeUnassignedBranch({
    required String branchId,
  }) async {
    try {
      final result = await HttpService.getEmployeeUnassignedBranch(
        branchId: branchId,
      );
      _employeeUnassignedBranch = result;
    } catch (e) {
      debugPrint('$e getEmployeeUnassignedBranch');
    } finally {
      notifyListeners();
    }
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
      debugPrint('$e getEmployeeUnassignedBranch');
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
      await getEmployeeAssignedBranch(branchId: branchId);
      await getEmployeeUnassignedBranch(branchId: branchId);
      removeAssignedDuplicate();
    }
  }
}
