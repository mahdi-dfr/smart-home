import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turkeysh_smart_home/features/auth/presentation/screen/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       home: RegisterScreen(),
      locale: const Locale('fa'),
      theme: ThemeData(
        fontFamily: 'IranSans',
      ),


    );
  }
}
