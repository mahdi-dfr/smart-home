import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:turkeysh_smart_home/core/constants/constant.dart';
import 'package:turkeysh_smart_home/features/auth/presentation/widget/confirm_button.dart';
import 'package:turkeysh_smart_home/features/auth/presentation/widget/input_field.dart';

import '../widget/wave_widget.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: width,
            child: Stack(
              children: <Widget>[
                Opacity(

                  opacity: 0.5,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: ConstantsData().foregroundColor,
                      height: height * 0.53,
                    ),
                  ),
                ),

                ClipPath(

                    clipper: WaveClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ConstantsData().foregroundColor,
                      ),
                      height: height * 0.5,
                      alignment: Alignment.center,
                    )),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      child: Lottie.asset('assets/anim/login.json',
                          width: width / 3),
                    )),


              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                width: width * 0.8,
                height: height * 0.42,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.8),
                    // boxShadow: const [
                    //    BoxShadow(
                    //     color: Colors.grey,
                    //     offset: Offset(0.0, 1.0),
                    //     blurRadius: 4.0,
                    //   ),
                    // ],
                    border: Border.all(
                        width: 1,
                        color: ConstantsData().foregroundColor)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ورود به برنامه', style: TextStyle(fontFamily: 'BoldTitle', fontSize: 28),),
                    const SizedBox(height: 20,),
                    LoginEditText(
                      hint: 'نام کاربری',
                      //fieldController: controller.username,
                      icon: const Icon(Icons.person),
                      type: TextInputType.text,
                      isPass: false,
                      showPass: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    LoginEditText(
                      hint: 'رمز عبور',
                      //fieldController: controller.password,
                      icon: const Icon(Icons.lock),
                      type: TextInputType.visiblePassword,
                      isPass: true,
                      showPass: true,
                    ),

                    const SizedBox(height: 20,),
                    LoginButton(onClick: (){
                      Get.toNamed('/drawer');
                    }),



                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


