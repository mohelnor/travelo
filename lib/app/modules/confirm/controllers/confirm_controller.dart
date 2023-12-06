import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travelo/app/data/db_provider.dart';
import 'package:travelo/app/data/models/bookings.dart';
import 'package:travelo/app/data/models/bus.dart';
import 'package:travelo/app/data/models/seat.dart';

import '../../../../main.dart';
import '../../../data/models/user.dart';
import '../../../routes/app_pages.dart';

class ConfirmController extends GetxController {
  final api = Get.put(DbProvider());
  final box = GetStorage();
  final args = Get.arguments;
  TextEditingController bus = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController tickets = TextEditingController(text: '1');
  TextEditingController seats = TextEditingController();
  TextEditingController myNotes = TextEditingController();
  RxBool luggage = true.obs;
  Bus busClass = Bus();
  User user = User();
  Map trip = {};
  List<Seats> mySeats = <Seats>[].obs;
  @override
  void onInit() {
    setAll();
    super.onInit();
  }

  setAll() {
    if (box.read('user') != null) {
      user = box.read('user');
      fullname.text = user.name!;
      phone.text = user.phone!;
      busClass = args[0];
      trip = args[1];
      bus.text = busClass.name!;
    } else {
      Get.offAllNamed(Routes.SPLASH);
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

  addSeat() async {
    print(mySeats);
    final Seats result =
        await Get.toNamed(Routes.SEATS, arguments: busClass.id);
    var check = mySeats.any((res) => res.id == result.id);
    if (!check) {
      seats.text += '${result.seat!} - ';
      mySeats.add(result);
    }
    tickets.text = '${mySeats.length}';
  }

  bookNow() {
    String myLuggage = luggage.value ? '1' : '0';
    List data = [];
    List seatData = [];
    mySeats.forEach((seat) {
      data.add({
        'bus': int.parse(busClass.id!),
        'fullname': fullname.text,
        'phone': phone.text,
        'location': int.parse(user.city!),
        'seat': int.parse(seat.seat!),
        'luggage': int.parse(myLuggage),
        'user': int.parse(user.id!),
        'price': int.parse(busClass.ticketPrice!),
        'due': busClass.date,
        'trip': busClass.trip,
        'notes': myNotes.text
      });
      seatData.add({
        "id": seat.id,
        "taken": "1",
      });
    });

    api.add({"table": "bookings", "data": data}).then((res) {
      print(res.body[0].runtimeType);
      print(res.body[0]);
      if (res.body[0]) {
        print(seatsToJson(mySeats));
        api.edit({"table": "seats", "data": seatData}).then(
            (value) => print(value.bodyString));
      }
    });

    Get.offAllNamed(Routes.HOME);
  }
}
