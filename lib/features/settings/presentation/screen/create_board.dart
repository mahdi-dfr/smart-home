import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/core/constants/dimens.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/core/widget/custom_button.dart';
import 'package:turkeysh_smart_home/core/widget/text_field.dart';
import 'package:turkeysh_smart_home/features/settings/data/model/project_board.dart';
import 'package:turkeysh_smart_home/features/settings/presentation/controller/project_board_controller.dart';

import '../../../../core/constants/images.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/drop_box.dart';
import '../widget/board_item.dart';

class CreateBoardScreen extends StatelessWidget {
  CreateBoardScreen({Key? key}) : super(key: key);

  final _controller = Get.find<ProjectBoardController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .sizeOf(context)
        .width;
    var height = MediaQuery
        .sizeOf(context)
        .height;

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: CustomAppBar(
        height: 150,
        titleWidget: const Text(
          'ثبت برد جدید',
          style: AppStyles.appbarTitleStyle,
        ),
      ),
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFieldBox(
                    title: 'نام برد',
                    height: height / 12,
                    fontSize: 14,
                    controller: _controller.boardName,),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return BoardItem(
                      title: 'sms',
                      isBaseBoard: true,
                      isChecked: _controller.isSMSChecked.value,
                      onCheckTap: (bool? value) {
                        _controller.changeBoardCheckValue('0', value!);
                        _controller.isSMSChecked.value = value;
                        _controller.isSensorChecked.value = false;
                        _controller.isDimmerChecked.value = false;
                        _controller.isWifiChecked.value = false;
                        _controller.isRelayChecked.value = false;
                      },
                    );
                  }),
                  Obx(() {
                    return BoardItem(
                      title: 'wifi',
                      isBaseBoard: true,
                      isChecked: _controller.isWifiChecked.value,
                      onCheckTap: (bool? value) {
                        _controller.changeBoardCheckValue('1', value!);
                        _controller.isWifiChecked.value = value;
                        _controller.isSensorChecked.value = false;
                        _controller.isDimmerChecked.value = false;
                        _controller.isSMSChecked.value = false;
                        _controller.isRelayChecked.value = false;
                      },
                    );
                  }),
                  Obx(() {
                    return BoardItem(
                      title: 'sensor',
                      isBaseBoard: false,
                      isChecked: _controller.isSensorChecked.value,
                      onCheckTap: (bool? value) {
                        _controller.changeBoardCheckValue('2', value!);
                        _controller.isSensorChecked.value = value;
                        _controller.isSMSChecked.value = false;
                        _controller.isDimmerChecked.value = false;
                        _controller.isWifiChecked.value = false;
                        _controller.isRelayChecked.value = false;
                      },
                    );
                  }),
                  Obx(() {
                    return BoardItem(
                      title: 'dimmer',
                      isBaseBoard: false,
                      isChecked: _controller.isDimmerChecked.value,
                      onCheckTap: (bool? value) {
                        _controller.changeBoardCheckValue('4', value!);
                        _controller.isDimmerChecked.value = value;
                        _controller.isSensorChecked.value = false;
                        _controller.isSMSChecked.value = false;
                        _controller.isWifiChecked.value = false;
                        _controller.isRelayChecked.value = false;
                      },
                    );
                  }),
                  Obx(() {
                    return BoardItem(
                      title: 'relay',
                      isBaseBoard: false,
                      isChecked: _controller.isRelayChecked.value,
                      onCheckTap: (bool? value) {
                        _controller.changeBoardCheckValue('3', value!);
                        _controller.isRelayChecked.value = value;
                        _controller.isSensorChecked.value = false;
                        _controller.isDimmerChecked.value = false;
                        _controller.isWifiChecked.value = false;
                        _controller.isSMSChecked.value = false;
                      },
                    );
                  }),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() {
                return CustomButton(
                  onClick: () {
                   if(!_controller.isInEditMode){
                     if (_controller.selectedBoardType != '0' &&
                         _controller.selectedBoardType != '1') {
                       if (_controller.selectedWifiControlBoard != null ||
                           _controller.selectedSmsControlBoard != null) {
                         _controller.createNewProject().then((value) {
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
                       } else {
                         showTopSnackBar(
                           Overlay.of(context),
                           const CustomSnackBar.error(
                             message: 'لطفا ابتدا برد کنترل کننده را انتخاب نمایید',
                           ),
                         );
                       }
                     } else {
                       _controller.createNewProject().then((value) {
                         if (value is DataSuccess) {
                           Get.back();
                           showTopSnackBar(
                             Overlay.of(context),
                             CustomSnackBar.success(
                               message: value.data ??
                                   'اطلاعات با موفقیت ذخیره شد',
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
                   }else{
                     _controller.updateProject().then((value) {
                       if (value is DataSuccess) {
                         Get.back();
                         showTopSnackBar(
                           Overlay.of(context),
                           CustomSnackBar.success(
                             message: value.data ??
                                 'اطلاعات با موفقیت ویرایش شد',
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
                  buttonTitle: _controller.isInEditMode ? 'ویرایش' : 'ذخیره',
                  loading: _controller.isLoading.value,
                );
              }))
        ]),
      ),
    );
  }
}
