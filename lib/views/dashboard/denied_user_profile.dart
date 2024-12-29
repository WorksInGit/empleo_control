import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class DeniedUserProfile extends StatelessWidget {
  final Map<String, dynamic> user;

  const DeniedUserProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final profilePic = user['photoUrl'] ?? ''; // Fallback for profile picture
    final name = user['name'] ?? 'Unknown';
    final email = user['email'] ?? 'Not Provided';
    final qualification = user['qualification'] ?? 'N/A';
    final experience = user['experience'] ?? 'No experience listed';
    final skills = user['skills'] ?? []; // Ensure this is a list
    final contactNumber = user['phone'].toString();
    final location = user['location'] ?? 'Not Provided';

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        surfaceTintColor: HexColor('4CA6A8'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
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
                  backgroundImage: profilePic.isNotEmpty
                      ? NetworkImage(profilePic)
                      : const AssetImage('assets/icons/person.png')
                          as ImageProvider,
                ),
                SizedBox(height: 20.h),
                _buildLabel('Name'),
                _buildReadOnlyField(name),
                SizedBox(height: 20.h),
                _buildLabel('Email'),
                _buildReadOnlyField(email),
                SizedBox(height: 20.h),
                _buildLabel('Qualification'),
                _buildReadOnlyField(qualification),
                SizedBox(height: 20.h),
                _buildLabel('Experience'),
                _buildReadOnlyField(experience),
                SizedBox(height: 20.h),
                _buildLabel('Skills'),
                _buildSkillsContainer(skills),
                SizedBox(height: 20.h),
                _buildLabel('Contact Number'),
                _buildReadOnlyField(contactNumber),
                SizedBox(height: 20.h),
                _buildLabel('Location'),
                _buildReadOnlyField(location),
                SizedBox(height: 120.h),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 570.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Iconsax.direct_inbox,
                  label: 'EMAIL',
                  onTap: () async {
                    final Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: user['email'],
                      query: 'subject=Support@Empleo',
                    );
                    if (await canLaunchUrl(emailUri)) {
                      await launchUrl(emailUri);
                    } else {
                      throw 'Could not launch $emailUri';
                    }
                  },
                ),
                _buildActionButton(
                  icon: Iconsax.shield,
                  label: 'VERIFY',
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(user['uid'])
                        .update({'status': 1});
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildLabel(String label) {
    return Row(
      children: [
        SizedBox(width: 25.w),
        Text(
          label,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildReadOnlyField(String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        controller: TextEditingController(text: value),
        readOnly: true,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor('4CA6A8')),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsContainer(List<dynamic> skills) {
    if (skills.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Container(
          width: double.infinity,
          height: 60.h,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 238, 237, 237)),
          ),
          child: Center(
            child: Text(
              'No skills listed',
              style: GoogleFonts.poppins(fontSize: 12.sp),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 238, 237, 237)),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(width: 20.w),
                Container(
                  width: 80.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: HexColor('4CA6A8')),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15).r,
                  ),
                  child: Center(
                    child: Text(
                      skills[index].toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
              ],
            );
          },
        ),
      ),
    );
  }
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
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12.sp),
        ),
      ],
    ),
  );
}
