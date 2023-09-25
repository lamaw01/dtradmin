import 'package:flutter/material.dart';

import '../model/schedule_model.dart';
import '../service/http_service.dart';

class ScheduleProvider with ChangeNotifier {
  var _scheduleProviderList = <ScheduleModel>[];
  List<ScheduleModel> get scheduleProviderList => _scheduleProviderList;

  bool checkScheduleId(String scheduleId) {
    for (var schedule in _scheduleProviderList) {
      if (schedule.schedId == scheduleId) {
        return true;
      }
    }
    return false;
  }

  Future<void> getSchedule() async {
    try {
      final result = await HttpService.getSchedule();
      _scheduleProviderList = result;
    } catch (e) {
      debugPrint('$e getSchedule');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addSchedule({
    required String schedId,
    required String schedType,
    required String schedIn,
    required String breakStart,
    required String breakEnd,
    required String schedOut,
    required String description,
  }) async {
    try {
      await HttpService.addSchedule(
        schedId: schedId,
        schedType: schedType,
        schedIn: schedIn,
        breakStart: breakStart,
        breakEnd: breakEnd,
        schedOut: schedOut,
        description: description,
      );
    } catch (e) {
      debugPrint('$e addSchedule');
    } finally {
      await getSchedule();
    }
  }

  Future<void> updateSchedule({
    required String schedId,
    required String schedType,
    required String schedIn,
    required String breakStart,
    required String breakEnd,
    required String schedOut,
    required String description,
    required int id,
  }) async {
    try {
      await HttpService.updateSchedule(
        schedId: schedId,
        schedType: schedType,
        schedIn: schedIn,
        breakStart: breakStart,
        breakEnd: breakEnd,
        schedOut: schedOut,
        description: description,
        id: id,
      );
    } catch (e) {
      debugPrint('$e updateSchedule');
    } finally {
      await getSchedule();
    }
  }

  Future<void> deleteSchedule({
    required int id,
  }) async {
    try {
      await HttpService.deleteSchedule(
        id: id,
      );
    } catch (e) {
      debugPrint('$e deleteSchedule');
    } finally {
      await getSchedule();
    }
  }
}
