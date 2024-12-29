import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:empleo_control/controllers/profile_controller.dart';

class AdminProfileEdit extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  AdminProfileEdit({super.key}) {
    controller.loadProfileData(); // Load profile data on initialization
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Obx(() => Scaffold(
          appBar: AppBar(
            surfaceTintColor: HexColor('4CA6A8'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text('Edit Profile'),
            titleTextStyle: GoogleFonts.poppins(color: Colors.black, fontSize: 20.sp,
            fontWeight: FontWeight.w500
            ),
            centerTitle: true,
          ),
              backgroundColor: Colors.white,
              body: controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: HexColor('4CA6A8'),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                    
                          SizedBox(height: 80.h),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 60.r,
                                backgroundImage: controller.photoUrl.value.isNotEmpty
                                    ? NetworkImage(controller.photoUrl.value)
                                    : const AssetImage('assets/images/james.png')
                                        as ImageProvider,
                              ),
                              IconButton(
                                onPressed: () async {
                                  String newPhotoUrl = await controller.pickPhoto();
                                  if (newPhotoUrl.isNotEmpty) {
                                    controller.photoUrl.value = newPhotoUrl;
                                  }
                                },
                                icon: Icon(
                                  Iconsax.camera5,
                                  color: HexColor('4CA6A8'),
                                  size: 30.sp,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20.h),
                          _buildEditableField(
                              label: "Name",
                              value: controller.name.value,
                              onChanged: (value) => controller.name.value = value),
                          SizedBox(height: 20.h),
                          _buildEditableField(
                              label: "Email",
                              value: controller.email.value,
                              onChanged: (value) => controller.email.value = value),
                          SizedBox(height: 20.h),
                          _buildEditableField(
                              label: "Password",
                              value: controller.password.value,
                              onChanged: (value) =>
                                  controller.password.value = value,
                              obscureText: true),
                          SizedBox(height: 60.h),
                          SizedBox(
                            width: 200.w,
                            height: 50.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor('4CA6A8')),
                              onPressed: () => controller.saveProfileData(),
                              child: Text(
                                'Save',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            )),
      ),
    );
  }

  Widget _buildEditableField(
      {required String label,
      required String value,
      required Function(String) onChanged,
      bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 25.w),
            Text(
              label,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: TextFormField(
            initialValue: value,
            onChanged: onChanged,
            obscureText: obscureText,
            decoration: InputDecoration(
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