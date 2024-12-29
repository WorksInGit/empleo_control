import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo_control/views/dashboard/company_denied_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminDenied extends StatelessWidget {
  const AdminDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text(
              'Denied',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              TabBar(
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                      color: HexColor('4CA6A8'),
                      borderRadius: BorderRadius.circular(15.r)),
                  labelStyle: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
                    Container(
                        width: 250.w,
                        child: Tab(
                          text: 'Users',
                        )),
                    Container(
                        width: 250.w,
                        child: Tab(
                          text: 'Companies',
                        )),
                    Container(
                        width: 250.w,
                        child: Tab(
                          text: 'Jobs',
                        )),
                  ]),
              Expanded(
                  child: TabBarView(children: [
                UserDenied(),
                CompaniesDenied(),
                JobsDenied()
              ]))
            ],
          ),
        ),
      ),
    );
  }
}

class UserDenied extends StatelessWidget {
  const UserDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('status', isEqualTo: -1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching user data.'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No users found.'),
          );
        }

        final users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index].data() as Map<String, dynamic>;
            final userName = user['name'] ?? 'Unknown';
            final department = user['qualification'] ?? 'N/A';
            final location = user['location'] ?? 'N/A';
            final profilePic = user['photoUrl'] ?? 'assets/images/john.png';

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  backgroundImage: profilePic.startsWith('http')
                      ? NetworkImage(profilePic)
                      : AssetImage(profilePic) as ImageProvider,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      department,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300, fontSize: 13.sp),
                    ),
                  ],
                ),
                trailing: Text(
                  location,
                  style: GoogleFonts.poppins(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CompaniesDenied extends StatelessWidget {
  const CompaniesDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('companies')
          .where('status', isEqualTo: -1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching company data.'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No denied companies found.'),
          );
        }

        final companies = snapshot.data!.docs;
        return ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, index) {
            final companyId = companies[index].id;
            final company = companies[index].data() as Map<String, dynamic>;
            final companyName = company['companyName'] ?? 'Unknown Company';
            final location = company['location'] ?? 'N/A';
            final industry = company['industry'] ?? 'N/A';
            final logoUrl = company['photoUrl'] ?? 'assets/icons/google.png';

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                onTap: () {
                  Get.to(
                    CompanyDeniedProfile(companyId: companyId),
                    transition: Transition.cupertino,
                    duration: Duration(milliseconds: 500),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: logoUrl.startsWith('http')
                      ? NetworkImage(logoUrl)
                      : AssetImage(logoUrl) as ImageProvider,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      location,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300, fontSize: 13.sp),
                    ),
                  ],
                ),
                trailing: Text(
                  industry,
                  style: GoogleFonts.poppins(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class JobsDenied extends StatelessWidget {
  const JobsDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('jobs')
            .where('status', isEqualTo: -1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No denied jobs found!',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
            );
          }

          final deniedJobs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: deniedJobs.length,
            itemBuilder: (context, index) {
              final job = deniedJobs[index].data() as Map<String, dynamic>;
              final jobTitle = job['jobName'] ?? 'N/A';
              final jobType = job['timing'] ?? 'N/A';
              final salary = job['salary'] ?? 'N/A';
              final logoUrl = job['photoUrl'] ?? 'assets/icons/default.png';

              return Padding(
                padding: EdgeInsets.all(10.0.r),
                child: ListTile(
                  onTap: () {
                    // Define action when tapping on a job
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: logoUrl.startsWith('http')
                        ? NetworkImage(logoUrl)
                        : AssetImage(logoUrl) as ImageProvider,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            jobTitle,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.currency_rupee_sharp,
                                size: 15.sp,
                              ),
                              Text(
                                '$salary/M',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        jobType,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
