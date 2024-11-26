import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           SizedBox(height: 10.h), // Adjusted with ScreenUtil
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Iconsax.arrow_circle_left,
                      size: 30.sp, // Adjusted with ScreenUtil
                    ),
                  ),
                  SizedBox(width: 30.w), // Adjusted with ScreenUtil
                  Text(
                    'Profile',
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 30.w), // Adjusted with ScreenUtil
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Iconsax.edit5, size: 30.sp,) // Adjusted with ScreenUtil
                  ),
                ],
              ),
        ],
      ),
    );
  }
}