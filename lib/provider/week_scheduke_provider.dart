import 'package:flutter/material.dart';

import '../model/week_schedule_model.dart';
import '../service/http_service.dart';

enum WeekScheduleProviderEnum { empty, success, error }

class WeekScheduleProvider with ChangeNotifier {
  var weekScheduleProviderStatus = WeekScheduleProviderEnum.empty;

  final _weekScheduleProviderList = <WeekScheduleModel>[];
  List<WeekScheduleModel> get weekScheduleProviderList =>
      _weekScheduleProviderList;

  Future<void> getWeekSchedule() async {
    if (weekScheduleProviderStatus == WeekScheduleProviderEnum.empty) {
      try {
        final result = await HttpService.getWeekSchedule();
        _weekScheduleProviderList.addAll(result);
        if (_weekScheduleProviderList.isNotEmpty) {
          weekScheduleProviderStatus = WeekScheduleProviderEnum.success;
        }
      } catch (e) {
        debugPrint('$e getWeekSchedule');
        weekScheduleProviderStatus = WeekScheduleProviderEnum.error;
      } finally {
        notifyListeners();
      }
    }
  }
}
