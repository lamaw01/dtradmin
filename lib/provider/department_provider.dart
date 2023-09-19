import 'package:flutter/material.dart';

import '../model/department_model.dart';
import '../service/http_service.dart';

class DepartmentProvider with ChangeNotifier {
  var _departmentList = <DepartmentModel>[];
  List<DepartmentModel> get departmentList => _departmentList;

  bool checkDepartmentId(String departmentId) {
    for (var branch in _departmentList) {
      if (branch.departmentId == departmentId) {
        return true;
      }
    }
    return false;
  }

  Future<void> getDepartment() async {
    try {
      final result = await HttpService.getDepartment();
      _departmentList = result;
    } catch (e) {
      debugPrint('$e getDepartment');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addDepartment({
    required String departmentId,
    required String departmentName,
  }) async {
    try {
      await HttpService.addDepartment(
          departmentId: departmentId, departmentName: departmentName);
    } catch (e) {
      debugPrint('$e addDepartment');
    } finally {
      await getDepartment();
    }
  }

  Future<void> updateDepartment({
    required String departmentId,
    required String departmentName,
    required int id,
  }) async {
    try {
      await HttpService.updateDepartment(
          departmentId: departmentId, departmentName: departmentName, id: id);
    } catch (e) {
      debugPrint('$e updateDepartment');
    } finally {
      await getDepartment();
    }
  }

  Future<void> deleteDepartment({
    required int id,
  }) async {
    try {
      await HttpService.deleteDepartment(id: id);
    } catch (e) {
      debugPrint('$e deleteDepartment');
    } finally {
      await getDepartment();
    }
  }
}
