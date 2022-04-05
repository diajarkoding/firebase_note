import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final box = GetStorage();

// final CollectionReference userRef =
//     FirebaseFirestore.instance.collection('users');

FirebaseFirestore firestore = FirebaseFirestore.instance;

final FirebaseAuth auth = FirebaseAuth.instance;

final firebase_storage.FirebaseStorage firebaseStorage =
    firebase_storage.FirebaseStorage.instance;

final RxBool isLoading = false.obs;

final RxBool isHidden = true.obs;

final RxBool rememberMe = false.obs;

void errorMsg(String msg) {
  Get.snackbar('ERROR', msg);
}

void successMsg(String msg) {
  Get.snackbar('BERHASIL', msg);
}
