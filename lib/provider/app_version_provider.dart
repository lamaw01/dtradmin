import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../model/app_version_model.dart';
import '../service/http_service.dart';

class AppVersionProvider with ChangeNotifier {
  var _appVersionProviderList = <AppVersionModel>[];
  List<AppVersionModel> get appVersionProviderList => _appVersionProviderList;

  var _appVersion = "";
  String get appVersion => _appVersion;

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

  // get device version
  Future<void> getPackageInfo() async {
    try {
      await PackageInfo.fromPlatform().then((result) {
        _appVersion = result.version;
      });
    } catch (e) {
      debugPrint('$e getPackageInfo');
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
