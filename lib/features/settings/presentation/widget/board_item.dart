import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/core/constants/styles.dart';
import 'package:turkeysh_smart_home/features/settings/presentation/controller/project_board_controller.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/widget/drop_box.dart';

class BoardItem extends StatelessWidget {
  BoardItem({required this.title,
    required this.isBaseBoard,
    required this.isChecked,
    required this.onCheckTap,
    Key? key})
      : super(key: key);

  bool isBaseBoard;
  String title;
  Function(bool? value) onCheckTap;
  bool? isChecked;

  final _controller = Get.find<ProjectBoardController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .sizeOf(context)
        .width;
    var height = MediaQuery
        .sizeOf(context)
        .height;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 1),
              blurRadius: 5,
              spreadRadius: 1)
        ],
        color: Colors.white,
        image: const DecorationImage(
            image: AssetImage(Images.logo), fit: BoxFit.cover, opacity: 0.05),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          children: [
            Row(
              children: [
                RoundCheckBox(
                  isChecked: isChecked,
                  size: 30,
                  checkedColor: CustomColors.foregroundColor,
                  onTap: (value) {
                    onCheckTap(value);
                  },
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  title,
                  style: AppStyles.style5,
                )
              ],
            ),
            isBaseBoard
                ? const SizedBox()
                : Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Obx(() {
                  return CustomDropDown(
                    items: _controller.smsBoardList.value.keys.toList(),
                    title: 'برد پیامکی کنترل کننده',
                    onPressed: (value) {
                      _controller.selectedSmsControlBoard = _controller
                          .smsBoardList.value[value.toString()]
                          .toString();
                    },
                    width: width,
                    height: height / 12,
                  );
                }),
                const SizedBox(
                  height: 12,
                ),
                Obx(() {
                  return CustomDropDown(
                    items: _controller.wifiBoardList.value.keys.toList(),
                    title: 'برد وای فای کنترل کننده',
                    width: width,
                    height: height / 12,
                    onPressed: (value) {
                      _controller.selectedWifiControlBoard = _controller
                          .wifiBoardList.value[value.toString()]
                          .toString();
                    },
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
