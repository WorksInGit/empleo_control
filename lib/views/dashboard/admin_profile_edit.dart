import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class AdminProfileEdit extends StatelessWidget {
  const AdminProfileEdit({super.key});

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
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10.h), // Adjusted with ScreenUtil
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Edit Profile',
                          style: GoogleFonts.poppins(
                              fontSize: 20.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 70.h), // Adjusted with ScreenUtil
                    CircleAvatar(
                      radius: 60.r, // Adjusted with ScreenUtil
                      backgroundImage: AssetImage('assets/images/james.png'),
                    ),
                    SizedBox(height: 20.h), // Adjusted with ScreenUtil
                    Row(
                      children: [
                        SizedBox(width: 25.w), // Adjusted with ScreenUtil
                        Text(
                          'Name',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h), // Adjusted with ScreenUtil
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w), // Adjusted with ScreenUtil
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text(
                              'James Micheal',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w200),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: HexColor('4CA6A8')))),
                      ),
                    ),
                    SizedBox(height: 20.h), // Adjusted with ScreenUtil
                    Row(
                      children: [
                        SizedBox(width: 25.w), // Adjusted with ScreenUtil
                        Text(
                          'Email',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h), // Adjusted with ScreenUtil
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w), // Adjusted with ScreenUtil
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text(
                              'james123@gmail.com',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w200),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: HexColor('4CA6A8')))),
                      ),
                    ),
                    SizedBox(height: 20.h), // Adjusted with ScreenUtil
                    Row(
                      children: [
                        SizedBox(width: 25.w), // Adjusted with ScreenUtil
                        Text(
                          'Password',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h), // Adjusted with ScreenUtil
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w), // Adjusted with ScreenUtil
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: HexColor('4CA6A8')))),
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),

                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor('4CA6A8')),
                          onPressed: () {},
                          child: Text(
                            'Save',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                          )),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(left: 210.w, top: 190.h),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Iconsax.camera5,
                          color: HexColor('4CA6A8'),
                          size: 40.sp,
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
