import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/database.dart';
import '../../../utils/constans/constan.dart';

class LoginController extends GetxController {
  final RxBool rememberMe = false.obs;

  final TextEditingController emailC = TextEditingController(text: '');

  final TextEditingController passC = TextEditingController(text: '');

  // FirebaseAuth auth = FirebaseAuth.instance;

  // final box = GetStorage();

  // void errMsg(String msg) {
  //   Get.snackbar('ERROR', msg);
  // }

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        isLoading.value = true;

        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);

        await Database().getUserById(userCredential.user!.uid);

        isLoading.value = false;
        if (userCredential.user!.emailVerified == true) {
          if (box.read('rememberme') != null) {
            await box.remove('rememberme');
          }
          if (rememberMe.isTrue) {
            await box.write(
              'rememberme',
              {'email': emailC.text, 'pass': passC.text},
            );
          }
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.defaultDialog(
            title: 'Email Belum Di Verifikasi',
            middleText: 'Apakah anda ingin mengirim ulang email verifikasi ?',
            actions: [
              OutlinedButton(
                onPressed: () => Get.back(),
                child: const Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await userCredential.user!.sendEmailVerification();
                    Get.back();
                    successMsg('Kami telah mengirim ulang email verifikasi');
                  } catch (e) {
                    Get.back();
                    errorMsg(
                        'Tunggu beberapa saat lagi untuk kirim ulang email verifikasi');

                    // print(e);
                  }
                },
                child: const Text('Ya'),
              ),
            ],
          );
        }
        // print(userCredential);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        // print(e.code);
        errorMsg(e.code);
      }
    } else {
      errorMsg('Email & Password harus di isi');
    }
  }
}
