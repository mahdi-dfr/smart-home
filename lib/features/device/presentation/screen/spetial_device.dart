import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';

class SpecialDeviceScreen extends StatelessWidget {
  SpecialDeviceScreen({required this.name, Key? key}) : super(key: key);

  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: (){

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
        titleWidget: Text( name ?? '', style: AppStyles.appbarTitleStyle,),
      ),
      body: SafeArea(
        child: Center(
          child: Lottie.asset(Images.empty, width: MediaQuery.sizeOf(context).width / 2),

        ),
      ),
    );
  }
}
