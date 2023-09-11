import 'package:flutter/material.dart';

import '../model/branch_employee.dart';
import '../service/http_service.dart';

enum BranchEmployeeEnum { empty, success, error }

class BranchEmployeeProvider with ChangeNotifier {
  var branchEmployeeStatus = BranchEmployeeEnum.empty;

  final _branchEmployeeList = <BranchEmployeeModel>[];
  List<BranchEmployeeModel> get branchEmployeeList => _branchEmployeeList;

  String fullName(BranchEmployeeModel m) {
    return '${m.lastName}, ${m.firstName} ${m.middleName}';
  }

  Future<void> getBranchEmployee() async {
    if (branchEmployeeStatus == BranchEmployeeEnum.empty) {
      try {
        final result = await HttpService.getBranchEmployee();
        _branchEmployeeList.addAll(result);
        if (_branchEmployeeList.isNotEmpty) {
          branchEmployeeStatus = BranchEmployeeEnum.success;
        }
      } catch (e) {
        debugPrint('$e getBranchEmployee');
        branchEmployeeStatus = BranchEmployeeEnum.error;
      } finally {
        notifyListeners();
      }
    }
  }
}
