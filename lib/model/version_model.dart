// To parse this JSON data, do
//
//     final versionModel = versionModelFromJson(jsonString);

import 'dart:convert';

List<VersionModel> versionModelFromJson(String str) => List<VersionModel>.from(
    json.decode(str).map((x) => VersionModel.fromJson(x)));

String versionModelToJson(List<VersionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VersionModel {
  int id;
  String name;
  String version;
  DateTime updated;

  VersionModel({
    required this.id,
    required this.name,
    required this.version,
    required this.updated,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
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
