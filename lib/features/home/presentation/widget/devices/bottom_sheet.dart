import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/dimens.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/widget/custom_button.dart';

createBottomSheet(){
  return Get.bottomSheet(
    BottomSheet(
        onClosing: () {},
        enableDrag: false,
        showDragHandle: false,

        builder: (context) {
          return Container(
            width: MediaQuery.sizeOf(
                context)
                .width,
            height: MediaQuery.sizeOf(
                context)
                .height / 2,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        AppDimensions
                            .borderRadius),
                    topRight:
                    Radius.circular(
                        AppDimensions
                            .borderRadius))),
            child: Container(
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: CustomColors.backgroundColor,
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 1),
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 2)
                  ]
              ),
              child: Stack(
                  children: [Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('زمان روشن'),
                          ElevatedButton(onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.foregroundColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: const Text('انتخاب زمان', style: AppStyles.style10,),),

                        ],
                      ),
                      const SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('زمان خاموش'),
                          ElevatedButton(onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.foregroundColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: const Text('انتخاب زمان', style: AppStyles.style10,),),



                        ],
                      ),

                      const SizedBox(height: 24,),

                      SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('شنبه', style: AppStyles.style8,),
                                  RoundCheckBox(onTap: (value){}, size: 30,
                                    checkedColor: CustomColors.foregroundColor,)
                                ],
                              ),
                              const SizedBox(height: 12),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('یکشنبه', style: AppStyles.style8,),
                                  RoundCheckBox(onTap: (value){}, size: 30,
                                    checkedColor: CustomColors.foregroundColor,)
                                ],
                              ),
                              const SizedBox(height: 12,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('دوشنبه', style: AppStyles.style8,),
                                  RoundCheckBox(onTap: (value){}, size: 30,
                                    checkedColor: CustomColors.foregroundColor,)
                                ],
                              ),
                              const SizedBox(height: 12,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('سه شنبه', style: AppStyles.style8,),
                                  RoundCheckBox(onTap: (value){}, size: 30,
                                    checkedColor: CustomColors.foregroundColor,)
                                ],
                              ),
                              const SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('چهارشنبه', style: AppStyles.style8,),
                                  RoundCheckBox(onTap: (value){}, size: 30,
                                    checkedColor: CustomColors.foregroundColor,)
                                ],
                              ),
                              const SizedBox(height: 12,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('پنجشنبه', style: AppStyles.style8,),
                                  RoundCheckBox(onTap: (value){}, size: 30,
                                    checkedColor: CustomColors.foregroundColor,)
                                ],
                              ),
                              const SizedBox(height: 12,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('جمعه', style: AppStyles.style8,),
                                  RoundCheckBox(onTap: (value){}, size: 30,
                                    checkedColor: CustomColors.foregroundColor,)
                                ],
                              ),
                              const SizedBox(height: 72,),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                    Align(alignment: Alignment.bottomCenter,
                      child: CustomButton(onClick: (){}, buttonTitle: 'ثبت',),)
                  ]
              ),
            ),
          );
        }),
    enableDrag: false,
    backgroundColor: Colors.white,
    elevation: 2,

  );
}