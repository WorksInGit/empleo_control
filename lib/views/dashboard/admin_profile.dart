import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo_control/controllers/drawer_controller.dart';
import 'package:empleo_control/views/dashboard/admin_profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class AdminProfile extends StatelessWidget {
   AdminProfile({super.key});
final CustomDrawerController controller = Get.put(CustomDrawerController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          return FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('admin').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: HexColor('4CA6A8'),),
                  );
                }
                var data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                
                return  Column(
                children: [
                   SizedBox(height: 10.h), // Adjusted with ScreenUtil
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          
                          SizedBox(width: 100.w), // Adjusted with ScreenUtil
                          Text(
                            'Profile',
                            style: GoogleFonts.poppins(
                                fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 30.w), // Adjusted with ScreenUtil
                          IconButton(
                            onPressed: () {
                             Get.to(
                                AdminProfileEdit(),
                                transition: Transition
                                    .cupertino, // Specify the transition
                                duration: Duration(
                                    milliseconds:
                                        500), // Optional: set animation duration
                              );
                            },
                            icon: Icon(
                              Iconsax.edit5, size: 30.sp,) // Adjusted with ScreenUtil
                          ),
                        ],
                      ),
                      SizedBox(height: 70.h), // Adjusted with ScreenUtil
                    CircleAvatar(
                      radius: 60.r, // Adjusted with ScreenUtil
                      backgroundImage: data['photoUrl'] != null ? NetworkImage(data['photoUrl']) :
                      AssetImage('assets/images/james.png'),
                    ),
                     SizedBox(height: 20.h), // Adjusted with ScreenUtil
                    Row(
                      children: [
                        SizedBox(width: 25.w), // Adjusted with ScreenUtil
                        Text(
                          'Name',
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
                              data['name'],
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
                          'Email',
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
                              data['email'],
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
                          'Password',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h), // Adjusted with ScreenUtil
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w), // Adjusted with ScreenUtil
                      child: TextFormField(
                        initialValue: data['password'],
                        obscureText: true,
                        decoration: InputDecoration(
                           
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: HexColor('4CA6A8')))),
                      ),
                    ),
                ],
              );
              },

            ),
          ),
        ),
      ),
    );
  }
}