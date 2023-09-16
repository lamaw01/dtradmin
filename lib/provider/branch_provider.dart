import 'package:flutter/material.dart';

import '../model/branch_model.dart';
import '../service/http_service.dart';

enum BranchEnum { empty, success, error }

class BranchProvider with ChangeNotifier {
  var branchStatus = BranchEnum.empty;

  final _branchList = <BranchModel>[
    BranchModel(
      id: 0,
      branchId: '000',
      branchName: '--Select--',
    )
  ];
  List<BranchModel> get branchList => _branchList;

  Future<void> getBranch() async {
    if (branchStatus == BranchEnum.empty) {
      try {
        final result = await HttpService.getBranch();
        _branchList.addAll(result);
        if (_branchList.isNotEmpty) {
          branchStatus = BranchEnum.success;
        }
      } catch (e) {
        debugPrint('$e getBranch');
        branchStatus = BranchEnum.error;
      } finally {
        notifyListeners();
      }
    }
  }
}
