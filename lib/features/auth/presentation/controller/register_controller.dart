import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/usecase/auth_usecase.dart';


class RegisterController extends GetxController {
  var isLoading = false.obs;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthDate = TextEditingController();

  TextEditingController loginUsername = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  final AuthUseCase _usecase;

  RegisterController(this._usecase);

  signUpUser() async {
    isLoading.value = true;
    if (Get.find<ConnectionController>().isConnected.value) {
      if (username.text.isNotEmpty &&
          password.text.isNotEmpty &&
          confirmPassword.text.isNotEmpty &&
          mobileNumber.text.isNotEmpty) {
        if (password.text == confirmPassword.text) {
          if (mobileNumber.text.length == 11 &&
              mobileNumber.text.startsWith('09')) {

            // hash password
            var hashedPass = utf8.encode(password.text);
            var digest = sha512.convert(hashedPass);

            var response = await _usecase.registerUserUsecase(
                username.text, digest.toString(), mobileNumber.text, email.text, birthDate.text);
            if (response is DataSuccess) {
              Get.offAllNamed('/');
              isLoading.value = false;
              Get.snackbar('اطلاعات با موفقیت ذخیره شد', '');

              username.text = '';
              password.text = '';
              confirmPassword.text = '';
              email.text = '';
              mobileNumber.text = '';
              birthDate.text = '';

            } else {
              Get.snackbar('خطا', response.toString());
              isLoading.value = false;
            }
          } else {
            isLoading.value = false;
            Get.snackbar('خطا', 'لطفا شماره موبایل را با فرمت مناسب وارد کنید');
          }
        } else {
          isLoading.value = false;
          Get.snackbar('خطا', 'رمز عبور با تکرار آن مطابقت ندارد');
        }
      } else {
        isLoading.value = false;
        Get.snackbar('خطا', 'لطفا تمام اطلاعات را وارد نمایید');
      }
    } else {
      Get.snackbar('خطا', 'لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }
  }

  loginUser() async {
    isLoading.value = true;
    print(username.text);
    print(password.text);
    if (Get.find<ConnectionController>().isConnected.value) {
      if(loginUsername.text.isNotEmpty && loginPassword.text.isNotEmpty){

        // hash password
        var hashedPass = utf8.encode(loginPassword.text);
        var digest = sha512.convert(hashedPass);

        DataState<UserEntity> dataState =
        await _usecase.loginUser(username.text, digest.toString());
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            Get.offAllNamed('/drawer');
            GetStorage().write(ConstantsData.userTokenAccess, dataState.data!.access);
            GetStorage().write(ConstantsData.userTokenRefresh, dataState.data!.refresh);

            isLoading.value = false;
          }
        } else {
          isLoading.value = false;
          print(dataState.error);
          Get.snackbar('خطا', dataState.error.toString());
        }
      }else{
        isLoading.value = false;
        Get.snackbar('خطا', 'لطفا ابتدا فیلد های خالی را تکمیل نمایید');
      }

    }else{
      isLoading.value = false;
      Get.snackbar('خطا', 'لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }

  }


  @override
  void dispose() {
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    mobileNumber.dispose();
    super.dispose();
  }
}
