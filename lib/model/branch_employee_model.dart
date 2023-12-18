// To parse this JSON data, do
//
//     final branchEmployeeModel = branchEmployeeModelFromJson(jsonString);

import 'dart:convert';

List<BranchEmployeeModel> branchEmployeeModelFromJson(String str) =>
    List<BranchEmployeeModel>.from(
        json.decode(str).map((x) => BranchEmployeeModel.fromJson(x)));

String branchEmployeeModelToJson(List<BranchEmployeeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchEmployeeModel {
  int id;
  String employeeId;
  String firstName;
  String lastName;
  String middleName;
  String branchId;
  String branchName;

  BranchEmployeeModel({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.branchId,
    required this.branchName,
  });

  factory BranchEmployeeModel.fromJson(Map<String, dynamic> json) =>
      BranchEmployeeModel(
        id: json["id"],
        employeeId: json["employee_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "branch_id": branchId,
        "branch_name": branchName,
      };
}
