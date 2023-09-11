import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/branch_employee.dart';
import '../model/branch_model.dart';
import '../model/department_employee_model.dart';
import '../model/department_model.dart';
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
    // debugPrint('getRecords ${response.body}');
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
    // debugPrint('getDeviceLog ${response.body}');
    return deviceLogModelFromJson(response.body);
  }

  static Future<List<BranchModel>> getBranch() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_branch.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getBranch ${response.body}');
    return branchModelFromJson(response.body);
  }

  static Future<List<BranchEmployeeModel>> getBranchEmployee() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_branch_employee.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    debugPrint('getBranchEmployee ${response.body}');
    return branchEmployeeModelFromJson(response.body);
  }

  static Future<List<DepartmentModel>> getDepartment() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_department.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getDepartment ${response.body}');
    return departmentModelFromJson(response.body);
  }

  static Future<List<DepartmentEmployeeModel>> getDepartmentEmployee() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_department_employee.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    debugPrint('getDepartmentEmployee ${response.body}');
    return departmentEmployeeModelFromJson(response.body);
  }
}
