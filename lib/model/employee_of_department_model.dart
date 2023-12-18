// To parse this JSON data, do
//
//     final employeeOfDepartmentModel = employeeOfDepartmentModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeOfDepartmentModel> employeeOfDepartmentModelFromJson(String str) =>
    List<EmployeeOfDepartmentModel>.from(
        json.decode(str).map((x) => EmployeeOfDepartmentModel.fromJson(x)));

String employeeOfDepartmentModelToJson(List<EmployeeOfDepartmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeOfDepartmentModel {
  String employeeId;
  String firstName;
  String lastName;
  String middleName;
  bool isSelected;

  EmployeeOfDepartmentModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    this.isSelected = false,
  });

  factory EmployeeOfDepartmentModel.fromJson(Map<String, dynamic> json) =>
      EmployeeOfDepartmentModel(
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
      };
}
