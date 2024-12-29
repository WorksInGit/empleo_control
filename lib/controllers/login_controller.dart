import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empleo_control/admin_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:empleo_control/views/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> clearLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }

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
      isLoading.value = true;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        isLoading.value = false;
        await saveLoginStatus(true);

        Get.off(
          CustomDrawer(),
          transition: Transition.fadeIn, // Specify the transition
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
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'An error occurred while logging in: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> checkLoginStatus() async {
    bool loggedIn = await isUserLoggedIn();
    if (loggedIn) {
      Get.off(
        CustomDrawer(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 500),
      );
    }
  }

  Future<void> logout() async {
    await clearLoginStatus();
    Get.offAll(AdminLogin());
  }
}
