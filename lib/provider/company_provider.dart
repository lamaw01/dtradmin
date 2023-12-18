import 'package:flutter/material.dart';

import '../model/company_model.dart';
import '../service/http_service.dart';

class CompanyProvider with ChangeNotifier {
  var _companyList = <CompanyModel>[];
  List<CompanyModel> get companyList => _companyList;

  var _companyListForEmployee = <CompanyModel>[];
  List<CompanyModel> get companyListForEmployee => _companyListForEmployee;

  var _companyListSelect = <CompanyModel>[];
  List<CompanyModel> get companyListSelect => _companyListSelect;

  var _selectedCompany =
      CompanyModel(id: 0, companyId: '000', companyName: '--Select--');
  CompanyModel get selectedCompany => _selectedCompany;

  void changeSelectedCompany(CompanyModel companyModel) {
    _selectedCompany = companyModel;
    notifyListeners();
  }

  Future<void> getCompany() async {
    try {
      final result = await HttpService.getCompany();
      _companyList = result;
      notifyListeners();
    } catch (e) {
      debugPrint('$e getcompany');
    }
  }

  bool checkCompanyId(String companyId) {
    for (var company in _companyList) {
      if (company.companyId == companyId) {
        return true;
      }
    }
    return false;
  }

  Future<void> addCompany({
    required String companyId,
    required String companyName,
  }) async {
    try {
      await HttpService.addCompany(
          companyId: companyId, companyName: companyName);
    } catch (e) {
      debugPrint('$e addCompany');
    } finally {
      await getCompany();
    }
  }

  Future<void> updateCompany({
    required String companyId,
    required String companyName,
    required int id,
  }) async {
    try {
      await HttpService.updateCompany(
        companyId: companyId,
        companyName: companyName,
        id: id,
      );
    } catch (e) {
      debugPrint('$e updateCompany');
    } finally {
      await getCompany();
    }
  }

  Future<void> deleteCompany({
    required int id,
  }) async {
    try {
      await HttpService.deleteCompany(id: id);
    } catch (e) {
      debugPrint('$e deleteCompany');
    } finally {
      await getCompany();
    }
  }

  Future<void> getCompanySelect() async {
    try {
      final result = await HttpService.getCompany();
      _companyListSelect = result;
      notifyListeners();
    } catch (e) {
      debugPrint('$e getDepartmentSelect');
    }
  }

  Future<void> getCompanyForEmployee() async {
    try {
      final result = await HttpService.getCompany();
      result.insert(0, _selectedCompany);
      _companyListForEmployee = result;
      notifyListeners();
    } catch (e) {
      debugPrint('$e getDepartmentForEmployee');
    }
  }
}
