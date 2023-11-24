String errorConvertor(String? errorMessage){
  if(errorMessage != null){
    if(errorMessage.contains('A user with that username already exists')){
      return 'کاربری با این نام کاربری از قبل وجود دارد!';
    }else if(errorMessage.contains('No active account found with the given credentials')){
      return 'نام کاربری یا رمز عبور اشتباه است!';
    }
  }

  return 'خطا در ارسال اطلاعات';
}