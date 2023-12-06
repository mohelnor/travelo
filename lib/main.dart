import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travelo/app/data/lang.dart';
import 'package:travelo/app/data/models/user.dart';
import 'package:travelo/app/data/user_provider.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/themes.dart';
import 'app/theme/themescontroller.dart';

Future<void> main() async {
  await GetStorage.init();
  initServices();
  runApp(
    GetMaterialApp(
      translations: Lang(),
      locale: const Locale('ar', 'SA'),
      fallbackLocale: const Locale('ar', 'SA'),
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: SettingsService().theme.getThemeMode(),
      debugShowCheckedModeBanner: false,
      title: "travelo".tr,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

void initServices() async {
  print('starting services ...');
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => SettingsService().init());
  print('All services started...');
}

class AuthService extends GetxService {
  final box = GetStorage();
  final userProvider = Get.put(UserProvider());
  final isLogged = false.obs;
  User user = User();

  void logOut() {
    isLogged.value = false;
    box.remove('user');
  }

  void login(User me) async {
    userProvider.authUser({
      "query":
          "SELECT * FROM users WHERE phone = '${me.phone}' and password = '${me.password}'",
      "return_result": "true"
    }).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        if (value.body['res'][0] == 0) {
          return;
        }
        user = User.fromJson(value.body['res'][1][0]);
        isLogged.value = true;
        await box.write('user', user);
      } else {
        print('connection problems');
      }
    });

    // isLogged.value = true;
  }

  void checkLoginStatus() {
    if (box.read('user') != null) {
      user = User.fromJson(box.read('user'));
      login(user);
    } else {
      print('user not set');
    }
  }

  Future<AuthService> init() async {
    checkLoginStatus();
    return this;
  }
}

class SettingsService extends GetxService {
  final theme = Get.put(ThemesController());
  final box = GetStorage();
  Future<SettingsService> init() async {
    Locale? locale = Get.deviceLocale;
    List lang = box.read('locale') ?? [];
    if (lang.isNotEmpty) {
      locale = Locale(lang[0], lang[1]);
      Get.updateLocale(locale);
    }

    print('$runtimeType delays 1 sec');
    await 1.delay();
    print('$runtimeType ready!');
    return this;
  }
}
