import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/constants/dimens.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/features/settings/data/model/project_board.dart';
import 'package:turkeysh_smart_home/features/settings/presentation/controller/project_board_controller.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/question_dialog.dart';
import '../widget/project_board_widget.dart';

class BoardSettingScreen extends StatelessWidget {
  BoardSettingScreen({Key? key}) : super(key: key);

  final _controller = Get.find<ProjectBoardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.isInEditMode = false;
            _controller.getControlBoard(
                GetStorage().read(AppUtils.projectIdConst).toString());
            Get.toNamed(PagesRoutes.createBoard);
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
          titleWidget: const Text(
            'تنظیمات برد ها',
            style: AppStyles.appbarTitleStyle,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: PagedListView<int, ProjectBoardResults>(
                pagingController: _controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, item, index) {
                    return CustomListWidget(
                      title: item.name ?? '',
                      content: item.parentBoard.toString() ?? '',
                      onDeleteClicked: () {
                        questionDialog(
                            title: 'حذف برد',
                            question: 'آیا مطمئن هستید؟',
                            onYesClicked: () {
                              if (item.id != null) {
                                _controller
                                    .deleteProjectBoard(item.id!)
                                    .then((value) {
                                  if (value is DataSuccess) {
                                    Get.back();
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.success(
                                        message: value.data ??
                                            'اطلاعات با موفقیت حذف شد',
                                      ),
                                    );
                                  } else {
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                        message: value.error ??
                                            'خطا در ارسال اطلاعات',
                                      ),
                                    );
                                  }
                                });
                              }
                            });
                      },
                      onEditClicked: () {
                        _controller.isInEditMode = true;
                        _controller.getControlBoard(
                            GetStorage().read(AppUtils.projectIdConst).toString());
                        Get.toNamed(PagesRoutes.createBoard);
                      },
                      onNodeClicked: () {},
                    );
                  },
                  noItemsFoundIndicatorBuilder: (_) => Center(
                    child: Lottie.asset(Images.empty,
                        width: MediaQuery.sizeOf(context).width / 2),
                  ),
                )),
          ),
        ));
  }
}
