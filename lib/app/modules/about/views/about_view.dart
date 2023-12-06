import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AboutV'.tr),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'aboutMsg'.tr,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
