import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/device_log_model.dart';
import '../model/device_model.dart';

class HttpService {
  static const String _serverUrl = 'http://103.62.153.74:53000/dtr_admin_api';
  static String get serverUrl => _serverUrl;

  static Future<List<DeviceModel>> getDevice() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_device.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    debugPrint('getRecords ${response.body}');
    return deviceModelFromJson(response.body);
  }

  static Future<List<DeviceLogModel>> getDeviceLog() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_device_log.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    debugPrint('getDeviceLog ${response.body}');
    return deviceLogModelFromJson(response.body);
  }
}
