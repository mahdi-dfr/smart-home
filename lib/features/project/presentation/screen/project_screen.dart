import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:turkeysh_smart_home/core/constants/colors.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/core/widget/custom_app_bar.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/resource/ask_dialog.dart';
import '../../../../core/resource/data_state.dart';
import '../controller/project_controller.dart';
import '../widget/create_project_dialog.dart';
import '../widget/project_item.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen({Key? key}) : super(key: key);

  final _controller = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: CustomAppBar(
        height: width > 600 ? 100 : 150,
      ),
      backgroundColor: CustomColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.projectEditMode = false;
          Get.defaultDialog(
              title: 'ایجاد پروژه',
              content: Obx(() {
                return CreateProjectDialog(
                  onSaveClicked: () {
                    Get.find<ProjectController>()
                        .createNewProject()
                        .then((value) {
                      if (value is DataSuccess) {
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(
                            message: "اطلاعات ذخیره شد",
                          ),
                        );
                        Get.back();
                      } else {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: value.error.toString(),
                          ),
                        );
                      }
                    });
                  },
                  loading: _controller.isLoading.value,
                );
              }));
        },
        backgroundColor: CustomColors.foregroundColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Obx(() {
              return _controller.isGetProjectsLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.beat(
                          color: CustomColors.foregroundColor, size: 35))
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: width > 600 ? 3 : 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemBuilder: (context, index) {
                        return ProjectItemWidget(
                          title:
                              _controller.projectList.value[index].name ?? '',
                          onClick: () async {
                            _controller.projectId =
                                _controller.projectList.value[index].id ?? 0;
                            GetStorage().write(
                                AppUtils.projectIdConst, _controller.projectId);

                            GetStorage().write(AppUtils.projectNameConst,
                                _controller.projectList.value[index].name);
                            Get.toNamed(PagesRoutes.home);
                          },
                          onLongClick: () {
                            Get.defaultDialog(
                                title: 'انتخاب کنید',
                                content: Container(
                                  padding: const EdgeInsets.all(
                                      AppDimensions.mediumPadding),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3,
                                          color: CustomColors.foregroundColor),
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.borderRadius)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Get.back();
                                                askDialog(() {
                                                  _controller
                                                      .deleteProject(_controller
                                                          .projectList[index]
                                                          .id!)
                                                      .then((value) {
                                                    if (value is DataSuccess) {
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
                                                          message: value
                                                                  .error ??
                                                              'خطا در ارسال اطلاعات',
                                                        ),
                                                      );
                                                    }
                                                  });
                                                  Get.back();
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: CustomColors
                                                    .foregroundColor,
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
                                                _controller.projectEditMode =
                                                    true;
                                                Get.back();
                                                Get.defaultDialog(
                                                    title: 'ویرایش پروژه',
                                                    content: Obx(() {
                                                      return CreateProjectDialog(
                                                        onSaveClicked: () {
                                                          _controller
                                                              .updateProject(
                                                                  _controller
                                                                      .projectList
                                                                      .value[
                                                                          index]
                                                                      .id!)
                                                              .then((value) {
                                                            if (value
                                                                is DataSuccess) {
                                                              showTopSnackBar(
                                                                Overlay.of(
                                                                    context),
                                                                const CustomSnackBar
                                                                    .success(
                                                                  message:
                                                                      "اطلاعات ذخیره شد",
                                                                ),
                                                              );
                                                              Get.back();
                                                            } else {
                                                              showTopSnackBar(
                                                                Overlay.of(
                                                                    context),
                                                                CustomSnackBar
                                                                    .error(
                                                                  message: value
                                                                      .error
                                                                      .toString(),
                                                                ),
                                                              );
                                                            }
                                                          });
                                                        },
                                                        loading: _controller
                                                            .isLoading.value,
                                                      );
                                                    }));
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: CustomColors
                                                    .foregroundColor,
                                              )),
                                          const Text(
                                            'ویرایش',
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      itemCount: _controller.projectList.value.length,
                    );
            })),
      ),
    );
  }
}
