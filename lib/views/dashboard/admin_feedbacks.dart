import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo_control/controllers/feedback_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AdminFeedbackPage extends StatelessWidget {
  UserFeedbackController controller = Get.put(UserFeedbackController());

  @override
  Widget build(BuildContext context) {
    controller.fetchFeedbacks();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: HexColor('4CA6A8'),
          title: Text('User Feedbacks', style: GoogleFonts.poppins()),
          centerTitle: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: Obx(() {
          if (controller.feedbacks.isEmpty) {
            return const Center(child: Text('No Feedbacks from the users !'));
          }

          return ListView.builder(
            itemCount: controller.feedbacks.length,
            itemBuilder: (context, index) {
              var feedback = controller.feedbacks[index];

              return FeedbackCard(feedback: feedback);
            },
          );
        }),
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final Map<String, dynamic> feedback;

  const FeedbackCard({Key? key, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String emojiFeedbackLabel = '';
    switch (feedback['emoji']) {
      case '🥴':
        emojiFeedbackLabel = 'Unsatisfactory';
        break;
      case '😐':
        emojiFeedbackLabel = 'Fair';
        break;
      case '🤩':
        emojiFeedbackLabel = 'Excellent';
        break;
      default:
        emojiFeedbackLabel = 'Fair';
        break;
    }
    return Card(
      color: Colors.white,
      margin:  EdgeInsets.all(12.r),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
    CircleAvatar(
  backgroundColor: Colors.transparent,
  radius: 30,
  backgroundImage: (feedback['profileUrl'] != null && feedback['profileUrl'].isNotEmpty) 
      ? NetworkImage(feedback['profileUrl']) 
      : const AssetImage('assets/icons/person.png') as ImageProvider,
),        const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feedback['userName'] ?? 'Anonymous',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    feedback['feedbackText'] ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        feedback['emoji'] ?? '😐',
                        style: const TextStyle(fontSize: 24), // Emoji size
                      ),
                      const SizedBox(width: 6),
                      Text(
                        emojiFeedbackLabel, // Display appropriate feedback label
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Submitted on: ${DateFormat('MMM d, yyyy h:mm a').format(feedback['createdAt'] is Timestamp ? feedback['createdAt'].toDate() : feedback['createdAt'])}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
