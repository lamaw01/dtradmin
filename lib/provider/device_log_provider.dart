import 'package:flutter/material.dart';

import '../model/device_log_model.dart';
import '../service/http_service.dart';

class DeviceLogProvider with ChangeNotifier {
  var _deviceLogList = <DeviceLogModel>[];
  List<DeviceLogModel> get deviceLogList => _deviceLogList;

  Future<void> getDeviceLog() async {
    try {
      final result = await HttpService.getDeviceLog();
      _deviceLogList = result;
    } catch (e) {
      debugPrint('$e getDeviceLog');
    } finally {
      notifyListeners();
    }
  }

  // Future<void> refreshDeviceLog() async {
  //   try {
  //     final result = await HttpService.getDeviceLog();
  //     _deviceLogList = result;
  //   } catch (e) {
  //     debugPrint('$e refreshDeviceLog');
  //   } finally {
  //     notifyListeners();
  //   }
  // }
}
