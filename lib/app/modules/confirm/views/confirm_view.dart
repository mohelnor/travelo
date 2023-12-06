import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/txtfields.dart';
import '../controllers/confirm_controller.dart';

class ConfirmView extends GetView<ConfirmController> {
  const ConfirmView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('confirmView'.tr),
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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all()),
                      child: TxtField(
                        readOnly: true,
                        controller: controller.bus,
                        hintText: 'bus'.tr,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all()),
                      child: TxtField(
                        controller: controller.phone,
                        hintText: 'phone'.tr,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all()),
                      child: TxtField(
                        controller: controller.fullname,
                        hintText: 'fullName'.tr,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all()),
                      child: TxtField(
                        controller: controller.tickets,
                        hintText: 'tickets'.tr,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all()),
                      child: TxtField(
                        onTap: controller.addSeat,
                        readOnly: true,
                        controller: controller.seats,
                        hintText: 'seat'.tr,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all()),
                        child: Obx(() => CheckboxListTile(
                              title: Text('luggage'.tr),
                              value: controller.luggage.value,
                              onChanged: (value) {
                                controller.luggage.value =
                                    !controller.luggage.value;
                              },
                            ))),
                    Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all()),
                      child: TxtField(
                        minLines: 1,
                        maxLines: 3,
                        controller: controller.myNotes,
                        hintText: 'myNote'.tr,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.dialog(Center(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            height: 130,
                            width: 200,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Material(
                              color: Colors.transparent,
                              textStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Center(
                                    child: Text(
                                      'confirmMsg'.tr,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Get.back();
                                            controller.bookNow();
                                          },
                                          icon: const Icon(Icons.check),
                                          label: Text(
                                            'yes'.tr,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          )),
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: const Icon(Icons.close),
                                          label: Text(
                                            'no'.tr,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                        // controller.bookNow;
                      },
                      child: SizedBox(
                          width: Get.size.width,
                          height: 40,
                          child: Center(child: Text('confirm'.tr))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
