import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/core/widget/question_dialog.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/device_controller.dart';
import 'package:turkeysh_smart_home/features/home/presentation/widget/devices/relay_one_time.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../device/presentation/screen/one_time_devices.dart';
import '../../data/model/room_response.dart';
import '../widget/devices/sensors_widget.dart';

class DeviceListScreen extends StatelessWidget {
  DeviceListScreen({required this.room, Key? key}) : super(key: key);

  RoomResults room;
  final _controller = Get.find<DeviceController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(PagesRoutes.createDevice);
        },
        backgroundColor: CustomColors.foregroundColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: CustomAppBar(
        height: width > 600 ? 100 : 150,
        titleWidget: Text(
          room.name ?? '',
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
                      ? Lottie.asset(Images.empty,
                          width: MediaQuery.sizeOf(context).width / 2)
                      : CustomScrollView(slivers: [
                          SliverToBoxAdapter(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: TextButton(
                                onPressed: () {
                                  _controller.filterDevicesBasedOnOneTime();
                                  Get.to(OneTimeDeviceScreen());
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.grid_view_outlined,
                                      color: CustomColors.foregroundColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      'مشاهده کلید ها',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                )),
                          )),
                          SliverList.builder(
                              itemBuilder: (BuildContext context, int index) {
                                if (_controller.deviceList[index].deviceType ==
                                    '0') {
                                  return RelayOneTimeWidget(
                                    boardId: _controller.deviceList[index]
                                        .nodeProject?.boardProject,
                                    nodeId: _controller.deviceList[index]
                                        .nodeProject?.uniqueId,
                                    title: _controller
                                        .deviceList.value[index].name,
                                    onLongPress: () {
                                      questionDialog(
                                          title: 'حذف تجهیز',
                                          question:
                                              'آیا میخواهید این تجهز را حذف کنید؟',
                                          onYesClicked: () {
                                            _controller
                                                .deleteDevice(_controller
                                                    .deviceList[index].id!)
                                                .then((value) {
                                              if (value is DataSuccess) {
                                                Get.back();
                                                const CustomSnackBar.success(
                                                    message:
                                                        'تجهیز با موفقیت حذف شد!');
                                              } else {
                                                const CustomSnackBar.error(
                                                    message:
                                                        'خطا در ارسال اطلاعات');
                                              }
                                            });
                                          });
                                    },
                                  );
                                } else {
                                  return SensorWidget(
                                    title: _controller.deviceList[index].name,
                                    type: _controller
                                        .deviceList[index].deviceType
                                        .toString(),
                                    onLongPress: () {
                                      questionDialog(
                                          title: 'حذف تجهیز',
                                          question:
                                              'آیا میخواهید این تجهز را حذف کنید؟',
                                          onYesClicked: () {
                                            _controller
                                                .deleteDevice(_controller
                                                    .deviceList[index].id!)
                                                .then((value) {
                                              if (value is DataSuccess) {
                                                Get.back();
                                                const CustomSnackBar.success(
                                                    message:
                                                        'تجهیز با موفقیت حذف شد!');
                                              } else {
                                                const CustomSnackBar.error(
                                                    message:
                                                        'خطا در ارسال اطلاعات');
                                              }
                                            });
                                          });
                                    },
                                  );
                                }
                              },
                              itemCount: _controller.deviceList.length),
                        ]),
                ),
              );
      })),
    );
  }
}
