// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

List<ScheduleModel> scheduleModelFromJson(String str) =>
    List<ScheduleModel>.from(
        json.decode(str).map((x) => ScheduleModel.fromJson(x)));

String scheduleModelToJson(List<ScheduleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleModel {
  int id;
  String schedId;
  String schedType;
  String schedIn;
  String breakStart;
  String breakEnd;
  String schedOut;
  String description;

  ScheduleModel({
    required this.id,
    required this.schedId,
    required this.schedType,
    required this.schedIn,
    required this.breakStart,
    required this.breakEnd,
    required this.schedOut,
    required this.description,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        schedId: json["sched_id"],
        schedType: json["sched_type"],
        schedIn: json["sched_in"],
        breakStart: json["break_start"],
        breakEnd: json["break_end"],
        schedOut: json["sched_out"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sched_id": schedId,
        "sched_type": schedType,
        "sched_in": schedIn,
        "break_start": breakStart,
        "break_end": breakEnd,
        "sched_out": schedOut,
        "description": description,
      };
}
