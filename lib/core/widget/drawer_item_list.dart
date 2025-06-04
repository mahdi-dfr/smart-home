import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/styles.dart';

import '../constants/utils.dart';
import '../resource/connection/websocket_service.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.title, required this.onTap, required this.icon});

  final String title;
  final Icon icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    icon,
                    const SizedBox(
                      width: 10,
                    ),
                    Text(title, style: AppStyles.style4),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DrawerItemOption extends StatefulWidget {
  const DrawerItemOption({super.key, required this.title, required this.icon, required this.onTap});

  final String title;
  final Icon icon;
  final Function() onTap;

  @override
  State<DrawerItemOption> createState() => _DrawerItemOptionState();
}

class _DrawerItemOptionState extends State<DrawerItemOption> {
  bool isOfflineMode = GetStorage().read(AppUtils.offlineMode) ?? false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        widget.icon,
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.title, style: AppStyles.style4),
                      ],
                    ),
                    Switch(
                        value: isOfflineMode,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            isOfflineMode = value;
                            GetStorage().write(AppUtils.offlineMode, value);
                            if(isOfflineMode){
                              Get.find<WebsocketService>().initWebSocket();
                            }
                          });
                        })
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
