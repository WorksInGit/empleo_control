import 'package:empleo_control/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 200.h),
                Center(
                  child: Text(
                    'Welcome Back!',
                    style: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('Fill your details to continue as admin'),
                SizedBox(height: 30.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      label: Text('Email Address'),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Obx(() {
                  return GestureDetector(
                    onTap: controller.isLoading.value
                        ? null // Disable button while loading
                        : () {
                            controller.login();
                          },
                    child: Container(
                      width: 340.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: controller.isLoading.value
                            ? Colors.grey // Indicate disabled state
                            : HexColor('4CA6A8'),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'LOG IN',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.sp,
                                ),
                              ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}