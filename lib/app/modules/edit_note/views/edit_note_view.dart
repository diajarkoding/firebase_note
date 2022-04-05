import 'package:firebase_note/app/data/models/note_model.dart';
import 'package:firebase_note/app/services/database.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  const EditNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return TextField(
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w300,
          color: Colors.grey,
        ),
        controller: controller.titleC,
        decoration: const InputDecoration.collapsed(
          hintText: 'Judul',
          hintStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
          ),
        ),
      );
    }

    Widget desc() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: TextField(
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
          ),
          controller: controller.descC,
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          decoration: const InputDecoration.collapsed(
            hintText: 'Tulis sesuatu ....',
            hintStyle: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    Widget body() {
      return FutureBuilder<NoteModel>(
        future: Database().getNoteById(Get.arguments),
        builder: (contex, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            controller.titleC.text = snapshot.data!.title;
            controller.descC.text = snapshot.data!.desc;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                title(),
                desc(),
              ],
            );
          } else {
            return const Center(
              child: Text('Tidak dapat mengambil data'),
            );
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.editNote(Get.arguments),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: body(),
    );
  }
}
