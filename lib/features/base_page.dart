import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';

import '../core/constants/utils.dart';
import '../core/widget/drawer.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);



  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int currentIndex = 0;
  final _advancedDrawerController = AdvancedDrawerController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: const Icon(Icons.monitor),
      ),
      drawer: MyDrawerWidget(),
      //key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        activeIndex: currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 20,
        blurEffect: true,
        height: width > 600 ? MediaQuery.sizeOf(context).height / 9 : MediaQuery.sizeOf(context).height / 12,
        rightCornerRadius: 20,
        elevation: 10,
        splashColor: CustomColors.foregroundColor,
        onTap: (int index) => setState(() => currentIndex = index),
        itemCount: AppUtils.iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 4,),
              Icon(
                AppUtils.iconList[index],
                size: 24,
                color: isActive ? CustomColors.foregroundColor : Colors.grey,
              ),
              const SizedBox(height: 4,),
              Text(AppUtils.navTitle[index], style: TextStyle(
                  fontSize: 10,
                  color: isActive ? CustomColors.foregroundColor : Colors.black
              ),)
            ],
          );
        },
      ),
      body: AppUtils.pages[currentIndex],
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
