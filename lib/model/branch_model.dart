// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

List<BranchModel> branchModelFromJson(String str) => List<BranchModel>.from(
    json.decode(str).map((x) => BranchModel.fromJson(x)));

String branchModelToJson(List<BranchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchModel {
  int id;
  String branchId;
  String branchName;
  bool selected;

  BranchModel({
    required this.id,
    required this.branchId,
    required this.branchName,
    this.selected = false,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        id: json["id"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_id": branchId,
        "branch_name": branchName,
      };
}
