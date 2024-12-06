import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardController extends GetxController {
  
  var usersCount = 0.obs;
  var jobsCount = 0.obs;
  var companiesCount = 0.obs;

  // Method to fetch data from backend
  Future<void> fetchData() async {
    // Simulate an API call
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    usersCount.value = 120; // Replace with actual API response
    jobsCount.value = 34;
    companiesCount.value = 12;
  }

  @override
  void onInit() {
    super.onInit();
    fetchData(); // Fetch data when the controller is initialized

  }
  Future<void> check() async {
    await FirebaseFirestore.instance.collection('admin').add({
      'Name': 'Google',
    });
  }

}
