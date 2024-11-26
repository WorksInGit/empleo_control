
import 'package:empleo_control/views/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
            height: 200.h,
          ),
                Center(
                  child: Text(
                    'Welcome Back!',
                    style: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('Fill your Details to continue as admin'),
                30.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: Text('Email Address'),
                        prefixIcon: Icon(Icons.email),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: Text('Password'),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        suffixIcon: Icon(Icons.visibility_off)),
                  ),
                ),
                 SizedBox(
            height: 30.h,
          ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => CustomDrawer());
                  },
                  child: Container(
                    width: 340.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                        color: HexColor('4CA6A8'),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        'LOG IN',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
                 SizedBox(
            height: 20.h,
          ),
               

                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
