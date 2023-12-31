import 'package:flutter/material.dart';

import '../model/device_model.dart';
import '../service/http_service.dart';

class DeviceProvider with ChangeNotifier {
  var _deviceList = <DeviceModel>[];
  List<DeviceModel> get deviceList => _deviceList;

  Future<void> getDevice() async {
    try {
      final result = await HttpService.getDevice();
      _deviceList = result;
      notifyListeners();
    } catch (e) {
      debugPrint('$e getDevice');
    }
  }

  bool checkDeviceId(String deviceId) {
    for (var device in _deviceList) {
      if (device.deviceId == deviceId) {
        return true;
      }
    }
    return false;
  }

  Future<void> addDevice({
    required String branchId,
    required String deviceId,
    required String description,
  }) async {
    try {
      await HttpService.addDevice(
        branchId: branchId,
        deviceId: deviceId,
        description: description,
      );
    } catch (e) {
      debugPrint('$e addDevice');
    } finally {
      await getDevice();
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
    } catch (e) {
      debugPrint('$e updateDevice');
    } finally {
      await getDevice();
    }
  }

  Future<void> deleteDevice({
    required int id,
  }) async {
    try {
      await HttpService.deleteDevice(id: id);
    } catch (e) {
      debugPrint('$e deleteDevice');
    } finally {
      await getDevice();
    }
  }
}
