import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/txtfields.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            TxtField(
              controller: controller.name,
              hintText: 'fullName'.tr,
            ),
            const SizedBox(
              height: 10,
            ),
            TxtField(
              controller: controller.phone,
              hintText: 'phone'.tr,
            ),
            const SizedBox(
              height: 10,
            ),
            TxtField(
              controller: controller.address,
              hintText: 'address'.tr,
            ),
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
            TxtField(
              controller: controller.password,
              hintText: 'password'.tr,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: controller.signup,
              child: SizedBox(
                  width: Get.size.width,
                  height: 40,
                  child: Center(child: Text('signup'.tr))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('cancel'.tr))
          ],
        ),
      ),
    );
  }
}
