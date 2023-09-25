import 'package:flutter/material.dart';

import '../model/app_version_model.dart';
import '../service/http_service.dart';

class AppVersionProvider with ChangeNotifier {
  var _appVersionProviderList = <AppVersionModel>[];
  List<AppVersionModel> get appVersionProviderList => _appVersionProviderList;

  Future<void> getAppVersion() async {
    try {
      final result = await HttpService.getAppVersion();
      _appVersionProviderList = result;
    } catch (e) {
      debugPrint('$e getAppVersion');
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateAppVersion({
    required String name,
    required String version,
    required int id,
  }) async {
    try {
      await HttpService.updateAppVersion(name: name, version: version, id: id);
    } catch (e) {
      debugPrint('$e updateAppVersion');
    } finally {
      await getAppVersion();
    }
  }
}
