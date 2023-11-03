import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';

import '../core/constants/utils.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: const Icon(Icons.monitor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        activeIndex: currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 20,
        blurEffect: true,
        height: MediaQuery.sizeOf(context).height / 12,
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
}
