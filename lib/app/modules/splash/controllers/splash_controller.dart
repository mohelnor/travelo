import 'dart:async';

import 'package:get/get.dart';
import 'package:travelo/app/routes/app_pages.dart';
import 'package:travelo/main.dart';

class SplashController extends GetxController {
  Timer? _timer;
  final authService = Get.put(AuthService());
  @override
  void onInit() {
    super.onInit();
    authService.checkLoginStatus();
    checkAuth();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }

  void checkAuth() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      _timer = timer;
      if (authService.isLogged.value) {
        Get.offNamed(Routes.HOME);
      } else {
        Get.offNamed(Routes.WELCOME);
      }
    });
  }
}
