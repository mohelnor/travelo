import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travelo/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/mytile.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    controller;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("acct".tr,
                        style: theme.textTheme.headline6
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 80,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.isDarkMode
                          ? Colors.transparent
                          : Colors.grey.shade200),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Get.isDarkMode
                                ? Colors.grey
                                : Colors.grey.shade300),
                        child: Center(
                          child: Icon(Icons.person,
                              size: 32, color: Colors.grey.shade500),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.USER);
                        },
                        child: Text("acctMng".tr,
                            style: theme.textTheme.subtitle1?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.blue)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Text("settings".tr,
                    style: const TextStyle(fontWeight: FontWeight.w400)),
                const SizedBox(height: 16),
                MyTile(
                    title: 'apperance'.tr,
                    icon: Icons.dark_mode,
                    trailing: 'bkg'.tr,
                    color: Colors.purple,
                    onTap: () {
                      // Get.snackbar('مزايا إضافية', 'تضاف في المستقبل بإذن الله');
                      final theme = Theme.of(context);
                      _showAppearanceModal(theme, 'Light', controller);
                    }),
                const SizedBox(height: 8),
                MyTile(
                    title: 'lang'.tr,
                    icon: Icons.language,
                    color: Colors.grey,
                    onTap: () {
                      // Get.snackbar('مزايا إضافية', 'تضاف في المستقبل بإذن الله');
                      final theme = Theme.of(context);
                      _langBottomSheet();
                    }),
                const SizedBox(height: 8),
                MyTile(
                    title: 'about'.tr,
                    icon: Icons.people,
                    trailing: '',
                    color: Colors.orange,
                    onTap: () {
                      // Get.snackbar('مزايا إضافية', 'تضاف في المستقبل بإذن الله');
                      people();
                    }),
                const SizedBox(height: 8),
                MyTile(
                    title: 'help'.tr,
                    icon: Icons.help,
                    trailing: '',
                    color: Colors.green,
                    onTap: () {
                      helpModal();
                    }),
                const SizedBox(height: 8),
                MyTile(
                    title: 'exit'.tr,
                    icon: Icons.exit_to_app,
                    trailing: '',
                    color: Colors.red,
                    onTap: () {
                      GetStorage().erase();
                      Get.offAllNamed(Routes.SIGNIN);
                    }),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Text("version".tr,
                  style: theme.textTheme.bodyText2
                      ?.copyWith(color: Colors.grey.shade500)),
            ),
          ],
        ),
      ),
    ));
  }

  _langBottomSheet() {
    final box = GetStorage();
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(16),
      height: 320,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "selectLang".tr,
          ),
          const SizedBox(height: 32),
          ListTile(
            leading: const Icon(
              Icons.brightness_3,
              color: Colors.greenAccent,
            ),
            title: const Text("العربية"),
            onTap: () async {
              Get.updateLocale(const Locale('ar', 'SA'));
              await box.write('locale', ['ar', 'SA']);
              Get.back();
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(
              Icons.abc_sharp,
              color: Colors.yellow,
            ),
            title: const Text("English"),
            onTap: () async {
              Get.updateLocale(const Locale('en', 'US'));
              await box.write('locale', ['en', 'US']);
              Get.back();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    ));
  }

  _showAppearanceModal(
      ThemeData theme, String current, SettingsController controller) {
    final box = GetStorage();
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(16),
      height: 320,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "selectTheme".tr,
            style: theme.textTheme.subtitle1,
          ),
          const SizedBox(height: 32),
          ListTile(
            leading: const Icon(
              Icons.brightness_5,
              color: Colors.blue,
            ),
            title: Text("Light".tr, style: theme.textTheme.bodyText1),
            onTap: () async {
              controller.themesController.setTheme('light');
              Get.back();
            },
            trailing: Icon(
              Icons.check,
              color: current == 'light' ? Colors.blue : Colors.transparent,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(
              Icons.brightness_2,
              color: Colors.orange,
            ),
            title: Text("Dark".tr, style: theme.textTheme.bodyText1),
            onTap: () async {
              controller.themesController.setTheme('dark');
              Get.back();
            },
            trailing: Icon(
              Icons.check,
              color: current == 'dark' ? Colors.orange : Colors.transparent,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(
              Icons.brightness_6,
              color: Colors.blueGrey,
            ),
            title: Text("System".tr, style: theme.textTheme.bodyText1),
            onTap: () {
              controller.themesController.setTheme('system');
              Get.back();
            },
            trailing: Icon(
              Icons.check,
              color: current == 'system' ? Colors.blueGrey : Colors.transparent,
            ),
          ),
        ],
      ),
    ));
  }

  helpModal() {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(16),
      height: 320,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.help,
                color: Colors.blue,
              ),
              const SizedBox(width: 15),
              Text(
                "helpCntr".tr,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          const SizedBox(height: 32),
          ListTile(
            title: Text("contact".tr),
            trailing: const Icon(
              Icons.phone,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              if (!await launchUrl(
                  Uri.parse('tel:${controller.companies[0].phone}'))) {
                throw Exception('Could not launch');
              }
            },
            child: Text(
              "${controller.companies[0].phone}",
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text("email".tr),
            trailing: const Icon(
              Icons.email,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "help@travelo.com",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ));
  }

  people() {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(16),
      height: 320,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.help,
                color: Colors.blue,
              ),
              const SizedBox(width: 15),
              Text(
                "about".tr,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          const SizedBox(height: 32),
          Text(
            '''txt'''.tr,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    ));
  }
}
