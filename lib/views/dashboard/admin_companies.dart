import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo_control/views/dashboard/admin_company_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCompanies extends StatelessWidget {
  const AdminCompanies({super.key});

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
                  decoration: InputDecoration(
                    label: const Text('Search here'),
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                ),
              ),
              const Expanded(child: AdminAcceptedCompanies())
            ],
          ),
        ),
      ),
    );
  }
}

class AdminAcceptedCompanies extends StatelessWidget {
  const AdminAcceptedCompanies({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('companies') // Replace with your collection name
          .where('status', isEqualTo: 1) // Filter for approved companies
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No approved companies found',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
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
            final companyLogo =
                company['photoUrl'] ?? ''; // Assuming logo is a URL

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                onTap: () {
                  Get.to(
                    AdminCompanyProfile(companyId: company.id),
                    transition: Transition.cupertino,
                    duration: Duration(milliseconds: 500),
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
