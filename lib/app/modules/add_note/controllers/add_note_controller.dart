import 'package:firebase_note/app/data/models/note_model.dart';
import 'package:firebase_note/app/services/database.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../utils/constans/constan.dart';

class AddNoteController extends GetxController {
  final TextEditingController titleC = TextEditingController(text: '');
  final TextEditingController descC = TextEditingController(text: '');

  void addNote() async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      try {
        NoteModel note = NoteModel(
          id: auth.currentUser!.uid,
          title: titleC.text,
          desc: descC.text,
          createdAt: DateTime.now().toIso8601String(),
        );

        await Database().setNote(note);

        // Get.snackbar('BERHASIL', 'Catatan ditambahkan');

        Get.back();
      } catch (e) {
        // print(e);
        // Get.snackbar('ERROR', 'Tidak dapat menambah catatan');
        errorMsg('Tidak dapat menambah catatan');
      }
    } else {
      // Get.snackbar('ERROR', 'Judul dan deskripsi harus di isi');
      errorMsg('Judul dan deskripsi harus di isi');
    }
  }
}
