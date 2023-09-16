import 'package:flutter/material.dart';

import '../model/device_log_model.dart';
import '../service/http_service.dart';

enum DeviceLogEnum { empty, success, error }

class DeviceLogProvider with ChangeNotifier {
  var deviceLogStatus = DeviceLogEnum.empty;

  var _deviceLogList = <DeviceLogModel>[];
  List<DeviceLogModel> get deviceLogList => _deviceLogList;

  Future<void> getDeviceLog() async {
    if (deviceLogStatus == DeviceLogEnum.empty) {
      try {
        final result = await HttpService.getDeviceLog();
        _deviceLogList.addAll(result);
        if (_deviceLogList.isNotEmpty) {
          deviceLogStatus = DeviceLogEnum.success;
        }
      } catch (e) {
        debugPrint('$e getDeviceLog');
        deviceLogStatus = DeviceLogEnum.error;
      } finally {
        notifyListeners();
      }
    }
  }

  Future<void> refreshDeviceLog() async {
    try {
      final result = await HttpService.getDeviceLog();
      _deviceLogList = result;
    } catch (e) {
      debugPrint('$e refreshDeviceLog');
    } finally {
      notifyListeners();
    }
  }
}
