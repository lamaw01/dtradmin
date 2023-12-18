// To parse this JSON data, do
//
//     final CompanyEmployeeModel = companyEmployeeModelFromJson(jsonString);

import 'dart:convert';

List<CompanyEmployeeModel> companyEmployeeModelFromJson(String str) =>
    List<CompanyEmployeeModel>.from(
        json.decode(str).map((x) => CompanyEmployeeModel.fromJson(x)));

String companyEmployeeModelToJson(List<CompanyEmployeeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyEmployeeModel {
  int id;
  String employeeId;
  String firstName;
  String lastName;
  String middleName;
  String companyId;
  String companyName;

  CompanyEmployeeModel({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.companyId,
    required this.companyName,
  });

  factory CompanyEmployeeModel.fromJson(Map<String, dynamic> json) =>
      CompanyEmployeeModel(
        id: json["id"],
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        companyId: json["company_id"],
        companyName: json["company_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "company_id": companyId,
        "company_name": companyName,
      };
}
