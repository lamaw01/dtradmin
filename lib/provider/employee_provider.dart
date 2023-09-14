import 'package:flutter/material.dart';

import '../model/employee_model.dart';
import '../service/http_service.dart';

enum EmployeeEnum { empty, success, error }

class EmployeeProvider with ChangeNotifier {
  var employeeStatus = EmployeeEnum.empty;

  final _employeeList = <EmployeeModel>[];
  List<EmployeeModel> get employeeList => _employeeList;

  String fullName(EmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  Future<void> getEmployee() async {
    if (employeeStatus == EmployeeEnum.empty) {
      try {
        final result = await HttpService.getEmployee();
        _employeeList.addAll(result);
        if (_employeeList.isNotEmpty) {
          employeeStatus = EmployeeEnum.success;
        }
      } catch (e) {
        debugPrint('$e getEmployee');
        employeeStatus = EmployeeEnum.error;
      } finally {
        notifyListeners();
      }
    }
  }
}
