import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/routes.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/core/widget/oval_right_border_clipper.dart';
import 'package:turkeysh_smart_home/core/widget/question_dialog.dart';

import '../constants/images.dart';
import 'drawer_item_list.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({Key? key}) : super(key: key);

  //final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width: 300,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: Get.theme.primaryColor,
                    ),
                    onPressed: () {
                      questionDialog(
                          title: 'خروج از حساب کاربری',
                          question: 'آیا میخواهید از حساب کاربری خود خارج شوید؟',
                          onYesClicked: () {
                            GetStorage().remove(AppUtils.userTokenAccess);
                            GetStorage().remove(AppUtils.userTokenRefresh);
                            GetStorage().remove(AppUtils.username);
                            Get.offAllNamed(PagesRoutes.login);
                          });
                    },
                  ),
                ),
                width > 600
                    ? const SizedBox()
                    : Container(
                        height: 90,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          //shape: BoxShape.circle,
                          //border: Border.all(width: 2, color: Colors.orange),
                          image: DecorationImage(image: AssetImage(Images.logo)),
                        ),
                      ),
                const SizedBox(height: 5.0),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: null,
                        bottom: 00,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(0),
                          child: Container(
                            height: 500,
                            width: 500,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Get.isDarkMode ? Images.logoDark : Images.logo),
                                  fit: BoxFit.cover,
                                  opacity: 0.05),
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            DrawerItemOption(
                                icon: const Icon(Icons.signal_wifi_connected_no_internet_4),
                                title: 'حالت آفلاین',
                                onTap: () {
                                  // Get.toNamed(
                                  // RouteHelper.getLanguageRoute('menu'));
                                }),
                            DrawerItem(
                                icon: const Icon(Icons.language),
                                title: 'زبان',
                                onTap: () {
                                  // Get.toNamed(
                                  // RouteHelper.getLanguageRoute('menu'));
                                }),

                            DrawerItem(
                                icon: const Icon(Icons.settings),
                                title: 'تنظیمات',
                                onTap: () {
                                  //Get.toNamed(RouteHelper.getSettingRoute());
                                }),
                            DrawerItem(
                                icon: const Icon(Icons.developer_board),
                                title: 'تنظیمات بردها',
                                onTap: () {
                                  Get.back();
                                  Get.toNamed(PagesRoutes.boardSetting);
                                }),

                            DrawerItem(
                                icon: const Icon(Icons.info),
                                title: 'در مورد ما',
                                onTap: () {
                                  //Todo Page about us...
                                }),

                            DrawerItem(
                                icon: const Icon(Icons.shopping_bag),
                                title: 'فروشگاه',
                                onTap: () {
                                  //Todo Page store WebView
                                }),

                          ],
                        ),
                      ).paddingSymmetric(horizontal: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
