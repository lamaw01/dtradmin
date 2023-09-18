import 'package:flutter/material.dart';

import '../model/branch_model.dart';
import '../service/http_service.dart';

class BranchProvider with ChangeNotifier {
  var _branchList = <BranchModel>[];
  List<BranchModel> get branchList => _branchList;

  Future<void> getBranch() async {
    try {
      final result = await HttpService.getBranch();
      _branchList = result;
      notifyListeners();
    } catch (e) {
      debugPrint('$e getBranch');
    }
  }

  bool checkBranchId(String branchId) {
    for (var branch in _branchList) {
      if (branch.branchId == branchId) {
        return true;
      }
    }
    return false;
  }

  Future<void> addBranch({
    required String branchId,
    required String branchName,
  }) async {
    try {
      await HttpService.addBranch(branchId: branchId, branchName: branchName);
    } catch (e) {
      debugPrint('$e addBranch');
    } finally {
      await getBranch();
    }
  }

  Future<void> updateBranch({
    required String branchId,
    required String branchName,
    required int id,
  }) async {
    try {
      await HttpService.updateBranch(
        branchId: branchId,
        branchName: branchName,
        id: id,
      );
    } catch (e) {
      debugPrint('$e updateDevice');
    } finally {
      await getBranch();
    }
  }

  Future<void> deleteBranch({
    required int id,
  }) async {
    try {
      await HttpService.deleteBranch(id: id);
    } catch (e) {
      debugPrint('$e deleteDevice');
    } finally {
      await getBranch();
    }
  }
}
