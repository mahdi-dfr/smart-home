import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/core/widget/custom_button.dart';
import 'package:turkeysh_smart_home/core/widget/text_field.dart';
import 'package:turkeysh_smart_home/features/home/presentation/controller/room_controller.dart';
import 'package:turkeysh_smart_home/features/project/presentation/controller/project_controller.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widget/custom_app_bar.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: CustomAppBar(
        height: 150,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFieldBox(
                title: 'نام اتاق',
                height: width > 600 ? height/6 : height / 12,
                controller: Get.find<RoomController>().roomName,
              ),
              Obx(() {
                return CustomButton(
                  loading: Get.find<RoomController>().isLoading.value,
                  onClick: () {
                    if (Get.find<RoomController>().isRoomUpdateMode) {
                      Get.find<RoomController>()
                          .updateRoom(Get.find<RoomController>().roomId!,
                              GetStorage().read(AppUtils.projectIdConst))
                          .then((value) {
                        if (value is DataSuccess) {
                          Get.back();
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message:
                                  value.data ?? 'اطلاعات با موفقیت ویرایش شد',
                            ),
                          );
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: value.error ?? 'خطا در ارسال اطلاعات',
                            ),
                          );
                        }
                      });
                    } else {
                      Get.find<RoomController>()
                          .createNewRoom(
                              Get.find<ProjectController>().projectId ?? 0)
                          .then((value) {
                        if (value is DataSuccess) {
                          Get.back();
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message:
                                  value.data ?? 'اطلاعات با موفقیت ذخیره شد',
                            ),
                          );
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: value.error ?? 'خطا در ارسال اطلاعات',
                            ),
                          );
                        }
                      });
                    }
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
