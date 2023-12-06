import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/db_provider.dart';
import '../../../data/models/city.dart';
import '../../../data/models/user.dart';
import '../../../routes/app_pages.dart';

class UserController extends GetxController {
  final auth = Get.find<AuthService>();
  User user = User();
  final api = Get.put(DbProvider());
  final isLoading = false.obs;
  final cities = <City>[].obs;
  final location = City().obs;
  int id = 0;
  final enabled = false.obs;

  List<DropdownMenuItem<City>> items = [];
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    fetchCities();
    user = auth.user!;
    phone.text = user.phone!;
    name.text = user.name!;
    address.text = user.address!;
    password.text = user.password!;
    id = int.parse(user.id!);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onChangeLocation(value) {
    location!(value);
  }

  void signup() {
    if (phone.text.isNotEmpty) {
      api.edit({
        "table": "users",
        "id": id,
        "data": {
          'name': name.text,
          'password': password.text,
          'address': address.text,
          'phone': phone.text,
          'city': int.parse(location.value.id!)
        },
      }).then((res) {
        print(res.bodyString);
        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          if (res.body['msg']) {
            Get.toNamed(Routes.SIGNIN);
          } else {
            Get.bottomSheet(Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 130,
                width: 200,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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
                          'signupMsg'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'yes'.tr,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ));
          }
        } else {
          print('connection problems');
        }
      });
    }
  }

  getItems() {
    items = List<DropdownMenuItem<City>>.from(cities.map((city) {
      return DropdownMenuItem<City>(
        value: city,
        child: Text(city.name!),
      );
    }));
  }

  fetchCities() async {
    isLoading.value = true;
    try {
      api.fetch({"table": "cities"}).then((res) {
        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          cities.value = cityFromJson(json.encode(res.body['res']));
          location.value = cities[0];
          if (cities.isNotEmpty) {
            getItems();
            isLoading.value = false;
          }
        } else {
          print('connection problems');
        }
        return;
      });
    } catch (e) {
      print('$e problems');
    }
  }
}
