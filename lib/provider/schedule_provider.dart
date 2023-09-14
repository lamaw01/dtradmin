import 'package:flutter/material.dart';

import '../model/schedule_model.dart';
import '../service/http_service.dart';

enum ScheduleProviderEnum { empty, success, error }

class ScheduleProvider with ChangeNotifier {
  var scheduleProviderStatus = ScheduleProviderEnum.empty;

  final _scheduleProviderList = <ScheduleModel>[];
  List<ScheduleModel> get scheduleProviderList => _scheduleProviderList;

  Future<void> getSchedule() async {
    if (scheduleProviderStatus == ScheduleProviderEnum.empty) {
      try {
        final result = await HttpService.getSchedule();
        _scheduleProviderList.addAll(result);
        if (_scheduleProviderList.isNotEmpty) {
          scheduleProviderStatus = ScheduleProviderEnum.success;
        }
      } catch (e) {
        debugPrint('$e getSchedule');
        scheduleProviderStatus = ScheduleProviderEnum.error;
      } finally {
        notifyListeners();
      }
    }
  }
}
