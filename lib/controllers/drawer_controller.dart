import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawerController extends GetxController {
  var isDrawerOpen = false.obs;
  

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }


  void closeDrawer() {
    isDrawerOpen.value = false;
  }
}