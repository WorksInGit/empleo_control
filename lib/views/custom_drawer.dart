import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo_control/controllers/drawer_controller.dart';
import 'package:empleo_control/views/dashboard/admin_companies.dart';
import 'package:empleo_control/views/dashboard/admin_denied.dart';
import 'package:empleo_control/views/dashboard/admin_jobs.dart';
import 'package:empleo_control/views/dashboard/admin_profile.dart';
import 'package:empleo_control/views/dashboard/admin_request.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final CustomDrawerController controller = Get.put(CustomDrawerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                  showTitle: true,
                                  color: HexColor('00B6B6'),
                                  value: 40),
                              PieChartSectionData(
                                  color: HexColor('20CC87'), value: 30),
                              PieChartSectionData(
                                  color: HexColor('7CFFD3'), value: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 80.w),
                            Text('Total of the application'),
                          ],
                        ),
                        SizedBox(height: 70.w),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 40,
                            bottom: 20,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'This Month',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.sp),
                              ),
                              SizedBox(width: 10.w),
                              FaIcon(FontAwesomeIcons.calendar),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  color: HexColor('00B6B6'),
                                  borderRadius: BorderRadius.circular(20.r)),
                            ),
                            SizedBox(width: 20.w),
                            Text(
                              'User',
                              style: GoogleFonts.poppins(fontSize: 25.sp),
                            ),
                            Spacer(),
                            Text(
                              '40',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(width: 20.w),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  color: HexColor('7CFFD3'),
                                  borderRadius: BorderRadius.circular(20.r)),
                            ),
                            SizedBox(width: 20.w),
                            Text(
                              'Companies',
                              style: GoogleFonts.poppins(fontSize: 25.sp),
                            ),
                            Spacer(),
                            Text(
                              '20',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(width: 20.w),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  color: HexColor('20CC87'),
                                  borderRadius: BorderRadius.circular(20.r)),
                            ),
                            SizedBox(width: 20.w),
                            Text(
                              'Jobs',
                              style: GoogleFonts.poppins(fontSize: 25.sp),
                            ),
                            Spacer(),
                            Text(
                              '20',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(width: 20.w),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            SizedBox(width: 100.w),
                            Text('Total of this month'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80.h),
                ],
              ),
            ),

            // Main Content
            Obx(() {
              return GestureDetector(
                onTap: () {
                  if (controller.isDrawerOpen.value) {
                    controller.closeDrawer();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: Matrix4.translationValues(
                    controller.isDrawerOpen.value ? 250.w : 0,
                    0,
                    0,
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('admin')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: HexColor('4CA6A8'),
                          ),
                        );
                      }
                      var data = snapshot.data!.docs.first.data()
                          as Map<String, dynamic>;
                      controller.photoUrl.value = data['photoUrl'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: GestureDetector(
                                  onTap: controller.toggleDrawer,
                                  child: CircleAvatar(
                                    backgroundColor: HexColor('4CA6A8'),
                                    radius: 25.r,
                                    child: const Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              CircleAvatar(
                                radius: 25.r,
                                backgroundColor: Colors.grey.shade200,
                                child: CachedNetworkImage(
                                  imageUrl: data['photoUrl'] ?? '',
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                    color: HexColor('4CA6A8'),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 25.r,
                                    backgroundImage: imageProvider,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            }),

            // Custom Drawer
            Obx(() {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: controller.isDrawerOpen.value ? 0 : -250.w,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 250.w,
                  color: Colors.white,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('admin')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return SizedBox.shrink();
                      var adminData = snapshot.data!.docs.first.data()
                          as Map<String, dynamic>;

                      return Column(
                        children: [
                          SizedBox(height: 60.h),
                          CircleAvatar(
                            radius: 50.r,
                            backgroundColor: Colors.grey.shade200,
                            child: CachedNetworkImage(
                              imageUrl: adminData['photoUrl'] ?? '',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                color: HexColor('4CA6A8'),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, size: 50),
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 50.r,
                                backgroundImage: imageProvider,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            adminData['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            adminData['email'],
                            style: GoogleFonts.poppins(
                                fontSize: 14.sp, color: Colors.black),
                          ),
                          SizedBox(height: 20.h),
                          ListTile(
                            onTap: () {
                              Get.to(
                                AdminProfile(),
                                transition: Transition
                                    .cupertino, // Specify the transition
                                duration: Duration(
                                    milliseconds:
                                        500), // Optional: set animation duration
                              );
                            },
                            leading: Icon(Iconsax.profile_circle5,
                                color: Colors.black),
                            title: const Text('Profile'),
                          ),
                          ListTile(
                            onTap: () {
                               Get.to(
                                AdminRequest(),
                                transition: Transition
                                    .cupertino, // Specify the transition
                                duration: Duration(
                                    milliseconds:
                                        500), // Optional: set animation duration
                              );
                            },
                            leading: Icon(Iconsax.message_question5,
                                color: Colors.black),
                            title: const Text('Requests'),
                          ),
                          ListTile(
                            onTap: () {
                               Get.to(
                                AdminDenied(),
                                transition: Transition
                                    .cupertino, // Specify the transition
                                duration: Duration(
                                    milliseconds:
                                        500), // Optional: set animation duration
                              );
                            },
                            leading: Icon(Iconsax.danger5, color: Colors.black),
                            title: const Text('Denied'),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => AdminCompanies());
                            },
                            leading: FaIcon(FontAwesomeIcons.buildingShield,
                                color: Colors.black),
                            title: const Text('Companies'),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => AdminJobs());
                            },
                            leading: FaIcon(FontAwesomeIcons.box,
                                color: Colors.black),
                            title: const Text('Jobs'),
                          ),
                          ListTile(
                            onTap: () {
                              controller.closeDrawer();
                            },
                            leading: Icon(Iconsax.profile_2user5,
                                color: Colors.black),
                            title: const Text('Users'),
                          ),
                          ListTile(
                            onTap: () {
                              controller.closeDrawer();
                            },
                            leading: FaIcon(FontAwesomeIcons.award,
                                color: Colors.black),
                            title: const Text('Feedback'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
