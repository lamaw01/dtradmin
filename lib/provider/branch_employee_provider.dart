import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/employee_model.dart';
import '../model/employee_of_branch_model.dart';
import '../service/http_service.dart';

class BranchEmployeeProvider with ChangeNotifier {
  // var _branchEmployeeList = <BranchEmployeeModel>[];
  // List<BranchEmployeeModel> get branchEmployeeList => _branchEmployeeList;

  var _employeeOfBranchList = <EmployeeOfBranchModel>[];
  List<EmployeeOfBranchModel> get employeeOfBranchList => _employeeOfBranchList;

  // var _employeeUnassignedBranch = <EmployeeOfBranchModel>[];
  // List<EmployeeOfBranchModel> get employeeUnassignedBranch =>
  //     _employeeUnassignedBranch;

  var _employeeAssignedBranch = <EmployeeOfBranchModel>[];
  List<EmployeeOfBranchModel> get employeeAssignedBranch =>
      _employeeAssignedBranch;

  var _employeeUnassigendBranchList = <EmployeeModel>[];
  List<EmployeeModel> get employeeUnassigendBranchList =>
      _employeeUnassigendBranchList;

  // var _employeeUnassigendBranchListDisplay = <EmployeeModel>[];
  // List<EmployeeModel> get employeeUnassigendBranchListDisplay =>
  //     _employeeUnassigendBranchListDisplay;

  // String fullName(BranchEmployeeModel m) {
  //   return '${m.lastName}, ${m.firstName} ${m.middleName}';
  // }

  String fullNameEmp(EmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  String fullNameEmpOfBranch(EmployeeOfBranchModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  // void removeAssignedDuplicate() {
  //   for (int i = 0; i < _employeeUnassignedBranch.length; i++) {
  //     for (int j = 0; j < _employeeAssignedBranch.length; j++) {
  //       if (_employeeUnassignedBranch[i].employeeId ==
  //           _employeeAssignedBranch[j].employeeId) {
  //         _employeeUnassignedBranch.removeAt(i);
  //       }
  //     }
  //   }
  // }

  void removeEmployeeAssignedDuplicate() {
    _employeeUnassigendBranchList.removeWhere((e) {
      bool result = false;
      for (final d in _employeeAssignedBranch) {
        if (d.employeeId == e.employeeId) {
          log('${d.lastName} ${e.lastName}');
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

  // void sortBranchListLastName() {
  //   _branchEmployeeList.sort((a, b) {
  //     var valueA = a.lastName.toLowerCase();
  //     var valueB = b.lastName.toLowerCase();
  //     return valueA.compareTo(valueB);
  //   });
  //   notifyListeners();
  // }

  // void sortBranchListId() {
  //   _branchEmployeeList.sort((a, b) {
  //     var valueA = a.id;
  //     var valueB = b.id;
  //     return valueA.compareTo(valueB);
  //   });
  //   notifyListeners();
  // }

  // bool checkEmployeeBranchId({
  //   required String employeeId,
  //   required String branchId,
  // }) {
  //   for (var employeeBranch in _branchEmployeeList) {
  //     if (employeeBranch.employeeId == employeeId &&
  //         employeeBranch.branchId == branchId) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // Future<void> getEmployeeBranch() async {
  //   try {
  //     final result = await HttpService.getEmployeeBranch();
  //     _branchEmployeeList = result;
  //   } catch (e) {
  //     debugPrint('$e getBranchEmployee');
  //   } finally {
  //     notifyListeners();
  //   }
  // }

  // Future<void> addEmployeeBranch({
  //   required String employeeId,
  //   required String branchId,
  // }) async {
  //   try {
  //     await HttpService.addEmployeeBranch(
  //       employeeId: employeeId,
  //       branchId: branchId,
  //     );
  //   } catch (e) {
  //     debugPrint('$e addEmployeeBranch');
  //   } finally {
  //     await getEmployeeBranch();
  //   }
  // }

  // Future<void> updateEmployeeBranch({
  //   required String employeeId,
  //   required String branchId,
  //   required int id,
  // }) async {
  //   try {
  //     await HttpService.updateEmployeeBranch(
  //       employeeId: employeeId,
  //       branchId: branchId,
  //       id: id,
  //     );
  //   } catch (e) {
  //     debugPrint('$e updateEmployeeBranch');
  //   } finally {
  //     await getEmployeeBranch();
  //   }
  // }

  // Future<void> deleteEmployeeBranch(
  //   int id,
  // ) async {
  //   try {
  //     await HttpService.deleteEmployeeBranch(id: id);
  //   } catch (e) {
  //     debugPrint('$e deleteEmployeeBranch');
  //   } finally {
  //     await getEmployeeBranch();
  //   }
  // }

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

  // Future<void> getEmployeeUnassignedBranch({
  //   required String branchId,
  // }) async {
  //   try {
  //     final result = await HttpService.getEmployeeUnassignedBranch(
  //       branchId: branchId,
  //     );
  //     _employeeUnassignedBranch = result;
  //   } catch (e) {
  //     debugPrint('$e getEmployeeUnassignedBranch');
  //   } finally {
  //     notifyListeners();
  //   }
  // }

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
      // await getEmployeeUnassignedBranch(branchId: branchId);
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
      // await getEmployeeUnassignedBranch(branchId: branchId);
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
