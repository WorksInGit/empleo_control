import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminRequestProfile extends StatelessWidget {
  AdminRequestProfile({super.key});
  final companyData = Get.arguments['companyData'];
  final docId = Get.arguments['docId'];

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email client';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 60.r,
                      backgroundImage: companyData['photoUrl'] != null
                          ? NetworkImage(companyData['photoUrl'])
                          : const AssetImage('assets/icons/default_company.png')
                              as ImageProvider,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      companyData['companyName'] ?? 'Unnamed Company',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    SizedBox(height: 20.h),
                    _buildLabel('Email Address'),
                    _buildTextField(companyData['email'] ?? 'Not provided'),
                    SizedBox(height: 20.h),
                    _buildLabel('Contact Number'),
                    _buildTextField(companyData['contactNo'] ?? 'Not provided'),
                    SizedBox(height: 20.h),
                    _buildLabel('About'),
                    _buildTextField(companyData['about'] ?? 'No description',
                        maxLines: 2),
                    SizedBox(height: 20.h),
                    _buildLabel('Industry'),
                    _buildTextField(companyData['industry'] ?? 'Not specified'),
                    SizedBox(height: 20.h),
                    _buildLabel('Location'),
                    _buildTextField(companyData['location'] ?? 'Not specified'),
                    SizedBox(height: 110.h),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Iconsax.shield_tick,
                        label: 'VERIFY',
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('companies')
                              .doc(docId)
                              .update({'status': 1});
                          Get.back();
                        },
                      ),
                      _buildActionButton(
                        icon: Iconsax.direct_inbox,
                        label: 'EMAIL',
                        onTap: () {
                          _launchEmail(
                              companyData['email'] ?? 'no-reply@example.com');
                        },
                      ),
                      _buildActionButton(
                        icon: Iconsax.shield_cross,
                        label: 'DENY',
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('companies')
                              .doc(docId)
                              .update({'status': -1});
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Row(
      children: [
        SizedBox(width: 25.w),
        Text(
          text,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildTextField(String text, {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        maxLines: maxLines,
        readOnly: true,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue
            )
          ),
          hintText: text,
          hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w200),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor('4CA6A8')),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return SizedBox(
      width: 90.w, // Ensure consistent width for all buttons
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            MainAxisAlignment.center, // Vertically center the content
        children: [
          Container(
            alignment: Alignment.center, // Ensure the icon is centered
            child: IconButton(
              onPressed: onTap,
              icon: Icon(icon, size: 40, color: Colors.black),
            ),
          ),
          SizedBox(height: 5.h), // Space between icon and label
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
