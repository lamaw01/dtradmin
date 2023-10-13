// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromJson(jsonString);

import 'dart:convert';

List<DepartmentModel> departmentModelFromJson(String str) =>
    List<DepartmentModel>.from(
        json.decode(str).map((x) => DepartmentModel.fromJson(x)));

String departmentModelToJson(List<DepartmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentModel {
  int id;
  String departmentId;
  String departmentName;
  bool selected;

  DepartmentModel({
    required this.id,
    required this.departmentId,
    required this.departmentName,
    this.selected = false,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      DepartmentModel(
        id: json["id"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_id": departmentId,
        "department_name": departmentName,
      };
}
