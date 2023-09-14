// To parse this JSON data, do
//
//     final weekScheduleModel = weekScheduleModelFromJson(jsonString);

import 'dart:convert';

List<WeekScheduleModel> weekScheduleModelFromJson(String str) =>
    List<WeekScheduleModel>.from(
        json.decode(str).map((x) => WeekScheduleModel.fromJson(x)));

String weekScheduleModelToJson(List<WeekScheduleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WeekScheduleModel {
  int id;
  String weekSchedId;
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;
  String description;

  WeekScheduleModel({
    required this.id,
    required this.weekSchedId,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.description,
  });

  factory WeekScheduleModel.fromJson(Map<String, dynamic> json) =>
      WeekScheduleModel(
        id: json["id"],
        weekSchedId: json["week_sched_id"],
        monday: json["monday"],
        tuesday: json["tuesday"],
        wednesday: json["wednesday"],
        thursday: json["thursday"],
        friday: json["friday"],
        saturday: json["saturday"],
        sunday: json["sunday"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "week_sched_id": weekSchedId,
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "friday": friday,
        "saturday": saturday,
        "sunday": sunday,
        "description": description,
      };
}
