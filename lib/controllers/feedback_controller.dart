import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserFeedbackController extends GetxController {
  var feedbacks = <Map<String, dynamic>>[].obs; // List of maps to store feedbacks

  void fetchFeedbacks() async {
    try {
      var feedbackData = await FirebaseFirestore.instance
          .collection('feedbacks')
          .orderBy('createdAt', descending: true)
          .get();

      feedbacks.value = feedbackData.docs.map((doc) {
        return {
          'userName': doc['userName'] ?? 'Anonymous',
          'profileUrl': doc['profileUrl'] ?? '',
          'feedbackText': doc['feedbackText'] ?? '',
          'emoji': doc['emoji'] ?? '😐',
          'createdAt': (doc['createdAt'] as Timestamp).toDate(),
        };
      }).toList();
    } catch (e) {
      print('Error fetching feedbacks: $e');
    }
  }
}