import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travelo/app/data/models/bookings.dart';
import 'package:travelo/app/data/models/company.dart';
import 'package:travelo/app/data/models/user.dart';

import '../../../../main.dart';
import '../../../data/db_provider.dart';

class OrdersController extends GetxController {
  final api = Get.put(DbProvider());
  final auth = Get.find<AuthService>();
  final box = GetStorage();
  final isLoading = true.obs;
  final companies = <Company>[].obs;
  RxList<Bookings> bookings = <Bookings>[].obs;
  User user = User();
  @override
  void onInit() {
    user = auth.user!;
    user = box.read('user');
    fetchBookings();
    fetchCompany();
    super.onInit();
  }

  fetchBookings() {
    print("SELECT * FROM bookings WHERE user = ${user.id}");
    api.queryData({
      "query": "SELECT * FROM bookings WHERE user = ${user.id}",
      "return_result": "true"
    }).then((res) {
      // print(res.bodyString);
      if (res.statusCode! >= 200 &&
          res.statusCode! < 300 &&
          res.body['res'].toString().isNotEmpty) {
        bookings.value = bookingsFromJson(json.encode(res.body['res'][1]));
        isLoading.value = false;
      } else {
        print('connection problems');
      }
    });
  }

  fetchCompany() {
    try {
      api.fetch({"table": "company"}).then((res) {
        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          companies.value = companyFromJson(json.encode(res.body['res']));
          // if (companies.isNotEmpty) {
          //   isLoading.value = false;
          // }
        } else {
          print('connection problems');
        }
        return;
      });
    } catch (e) {
      print('$e problems');
    }
  }

  editBookings(Bookings mybookings) {
    isLoading.value = true;
    mybookings.payed = '1';
    api.edit({"table": "bookings", "data": bookings}).then((res) {
      if (res.statusCode! >= 200 &&
          res.statusCode! < 300 &&
          res.body['res'].toString().isNotEmpty) {
        fetchBookings();
        isLoading.value = false;
      } else {
        print('connection problems');
      }
    });
    Get.back();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
