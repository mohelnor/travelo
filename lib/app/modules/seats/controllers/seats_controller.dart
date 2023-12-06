import 'dart:convert';

import 'package:get/get.dart';
import '../../../data/db_provider.dart';
import '../../../data/models/seat.dart';

class SeatsController extends GetxController {
  final api = Get.put(DbProvider());
  final isLoading = false.obs;
  final seats = <Seats>[].obs;

  @override
  void onInit() {
    fetchSeats();
    super.onInit();
  }

  fetchSeats() async {
    isLoading.value = true;
    try {
      api.fetch({
        "table": "seats",
        "where": "taken = 0 AND bus = ${Get.arguments}"
      }).then((res) {
        print(res.bodyString);
        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          if (res.body['msg'] == 'ok') {
            seats.value = seatsFromJson(json.encode(res.body['res']));
          }
          isLoading.value = false;
        } else {
          print('connection problems');
        }
        return;
      });
    } catch (e) {
      print('$e problems');
    }
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
