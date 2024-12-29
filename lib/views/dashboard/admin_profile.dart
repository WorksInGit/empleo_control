import 'package:empleo_control/controllers/profile_controller.dart';
import 'package:empleo_control/views/dashboard/admin_profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class AdminProfile extends StatelessWidget {
  AdminProfile({super.key});
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    // Preload data when the widget is built
    controller.loadProfileData();

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: HexColor('4CA6A8'),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 100.w),
                      Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 30.w),
                      IconButton(
                          onPressed: () {
                            Get.to(
                              AdminProfileEdit(),
                              transition: Transition.cupertino,
                              duration: Duration(milliseconds: 500),
                            );
                          },
                          icon: Icon(Iconsax.edit5, size: 30.sp)),
                    ],
                  ),
                  SizedBox(height: 70.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundColor: HexColor('D6D6D6'),
                        child: controller.photoUrl.isEmpty
                            ? Icon(Icons.person, size: 60.sp)
                            : null,
                      ),
                      if (controller.photoUrl.isNotEmpty)
                        CircleAvatar(
                          radius: 60.r,
                          backgroundImage:
                              NetworkImage(controller.photoUrl.value),
                        ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  buildProfileField('Name', controller.name.value),
                  SizedBox(height: 20.h),
                  buildProfileField('Email', controller.email.value),
                  SizedBox(height: 20.h),
                  buildProfileField('Password', '********'),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            label,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: TextFormField(
            initialValue: value,
            decoration: InputDecoration(
              enabled: false,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w200),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('4CA6A8')),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
