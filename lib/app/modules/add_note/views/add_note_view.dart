import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({Key? key}) : super(key: key);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.addNote(),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          title(),
          desc(),
        ],
      ),
    );
  }
}
