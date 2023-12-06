import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/myrow.dart';

import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);
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
        title: Text('Booking'.tr),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          height: Get.height * 0.85,
          child: Card(
            color: Get.isDarkMode ? Colors.transparent : Colors.grey[100],
            margin: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ))
                    : Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          MyRow(
                              txt: 'location'.tr,
                              txt2: controller.trip['locationN']),
                          MyRow(
                              txt: 'destination'.tr,
                              txt2: controller.trip['destinationN']),
                          MyRow(
                              txt: 'bus'.tr,
                              txt2:
                                  '${controller.bus.name!} / ${controller.bus.plate!}'),
                          MyRow(txt: 'takeoff'.tr, txt2: controller.bus.date!),
                          MyRow(txt: 'tickets'.tr, txt2: controller.bus.seats!),
                          MyRow(
                              txt: 'ticketPrice'.tr,
                              txt2: controller.bus.ticketPrice!),
                          MyColomn(
                            txt: 'note'.tr,
                            txt2: controller.bus.details!,
                            maxLines: 3,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.CONFIRM,
                                  arguments: Get.arguments);
                            },
                            child: SizedBox(
                                width: Get.width,
                                height: 40,
                                child: Center(child: Text('book'.tr))),
                          ),
                        ],
                      ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
