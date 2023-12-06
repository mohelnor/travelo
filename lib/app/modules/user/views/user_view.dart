import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/txtfields.dart';
import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              tooltip: 'Edit'.tr,
              onPressed: () =>
                  controller.enabled.value = !controller.enabled.value,
              icon: const Icon(Icons.edit_attributes))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'signupWelcome'.tr,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => TxtField(
                  controller: controller.name,
                  hintText: 'fullName'.tr,
                  enabled: controller.enabled.value,
                )),
            const SizedBox(
              height: 10,
            ),
            Obx(() => TxtField(
                  controller: controller.phone,
                  hintText: 'phone'.tr,
                  enabled: controller.enabled.value,
                )),
            const SizedBox(
              height: 10,
            ),
            Obx(() => TxtField(
                  controller: controller.address,
                  hintText: 'address'.tr,
                  enabled: controller.enabled.value,
                )),
            const SizedBox(
              height: 10,
            ),
            Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : DropdownButton(
                    hint: Text('city'.tr),
                    items: controller.items,
                    value: controller.location?.value,
                    onChanged: controller.onChangeLocation,
                    isExpanded: true,
                    alignment: Alignment.center,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(10),
                  )),
            const SizedBox(
              height: 10,
            ),
            Obx(() => TxtField(
                  controller: controller.password,
                  hintText: 'password'.tr,
                  enabled: controller.enabled.value,
                  obscureText: !controller.enabled.value,
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: controller.signup,
              child: SizedBox(
                  width: Get.size.width,
                  height: 40,
                  child: Center(child: Text('Edit'.tr))),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
