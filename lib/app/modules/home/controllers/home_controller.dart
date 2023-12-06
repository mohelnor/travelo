import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelo/app/data/db_provider.dart';
import 'package:travelo/app/data/models/city.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final api = Get.put(DbProvider());
  final isLoading = false.obs;
  final cities = <City>[].obs;
  final location = City().obs;
  final destination = City().obs;
  List<DropdownMenuItem<City>> items = [];
  TextEditingController dateController = TextEditingController();

  @override
  void onInit() {
    fetchCities();
    ever(cities, (callback) => getItems());
    super.onInit();
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
          destination.value = cities[0];
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void settings() {
    Get.toNamed(Routes.SETTINGS);
  }

  void onChangeLocation(value) {
    location(value);
    update();
  }

  void onChangeDestination(value) {
    destination(value);
    update();
  }

  void search() {
    if (dateController.text.isNotEmpty &&
        location.value.name!.isNotEmpty &&
        destination.value.name!.isNotEmpty) {
      Get.toNamed(Routes.TRIPS, arguments: {
        'location': location.value.id,
        'destination': destination.value.id,
        'locationN': location.value.name,
        'destinationN': destination.value.name,
        'myDate': dateController.text,
      });
    }
  }
}
