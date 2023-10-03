import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:turkeysh_smart_home/features/auth/presentation/widget/wave_widget.dart';
import '../../../../core/constants/constant.dart';
import '../controller/register_controller.dart';
import '../widget/confirm_button.dart';
import '../widget/input_field.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: ConstantsData.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
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
                        color: ConstantsData.foregroundColor,
                        height: height * 0.58,
                      ),
                    ),
                  ),
                  ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ConstantsData.foregroundColor,
                        ),
                        height: height * 0.55,
                        alignment: Alignment.center,
                      )),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Image.asset(
                            'assets/images/register_image.png',
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'ثبت نام',
              style: TextStyle(fontFamily: 'BoldTitle', fontSize: 28),
            ),
            const SizedBox(
              height: 20,
            ),
            LoginEditText(
              hint: 'نام کاربری',
              fieldController: _controller.username,
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
              fieldController: _controller.password,
              icon: const Icon(Icons.lock),
              type: TextInputType.visiblePassword,
              isPass: true,
              showPass: true,
            ),
            const SizedBox(
              height: 8,
            ),
            LoginEditText(
              hint: 'تکرار رمز عبور',
              fieldController: _controller.confirmPassword,
              icon: const Icon(Icons.lock),
              type: TextInputType.visiblePassword,
              isPass: true,
              showPass: true,
            ),
            const SizedBox(
              height: 8,
            ),
            LoginEditText(
              hint: 'آدرس ایمیل',
              fieldController: _controller.email,
              icon: const Icon(Icons.person),
              type: TextInputType.emailAddress,
              isPass: false,
              showPass: false,
            ),
            const SizedBox(
              height: 8,
            ),
            LoginEditText(
              hint: 'شماره همراه',
              fieldController: _controller.mobileNumber,
              icon: const Icon(Icons.person),
              type: TextInputType.phone,
              isPass: false,
              showPass: false,
            ),
            const SizedBox(
              height: 8,
            ),
            LoginEditText(
              hint: 'تاریخ تولد',
              fieldController: _controller.birthDate,
              icon: const Icon(Icons.person),
              type: TextInputType.datetime,
              isPass: false,
              showPass: false,
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 20,
            ),
            _controller.isLoading.value
                ? LoadingAnimationWidget.beat(
                    color: ConstantsData.foregroundColor, size: 35)
                : LoginButton(onClick: () {
                    _controller.signUpUser();
                  }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
