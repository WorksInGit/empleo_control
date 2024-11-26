import 'package:empleo_control/admin_login.dart';
import 'package:empleo_control/splash_screen.dart';
import 'package:empleo_control/views/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 786),
      splitScreenMode: true,
      minTextAdapt: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Empleo Control',
        home: CustomDrawer(),
      ),
    );
  }
}
