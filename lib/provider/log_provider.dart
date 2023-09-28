import 'package:flutter/material.dart';

import '../model/log_model.dart';
import '../service/http_service.dart';

class LogProvider with ChangeNotifier {
  var _logList = <LogModel>[];
  List<LogModel> get logList => _logList;

  Future<void> getLog() async {
    try {
      final result = await HttpService.getLog();
      _logList = result;
    } catch (e) {
      debugPrint('$e getLog');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addLog({required int id}) async {
    try {
      final result = await HttpService.getLog(id: id);
      _logList.addAll(result);
    } catch (e) {
      debugPrint('$e addLog');
    } finally {
      notifyListeners();
    }
  }

  // Future<void> refreshLog() async {
  //   try {
  //     final result = await HttpService.getLog();
  //     _LogList = result;
  //   } catch (e) {
  //     debugPrint('$e refreshLog');
  //   } finally {
  //     notifyListeners();
  //   }
  // }
}
