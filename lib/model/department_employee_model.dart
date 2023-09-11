// To parse this JSON data, do
//
//     final departmentEmployeeModel = departmentEmployeeModelFromJson(jsonString);

import 'dart:convert';

List<DepartmentEmployeeModel> departmentEmployeeModelFromJson(String str) =>
    List<DepartmentEmployeeModel>.from(
        json.decode(str).map((x) => DepartmentEmployeeModel.fromJson(x)));

String departmentEmployeeModelToJson(List<DepartmentEmployeeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentEmployeeModel {
  int id;
  String employeeId;
  String firstName;
  String lastName;
  String middleName;
  String departmentId;
  String departmentName;

  DepartmentEmployeeModel({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.departmentId,
    required this.departmentName,
  });

  factory DepartmentEmployeeModel.fromJson(Map<String, dynamic> json) =>
      DepartmentEmployeeModel(
        id: json["id"],
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "department_id": departmentId,
        "department_name": departmentName,
      };
}
