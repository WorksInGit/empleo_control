import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminCompanyProfile extends StatelessWidget {
  const AdminCompanyProfile({super.key, required this.companyId});

  final String companyId;

  @override
  Widget build(BuildContext context) {
    String mail = '';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection(
                      'companies') // Replace with your Firestore collection name
                  .doc(companyId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: HexColor('4CA6A8'),
                  ));
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(
                    child: Text(
                      'Company not found',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                    ),
                  );
                }

                final companyDoc =
                    snapshot.data!.data() as Map<String, dynamic>;
                final companyName = companyDoc['companyName'] ?? 'N/A';
                final companyEmail = companyDoc['email'] ?? 'N/A';
                final companyContact = companyDoc['contactNo'] ?? 'N/A';
                final companyAbout = companyDoc['about'] ?? 'N/A';
                final companyIndustry = companyDoc['industry'] ?? 'N/A';
                final companyLocation = companyDoc['location'] ?? 'N/A';
                final companyLogo = companyDoc['photoUrl'] ?? '';
                mail = companyDoc['email'];

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 60.r,
                        backgroundImage: companyLogo.isNotEmpty
                            ? NetworkImage(companyLogo)
                            : const AssetImage(
                                    'assets/icons/default_company.png')
                                as ImageProvider,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        companyName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      buildInfoSection(
                        title: 'Email Address',
                        value: companyEmail,
                      ),
                      buildInfoSection(
                        title: 'Contact Number',
                        value: companyContact,
                      ),
                      buildInfoSection(
                        title: 'About',
                        value: companyAbout,
                        maxLines: 3,
                      ),
                      buildInfoSection(
                        title: 'Industry',
                        value: companyIndustry,
                      ),
                      buildInfoSection(
                        title: 'Location',
                        value: companyLocation,
                      ),
                      SizedBox(height: 110.h),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 650.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildActionButton(
                    icon: Iconsax.direct_inbox,
                    label: 'EMAIL',
                    onPressed: () async {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: mail,
                        query: 'subject=Support@Empleo',
                      );
                      if (await canLaunchUrl(emailUri)) {
                        await launchUrl(emailUri);
                      } else {
                        throw 'Could not launch $emailUri';
                      }
                    },
                  ),
                  buildActionButton(
                    icon: Iconsax.shield_cross,
                    label: 'DENY',
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Deny Confirmation",
                        middleText:
                            "Are you sure you want to deny this company profile?",
                        textConfirm: "Yes",
                        textCancel: "No",
                        confirmTextColor: Colors.white,
                        backgroundColor: Colors.white,
                        titleStyle: GoogleFonts.poppins(fontSize: 18.sp),
                        middleTextStyle: GoogleFonts.poppins(fontSize: 15.sp),
                        buttonColor: HexColor('4CA6A8'),
                        onCancel: () {
                          Get.back();
                        },
                        onConfirm: () async {
                          await FirebaseFirestore.instance
                              .collection('companies')
                              .doc(companyId)
                              .update({'status': -1});
                          Get.back();
                          Get.back();
                        },
                        // Set confirm button text color
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoSection({
    required String title,
    required String value,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Row(
          children: [
            SizedBox(width: 25.w),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: TextFormField(
            maxLines: maxLines,
            readOnly: true,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              hintText: value,
              hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w200),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('4CA6A8')),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 35,
            color: Colors.black,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
