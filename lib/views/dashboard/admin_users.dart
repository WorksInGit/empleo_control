import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo_control/controllers/search_controller.dart';
import 'package:empleo_control/views/dashboard/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminUsers extends StatelessWidget {
  AdminUsers({super.key});

  final AdminSearchController controller = Get.put(AdminSearchController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: const Text('Users'),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                child: TextField(
                  controller: controller.searchController,
                  focusNode: controller.focusNode, 
                  onChanged: controller.updateSearchQuery,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor('4CA6A8')),
                    ),
                    label: Text(
                      'Search here',
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => StreamBuilder<QuerySnapshot>(
                  stream: controller.getFilteredUsers(),
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
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true, 
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index].data() as Map<String, dynamic>;
                              final userName = user['name'] ?? 'Unknown';
                              final department = user['qualification'] ?? 'N/A';
                              final location = user['location'] ?? 'N/A';
                              final profilePic = user['photoUrl'];
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ListTile(
                                  onTap: () {
                                    controller.focusNode.unfocus();
                                    Get.to(
                                      UserProfile(
                                        user: user,
                                      ),
                                      transition: Transition
                                          .cupertino, // Specify the transition
                                      duration: const Duration(
                                          milliseconds:
                                              500), // Optional: set animation duration
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: profilePic != ''
                                        ? NetworkImage(profilePic)
                                        : const AssetImage(
                                                'assets/icons/person.png')
                                            as ImageProvider,
                                  ),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userName,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        department,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13.sp),
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
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}