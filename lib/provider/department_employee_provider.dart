import 'package:flutter/material.dart';

import '../model/department_employee_model.dart';
import '../service/http_service.dart';

enum DepartmentEmployeeEnum { empty, success, error }

class DepartmentEmployeeProvider with ChangeNotifier {
  var departmentEmployeeStatus = DepartmentEmployeeEnum.empty;

  final _departmentEmployeeList = <DepartmentEmployeeModel>[];
  List<DepartmentEmployeeModel> get departmentEmployeeList =>
      _departmentEmployeeList;

  String fullName(DepartmentEmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  Future<void> getDepartmentEmployee() async {
    if (departmentEmployeeStatus == DepartmentEmployeeEnum.empty) {
      try {
        final result = await HttpService.getDepartmentEmployee();
        _departmentEmployeeList.addAll(result);
        if (_departmentEmployeeList.isNotEmpty) {
          departmentEmployeeStatus = DepartmentEmployeeEnum.success;
        }
      } catch (e) {
        debugPrint('$e getDepartmentEmployee');
        departmentEmployeeStatus = DepartmentEmployeeEnum.error;
      } finally {
        notifyListeners();
      }
    }
  }
}
