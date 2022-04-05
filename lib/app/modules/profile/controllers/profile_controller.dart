import 'dart:io';
import 'package:firebase_note/app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../routes/app_pages.dart';
import '../../../services/database.dart';
import '../../../utils/constans/constan.dart';

class ProfileController extends GetxController {
  TextEditingController emailC = TextEditingController(text: '');

  TextEditingController passC = TextEditingController(text: '');

  TextEditingController nameC = TextEditingController(text: '');

  TextEditingController phoneC = TextEditingController(text: '');

  XFile? image;

  // FirebaseAuth auth = FirebaseAuth.instance;

  // RxBool isLoading = false.obs;

  // RxBool isHidden = true.obs;

  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      // Get.snackbar('ERROR', 'Tidak dapat logout');
      errorMsg('Tidak dapat logout');
      // print(e);
    }
  }

  Future<UserModel?> getDataUser() async {
    try {
      UserModel? user = await Database().getUserById(auth.currentUser!.uid);
      return user;
    } catch (e) {
      // print(e);
      // Get.snackbar('ERROR', 'Tidak dapat mengambil data');
      errorMsg('Tidak dapat mengambil data');
      rethrow;
    }
  }

  // Stream data user
  Stream<UserModel?> fetchUser() {
    try {
      var snapshot = Database().streamDataUser(auth.currentUser!.uid);
      return snapshot;
    } catch (e) {
      print(e);
      errorMsg(e.toString());
      rethrow;
    }
  }

  Future<void> editProfile() async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        phoneC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        await Database()
            .updateUser(auth.currentUser!.uid, nameC.text, phoneC.text);

        if (image != null) {
          String ext = image!.name.split('.').last;
          await firebaseStorage
              .ref(auth.currentUser!.uid)
              .child('profile.$ext')
              .putFile(
                File(image!.path),
              );

          String imageUrl = await firebaseStorage
              .ref(auth.currentUser!.uid)
              .child('profile.$ext')
              .getDownloadURL();

          await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .update({'imageUrl': imageUrl});
        }

        if (passC.text.isNotEmpty) {
          await auth.currentUser!.updatePassword(passC.text);
          await logout();

          isLoading.value = false;

          Get.offAndToNamed(Routes.LOGIN);
        } else {
          isLoading.value = false;
        }
        isLoading.value = false;
        // Get.snackbar('BERHASIL', 'Profile telah di update');
        Get.back();
        successMsg('Profile telah di update');
      } catch (e) {
        isLoading.value = false;
        // print(e);
        // Get.snackbar('ERROR', 'Tidak dapat mengupdate data');
        errorMsg('Tidak dapat mengupdate data');
        rethrow;
      }
    } else {
      // Get.snackbar('ERROR', 'Data diri tidak boleh kosong');
      errorMsg('Data diri tidak boleh kosong');
    }
  }

  void imagePicker() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      update();
    }
  }

  void resetImage() {
    image = null;

    update();
  }

  void clearImage() async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'imageUrl': ''});
      update();
    } catch (e) {
      errorMsg('Tidak dapat menclear image');
    }
  }
}
