import 'package:empleo_control/views/dashboard/admin_company_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
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
              Get.to(() => ApplyPage());
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


class ApplyPage extends StatelessWidget {
  const ApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                SizedBox(height: 100.h),
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/google.png'),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Product Lead Manager',
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Google -',
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                    Icon(Iconsax.location5, size: 16.sp),
                    Text(
                      'Anderi, Mumbai',
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.clock5, size: 16.sp),
                    SizedBox(width: 5.w),
                    Text(
                      'Full Time',
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                    SizedBox(width: 10.w),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee_sharp,
                          size: 15.sp,
                        ),
                        Text('1200/m', style: GoogleFonts.poppins(fontSize: 14.sp))
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                TabBar(
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: HexColor('4CA6A8'),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    SizedBox(
                      width: 250.w,
                      child: Tab(text: 'Description'),
                    ),
                    SizedBox(
                      width: 250.w,
                      child: Tab(text: 'Company'),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Description(),
                      AboutCompany(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Iconsax.call5, size: 35.sp, color: Colors.black,)),
                        Text('CONTACT', style: GoogleFonts.poppins(fontWeight: FontWeight.w700),)
                      ],
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    Column(
                      children: [
                        IconButton(onPressed: () {
                        
                        }, icon: Icon(Icons.work_off_rounded, size: 35.sp, color: Colors.black,)),
                        Text('DENY', style: GoogleFonts.poppins(fontWeight: FontWeight.w700),)
                      ],
                    )
                  ],
                ),
               
              ],
            ),
          ),
          
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(7.w),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    'Qualification :',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
            _buildListItem('Exceptional communication skill and team'),
            _buildListItem('working skill'),
            _buildListItem('Exceptional communication skill and team'),
            _buildListItem('working skill'),
            _buildListItem('Exceptional communication skill and team'),
            _buildListItem('working skill'),
            
           
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        children: [
          SizedBox(width: 20.w),
          Icon(
            Icons.circle,
            size: 13.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutCompany extends StatelessWidget {
  const AboutCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'About',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Google is a multinational company in the silicon valley of '
                'California and one of the leading companies in the technology industry.',
                style: GoogleFonts.poppins(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
