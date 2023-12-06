import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/db_provider.dart';
import '../../../data/models/company.dart';
import '../../../theme/themescontroller.dart';

class SettingsController extends GetxController {
  final ThemesController themesController = Get.find();
  final api = Get.put(DbProvider());
  final companies = <Company>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchCompany();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchCompany() {
    try {
      api.fetch({"table": "company"}).then((res) {
        print(res.bodyString);
        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          companies.value = companyFromJson(json.encode(res.body['res']));
        } else {
          print('connection problems');
        }
        return;
      });
    } catch (e) {
      print('$e problems');
    }
  }
}
