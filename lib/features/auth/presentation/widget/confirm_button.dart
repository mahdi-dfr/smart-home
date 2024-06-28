import 'package:flutter/material.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';

class LoginButton extends StatelessWidget {

  Function onClick;
  String buttonTitle;

  LoginButton({
    this.buttonTitle = 'ورود',
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Container(
        width: width > 600 ? width/2 : MediaQuery.of(context).size.width,
        height: height / 17,
        margin: const EdgeInsets.fromLTRB(50, 16, 50, 0),
        child: ElevatedButton(
          onPressed: () {
            onClick();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.foregroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100))),
          child: Text(
            buttonTitle,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ));
  }
}
