import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/resource/ask_dialog.dart';
import '../../../../core/resource/data_state.dart';
import '../../../project/presentation/controller/project_controller.dart';
import '../controller/room_controller.dart';

class ModificationDialogContent extends StatelessWidget {
  ModificationDialogContent({super.key, required this.index});

  final _controller = Get.find<RoomController>();
  final int index;


  @override
  Widget build(BuildContext context) {
    final overlay = Overlay.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimensions.mediumPadding),
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: CustomColors.foregroundColor),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                    askDialog('حذف اتاق', 'آیا مطمئن هستید؟', () {
                      if (_controller.roomsList[index].id != null) {
                        _controller
                            .deleteRoom(_controller.roomsList[index].id!,
                            Get.find<ProjectController>().projectId!)
                            .then((value) {
                          if (value is DataSuccess) {
                            showTopSnackBar(
                              overlay,
                              CustomSnackBar.success(
                                message: value.data ?? 'اطلاعات با موفقیت حذف شد',
                              ),
                            );
                          } else {
                            showTopSnackBar(
                              overlay,
                              CustomSnackBar.error(
                                message: value.error ?? 'خطا در ارسال اطلاعات',
                              ),
                            );
                          }
                        });
                      }
                      Get.back();
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: CustomColors.foregroundColor,
                  )),
              const Text(
                'حذف',
              )
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                    _controller.roomId = _controller.roomsList[index].id;
                    _controller.isRoomUpdateMode = true;
                    Get.toNamed(PagesRoutes.createRoom);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: CustomColors.foregroundColor,
                  )),
              const Text(
                'ویرایش',
              )
            ],
          ),
        ],
      ),
    );
  }
}
