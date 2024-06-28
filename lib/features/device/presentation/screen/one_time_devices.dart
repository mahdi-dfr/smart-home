import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:turkeysh_smart_home/features/device/presentation/widget/one_time_widget.dart';
import 'package:turkeysh_smart_home/features/device/presentation/controller/device_controller.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';

class OneTimeDeviceScreen extends StatelessWidget {
  OneTimeDeviceScreen({Key? key}) : super(key: key);

  final _controller = Get.find<DeviceController>();
  late String projectName;
  late String username;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .sizeOf(context)
        .width;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: CustomAppBar(
        height: width > 600 ? 150 : 150,
        titleWidget: const Text(
          'کلید ها',
          style: AppStyles.appbarTitleStyle,
        ),
      ),
      body: SafeArea(child: Obx(() {
        return _controller.isDeviceLoading.value
            ? Center(
          child: LoadingAnimationWidget.beat(
              color: CustomColors.foregroundColor, size: 35),
        )
            : Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Center(
            child: _controller.deviceList.isEmpty
                ? Lottie.asset(Images.empty, width: width / 2)
                : CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        Images.right,
                        width: width > 600 ? width / 7 : width / 3,
                        color: CustomColors.foregroundColor,
                      ),
                      const Text(
                        'کلیدهای تک تایمر',
                        style: AppStyles.style1,
                      ),
                      SvgPicture.asset(
                        Images.left,
                        width: width > 600 ? width / 7 : width / 3,
                        color: CustomColors.foregroundColor,
                      ),
                    ],
                  ),
                ),
              ),
              SliverGrid.builder(
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width > 600 ? 5 : 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return OneTimeWidget(title: _controller.oneTimeDeviceList[index]
                        .name, boardId: _controller.deviceList[index].projectBoard?.uniqueId,
                        nodeId: _controller.deviceList[index].nodeProject?.uniqueId,
                        onPressed: (){});
                  },
                  itemCount: _controller.oneTimeDeviceList.length),
            ]),
          ),
        );
      })),
    );
  }
}
