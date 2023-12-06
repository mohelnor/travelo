import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:travelo/app/data/models/bookings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var dataController = controller.bookings;
    return Scaffold(
      appBar: AppBar(
        title: Text('bookings'.tr),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
              strokeWidth: 1,
            ))
          : dataController.isEmpty
              ? Center(child: Text('emtyOrders'.tr))
              : ListView.builder(
                  itemCount: dataController?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _openBottomSheet(dataController[index]);
                      },
                      child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: dataController[index].payed == '0'
                                  ? Colors.red[100]
                                  : Colors.greenAccent[100],
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              const Badge(
                                alignment: AlignmentDirectional.bottomEnd,
                                label: Text('2'),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.amber,
                                  child: Icon(Icons.book),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dataController[index].user!.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Text(dataController[index].fullname!,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                  Text(dataController[index].phone!,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                ],
                              ),
                            ],
                          )),
                    );
                  })),
    );
  }

  _openBottomSheet(Bookings mybookings) {
    Map bookings = mybookings.toJson();
    List myKeys = bookings.keys.toList();
    List myValues = bookings.values.toList();
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(15)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ...List.generate(
                bookings.length,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(myKeys[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(myValues[index]),
                        ],
                      ),
                    )),
            Builder(
              builder: (context) {
                if (bookings['payed'] == '0') {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () async {
                          print(controller.companies[0].phone);
                          if (!await launchUrl(Uri.parse(
                              'tel:${controller.companies[0].phone}'))) {
                            throw Exception('Could not launch');
                          }
                          // controller.editBookings(mybookings);
                        },
                        child: SizedBox(
                            width: Get.width * 0.75,
                            child: Center(child: Text('payNow'.tr)))),
                  );
                }
                return Container();
              },
            )
          ]),
        ),
      ),
    );
  }
}
