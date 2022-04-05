import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note/app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/constans/constan.dart';

class RegisterController extends GetxController {
  TextEditingController emailC = TextEditingController(text: '');

  TextEditingController passC = TextEditingController(text: '');

  TextEditingController nameC = TextEditingController(text: '');

  TextEditingController phoneC = TextEditingController(text: '');

  // FirebaseAuth auth = FirebaseAuth.instance;

  void register() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: passC.text);

        // print(userCredential);

        isLoading.value = false;

        await userCredential.user!.sendEmailVerification();

        UserModel user = UserModel(
          id: userCredential.user!.uid,
          name: nameC.text,
          phone: phoneC.text,
          email: emailC.text,
          createdAt: DateTime.now().toIso8601String(),
        );

        await Database().setUser(user);

        // Get.snackbar('BERHASIL', 'Cek email untuk di verifikasi');
        successMsg('Cek email untuk di verifikasi');

        Get.offAllNamed(Routes.LOGIN);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        errorMsg(e.code);
        // print(e.code);
      } catch (e) {
        errorMsg('$e');
        // print(e);
      }
    } else {
      errorMsg('Email & Password harus di isi');
    }
  }
}
