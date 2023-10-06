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
  String lastName;
  String firstName;
  String middleName;
  String logType;
  String deviceId;
  String address;
  String latlng;
  DateTime timeStamp;
  String team;
  int isSelfie;
  String app;
  String version;

  LogModel({
    required this.id,
    required this.employeeId,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.logType,
    required this.deviceId,
    required this.address,
    required this.latlng,
    required this.timeStamp,
    required this.team,
    required this.isSelfie,
    required this.app,
    required this.version,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
        id: json["id"],
        employeeId: json["employee_id"],
        lastName: json["last_name"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        logType: json["log_type"],
        deviceId: json["device_id"],
        address: json["address"],
        latlng: json["latlng"],
        timeStamp: DateTime.parse(json["time_stamp"]),
        team: json["team"],
        isSelfie: json["is_selfie"],
        app: json["app"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "last_name": lastName,
        "first_name": firstName,
        "middle_name": middleName,
        "log_type": logType,
        "device_id": deviceId,
        "address": address,
        "latlng": latlng,
        "time_stamp": timeStamp.toIso8601String(),
        "team": team,
        "is_selfie": isSelfie,
        "app": app,
        "version": version,
      };
}
