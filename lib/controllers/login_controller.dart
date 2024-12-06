import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:empleo_control/views/custom_drawer.dart';

class LoginController extends GetxController {
  // Controllers for email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Loading state
  RxBool isLoading = false.obs;

  // Login method
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both email and password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      // Set loading state to true
      isLoading.value = true;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Successful login
        isLoading.value = false; // Stop loading
        Get.off(
          CustomDrawer(),
          transition: Transition.cupertino, // Specify the transition
          duration:
              Duration(milliseconds: 500), // Optional: set animation duration
        );
      } else {
        // Invalid credentials
        isLoading.value = false; // Stop loading
        Get.snackbar(
          'Login Failed',
          'Invalid email or password',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      isLoading.value = false; // Stop loading
      Get.snackbar(
        'Error',
        'An error occurred while logging in: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}