import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turkeysh_smart_home/features/device/presentation/controller/device_controller.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/widget/custom_app_bar.dart';

class AllSensorSettings extends StatelessWidget {
  AllSensorSettings({super.key, required this.boardId, required this.type});

  final int boardId;
  final int type;

  final _controller = Get.find<DeviceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: CustomAppBar(
        height: 150,
        titleWidget: const Text(
          'تنظیمات سنسورها',
          style: AppStyles.appbarTitleStyle,
        ),
      ),
      body: SafeArea(child:
      Obx(() {
        return ListView.separated(itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('نام سنسور:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 8,),
                        Text(_controller.configList[index].sensorName!, style: TextStyle(fontSize: 16, ),),
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      children: [
                        const Text('بازه ی سنسور:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 8,),
                        Text(_controller.configList[index].configRange.toString(), style: TextStyle(fontSize: 16, ),),
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      children: [
                        const Text('وضعیت سنسور:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 8,),
                        Text(_controller.configList[index].status! ? 'On' : 'Off', style: TextStyle(fontSize: 16, ),),
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      children: [
                        const Text('نوع تنظیم:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 8,),
                        Text(_controller.configList[index].configType!, style: TextStyle(fontSize: 16, ),),
                      ],
                    ),

                    const SizedBox(height: 4,),
                    Row(
                      children: [
                        const Text('نام کلید:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 8,),
                        Text(_controller.configList[index].keyName!, style: TextStyle(fontSize: 16, ),),
                      ],
                    ),
                  ],
                ),
                IconButton(onPressed: () {
                  _controller.deleteConfigs(_controller.configList[index].isarId,
                      _controller.configList[index].configType == 'Max', boardId, type, index);

                }, icon: const Icon(Icons.delete_outlined))
              ],
            ),
          );
        }, separatorBuilder: (context, index) {
          return const SizedBox(height: 2,);
        }, itemCount: _controller.configList.length);
      })

      ),
    );
  }
}
