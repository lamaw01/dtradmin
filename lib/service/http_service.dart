import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/branch_employee_model.dart';
import '../model/branch_model.dart';
import '../model/company_model.dart';
import '../model/department_employee_model.dart';
import '../model/department_model.dart';
import '../model/device_log_model.dart';
import '../model/device_model.dart';
import '../model/employee_model.dart';
import '../model/employee_of_branch_model.dart';
import '../model/employee_of_company_model.dart';
import '../model/employee_of_department_model.dart';
import '../model/log_model.dart';
import '../model/schedule_model.dart';
import '../model/app_version_model.dart';
import '../model/week_schedule_model.dart';

class HttpService {
  // static String currentUri = Uri.base.toString();
  // static String isSecured = currentUri.substring(4, 5);

  // static const String _serverUrlHttp = 'http://103.62.153.74:53000/';
  // String get serverUrlHttp => _serverUrlHttp;

  // static const String _serverUrlHttps = 'https://konek.parasat.tv:50443/dtr/';
  // String get serverUrlHttps => _serverUrlHttps;

  // static final String _url =
  //     isSecured == 's' ? _serverUrlHttps : _serverUrlHttp;

  static const String _url = 'https://konek.parasat.tv:53000/';

  static const String _serverUrl = '${_url}dtr_admin_api';
  static String get serverUrl => _serverUrl;

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
          body:
              json.encode(<String, dynamic>{"branch_id": branchId, "device_id": deviceId, "description": description}),
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
          body: json.encode(<String, dynamic>{"branch_id": branchId, "branch_name": branchName, "id": id}),
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
    required String employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_employee_branch.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"employee_id": employeeId}),
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
    required String employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_employee_department.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"employee_id": employeeId}),
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

  // static Future<List<EmployeeOfBranchModel>> getEmployeeUnassignedBranch({
  //   required String branchId,
  // }) async {
  //   var response = await http
  //       .post(
  //         Uri.parse('$_serverUrl/get_unassigned_employee_branch.php'),
  //         headers: <String, String>{
  //           'Accept': '*/*',
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: json.encode(<String, dynamic>{
  //           "branch_id": branchId,
  //         }),
  //       )
  //       .timeout(const Duration(seconds: 10));
  //   debugPrint('getEmployeeUnassignedBranch ${response.body}');
  //   return employeeOfBranchModelFromJson(response.body);
  // }

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
    debugPrint('getEmployeeAssignedBranch ${response.body}');
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

  static Future<void> deleteEmployeeBranchMulti({
    required String branchId,
    required List<String> employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_branch_multi_employee.php'),
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
    debugPrint('deleteEmployeeBranchMulti ${response.body}');
  }

  static Future<List<DepartmentModel>> getDepartmentOfEmployee({
    required String employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/get_department_of_employee.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('getDepartmentOfEmployee ${response.body}');
    return departmentModelFromJson(response.body);
  }

  static Future<void> addEmployeeMultiDepartment({
    required String employeeId,
    required List<String> departmentId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_employee_multi_department.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
            "department_id": departmentId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addEmployeeMultiDepartment ${response.body}');
  }

  static Future<void> deleteEmployeeMultiDepartment({
    required String employeeId,
    required List<String> departmentId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_employee_multi_department.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
            "department_id": departmentId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteEmployeeMultiDepartment ${response.body}');
  }

  // static Future<List<EmployeeOfDepartmentModel>>
  //     getEmployeeUnassignedDepartment({required String departmentId}) async {
  //   var response = await http
  //       .post(
  //         Uri.parse('$_serverUrl/get_unassigned_employee_department.php'),
  //         headers: <String, String>{
  //           'Accept': '*/*',
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: json.encode(<String, dynamic>{
  //           "department_id": departmentId,
  //         }),
  //       )
  //       .timeout(const Duration(seconds: 10));
  //   debugPrint('getEmployeeUnassignedDepartment ${response.body}');
  //   return employeeOfDepartmentModelFromJson(response.body);
  // }

  static Future<List<EmployeeOfDepartmentModel>> getEmployeeAssignedDepartment({
    required String departmentId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/get_assigned_employee_department.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "department_id": departmentId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('getEmployeeAssignedDepartment ${response.body}');
    return employeeOfDepartmentModelFromJson(response.body);
  }

  static Future<void> addEmployeeDepartmentMulti({
    required String departmentId,
    required List<String> employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_department_multi_employee.php'),
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
    debugPrint('addEmployeeDepartmentMulti ${response.body}');
  }

  static Future<void> deleteEmployeeDepartmentMulti({
    required String departmentId,
    required List<String> employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_department_multi_employee.php'),
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
    debugPrint('deleteEmployeeDepartmentMulti ${response.body}');
  }

  static Future<List<EmployeeModel>> searchEmployee({
    required String employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/search_employee.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteEmployeeDepartmentMulti ${response.body}');
    return employeeModelFromJson(response.body);
  }

  static Future<List<CompanyModel>> getCompany() async {
    var response = await http.get(
      Uri.parse('$_serverUrl/get_company.php'),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(const Duration(seconds: 10));
    // debugPrint('getBranch ${response.body}');
    return companyModelFromJson(response.body);
  }

  static Future<void> addCompany({
    required String companyId,
    required String companyName,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_company.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "company_id": companyId,
            "company_name": companyName,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addCompany ${response.body}');
  }

  static Future<void> updateCompany({
    required String companyId,
    required String companyName,
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/update_company.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"company_id": companyId, "company_name": companyName, "id": id}),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('updateCompany ${response.body}');
  }

  static Future<void> deleteCompany({
    required int id,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_company.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{"id": id}),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteCompany ${response.body}');
  }

  static Future<List<CompanyModel>> getCompanyOfEmployee({
    required String employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/get_company_of_employee.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('getCompanyOfEmployee ${response.body}');
    return companyModelFromJson(response.body);
  }

  static Future<void> addEmployeeMultiCompany({
    required String employeeId,
    required List<String> companyId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_employee_multi_company.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
            "company_id": companyId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addEmployeeMultiCompany ${response.body}');
  }

  static Future<void> deleteEmployeeMultiCompany({
    required String employeeId,
    required List<String> companyId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_employee_multi_company.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "employee_id": employeeId,
            "company_id": companyId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteEmployeeMultiCompany ${response.body}');
  }

  static Future<List<EmployeeOfCompanyModel>> getEmployeeAssignedCompany({
    required String companyId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/get_assigned_employee_company.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "company_id": companyId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('getEmployeeAssignedCompany ${response.body}');
    return employeeOfCompanyModelFromJson(response.body);
  }

  static Future<void> addEmployeeCompanyMulti({
    required String companyId,
    required List<String> employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/add_company_multi_employee.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "company_id": companyId,
            "employee_id": employeeId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('addEmployeeCompanyMulti ${response.body}');
  }

  static Future<void> deleteEmployeeCompanyMulti({
    required String companyId,
    required List<String> employeeId,
  }) async {
    var response = await http
        .post(
          Uri.parse('$_serverUrl/delete_company_multi_employee.php'),
          headers: <String, String>{
            'Accept': '*/*',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "company_id": companyId,
            "employee_id": employeeId,
          }),
        )
        .timeout(const Duration(seconds: 10));
    debugPrint('deleteEmployeeCompanyMulti ${response.body}');
  }
}
