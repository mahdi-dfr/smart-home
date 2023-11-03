
import 'package:flutter/material.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';


class DropBox extends StatefulWidget {
  List<String> dropList;
  String title;
  bool star;
  String hint;
  double? fontSize;
  bool disable;
  double? width;
  Function(Object) onPressed;
  bool loading;

  DropBox({
    Key? key,
    this.fontSize = 12,
    required this.dropList,
    required this.title,
    this.loading = false,
    this.width,
    this.hint = 'انتخاب کنید ...',
    this.star = false,
    this.disable = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<DropBox> createState() => _DropBoxState();
}

class _DropBoxState extends State<DropBox> {
  var dropValue;

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [

        Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: widget.fontSize, color: widget.disable ? Colors.white : Colors.black),
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

        const SizedBox(height: 12,),

        Container(
          width: widget.width ?? MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height / 14,
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          //margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.foregroundColor, width: 1),
            borderRadius: BorderRadius.circular(13),
            color: CustomColors.backgroundColor,
          ),
          child: CustomDropDoawn(
            onTap: () {},
            loading: widget.loading,
            hint: widget.hint,
            dropList: widget.dropList,
            title: widget.title,
            onPressed: (String value) {
              widget.onPressed(value);
            },
            disable: widget.disable,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}



class CustomDropDoawn extends StatefulWidget {
  CustomDropDoawn(
      {Key? key,
        required this.dropList,
        required this.title,
        this.hint = ' انتخاب کنید ...',
        this.star = true,
        required this.onTap,
        this.loading = false,
        required this.disable,
        this.onPressed})
      : super(key: key);

  Function() onTap;
  List<String> dropList;
  String title;
  bool star;
  bool loading;
  String hint;
  bool disable;
  Function(String)? onPressed;

  @override
  State<CustomDropDoawn> createState() => _CustomDropDoawnState();
}

class _CustomDropDoawnState extends State<CustomDropDoawn> {
  var dropValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child:
      // widget.loading
      //     ? Center(child: LoadingAnimationWidget.discreteCircle(color: Colors.green, size: 30))
      //     :
      DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.dropList.contains(dropValue) ? dropValue : null,
          isExpanded: true,
          onTap: () {
            widget.onTap();
          },
          hint: Text(
            widget.hint,
            style: const TextStyle(fontSize: 14),
          ),
          items: widget.disable
              ? null
              : widget.dropList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            widget.disable
                ? null
                : setState(() {
              dropValue = value!;
              widget.onPressed!(dropValue!);
            });
          },
        ),
      ),
    );
  }
}