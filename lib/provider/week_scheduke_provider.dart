import 'package:flutter/material.dart';

import '../model/week_schedule_model.dart';
import '../service/http_service.dart';

class WeekScheduleProvider with ChangeNotifier {
  var _weekScheduleProviderList = <WeekScheduleModel>[];
  List<WeekScheduleModel> get weekScheduleProviderList =>
      _weekScheduleProviderList;

  bool checkWeekSchedId(String weekSchedId) {
    for (var weekSched in _weekScheduleProviderList) {
      if (weekSched.weekSchedId == weekSchedId) {
        return true;
      }
    }
    return false;
  }

  Future<void> getWeekSchedule() async {
    try {
      final result = await HttpService.getWeekSchedule();
      _weekScheduleProviderList = result;
    } catch (e) {
      debugPrint('$e getWeekSchedule');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addWeekSchedule({
    required String weekSchedId,
    required String monday,
    required String tuesday,
    required String wednesday,
    required String thursday,
    required String friday,
    required String saturday,
    required String sunday,
    required String description,
  }) async {
    try {
      await HttpService.addWeekSchedule(
        weekSchedId: weekSchedId,
        monday: monday,
        tuesday: tuesday,
        wednesday: wednesday,
        thursday: thursday,
        friday: friday,
        saturday: saturday,
        sunday: sunday,
        description: description,
      );
    } catch (e) {
      debugPrint('$e addWeekSchedule');
    } finally {
      await getWeekSchedule();
    }
  }

  Future<void> updateWeekSchedule({
    required String weekSchedId,
    required String monday,
    required String tuesday,
    required String wednesday,
    required String thursday,
    required String friday,
    required String saturday,
    required String sunday,
    required String description,
    required int id,
  }) async {
    try {
      await HttpService.updateWeekSchedule(
        weekSchedId: weekSchedId,
        monday: monday,
        tuesday: tuesday,
        wednesday: wednesday,
        thursday: thursday,
        friday: friday,
        saturday: saturday,
        sunday: sunday,
        description: description,
        id: id,
      );
    } catch (e) {
      debugPrint('$e updateWeekSchedule');
    } finally {
      await getWeekSchedule();
    }
  }

  Future<void> deleteWeekSchedule({
    required int id,
  }) async {
    try {
      await HttpService.deleteWeekSchedule(
        id: id,
      );
    } catch (e) {
      debugPrint('$e deleteWeekSchedule');
    } finally {
      await getWeekSchedule();
    }
  }
}
