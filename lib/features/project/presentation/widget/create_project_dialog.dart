import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turkeysh_smart_home/features/project/presentation/controller/project_controller.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/text_field.dart';

class CreateProjectDialog extends StatelessWidget {
  CreateProjectDialog(
      {required this.onSaveClicked,
      this.loading = false,
      this.isEditMode = false,
      Key? key})
      : super(key: key);

  Function() onSaveClicked;
  bool loading;
  bool isEditMode;

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Container(
      padding: const EdgeInsets.all(AppDimensions.mediumPadding),
      height: height * 0.55,
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: CustomColors.foregroundColor),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFieldBox(
              title: 'نام پروژه',
              height: width > 600 ? height/6 : height / 12,
              controller: Get.find<ProjectController>().projectName,
            ),
            TextFieldBox(
              title: 'آدرس پروژه',
              height: width > 600 ? height/6 : height / 12,
              controller: Get.find<ProjectController>().projectAddress,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomButton(
              onClick: onSaveClicked,
              buttonTitle: isEditMode ? 'ویرایش' : 'ذخیره',
              loading: loading,
            )
          ],
        ),
      ),
    );
  }
}
