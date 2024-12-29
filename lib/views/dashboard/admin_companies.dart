import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo_control/controllers/search_controller.dart';
import 'package:empleo_control/views/dashboard/admin_company_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminCompanies extends StatelessWidget {
  AdminCompanies({super.key});

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
            title: Text(
              'Companies',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: controller.searchController,
                  focusNode: controller.focusNode,
                  onChanged: controller.updateSearchQuery,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(
                        color: HexColor('4CA6A8'),
                      ),
                    ),
                    label: Text(
                      'Search here',
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() => AdminAcceptedCompanies(
                      stream: controller.getFilteredCompanies(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminAcceptedCompanies extends StatelessWidget {
  final Stream<QuerySnapshot> stream;

  const AdminAcceptedCompanies({super.key, required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No approved companies found',
              style: GoogleFonts.poppins(
                  fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          );
        }

        final companies = snapshot.data!.docs;

        return ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, index) {
            final company = companies[index];
            final companyName = company['companyName'] ?? 'N/A';
            final companyLocation = company['location'] ?? 'N/A';
            final companyType = company['industry'] ?? 'N/A';
            final companyLogo = company['photoUrl'] ?? '';

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                onTap: () {
                  Get.to(
                    AdminCompanyProfile(companyId: company.id),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: companyLogo.isNotEmpty
                      ? NetworkImage(companyLogo)
                      : const AssetImage('assets/icons/default_company.png')
                          as ImageProvider,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      companyLocation,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                trailing: Text(
                  companyType,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
