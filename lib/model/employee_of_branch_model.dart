// To parse this JSON data, do
//
//     final employeeOfBranchModel = employeeOfBranchModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeOfBranchModel> employeeOfBranchModelFromJson(String str) =>
    List<EmployeeOfBranchModel>.from(
        json.decode(str).map((x) => EmployeeOfBranchModel.fromJson(x)));

String employeeOfBranchModelToJson(List<EmployeeOfBranchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeOfBranchModel {
  String employeeId;
  String firstName;
  String lastName;
  String middleName;
  bool isSelected;

  EmployeeOfBranchModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    this.isSelected = false,
  });

  factory EmployeeOfBranchModel.fromJson(Map<String, dynamic> json) =>
      EmployeeOfBranchModel(
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
