import 'package:flutter/material.dart';
import 'package:turkeysh_smart_home/core/constants/constant.dart';

class LoginEditText extends StatefulWidget {
  LoginEditText({
    required this.hint,
    required this.icon,
    required this.type,
    required this.isPass,
    required this.showPass,
    this.fieldController,
    Key? key,
  }) : super(key: key);

  String hint;
  Icon icon;
  TextInputType type;
  bool isPass;
  bool showPass;
  TextEditingController? fieldController;

  @override
  State<LoginEditText> createState() => _LoginEditTextState();
}

class _LoginEditTextState extends State<LoginEditText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border:
          Border.all(width: 0.5, color: ConstantsData().foregroundColor)),
      child: TextField(
        controller: widget.fieldController,
        keyboardType: widget.type,
        obscureText: widget.showPass,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          suffixIcon: widget.isPass
              ? IconButton(
              onPressed: () {
                setState(() {
                  widget.showPass = !widget.showPass;
                });
              },
              icon: Icon(widget.showPass
                  ? Icons.visibility_off
                  : Icons.visibility))
              : null,
          border: InputBorder.none,
          hintText: widget.hint,
        ),
      ),
    );
  }
}
