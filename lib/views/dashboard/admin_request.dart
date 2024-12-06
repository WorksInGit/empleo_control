import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo_control/views/dashboard/admin_request_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminRequest extends StatelessWidget {
  const AdminRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Requests',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('companies')
              .where('status', isEqualTo: 0)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: HexColor('4CA6A8'),
              ));
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading requests.',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No requests available.',
                  style: TextStyle(fontSize: 18.sp),
                ),
              );
            }
            var requests = snapshot.data!.docs;
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                var request = requests[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: ListTile(
                    onTap: () {
                      Get.to(() => AdminRequestProfile(), arguments: {
                        'companyData': request,
                        'docId': requests[index].id
                      });
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: request['photoUrl'] != null
                          ? NetworkImage(request['photoUrl'])
                          : AssetImage('assets/icons/default_company.png')
                              as ImageProvider,
                    ),
                    title: Text(
                      request['companyName'] ?? 'Unnamed Company',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    subtitle: Text(
                      request['location'] ?? 'Location not specified',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300, fontSize: 14),
                    ),
                    trailing: Text(
                      request['industry'] ?? 'Industry unknown',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
