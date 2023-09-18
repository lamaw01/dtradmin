import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/branch_employee.dart';
import '../model/branch_model.dart';
import '../model/department_employee_model.dart';
import '../model/department_model.dart';
import '../model/device_log_model.dart';
import '../model/device_model.dart';
import '../model/employee_model.dart';
import '../model/schedule_model.dart';
import '../model/version_model.dart';
import '../model/week_schedule_model.dart';

class HttpService {
  static const String _serverUrl = 'http://103.62.153.74:53000/dtr_admin_api';

  static Future<List<DeviceModel>> getDevice() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_device.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getDevice ${response.body}');
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

  static Future<List<BranchEmployeeModel>> getEmployeeBranch() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_employee_branch.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getBranchEmployee ${response.body}');
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
      Uri.parse('$_serverUrl/get_employee_department.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getDepartmentEmployee ${response.body}');
    return departmentEmployeeModelFromJson(response.body);
  }

  static Future<List<EmployeeModel>> getEmployee() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_employee.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getEmployee ${response.body}');
    return employeeModelFromJson(response.body);
  }

  static Future<List<WeekScheduleModel>> getWeekSchedule() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_week_sched.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getWeekSchedule ${response.body}');
    return weekScheduleModelFromJson(response.body);
  }

  static Future<List<ScheduleModel>> getSchedule() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_schedule.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getSchedule ${response.body}');
    return scheduleModelFromJson(response.body);
  }

  static Future<List<VersionModel>> getAppVersion() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_app_version.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getAppVersion ${response.body}');
    return versionModelFromJson(response.body);
  }

  static Future<void> addDevice({
    required String branchId,
    required String deviceId,
    required int active,
    required String description,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_device.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "branch_id": branchId,
            "device_id": deviceId,
            "active": active,
            "description": description
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addDevice ${response.body}');
  }

  static Future<void> updateDevice({
    required String branchId,
    required String deviceId,
    required int active,
    required String description,
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/update_device.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "branch_id": branchId,
            "device_id": deviceId,
            "active": active,
            "description": description,
            "id": id
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('updateDevice ${response.body}');
  }

  static Future<void> deleteDevice({
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_device.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"id": id}),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteDevice ${response.body}');
  }

  static Future<void> addBranch({
    required String branchId,
    required String branchName,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_branch.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "branch_id": branchId,
            "branch_name": branchName,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addBranch ${response.body}');
  }

  static Future<void> updateBranch({
    required String branchId,
    required String branchName,
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/update_branch.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "branch_id": branchId,
            "branch_name": branchName,
            "id": id
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('updateBranch ${response.body}');
  }

  static Future<void> deleteBranch({
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_branch.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"id": id}),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteBranch ${response.body}');
  }

  static Future<void> addEmployeeBranch({
    required String employeeId,
    required String branchId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_employee_branch.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
            "branch_id": branchId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addEmployeeBranch ${response.body}');
  }

  static Future<void> updateEmployeeBranch({
    required String employeeId,
    required String branchId,
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/update_employee_branch.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
            "branch_id": branchId,
            "id": id,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('updateEmployeeBranch ${response.body}');
  }

  static Future<void> deleteEmployeeBranch({
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_employee_branch.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"id": id}),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteEmployeeBranch ${response.body}');
  }
}
