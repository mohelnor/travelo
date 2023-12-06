import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travelo/app/data/models/user.dart';

import '../../../../main.dart';
import '../../../data/db_provider.dart';
import '../../../routes/app_pages.dart';

class SigninController extends GetxController {
  final api = Get.put(DbProvider());
  final box = GetStorage();
  final auth = Get.find<AuthService>();
  User user = User();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login() async {
    if (phone.text.isNotEmpty && password.text.isNotEmpty) {
      api.fetch({
        "table": "users",
        "where": "phone = '${phone.text}' and password = '${password.text}'"
      }).then((res) {
        print(res.bodyString);
        if (res.statusCode! >= 200 &&
            res.statusCode! < 300 &&
            res.body['res'] != null) {
          user = userFromJson(json.encode(res.body['res']))[0];
          box.write('user', user).then((value) => Get.offNamed(Routes.HOME));
        } else {
          print('connection problems');
        }
      });
    }
  }

  void back() {
    auth.box.erase();
    Get.offAllNamed(Routes.WELCOME);
  }
}
