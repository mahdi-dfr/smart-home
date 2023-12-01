import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/device_controller.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/room_controller.dart';
import 'package:turkeysh_smart_home/features/home/presentation/screen/spetial_device.dart';
import 'package:turkeysh_smart_home/features/home/presentation/screen/view_room.dart';
import 'package:turkeysh_smart_home/features/project/presentation/controller/project_controller.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/utils.dart';
import '../../../../core/resource/ask_dialog.dart';
import '../../../../core/resource/data_state.dart';
import '../widget/custom_app_bar_delegate.dart';
import '../widget/device_info_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _controller = Get.find<RoomController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        body: CustomScrollView(slivers: [
      const SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: SliverCustomAppBar(
            lottieAssetSrc: Images.lottieHome2,
            maxHeight: 250,
            minHeight: 150,
          )),
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
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              return _controller.isLoading.value
                  ? SizedBox(
                      width: width,
                      child: Center(
                        child: LoadingAnimationWidget.beat(
                            color: CustomColors.foregroundColor, size: 35),
                      ),
                    )
                  : Row(
                      children: List.generate(_controller.roomsList.length + 1,
                          (index) {
                        if (index == _controller.roomsList.length) {
                          return InkWell(
                            onTap: () {
                              _controller.isRoomUpdateMode = false;
                              Get.toNamed(PagesRoutes.createRoom);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              width: width * 0.8,
                              height: height * 0.4,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(Images.logo),
                                      fit: BoxFit.cover,
                                      opacity: 0.05),
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.borderRadius),
                                  border: Border.all(
                                      width: 2,
                                      color: CustomColors.foregroundColor)),
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
                              Get.find<DeviceController>().roomId =
                                  _controller.roomsList[index].id;
                              Get.find<DeviceController>().getAllDevises();
                              Get.to(() => ViewRoomScreen(
                                  room: _controller.roomsList[index]));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              width: width * 0.8,
                              height: height * 0.4,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 0),
                                        spreadRadius: 2,
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.borderRadius),
                                  color: CustomColors.foregroundColor),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    width: width * 0.7,
                                    height: height * 0.3,
                                    decoration: BoxDecoration(
                                        color: CustomColors.backgroundColor,
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(
                                                AppDimensions.borderRadius),
                                            bottomLeft: Radius.circular(
                                                AppDimensions.borderRadius))),
                                    child: Lottie.asset(
                                      Images.roomAnim,
                                    ),
                                  ),
                                  Text(
                                    _controller.roomsList[index].name ?? '',
                                    style: AppStyles.style3,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Get.defaultDialog(
                                            title: 'انتخاب کنید',
                                            content: Container(
                                              padding: const EdgeInsets.all(
                                                  AppDimensions.mediumPadding),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 3,
                                                      color: CustomColors
                                                          .foregroundColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppDimensions
                                                              .borderRadius)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            Get.back();
                                                            askDialog(() {
                                                              _controller
                                                                  .deleteRoom(
                                                                      _controller
                                                                          .roomsList[
                                                                              index]
                                                                          .id!,
                                                                      Get.find<ProjectController>()
                                                                              .projectId ??
                                                                          0)
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                    is DataSuccess) {
                                                                  showTopSnackBar(
                                                                    Overlay.of(
                                                                        context),
                                                                    CustomSnackBar
                                                                        .success(
                                                                      message: value
                                                                              .data ??
                                                                          'اطلاعات با موفقیت حذف شد',
                                                                    ),
                                                                  );
                                                                } else {
                                                                  showTopSnackBar(
                                                                    Overlay.of(
                                                                        context),
                                                                    CustomSnackBar
                                                                        .error(
                                                                      message: value
                                                                              .error ??
                                                                          'خطا در ارسال اطلاعات',
                                                                    ),
                                                                  );
                                                                }
                                                              });
                                                              Get.back();
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: CustomColors
                                                                .foregroundColor,
                                                          )),
                                                      const Text(
                                                        'حذف',
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            Get.back();
                                                            _controller.roomId =
                                                                _controller
                                                                    .roomsList[
                                                                        index]
                                                                    .id;
                                                            _controller
                                                                    .isRoomUpdateMode =
                                                                true;
                                                            Get.toNamed(
                                                                PagesRoutes
                                                                    .createRoom);
                                                          },
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: CustomColors
                                                                .foregroundColor,
                                                          )),
                                                      const Text(
                                                        'ویرایش',
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                    );
            })),
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
                  Get.to(SpecialDeviceScreen(
                      name: AppUtils.deviceInfo.keys.toList()[index]));
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
