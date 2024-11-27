import 'package:empleo_control/views/dashboard/admin_request_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminRequest extends StatelessWidget {
  const AdminRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Request',
              style: GoogleFonts.poppins(
                  fontSize: 25.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      Get.to(() => AdminRequestProfile());
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/icons/google.png'),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Google'),
                        Text(
                          'Andheri, Mumbai',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300, fontSize: 15),
                        )
                      ],
                    ),
                    trailing: Text('Software'),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
