import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:travelo/app/routes/app_pages.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                'Welcome'.tr,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.offAndToNamed(Routes.SIGNIN);
                  },
                  child: SizedBox(
                    height: 40,
                    child: Center(child: Text('signin'.tr)),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.SIGNUP);
                  },
                  child: Text('signup'.tr)),
            ],
          ),
        ),
      ),
    );
  }
}
