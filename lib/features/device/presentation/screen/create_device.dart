import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/core/widget/custom_button.dart';
import 'package:turkeysh_smart_home/core/widget/drop_box.dart';
import 'package:turkeysh_smart_home/core/widget/text_field.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../controller/device_controller.dart';

class CreateDeviceScreen extends StatelessWidget {
  CreateDeviceScreen({Key? key}) : super(key: key);
  final _controller = Get.find<DeviceController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: CustomAppBar(
          height: width > 600 ? 150 : 150,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Stack(children: [
            SingleChildScrollView(
              child: Column(children: [
                TextFieldBox(
                  title: 'نام تجهیز',
                  height: width > 600 ? height/6 : height / 12,
                  controller: _controller.deviceName,
                ),
                CustomDropDown(
                    items: AppUtils.deviceTypeList,
                    title: 'نوع تجهیز',
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height / 12,
                    onPressed: (value) {
                      if (value.toString() == 'کلید سه تایمر') {
                        _controller.deviceType = '6';
                      } else if (value.toString() == 'کلید تک تایمر') {
                        _controller.deviceType = '0';
                      } else if (value.toString() == 'سنسور دما') {
                        _controller.deviceType = '1';
                      } else if (value.toString() == 'سنسور PH') {
                        _controller.deviceType = '2';
                      } else if (value.toString() == 'سنسور سختی آب') {
                        _controller.deviceType = '3';
                      } else if (value.toString() == 'سنسور خاک') {
                        _controller.deviceType = '4';
                      }
                      // else if (value.toString() ==
                      //     'چشمی ها و سنسور های تشخیص حرکت') {
                      //   _controller.deviceType = '7';
                      // } else if (value.toString() == 'دیمر') {
                      //   _controller.deviceType = '5';
                      // }

                      _controller.getDeviceNodes();
                    }),
                const SizedBox(
                  height: 24,
                ),
                Obx(() {
                  return CustomDropDown(
                      items: _controller.deviceNodeNames.value.keys.toList(),
                      isLoading: _controller.isGetNodesLoading.value,
                      title: 'نود انتخابی در تابلو',
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height / 12,
                      onPressed: (value) {
                        _controller.nodeProject = _controller
                            .deviceNodeNames.value[value.toString()]['id']
                            .toString();
                        _controller.boardId = _controller
                            .deviceNodeNames.value[value.toString()]['boardId'];
                      });
                }),
                SizedBox(
                  height: width > 600 ? height/5 : 24,
                ),
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() {
                return CustomButton(
                  loading: _controller.isLoading.value,
                  onClick: () {
                    _controller.createNewDevice()
                        .then((value) {
                      if (value is DataSuccess) {
                        Get.back();
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: value.data ?? 'اطلاعات با موفقیت ذخیره شد',
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
                  },
                );
              }),
            ),
          ]),
        )));
  }
}
