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
import '../model/employee_of_branch_model.dart';
import '../model/log_model.dart';
import '../model/schedule_model.dart';
import '../model/app_version_model.dart';
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

  static Future<List<AppVersionModel>> getAppVersion() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_app_version.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getAppVersion ${response.body}');
    return appVersionModelFromJson(response.body);
  }

  static Future<List<LogModel>> getLog({int? id}) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/get_log.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"id": id}),
        )
        .timeout(const Duration(seconds: 10));
    // debugPrint('getLog ${response.body}');
    return logModelFromJson(response.body);
  }

  static Future<void> addDevice({
    required String branchId,
    required String deviceId,
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

  static Future<void> addDepartment({
    required String departmentId,
    required String departmentName,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_department.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "department_id": departmentId,
            "department_name": departmentName,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addDepartment ${response.body}');
  }

  static Future<void> updateDepartment({
    required String departmentId,
    required String departmentName,
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/update_department.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "department_id": departmentId,
            "department_name": departmentName,
            "id": id,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('updateDepartment ${response.body}');
  }

  static Future<void> deleteDepartment({
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_department.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"id": id}),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteDepartment ${response.body}');
  }

  static Future<void> addEmployeeDepartment({
    required String departmentId,
    required String employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_employee_department.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "department_id": departmentId,
            "employee_id": employeeId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addEmployeeDepartment ${response.body}');
  }

  static Future<void> updateEmployeeDepartment({
    required String departmentId,
    required String employeeId,
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/update_employee_department.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "department_id": departmentId,
            "employee_id": employeeId,
            "id": id,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('updateEmployeeDepartment ${response.body}');
  }

  static Future<void> deleteEmployeeDepartment({
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_employee_department.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"id": id}),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteDepartment ${response.body}');
  }

  static Future<void> addEmployee({
    required String employeeId,
    required String firstName,
    required String lastName,
    required String middleName,
    required String weekSchedId,
    required int active,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_employee.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
            "first_name": firstName,
            "last_name": lastName,
            "middle_name": middleName,
            "week_sched_id": weekSchedId,
            "active": active,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addEmployee ${response.body}');
  }

  static Future<void> updateEmployee({
    required String employeeId,
    required String firstName,
    required String lastName,
    required String middleName,
    required String weekSchedId,
    required int active,
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/update_employee.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
            "first_name": firstName,
            "last_name": lastName,
            "middle_name": middleName,
            "week_sched_id": weekSchedId,
            "active": active,
            "id": id,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('updateEmployee ${response.body}');
  }

  static Future<void> deleteEmployee({
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_employee.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"id": id}),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteEmployee ${response.body}');
  }

  static Future<void> addWeekSchedule({
    required String weekSchedId,
    required String monday,
    required String tuesday,
    required String wednesday,
    required String thursday,
    required String friday,
    required String saturday,
    required String sunday,
    required String description,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_week_sched.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "week_sched_id": weekSchedId,
            "monday": monday,
            "tuesday": tuesday,
            "wednesday": wednesday,
            "thursday": thursday,
            "friday": friday,
            "saturday": saturday,
            "sunday": sunday,
            "description": description,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addWeekSchedule ${response.body}');
  }

  static Future<void> updateWeekSchedule({
    required String weekSchedId,
    required String monday,
    required String tuesday,
    required String wednesday,
    required String thursday,
    required String friday,
    required String saturday,
    required String sunday,
    required String description,
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/update_week_sched.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "week_sched_id": weekSchedId,
            "monday": monday,
            "tuesday": tuesday,
            "wednesday": wednesday,
            "thursday": thursday,
            "friday": friday,
            "saturday": saturday,
            "sunday": sunday,
            "description": description,
            "id": id,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('updateWeekSchedule ${response.body}');
  }

  static Future<void> deleteWeekSchedule({
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_week_sched.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"id": id}),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteWeekSchedule ${response.body}');
  }

  static Future<void> addSchedule({
    required String schedId,
    required String schedType,
    required String schedIn,
    required String breakStart,
    required String breakEnd,
    required String schedOut,
    required String description,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_sched.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "sched_id": schedId,
            "sched_type": schedType,
            "sched_in": schedIn,
            "break_start": breakStart,
            "break_end": breakEnd,
            "sched_out": schedOut,
            "description": description,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addSchedule ${response.body}');
  }

  static Future<void> updateSchedule({
    required String schedId,
    required String schedType,
    required String schedIn,
    required String breakStart,
    required String breakEnd,
    required String schedOut,
    required String description,
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/update_sched.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "sched_id": schedId,
            "sched_type": schedType,
            "sched_in": schedIn,
            "break_start": breakStart,
            "break_end": breakEnd,
            "sched_out": schedOut,
            "description": description,
            "id": id,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('updateSchedule ${response.body}');
  }

  static Future<void> deleteSchedule({
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_sched.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"id": id}),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteSchedule ${response.body}');
  }

  static Future<void> updateAppVersion({
    required String name,
    required String version,
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/update_app_version.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "name": name,
            "version": version,
            "id": id,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('updateAppVersion ${response.body}');
  }

  static Future<List<BranchModel>> getBranchOfEmployee({
    required String employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/get_branch_of_employee.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('getBranchOfEmployee ${response.body}');
    return branchModelFromJson(response.body);
  }

  static Future<void> addEmployeeMultiBranch({
    required String employeeId,
    required List<String> branchId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_employee_multi_branch.php'),
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
    debugPrint('addEmployeeMultiBranch ${response.body}');
  }

  static Future<void> deleteEmployeeMultiBranch({
    required String employeeId,
    required List<String> branchId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_employee_multi_branch.php'),
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
    debugPrint('deleteEmployeeMultiBranch ${response.body}');
  }

  static Future<List<EmployeeOfBranchModel>> getEmployeeOfBranch({
    required String branchId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/get_employee_of_branch.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "branch_id": branchId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('getEmployeeOfBranch ${response.body}');
    return employeeOfBranchModelFromJson(response.body);
  }

  static Future<List<EmployeeOfBranchModel>> getEmployeeUnassignedBranch({
    required String branchId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/get_unassigned_employee_branch.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "branch_id": branchId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('getEmployeeOfBranch ${response.body}');
    return employeeOfBranchModelFromJson(response.body);
  }

  static Future<List<EmployeeOfBranchModel>> getEmployeeAssignedBranch({
    required String branchId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/get_assigned_employee_branch.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "branch_id": branchId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('getEmployeeOfBranch ${response.body}');
    return employeeOfBranchModelFromJson(response.body);
  }

  static Future<void> addEmployeeBranchMulti({
    required String branchId,
    required List<String> employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_branch_multi_employee.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "branch_id": branchId,
            "employee_id": employeeId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addEmployeeBranchMulti ${response.body}');
  }
}
