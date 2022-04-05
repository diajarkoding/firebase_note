import 'package:firebase_note/app/services/database.dart';
import 'package:firebase_note/app/utils/constans/constan.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditNoteController extends GetxController {
  final TextEditingController titleC = TextEditingController(text: '');
  final TextEditingController descC = TextEditingController(text: '');

  Future<void> editNote(String id) async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      try {
        await Database()
            .updateNote(auth.currentUser!.uid, titleC.text, descC.text);

        Get.back();
      } catch (e) {
        print(e);
        errorMsg('Tidak dapat mengedit note');
      }
    } else {
      errorMsg('Judul dan deskripsi harus di isi');
    }
  }
}
