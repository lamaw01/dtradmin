// To parse this JSON data, do
//
//     final employeeOfCompanyModel = employeeOfCompanyModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeOfCompanyModel> employeeOfCompanyModelFromJson(String str) =>
    List<EmployeeOfCompanyModel>.from(
        json.decode(str).map((x) => EmployeeOfCompanyModel.fromJson(x)));

String employeeOfCompanyModelToJson(List<EmployeeOfCompanyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeOfCompanyModel {
  String employeeId;
  String firstName;
  String lastName;
  String middleName;
  bool isSelected;

  EmployeeOfCompanyModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    this.isSelected = false,
  });

  factory EmployeeOfCompanyModel.fromJson(Map<String, dynamic> json) =>
      EmployeeOfCompanyModel(
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
