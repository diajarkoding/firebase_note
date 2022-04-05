import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/constans/constan.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();
  // RxBool isLoading = false.obs;

  // FirebaseAuth auth = FirebaseAuth.instance;

  // void errMsg(String msg) {
  //   Get.snackbar('ERROR', msg);
  // }

  void reset() async {
    if (emailC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        await auth.sendPasswordResetEmail(email: emailC.text);
        isLoading.value = false;
        // Get.snackbar('BERHASIL', 'Permintaan reset pasword telah dikirim');
        successMsg('Permintaan reset pasword telah dikirim');
        Get.back();
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        errorMsg('$e');
      } catch (e) {
        isLoading.value = false;
        errorMsg('Tidak dapat reset password ke email ini');
      }
    } else {
      errorMsg('Email harus di isi');
    }
  }
}
