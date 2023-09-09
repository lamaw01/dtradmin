import 'package:flutter/material.dart';

import '../model/device_model.dart';
import '../service/http_service.dart';

enum DeviceEnum { empty, success, error }

class DeviceProvider with ChangeNotifier {
  var deviceStatus = DeviceEnum.empty;

  final _deviceList = <DeviceModel>[];
  List<DeviceModel> get deviceList => _deviceList;

  Future<void> getDevice() async {
    if (deviceStatus == DeviceEnum.empty) {
      try {
        final result = await HttpService.getDevice();
        _deviceList.addAll(result);
        if (_deviceList.isNotEmpty) {
          deviceStatus = DeviceEnum.success;
        }
      } catch (e) {
        debugPrint('$e getDevice');
        deviceStatus = DeviceEnum.error;
      } finally {
        notifyListeners();
      }
    }
  }
}
