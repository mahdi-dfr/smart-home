import 'package:flutter/material.dart';

import '../../features/home/presentation/screen/home_page.dart';
import '../../test.dart';

class AppUtils{
  static const String userTokenAccess = 'UserTokenAccess';
  static const String userTokenRefresh = 'UserTokenRefresh';

  static List<IconData> iconList = <IconData>[
    Icons.home,
    Icons.access_time_rounded,
    Icons.control_point_duplicate_sharp,
    Icons.menu,
  ];

  static List<Widget> pages = [
    HomePage(),
    Test2(),
    Test3(),
    Test4(),
  ];

  static List<String> navTitle = [
    'خانه',
    'سناریو',
    'شرایط خاص',
    '',
  ];
}