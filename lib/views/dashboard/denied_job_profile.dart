import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class DeniedApplyPage extends StatelessWidget {
  final DocumentSnapshot jobId;
  const DeniedApplyPage({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<DocumentSnapshot>(
          future:
              FirebaseFirestore.instance.collection('jobs').doc(jobId.id).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: HexColor('4CA6A8'),
                ),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Scaffold(
                body: Center(
                  child: Text(
                    'Job not found!',
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, color: Colors.grey),
                  ),
                ),
              );
            }

            final jobData = snapshot.data!.data() as Map<String, dynamic>;
            final id = snapshot.data!.id;
            final jobTitle = jobData['jobName'] ?? 'N/A';
            final company = jobData['companyName'] ?? 'N/A';
            final location = jobData['location'] ?? 'N/A';
            final employmentType = jobData['timing'] ?? 'N/A';
            final salary = jobData['salary'] ?? 'N/A';
            final companyLogo =
                jobData['photoUrl'] ?? 'assets/icons/default.png';
            final qualifications =
                List<String>.from(jobData['qualifications'] ?? []);
            final skills = List<String>.from(jobData['skills'] ?? []);
            return DefaultTabController(
              length: 2,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.h),
                        child: Column(
                          children: [
                            SizedBox(height: 60.h),
                            CircleAvatar(
                              radius: 50.r, // Adjust the radius as needed
                              backgroundColor: Colors.transparent,
                              backgroundImage: companyLogo.startsWith('http')
                                  ? NetworkImage(companyLogo)
                                  : AssetImage(companyLogo) as ImageProvider,
                            ),
                            SizedBox(height: 30.h),
                            Text(
                              jobTitle,
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$company -',
                                  style: GoogleFonts.poppins(fontSize: 14.sp),
                                ),
                                Icon(Iconsax.location5, size: 16.sp),
                                Text(
                                  location,
                                  style: GoogleFonts.poppins(fontSize: 14.sp),
                                )
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.clock5, size: 16.sp),
                                SizedBox(width: 5.w),
                                Text(
                                  employmentType,
                                  style: GoogleFonts.poppins(fontSize: 14.sp),
                                ),
                                SizedBox(width: 10.w),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee_sharp,
                                      size: 15.sp,
                                    ),
                                    Text(
                                      '$salary/m',
                                      style:
                                          GoogleFonts.poppins(fontSize: 14.sp),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            TabBar(
                              dividerColor: Colors.transparent,
                              indicator: BoxDecoration(
                                color: HexColor('4CA6A8'),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              labelStyle: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              tabs: [
                                SizedBox(
                                  width: 250.w,
                                  child: Tab(text: 'Description'),
                                ),
                                SizedBox(
                                  width: 250.w,
                                  child: Tab(text: 'Company'),
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  DeniedDescription(
                                    qualifications: qualifications,
                                    skills: skills,
                                  ),
                                  DeniedAboutCompany(
                                      companyDescription:
                                          jobData['about'] ?? 'N/A'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 640.h,
                        left: 100.w,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () async {
                                final Uri emailUri = Uri(
                                  scheme: 'mailto',
                                  path: jobData['companyEmail'],
                                  query: 'subject=Support@Empleo',
                                );
                                if (await canLaunchUrl(emailUri)) {
                                  await launchUrl(emailUri);
                                } else {
                                  throw 'Could not launch $emailUri';
                                }
                              },
                              icon: Icon(
                                Iconsax.direct_inbox,
                                size: 35.sp,
                              ),
                            ),
                            Text(
                              'EMAIL',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 640.h,
                        right: 100.w,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('jobs')
                                    .doc(id)
                                    .update({'status': 1});
                                Get.back();
                              },
                              icon: Icon(
                                Iconsax.shield_cross,
                                size: 35.sp,
                              ),
                            ),
                            Text(
                              'VERIFY',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DeniedDescription extends StatelessWidget {
  final List<String> qualifications;
  final List<String> skills;
  const DeniedDescription(
      {super.key, required this.qualifications, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(7.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Text(
                'Qualification',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
            for (var qualification in qualifications)
              _buildListItem(qualification),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Text(
                'Skills',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
            for (var skills in skills) _buildListItem(skills),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
      child: Row(
        children: [
          SizedBox(width: 20.w),
          Icon(
            Icons.circle,
            size: 9.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeniedAboutCompany extends StatelessWidget {
  final String companyDescription;
  const DeniedAboutCompany({super.key, required this.companyDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'About',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                companyDescription,
                style: GoogleFonts.poppins(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
