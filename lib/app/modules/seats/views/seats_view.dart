import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/seats_controller.dart';

class SeatsView extends GetView<SeatsController> {
  const SeatsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('seat'.tr),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ))
                : controller.seats.isEmpty
                ? const Center(
                    child: Text('لا تتوفر مقاعد خالية'))
                : GridView.builder(
                    itemCount: controller.seats.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (__, index) {
                      final seat = controller.seats[index];
                      return GestureDetector(
                        onTap: () {
                          Get.back(result: seat);
                        },
                        child: Card(
                          color: seat.taken == '1'
                              ? Colors.red
                              : Colors.greenAccent,
                          child: Center(
                              child: Text(
                            seat.seat.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      );
                    }),
          ),
        ));
  }
}
