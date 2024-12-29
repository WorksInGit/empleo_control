import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyDeniedProfile extends StatelessWidget {
  const CompanyDeniedProfile({super.key, required this.companyId});

  final String companyId;

  @override
  Widget build(BuildContext context) {
      String? email;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('companies')
                  .doc(companyId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: HexColor('4CA6A8'),
                    ),
                  );
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

                final companyData =
                    snapshot.data!.data() as Map<String, dynamic>;
                final companyName = companyData['companyName'] ?? 'N/A';
                final companyEmail = companyData['email'] ?? 'N/A';
                final companyContact = companyData['contactNo'] ?? 'N/A';
                final companyAbout = companyData['about'] ?? 'N/A';
                final companyIndustry = companyData['industry'] ?? 'N/A';
                final companyLocation = companyData['location'] ?? 'N/A';
                final companyLogo = companyData['photoUrl'] ?? '';
                email = companyEmail;
                return GestureDetector(
                  onTap: () {
                    return FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
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
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 670.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildActionButton(
                    icon: Iconsax.shield3,
                    label: 'VERIFY',
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('companies')
                          .doc(companyId)
                          .update({'status': 1});
                      Navigator.pop(context);
                    },
                  ),
                  buildActionButton(
                    icon: Iconsax.direct_inbox,
                    label: 'EMAIL',
                    onPressed: () {
                      _openGmail(email!);
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
            initialValue: value,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
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

  void _openGmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Verification Needed&body=Hello,',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch Gmail';
    }
  }
}
