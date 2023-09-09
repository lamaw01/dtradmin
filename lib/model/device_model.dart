// To parse this JSON data, do
//
//     final deviceModel = deviceModelFromJson(jsonString);

import 'dart:convert';

List<DeviceModel> deviceModelFromJson(String str) => List<DeviceModel>.from(
    json.decode(str).map((x) => DeviceModel.fromJson(x)));

String deviceModelToJson(List<DeviceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeviceModel {
  int id;
  String branchId;
  String deviceId;
  int active;
  String description;
  String branchName;

  DeviceModel({
    required this.id,
    required this.branchId,
    required this.deviceId,
    required this.active,
    required this.description,
    required this.branchName,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        id: json["id"],
        branchId: json["branch_id"],
        deviceId: json["device_id"],
        active: json["active"],
        description: json["description"],
        branchName: json["branch_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_id": branchId,
        "device_id": deviceId,
        "active": active,
        "description": description,
        "branch_name": branchName,
      };
}
