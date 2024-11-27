import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminDenied extends StatelessWidget {
  const AdminDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text('Denied', style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
            centerTitle: true,
          ),
          body: Column(
            children: [
              TabBar(
                 dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                    color: HexColor('4CA6A8'),
                    borderRadius: BorderRadius.circular(15.r)),
                labelStyle: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.bold),
                tabs: [
                Container(
                      width: 250.w,
                      child: Tab(
                        text: 'Users',
                      )),
                  Container(
                      width: 250.w,
                      child: Tab(
                        text: 'Companies',
                      )),
                  Container(
                      width: 250.w,
                      child: Tab(
                        text: 'Jobs',
                      )),
              ]),
              Expanded(child: TabBarView(children: [
                UserDenied(),
                CompaniesDenied(),
                JobsDenied()
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
class UserDenied extends StatelessWidget {
  const UserDenied({super.key});

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
              backgroundImage: AssetImage('assets/images/john.png'),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text('Adam', style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                Text('CS',style: GoogleFonts.poppins(fontWeight: FontWeight.w300),)
              ],
            ),
            trailing: Text('USA'),
          ),
        );
      },
    );
  }
}
class CompaniesDenied extends StatelessWidget {
  const CompaniesDenied({super.key});

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
class JobsDenied extends StatelessWidget {
  const JobsDenied({super.key});

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