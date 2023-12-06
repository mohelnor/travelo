import 'package:get/get.dart';

import '../../../data/models/bus.dart';

class BookingController extends GetxController {
  final isLoading = true.obs;
  final Bus bus = Get.arguments[0];
  final Map trip = Get.arguments[1];
  @override
  void onInit() {
    if (bus.id!.isNotEmpty) {
      isLoading.value = false;
    }
    print(Get.arguments);
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
}
