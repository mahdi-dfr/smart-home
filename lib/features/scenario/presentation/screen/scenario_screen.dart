import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:turkeysh_smart_home/core/constants/dimens.dart';
import 'package:turkeysh_smart_home/core/widget/drop_box.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../widget/panel_item.dart';

class ScenarioScreen extends StatelessWidget {
  ScenarioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: CustomAppBar(
        height: 150,
        titleWidget: const Text(
          'سناریو ها',
          style: AppStyles.appbarTitleStyle,
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomDropDown(
                      items: const ['پنل دیواری', 'نرم افزار'],
                      title: 'نوع سناریو',
                      width: width,
                      height: height/12,
                      onPressed: (value) {}),

                  const SizedBox(height: 12,),

                  Column(
                    children: [
                      PanelItem(title: 'پنل یک', onItemPressed: (){
                        Get.toNamed(PagesRoutes.panelScreen);
                      },),
                      PanelItem(title: 'پنل دو', onItemPressed: (){},),
                      PanelItem(title: 'پنل سه', onItemPressed: (){},),
                      PanelItem(title: 'پنل چهار', onItemPressed: (){},),

                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
