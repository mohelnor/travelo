import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/txtfields.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'signinWelcome'.tr,
              style: const TextStyle(fontSize: 20),
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
              controller: controller.password,
              hintText: 'password'.tr,
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: controller.login,
              child: SizedBox(
                  width: Get.size.width,
                  height: 40,
                  child: Center(child: Text('signin'.tr))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: controller.back,
              child: Text('back'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
