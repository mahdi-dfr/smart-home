import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:turkeysh_smart_home/core/widget/custom_button.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/drop_box.dart';

class ChooseScenarioScreen extends StatelessWidget {
  const ChooseScenarioScreen({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: CustomDropDown(
                            items: const ['روشن', 'خاموش'],
                            title: 'نوع سناریو',
                            width: width,
                            height: height/12,
                            onPressed: (value) {}),
                      )
                  ),
                  SliverList.builder(itemBuilder: (context, index){
                    return Container(
                        width: width,
                        height: height / 12,
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.5),
                          borderRadius:
                          BorderRadius.circular(AppDimensions.borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RoundCheckBox(
                                size: 30,
                                checkedColor: CustomColors.foregroundColor,
                                onTap: (value) {},
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              const Text('کلید یک')
                            ],
                          ),
                        ));
                  }, itemCount: 10,),
                  SliverToBoxAdapter(child: SizedBox(height: height/11,),)
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(onClick: (){},),
              )
            ],
          ),
        ),
      ),
    );
  }
}
