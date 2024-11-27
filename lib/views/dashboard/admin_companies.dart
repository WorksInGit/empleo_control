import 'package:empleo_control/views/dashboard/admin_company_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

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
              'Companies'
            ),
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
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              Expanded(child: AdminAcceptedCompanies())
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
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            onTap: () {
              Get.to(() => AdminCompanyProfile());
            },
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/icons/google.png'),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text('Google', style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                Text('Andheri, Mumbai',style: GoogleFonts.poppins(fontWeight: FontWeight.w300),)
              ],
            ),
            trailing: Text('IT'),
          ),
        );
      },
    );
  }
}