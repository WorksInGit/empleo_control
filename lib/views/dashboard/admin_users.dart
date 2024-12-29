import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminUsers extends StatelessWidget {
  const AdminUsers({super.key});

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
            title: const Text('Users'),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                child: const TextField(
                  decoration: InputDecoration(
                      label: Text('Search here'),
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              const Expanded(child: AdminAcceptedUsers())
            ],
          ),
        ),
      ),
    );
  }
}

class AdminAcceptedUsers extends StatelessWidget {
  const AdminAcceptedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('status', isEqualTo: 1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching user data.'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No users found.'),
          );
        }

        final users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index].data() as Map<String, dynamic>;
            final userName = user['name'] ?? 'Unknown';
            final department = user['qualification'] ?? 'N/A';
            final location = user['location'] ?? 'N/A';
            final profilePic = user['photoUrl'];

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: profilePic != '' ?
                       NetworkImage(profilePic)
                      : const AssetImage('assets/icons/person.png') as ImageProvider,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      department,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300, fontSize: 13.sp),
                    ),
                  ],
                ),
                trailing: Text(
                  location,
                  style: GoogleFonts.poppins(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
