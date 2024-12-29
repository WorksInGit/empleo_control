import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class AdminJobs extends StatelessWidget {
  const AdminJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text('Jobs'),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                      label: Text('Search here'),
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              Expanded(child: AdminAcceptedJobs())
            ],
          ),
        ),
      ),
    );
  }
}

class AdminAcceptedJobs extends StatelessWidget {
  const AdminAcceptedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('jobs')
          .where('status', isEqualTo: 1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No jobs found',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            ),
          );
        }
        final jobs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            final jobTitle = job['jobName'] ?? 'N/A';
            final salary = job['salary'] ?? 'N/A';
            final employmentType = job['timing'] ?? 'N/A';
            final companyLogo = job['photoUrl'] ?? 'assets/icons/default.png';
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                onTap: () {
                  Get.to(
                    ApplyPage(jobId: job.id),
                    transition: Transition.cupertino,
                    duration: Duration(milliseconds: 500),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: companyLogo.startsWith('http')
                      ? NetworkImage(companyLogo)
                      : AssetImage(companyLogo) as ImageProvider,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          jobTitle,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee_sharp,
                              size: 17,
                              color: Colors.grey,
                            ),
                            Text(
                              '$salary/M',
                              style: GoogleFonts.poppins(
                                  fontSize: 10.sp, color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      employmentType,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300, fontSize: 12.sp),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ApplyPage extends StatelessWidget {
  final String jobId;
  const ApplyPage({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<DocumentSnapshot>(
          future:
              FirebaseFirestore.instance.collection('jobs').doc(jobId).get(),
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
                                  Description(
                                    qualifications: qualifications,
                                    skills: skills,
                                  ),
                                  AboutCompany(
                                      companyDescription:
                                          jobData['about'] ?? 'N/A'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Fixed Icons
                      Positioned(
                        top: 650.h,
                        left: 100.w,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {},
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
                        top: 650.h,
                        right: 100.w,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('jobs')
                                    .doc(id)
                                    .update({'status': -1});
                                Get.back();
                              },
                              icon: Icon(
                                Iconsax.shield_cross,
                                size: 35.sp,
                              ),
                            ),
                            Text(
                              'DENY',
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

class Description extends StatelessWidget {
  final List<String> qualifications;
  final List<String> skills;
  const Description(
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
                'Qualification:',
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
                'Skills:',
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
            size: 13.sp,
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

class AboutCompany extends StatelessWidget {
  final String companyDescription;
  const AboutCompany({super.key, required this.companyDescription});

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
