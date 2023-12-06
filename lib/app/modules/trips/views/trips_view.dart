import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:travelo/app/routes/app_pages.dart';

import '../controllers/trips_controller.dart';

class TripsView extends GetView<TripsController> {
  const TripsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.SETTINGS);
                },
                icon: const Icon(Icons.settings))
          ],
          title: Text('buses'.tr),
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
                : controller.buses.isEmpty
                    ? Center(
                        child: Text('noTrips'.tr),
                      )
                    : GridView.builder(
                        itemCount: controller.buses.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (__, index) {
                          final bus = controller.buses[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.BOOKING,
                                  arguments: [bus, controller.args]);
                            },
                            child: Card(
                              // color: Colors.red,
                              child: Center(
                                  child: Text(
                                bus.name.toString(),
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
