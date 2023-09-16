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
