import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/db_provider.dart';
import '../../../data/models/city.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  final api = Get.put(DbProvider());
  final isLoading = false.obs;
  final cities = <City>[].obs;
  final location = City().obs;

  List<DropdownMenuItem<City>> items = [];
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    fetchCities();
    ever(cities, (callback) => getItems());
    super.onInit();
  }



  void onChangeLocation(value) {
    location(value);
    update();
  }

  void signup() {
    if (phone.text.isNotEmpty) {
      
      api.add({
        "table": "users",
        "data": {
          'user': name.text,
          'name': name.text,
          'password': password.text,
          'address': address.text,
          'phone': phone.text,
          'city': int.parse(location.value.id!)
        },
      }).then((res) {
        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          if (res.body[0]) {
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
