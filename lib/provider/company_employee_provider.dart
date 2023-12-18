import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/employee_model.dart';
import '../model/employee_of_company_model.dart';
import '../service/http_service.dart';

class CompanyEmployeeProvider with ChangeNotifier {
  var _employeeUnassigendCompanyList = <EmployeeModel>[];
  List<EmployeeModel> get employeeUnassigendCompanyList =>
      _employeeUnassigendCompanyList;

  var _employeeAssignedCompany = <EmployeeOfCompanyModel>[];
  List<EmployeeOfCompanyModel> get employeeAssignedCompany =>
      _employeeAssignedCompany;

  String fullNameEmp(EmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  String fullNameEmpOfCompany(EmployeeOfCompanyModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  void removeEmployeeAssignedDuplicate() {
    _employeeUnassigendCompanyList.removeWhere((e) {
      bool result = false;
      for (final d in _employeeAssignedCompany) {
        if (d.employeeId == e.employeeId) {
          return true;
        }
      }
      return result;
    });
  }

  List<String> assignedListToAdd() {
    var listString = <String>[];
    for (int i = 0; i < _employeeUnassigendCompanyList.length; i++) {
      if (_employeeUnassigendCompanyList[i].isSelected) {
        listString.add(_employeeUnassigendCompanyList[i].employeeId);
        log('true ${_employeeUnassigendCompanyList[i].lastName}');
      }
    }
    return listString;
  }

  List<String> unAssignedListToAdd() {
    var listString = <String>[];
    for (int i = 0; i < _employeeAssignedCompany.length; i++) {
      if (_employeeAssignedCompany[i].isSelected) {
        listString.add(_employeeAssignedCompany[i].employeeId);
        log('true ${_employeeAssignedCompany[i].lastName}');
      }
    }
    return listString;
  }

  Future<void> getEmployeeAssignedCompany({
    required String companyId,
  }) async {
    try {
      final result = await HttpService.getEmployeeAssignedCompany(
        companyId: companyId,
      );
      _employeeAssignedCompany = result;
    } catch (e) {
      debugPrint('$e getEmployeeAssignedCompany');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addEmployeeCompanyMulti({
    required String companyId,
    required List<String> employeeId,
  }) async {
    log(employeeId.toString());
    try {
      await HttpService.addEmployeeCompanyMulti(
          companyId: companyId, employeeId: employeeId);
    } catch (e) {
      debugPrint('$e addEmployeeCompanyMulti');
    } finally {
      await getEmployeeCompanyUnassigned();
      await getEmployeeAssignedCompany(companyId: companyId);
      removeEmployeeAssignedDuplicate();
      // await getEmployeeUnassignedCompany(CompanyId: CompanyId);
      // removeAssignedDuplicate();
    }
  }

  Future<void> deleteEmployeeCompanyMulti({
    required String companyId,
    required List<String> employeeId,
  }) async {
    log(employeeId.toString());
    try {
      await HttpService.deleteEmployeeCompanyMulti(
          companyId: companyId, employeeId: employeeId);
    } catch (e) {
      debugPrint('$e deleteEmployeeCompanyMulti');
    } finally {
      // await getEmployeeUnassignedCompany(CompanyId: CompanyId);
      await getEmployeeCompanyUnassigned();
      await getEmployeeAssignedCompany(companyId: companyId);
      removeEmployeeAssignedDuplicate();
      // removeAssignedDuplicate();
    }
  }

  Future<void> getEmployeeCompanyUnassigned() async {
    try {
      final result = await HttpService.getEmployee();
      _employeeUnassigendCompanyList = result;
    } catch (e) {
      debugPrint('$e getEmployee');
    } finally {
      notifyListeners();
    }
  }
}
