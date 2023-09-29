import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/usecase/register_usecase.dart';


class RegisterController extends GetxController {
  var isLoading = false.obs;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthDate = TextEditingController();

  final RegisterUseCase _usecase;

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
            var response = await _usecase.registerUserUsecase(
                username.text, password.text, mobileNumber.text);
            if (response is DataSuccess) {
              //Get.offAllNamed('/');
              isLoading.value = false;
              Get.snackbar('اطلاعات با موفقیت ذخیره شد', '');
            } else {
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

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    mobileNumber.dispose();
    super.dispose();
  }
}
