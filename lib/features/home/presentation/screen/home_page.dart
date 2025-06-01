import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/features/device/presentation/controller/device_controller.dart';
import 'package:turkeysh_smart_home/features/device/presentation/screen/spetial_device.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/room_controller.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/utils.dart';
import '../../../device/presentation/screen/device_list.dart';
import '../../../settings/presentation/controller/project_board_controller.dart';
import '../widget/custom_app_bar_delegate.dart';
import '../widget/device_info_widget.dart';
import '../widget/modification_dialog_content.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _controller = Get.find<RoomController>();
  final offlineMode = GetStorage().read(AppUtils.offlineMode) ?? false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: SliverCustomAppBar(
              lottieAssetSrc: Images.lottieHome2,
              maxHeight: width > 600 ? 220 : 250,
              minHeight: width > 600 ? 0 : 150,
              onOpenDrawer: () {
                Scaffold.of(context).openDrawer();
              })),
      SliverList(
          delegate: SliverChildListDelegate([
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
              alignment: Alignment.topRight,
              child: Text(
                'اتاق ها',
                style: AppStyles.style2,
              )),
        ),
        GetBuilder<RoomController>(builder: (logic) {
          if (!logic.isLoading.value) {
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(logic.roomsList.length + 1, (index) {
                    if (index == logic.roomsList.length) {
                      return InkWell(
                        onTap: () {
                          final offlineMode = GetStorage().read(AppUtils.offlineMode) ?? false;
                          if (!offlineMode) {
                            _controller.isRoomUpdateMode = false;
                            Get.toNamed(PagesRoutes.createRoom);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          width: width > 600 ? width * 0.3 : width * 0.8,
                          height: width > 600 ? height * 0.45 : height * 0.4,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(Images.logo), fit: BoxFit.cover, opacity: 0.05),
                              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                              border: Border.all(width: 2, color: CustomColors.foregroundColor)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 55,
                                  color: CustomColors.foregroundColor,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  'افزودن اتاق جدید',
                                  style: AppStyles.style1,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          if (logic.roomsList[index].id != null) {
                            Get.find<DeviceController>().roomId = logic.roomsList[index].id;
                            Get.find<DeviceController>().getAllDevises();
                            Get.to(() => DeviceListScreen(room: logic.roomsList[index]));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          width: width > 600 ? width * 0.3 : width * 0.8,
                          height: width > 600 ? height * 0.45 : height * 0.4,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(color: Colors.grey, offset: Offset(0, 0), spreadRadius: 2, blurRadius: 5)
                              ],
                              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                              color: CustomColors.foregroundColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(12),
                                  width: width > 600 ? width * 0.2 : width * 0.7,
                                  height: width > 600 ? height * 0.3 : height * 0.3,
                                  decoration: BoxDecoration(
                                      color: CustomColors.backgroundColor,
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(AppDimensions.borderRadius),
                                          bottomLeft: Radius.circular(AppDimensions.borderRadius))),
                                  child: SvgPicture.asset(Images.room)),
                              Text(
                                logic.roomsList[index].name ?? '',
                                style: AppStyles.style3,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: 'انتخاب کنید',
                                        content: ModificationDialogContent(
                                          index: index,
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                ));
          } else {
            return SizedBox(
              width: width,
              child: Center(
                child: LoadingAnimationWidget.beat(color: CustomColors.foregroundColor, size: 35),
              ),
            );
          }
        }),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'وسیله ها',
                style: AppStyles.style2,
              )),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Get.to(SpecialDeviceScreen(name: AppUtils.deviceInfo.keys.toList()[index]));
                },
                child: DeviceInfo(
                  index: index,
                  width: width,
                ));
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 2,
            );
          },
          itemCount: AppUtils.deviceInfo.length,
        )
      ]))
    ]));
  }
}
