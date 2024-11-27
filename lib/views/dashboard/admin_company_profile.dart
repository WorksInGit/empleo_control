import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class AdminCompanyProfile extends StatelessWidget {
  const AdminCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h), // Adjusted with ScreenUtil
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 60.r, // Adjusted with ScreenUtil
                      backgroundImage: AssetImage('assets/icons/google.png'),
                    ),
                    SizedBox(height: 20.h), 
                    Text('Google', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20.sp),),
                     SizedBox(height: 20.h), // Adjusted with ScreenUtil
                    Row(
                      children: [
                        SizedBox(width: 25.w), // Adjusted with ScreenUtil
                        Text(
                          'Email Address',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h), // Adjusted with ScreenUtil
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text(
                              'google@gmail.com',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: HexColor('4CA6A8')))),
                      ),
                    ),
                    SizedBox(height: 20.h), // Adjusted with ScreenUtil
                    Row(
                      children: [
                        SizedBox(width: 25.w), // Adjusted with ScreenUtil
                        Text(
                          'Contact Number',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h), // Adjusted with ScreenUtil
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text(
                              '+91 7012338848',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: HexColor('4CA6A8')))),
                      ),
                    ),
                    SizedBox(height: 20.h), // Adjusted with ScreenUtil
                    Row(
                      children: [
                        SizedBox(width: 25.w), // Adjusted with ScreenUtil
                        Text(
                          'About',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h), // Adjusted with ScreenUtil
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                      child: TextFormField(
                        maxLines: 2,
                        decoration: InputDecoration(
                            label: Text(
                              'Google is a multinational company which has its branches all over the world',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: HexColor('4CA6A8')))),
                      ),
                    ),
                    SizedBox(height: 20.h), // Adjusted with ScreenUtil
                    Row(
                      children: [
                        SizedBox(width: 25.w), // Adjusted with ScreenUtil
                        Text(
                          'Industry',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h), // Adjusted with ScreenUtil
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text(
                              'IT',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: HexColor('4CA6A8')))),
                      ),
                    ),
                    SizedBox(height: 20.h), // Adjusted with ScreenUtil
                    Row(
                      children: [
                        SizedBox(width: 25.w), // Adjusted with ScreenUtil
                        Text(
                          'Location',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h), // Adjusted with ScreenUtil
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text(
                              'Andheri, Mumbai',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: HexColor('4CA6A8')))),
                      ),
                    ),
                     SizedBox(height: 110.h),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 650.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                        Iconsax.call5, size: 60, color: Colors.black,),),
                      Text('CONTACT', style: GoogleFonts.poppins(fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Padding(
                          padding: EdgeInsets.only(right: 60),
                          child: Icon(
                          Iconsax.shield_cross5, size: 60,color: Colors.black),
                        ),),
                        
                       Text('DENY', style: GoogleFonts.poppins(fontWeight: FontWeight.bold))
                    ],
                  ),
            
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}