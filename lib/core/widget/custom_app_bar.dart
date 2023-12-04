import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/images.dart';
import 'custom_toolbar_shape.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool centerTitle;
  final Color backgroundColor;
  final Widget? titleWidget;

  CustomAppBar(
      {Key? key,
      required this.height,
      this.centerTitle = false,
      this.titleWidget,
      this.backgroundColor = Colors.transparent})
      : preferredSize = Size.fromHeight(height),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
        color: backgroundColor,
        child: Stack(fit: StackFit.loose, children: <Widget>[
          Container(
              color: Colors.transparent,
              width: Get.width,
              height: height,
              margin: EdgeInsets.only(bottom: Get.height / 35),
              child: CustomPaint(
                painter: CustomToolbarShape(lineColor: Get.theme.primaryColor),
              )),
          Align(
              alignment: const Alignment(0.0, 0.8),
              child: Container(
                  height: Get.height / 14,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2.0,
                            // shadow
                            spreadRadius: .5,
                            // set effect of extending the shadow
                            offset: Offset(
                              0.0,
                              5.0,
                            ),
                          )
                        ],
                      ),
                      child: Image.asset(Images.logoWide)))),
          Align(
            alignment: const Alignment(0, 0),
            child: AppBar(
              title: titleWidget,
              centerTitle: centerTitle,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                MediaQuery.sizeOf(context).width>600 ? Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 12),
                  child: IconButton(onPressed: (){
                    Get.back();
                  }, icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white,)),
                ) : const SizedBox()
              ],
            ),
          )
        ]));
  }

  @override
  final Size preferredSize;
}
