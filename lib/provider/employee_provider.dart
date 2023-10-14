import 'package:dtradmin/model/branch_model.dart';
import 'package:dtradmin/model/department_model.dart';
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

  var _departmentOfEmployeeList = <DepartmentModel>[];
  List<DepartmentModel> get departmentOfEmployeeList =>
      _departmentOfEmployeeList;

  var _isSearching = false;
  bool get isSearching => _isSearching;

  final _searchEmployeeList = <EmployeeModel>[];
  List<EmployeeModel> get searchEmployeeList => _searchEmployeeList;

  void changeStateSearching(bool state) {
    _isSearching = state;
    notifyListeners();
  }

  void clearSearchList() {
    _searchEmployeeList.clear();
    changeStateSearching(false);
  }

  bool checkEmployeeId(String employeeId) {
    for (var employee in _employeeList) {
      if (employee.employeeId == employeeId) {
        return true;
      }
    }
    return false;
  }

  void sortEmployeeListName() {
    _employeeList.sort((a, b) {
      var valueA = a.lastName.toLowerCase();
      var valueB = b.lastName.toLowerCase();
      return valueA.compareTo(valueB);
    });
    notifyListeners();
  }

  void sortEmployeeListId() {
    _employeeList.sort((a, b) {
      var valueA = a.id;
      var valueB = b.id;
      return valueA.compareTo(valueB);
    });
    notifyListeners();
  }

  void sortEmployeeListEmpId() {
    _employeeList.sort((a, b) {
      var valueA = a.employeeId;
      var valueB = b.employeeId;
      return valueA.compareTo(valueB);
    });
    notifyListeners();
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

  Future<void> addEmployeeMultiBranch({
    required String employeeId,
    required List<String> branchId,
  }) async {
    try {
      await HttpService.addEmployeeMultiBranch(
        employeeId: employeeId,
        branchId: branchId,
      );
    } catch (e) {
      debugPrint('$e addEmployeeMultiBranch');
    }
  }

  Future<void> deleteEmployeeMultiBranch({
    required String employeeId,
    required List<String> branchId,
  }) async {
    try {
      await HttpService.deleteEmployeeMultiBranch(
          employeeId: employeeId, branchId: branchId);
    } catch (e) {
      debugPrint('$e deleteEmployeeMultiBranch');
    }
  }

  Future<void> getDepartmentOfEmployee({
    required String employeeId,
  }) async {
    try {
      var result = await HttpService.getDepartmentOfEmployee(
        employeeId: employeeId,
      );
      _departmentOfEmployeeList = result;
    } catch (e) {
      debugPrint('$e getDepartmentOfEmployee');
    }
  }

  Future<void> addEmployeeMultiDepartment({
    required String employeeId,
    required List<String> departmentId,
  }) async {
    try {
      await HttpService.addEmployeeMultiDepartment(
        employeeId: employeeId,
        departmentId: departmentId,
      );
    } catch (e) {
      debugPrint('$e addEmployeeMultiDepartment');
    }
  }

  Future<void> deleteEmployeeMultiDepartment({
    required String employeeId,
    required List<String> departmentId,
  }) async {
    try {
      await HttpService.deleteEmployeeMultiDepartment(
          employeeId: employeeId, departmentId: departmentId);
    } catch (e) {
      debugPrint('$e deleteEmployeeMultiDepartment');
    }
  }

  Future<void> searchEmployee({required String employeeId}) async {
    try {
      var result = await HttpService.searchEmployee(employeeId: employeeId);
      _searchEmployeeList.replaceRange(0, _searchEmployeeList.length, result);
    } catch (e) {
      debugPrint('$e searchEmployee');
    } finally {
      notifyListeners();
    }
  }
}
