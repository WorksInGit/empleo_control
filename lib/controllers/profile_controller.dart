import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final name = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final photoUrl = ''.obs;

  final isLoading = false.obs;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> loadProfileData() async {
    isLoading.value = true;
    try {
      var snapshot = await FirebaseFirestore.instance.collection('admin').get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data();
        name.value = data['name'];
        email.value = data['email'];
        password.value = data['password'];
        photoUrl.value = data['photoUrl'] ?? '';
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load profile data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProfileData() async {
    isLoading.value = true;
    try {
      var snapshot = await FirebaseFirestore.instance.collection('admin').get();
      if (snapshot.docs.isNotEmpty) {
        var id = snapshot.docs.first.id;
        await FirebaseFirestore.instance.collection('admin').doc(id).update({
          'name': name.value,
          'email': email.value,
          'password': password.value,
          'photoUrl': photoUrl.value,
        });
        Get.snackbar("Success", "Profile updated successfully");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to save profile data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> pickPhoto() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return '';
    File file = File(image.path);
    return await _uploadPhoto(file);
  }

  Future<String> _uploadPhoto(File file) async {
    isLoading.value = true;
    try {
      String fileName =
          'admin_photos/${DateTime.now().millisecondsSinceEpoch}.jpg';
      var ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      Get.snackbar("Error", "Failed to upload photo: $e");
      return '';
    } finally {
      isLoading.value = false;
    }
  }
}
