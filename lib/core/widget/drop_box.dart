import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({required this.items, required this.title, this.height, this.width, this.color ,required this.onPressed, super.key});

  Function(String)? onPressed;
  String title;
  double? width = 200;
  double? height = 50;
  List<String> items;
  Color? color = const Color(0x8cababab);


  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment:Alignment.centerRight ,child: Text(widget.title, style: const TextStyle(fontSize: 14),)),
        const SizedBox(height: 8,),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Row(
              children: [
                const Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: widget.items
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
                if(selectedValue != null){
                  widget.onPressed!(selectedValue!);
                }
              });
            },
            buttonStyleData: ButtonStyleData(
              height: widget.height,
              width: widget.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: widget.color,
              ),
              elevation: 0,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.black,
            ),
            dropdownStyleData: DropdownStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              maxHeight: 400,
              width: widget.width! * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: widget.color,
              ),
              offset: const Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ],
    );

  }
}