import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/core/constants/styles.dart';


class CustomListWidget extends StatelessWidget {
  String title;
  String content;

  CustomListWidget(
      {this.title = 'عنوان',
        this.content = 'جزئیات',
        required this.onDeleteClicked,
        required this.onEditClicked,
        required this.onNodeClicked,
        Key? key})
      : super(key: key);

  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  Function() onDeleteClicked;
  Function() onEditClicked;
  Function() onNodeClicked;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTileCard(
        title: Text(
          title,
          style: AppStyles.style5
        ),
        subtitle: Text(
          content,
          style: AppStyles.style7,
        ),
        expandedTextColor: Colors.black,
        expandedColor: const Color(0xffffe6e6),
        leading: Icon(
          Icons.developer_board_outlined,
          color: CustomColors.foregroundColor,
          size: width > 600 ? width / 23 : width / 12,
        ),
        borderRadius: BorderRadius.circular(15),
        baseColor: Colors.white,
        children: [
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          SizedBox(
            width:  width > 600 ? width / 2 : width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(onPressed: onEditClicked, icon: Icon(Icons.edit, color: CustomColors.foregroundColor)),
                      const Text('ویرایش', style: AppStyles.style7,),
                      const SizedBox(width: 8,),
                    ],
                  ),

                  Column(
                    children: [
                      IconButton(onPressed: onDeleteClicked, icon: Icon(Icons.delete, color: CustomColors.foregroundColor,), ),
                      const Text('حذف', style: AppStyles.style7,),
                    ],
                  ),

                  Column(
                    children: [
                      IconButton(onPressed: onNodeClicked, icon: Icon(Icons.dashboard, color: CustomColors.foregroundColor,)),
                      const Text('مشاهده نود ها', style: AppStyles.style7,),
                    ],
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
