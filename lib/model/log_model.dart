// To parse this JSON data, do
//
//     final logModel = logModelFromJson(jsonString);

import 'dart:convert';

List<LogModel> logModelFromJson(String str) =>
    List<LogModel>.from(json.decode(str).map((x) => LogModel.fromJson(x)));

String logModelToJson(List<LogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LogModel {
  int id;
  String employeeId;
  String logType;
  String deviceId;
  String address;
  String latlng;
  DateTime timeStamp;
  int isSelfie;
  String team;
  String app;
  String version;

  LogModel({
    required this.id,
    required this.employeeId,
    required this.logType,
    required this.deviceId,
    required this.address,
    required this.latlng,
    required this.timeStamp,
    required this.isSelfie,
    required this.team,
    required this.app,
    required this.version,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
        id: json["id"],
        employeeId: json["employee_id"],
        logType: json["log_type"],
        deviceId: json["device_id"],
        address: json["address"],
        latlng: json["latlng"],
        timeStamp: DateTime.parse(json["time_stamp"]),
        isSelfie: json["is_selfie"],
        team: json["team"],
        app: json["app"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "log_type": logType,
        "device_id": deviceId,
        "address": address,
        "latlng": latlng,
        "time_stamp": timeStamp.toIso8601String(),
        "is_selfie": isSelfie,
        "team": team,
        "app": app,
        "version": version,
      };
}
