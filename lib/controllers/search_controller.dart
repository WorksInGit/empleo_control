import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminSearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  var searchQuery = ''.obs;

  Stream<QuerySnapshot> getFilteredUsers() {
    if (searchQuery.isEmpty) {
      return FirebaseFirestore.instance
          .collection('users')
          .where('status', isEqualTo: 1)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .where('status', isEqualTo: 1)
          .where('name', isGreaterThanOrEqualTo: searchQuery.value)
          .where('name', isLessThanOrEqualTo: '${searchQuery.value}\uf8ff')
          .snapshots();
    }
  }

  Stream<QuerySnapshot> getFilteredCompanies() {
    if (searchQuery.value.isEmpty) {
      return FirebaseFirestore.instance
          .collection('companies')
          .where('status', isEqualTo: 1)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('companies')
          .where('status', isEqualTo: 1)
          .where('companyName', isGreaterThanOrEqualTo: searchQuery.value)
          .where('companyName',
              isLessThanOrEqualTo: '${searchQuery.value}\uf8ff')
          .snapshots();
    }
  }

 Stream<QuerySnapshot> getFilteredJobs() {
  if (searchQuery.value.isEmpty) {
    return FirebaseFirestore.instance
        .collection('jobs')
        .where('status', isEqualTo: 1) 
        .snapshots();
  } else {
    return FirebaseFirestore.instance
        .collection('jobs')
        .where('status', isEqualTo: 1)
        .where('jobName', isGreaterThanOrEqualTo: searchQuery.value)
        .where('jobName', isLessThanOrEqualTo: '${searchQuery.value}\uf8ff')
        .snapshots();
  }
}
  void updateSearchQuery(String query) {
    searchQuery.value = query.trim();
  }

  @override
  void onClose() {
    searchController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
