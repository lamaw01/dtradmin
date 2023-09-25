// To parse this JSON data, do
//
//     final AppVersionModel = AppVersionModelFromJson(jsonString);

import 'dart:convert';

List<AppVersionModel> appVersionModelFromJson(String str) =>
    List<AppVersionModel>.from(
        json.decode(str).map((x) => AppVersionModel.fromJson(x)));

String appVersionModelToJson(List<AppVersionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppVersionModel {
  int id;
  String name;
  String version;
  DateTime updated;

  AppVersionModel({
    required this.id,
    required this.name,
    required this.version,
    required this.updated,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      AppVersionModel(
        id: json["id"],
        name: json["name"],
        version: json["version"],
        updated: DateTime.parse(json["updated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "version": version,
        "updated": updated.toIso8601String(),
      };
}
