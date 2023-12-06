import 'dart:convert';

import 'package:get/get.dart';
import 'package:travelo/app/data/models/bus.dart';

import '../../../data/db_provider.dart';

class TripsController extends GetxController {
  final api = Get.put(DbProvider());
  final isLoading = true.obs;
  RxList<Bus> buses = <Bus>[].obs;
  final count = 0.obs;
  Map<String, dynamic> args = Get.arguments;
  @override
  void onInit() {
    fetchBuses();
    super.onInit();
  }

  fetchBuses() {
    String location = '${args['location']}',
        destination = '${args['destination']}',
        myDate = args['myDate'];
    api.fetch({
      "table": "bus",
      "where":
          "trip = (SELECT id FROM `trips` WHERE location = ${location} AND destination = ${destination} AND day(due) = day('${myDate}'))"
    }).then((res) {
      print(res.bodyString);
      isLoading.value = res.body['res'] == null ? false : true;
      if (res.statusCode! >= 200 &&
          res.statusCode! < 300 &&
          res.body['res'] != null) {
        isLoading.value = false;
        buses.value = busFromJson(json.encode(res.body['res']));
      } else {
        print('connection problems');
      }
    });
  }

  @override
  void onReady() {
    fetchBuses();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
