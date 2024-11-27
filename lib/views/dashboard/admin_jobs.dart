import 'package:empleo_control/views/dashboard/admin_company_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AdminJobs extends StatelessWidget {
  const AdminJobs({super.key});

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
              'Jobs'
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
              Expanded(child: AdminAcceptedJobs())
            ],
          ),
        ),
      ),
    );
  }
}
class AdminAcceptedJobs extends StatelessWidget {
  const AdminAcceptedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            onTap: () {
              
            },
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/icons/google.png'),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  children: [
                    Text('Product Designer', style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                    SizedBox(
                      width: 60.w,
                    ),
                    Row(
                      children: [
                        Icon(Icons.currency_rupee_sharp, size: 17,),
                        Text('20000/M', style: GoogleFonts.poppins(fontSize: 10),)
                      ],
                    )
                  ],
                ),
                Text('Full Time',style: GoogleFonts.poppins(fontWeight: FontWeight.w300),)
              ],
            ),
            
          ),
        );
      },
    );
  }
}