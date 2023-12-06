import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:travelo/app/routes/app_pages.dart';
import '../../../widgets/txtfields.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              tooltip: "orders".tr,
              onPressed: () {
                Get.toNamed(Routes.ORDERS);
              },
              icon: const Icon(Icons.list)),
          IconButton(
              onPressed: controller.settings, icon: const Icon(Icons.settings)),
        ],
        title: Text('HomeView'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      Get.isDarkMode ? Colors.grey[500] : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : DropdownButton(
                        hint: Text('location'.tr),
                        items: controller.items,
                        value: controller.location.value,
                        onChanged: controller.onChangeLocation,
                        isExpanded: true,
                        alignment: Alignment.center,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(10),
                      )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  color:
                      Get.isDarkMode ? Colors.grey[500] : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : DropdownButton(
                        hint: Text('destination'.tr),
                        items: controller.items,
                        value: controller.destination.value,
                        onChanged: controller.onChangeDestination,
                        isExpanded: true,
                        alignment: Alignment.center,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(10),
                      )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DateField(
              controller: controller.dateController,
              hintText: 'pickDate'.tr,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050));
                if (pickedDate != null) {
                  controller.dateController.text = pickedDate
                      .toString(); //set foratted date to TextField value.
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                controller.search();
              },
              child: SizedBox(
                  width: Get.size.width,
                  height: 40,
                  child: Center(child: Text('search'.tr))),
            ),
          ],
        ),
      ),
    );
  }
}
