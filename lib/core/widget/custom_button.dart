import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  Function onClick;
  String buttonTitle;
  bool loading;

  CustomButton({
    this.buttonTitle = 'ذخیره',
    required this.onClick,
    this.loading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Container(
        width: width > 600 ? width/2 : width,
        height: width > 600 ? height / 15 : height / 20,
        margin: const EdgeInsets.fromLTRB(10, 16, 10, 10),
        child: ElevatedButton(
          onPressed: () {
            onClick();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.foregroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100))),
          child: loading
              ? LoadingAnimationWidget.beat(
                  color: CustomColors.foregroundColor, size: 20)
              : Text(
                  buttonTitle,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
        ));
  }
}
