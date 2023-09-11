import 'package:flutter/material.dart';

import '../model/department_model.dart';
import '../service/http_service.dart';

enum DepartmentEnum { empty, success, error }

class DepartmentProvider with ChangeNotifier {
  var departmentStatus = DepartmentEnum.empty;

  final _departmentList = <DepartmentModel>[];
  List<DepartmentModel> get departmentList => _departmentList;

  Future<void> getDepartment() async {
    if (departmentStatus == DepartmentEnum.empty) {
      try {
        final result = await HttpService.getDepartment();
        _departmentList.addAll(result);
        if (_departmentList.isNotEmpty) {
          departmentStatus = DepartmentEnum.success;
        }
      } catch (e) {
        debugPrint('$e getBranch');
        departmentStatus = DepartmentEnum.error;
      } finally {
        notifyListeners();
      }
    }
  }
}
