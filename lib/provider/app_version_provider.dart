import 'package:flutter/material.dart';

import '../model/version_model.dart';
import '../service/http_service.dart';

enum AppVersionProviderEnum { empty, success, error }

class AppVersionProvider with ChangeNotifier {
  var appVersionProviderStatus = AppVersionProviderEnum.empty;

  final _appVersionProviderList = <VersionModel>[];
  List<VersionModel> get appVersionProviderList => _appVersionProviderList;

  Future<void> getAppVersion() async {
    if (appVersionProviderStatus == AppVersionProviderEnum.empty) {
      try {
        final result = await HttpService.getAppVersion();
        _appVersionProviderList.addAll(result);
        if (_appVersionProviderList.isNotEmpty) {
          appVersionProviderStatus = AppVersionProviderEnum.success;
        }
      } catch (e) {
        debugPrint('$e getAppVersion');
        appVersionProviderStatus = AppVersionProviderEnum.error;
      } finally {
        notifyListeners();
      }
    }
  }
}
