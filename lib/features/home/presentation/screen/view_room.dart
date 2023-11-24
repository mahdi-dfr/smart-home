import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/device_controller.dart';
import 'package:turkeysh_smart_home/features/home/presentation/widget/devices/relay_one_time.dart';
import 'package:turkeysh_smart_home/features/home/presentation/widget/devices/relay_three_time.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../data/model/room_response.dart';
import '../widget/devices/sensors_widget.dart';

class ViewRoomScreen extends StatelessWidget {
  ViewRoomScreen({required this.room, Key? key}) : super(key: key);

  RoomResults room;
  final _controller = Get.find<DeviceController>();

  @override
  Widget build(BuildContext context) {
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
        height: 150,
        titleWidget: Text(room.name ?? '', style: AppStyles.appbarTitleStyle,),
      ),
      body: SafeArea(
        child: Obx(() {
          return _controller.isDeviceLoading.value ? Center(
            child: LoadingAnimationWidget.beat(color: CustomColors.foregroundColor, size: 35
            ),
          ):  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Center(
              child: _controller.deviceList.isEmpty ? Lottie.asset(
                  Images.empty, width: MediaQuery
                  .sizeOf(context)
                  .width / 2) : ListView.separated(itemBuilder: (context, index){
                    if(_controller.deviceList[index].deviceType == '0') {
                      return RelayOneTimeWidget(title: _controller.deviceList.value[index].name,);
                    }else{
                      return RelayThreeTimeWidget(title: _controller.deviceList.value[index].name);
                    }
              }
                  , separatorBuilder: (context, index){
                    return const SizedBox(height: 24,);
                  }
                  , itemCount: _controller.deviceList.length)

            ),
          );
        }),
      ),
    );
  }
}
