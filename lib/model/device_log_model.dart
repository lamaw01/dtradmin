// To parse this JSON data, do
//
//     final deviceLogModel = deviceLogModelFromJson(jsonString);

import 'dart:convert';

List<DeviceLogModel> deviceLogModelFromJson(String str) =>
    List<DeviceLogModel>.from(
        json.decode(str).map((x) => DeviceLogModel.fromJson(x)));

String deviceLogModelToJson(List<DeviceLogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeviceLogModel {
  int id;
  String deviceId;
  String address;
  String latlng;
  String appName;
  String version;
  DateTime logTime;
  DateTime timeStamp;
  String description;

  DeviceLogModel({
    required this.id,
    required this.deviceId,
    required this.address,
    required this.latlng,
    required this.appName,
    required this.version,
    required this.logTime,
    required this.timeStamp,
    required this.description,
  });

  factory DeviceLogModel.fromJson(Map<String, dynamic> json) => DeviceLogModel(
        id: json["id"],
        deviceId: json["device_id"],
        address: json["address"],
        latlng: json["latlng"],
        appName: json["app_name"],
        version: json["version"],
        logTime: DateTime.parse(json["log_time"]),
        timeStamp: DateTime.parse(json["time_stamp"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "device_id": deviceId,
        "address": address,
        "latlng": latlng,
        "app_name": appName,
        "version": version,
        "log_time": logTime.toIso8601String(),
        "time_stamp": timeStamp.toIso8601String(),
        "description": description,
      };
}
