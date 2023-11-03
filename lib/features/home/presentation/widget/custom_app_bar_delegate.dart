import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/images.dart';
import '../../../../core/widget/custom_toolbar_shape.dart';
import '../../../../core/widget/image_rect_clipper.dart';

class SliverCustomAppBar extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final String? imageAssetSrc;
  final String? lottieAssetSrc;
  final bool centerTitle;
  final Color backgroundColor;
  final Widget? titleWidget;

  const SliverCustomAppBar(
      {required this.maxHeight,
      this.imageAssetSrc,
      this.lottieAssetSrc,
      required this.minHeight,
      this.centerTitle = false,
      this.titleWidget,
      this.backgroundColor = Colors.transparent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: backgroundColor,
        child: Stack(fit: StackFit.loose, children: <Widget>[
          Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: math.max(maxHeight - shrinkOffset, minHeight),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 30),
              child: CustomPaint(
                painter: CustomToolbarShape(lineColor: Get.theme.primaryColor),
              )),
          Visibility(
            visible: imageAssetSrc != null,
            child: Opacity(
              opacity: getOpacity(
                  defaultOpacity: 0,
                  maxHeight: maxHeight,
                  minHeight: minHeight,
                  shrinkOffset: shrinkOffset),
              child: Align(
                alignment: const Alignment(0, 0),
                child: ClipOval(
                  clipper: ImageRectClipper(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      Image.file(
                        File(imageAssetSrc ?? ''),
                        width: Get.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        height: maxHeight,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.grey.withOpacity(0.0),
                                  Colors.black,
                                ],
                                stops: const [
                                  0.0,
                                  1.0
                                ])),
                      )
                    ],
                  ),
                ),
              ),
            ).marginOnly(bottom: 27),
          ),
          Visibility(
            visible: lottieAssetSrc != null,
            child: Opacity(
              opacity: getOpacity(
                  defaultOpacity: 0,
                  maxHeight: maxHeight,
                  minHeight: minHeight,
                  shrinkOffset: shrinkOffset,
                  minOpacity: 0.4),
              child: Align(
                alignment: const Alignment(0, 0),
                child: Lottie.asset(
                  lottieAssetSrc ?? '',
                  fit: BoxFit.fitHeight,
                  height: maxHeight,
                ),
              ),
            ).marginOnly(bottom: 60),
          ),
          Align(
              alignment: const Alignment(0.0, 0.8),
              child: Container(
                  height: MediaQuery.of(context).size.height / 14,
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
            ),
          ),
        ]));
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  double getOpacity(
      {required double shrinkOffset,
      required double maxHeight,
      required double minHeight,
      required double defaultOpacity,
      double minOpacity = 0.1}) {
    if (minHeight == maxHeight) {
      return defaultOpacity;
    }
    double temp = 1 - (shrinkOffset / (maxHeight - minHeight));
    if (temp > 1) {
      return 1;
    } else if (temp < minOpacity) {
      return 0;
    }
    return temp;
  }
}
