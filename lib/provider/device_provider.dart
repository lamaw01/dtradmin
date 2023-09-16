import 'package:flutter/material.dart';

import '../model/device_model.dart';
import '../service/http_service.dart';

enum DeviceEnum { empty, success, error }

class DeviceProvider with ChangeNotifier {
  var deviceStatus = DeviceEnum.empty;

  var _deviceList = <DeviceModel>[];
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

  Future<void> addDevice({
    required String branchId,
    required String deviceId,
    required int active,
    required String description,
  }) async {
    try {
      await HttpService.addDevice(
        branchId: branchId,
        deviceId: deviceId,
        active: active,
        description: description,
      );
      _deviceList = await HttpService.getDevice();
      notifyListeners();
    } catch (e) {
      debugPrint('$e addDevice');
    }
  }

  Future<void> updateDevice({
    required String branchId,
    required String deviceId,
    required int active,
    required String description,
    required int id,
  }) async {
    try {
      await HttpService.updateDevice(
        branchId: branchId,
        deviceId: deviceId,
        active: active,
        description: description,
        id: id,
      );
      _deviceList = await HttpService.getDevice();
      notifyListeners();
    } catch (e) {
      debugPrint('$e updateDevice');
    }
  }

  Future<void> deleteDevice({
    required int id,
  }) async {
    try {
      await HttpService.deleteDevice(id: id);
      _deviceList = await HttpService.getDevice();
      notifyListeners();
    } catch (e) {
      debugPrint('$e deleteDevice');
    }
  }
}
