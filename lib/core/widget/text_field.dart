import 'package:flutter/material.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';

class TextFieldBox extends StatefulWidget {
  String title;
  bool star;
  TextInputType type;
  double? fontSize;
  bool disable;
  TextEditingController? controller;
  String value;
  int maxLine;
  double height;

  TextFieldBox({
    Key? key,
    required this.title,
    this.star = false,
    this.maxLine = 1,
    required this.height,
    this.disable = false,
    this.type = TextInputType.text,
    this.fontSize = 14,
    this.controller,
    this.value = '',
  }) : super(key: key);

  @override
  State<TextFieldBox> createState() => _TextFieldBoxState();
}

class _TextFieldBoxState extends State<TextFieldBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.disable ? Colors.white : Colors.black),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.star ? '*' : '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: widget.height,
          child: TextField(
            readOnly: widget.disable,
            keyboardType: widget.type,
            controller: widget.controller,
            maxLines: widget.maxLine,
            // initialValue: value,
            decoration: InputDecoration(
              hintText: widget.value.isEmpty ? 'اینجا بنویسید' : widget.value,
              hintStyle: TextStyle(
                color: widget.disable ? Colors.white : Colors.grey,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: widget.disable
                        ? Colors.white
                        : CustomColors.foregroundColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
