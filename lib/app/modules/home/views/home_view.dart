import 'package:firebase_note/app/data/models/note_model.dart';
import 'package:firebase_note/app/data/models/user_model.dart';
import 'package:firebase_note/app/routes/app_pages.dart';
import 'package:firebase_note/app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constans/constan.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          StreamBuilder<UserModel?>(
            stream: controller.fetchUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[400],
                  ),
                );
              }
              if (snapshot.hasData) {
                UserModel? data = snapshot.data;
                var name = data!.name;
                return GestureDetector(
                  onTap: () => Get.toNamed(Routes.PROFILE),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[400],
                    backgroundImage: NetworkImage(data.imageUrl!.isNotEmpty
                        ? data.imageUrl!
                        : 'https://ui-avatars.com/api/?name=$name'),
                  ),
                );
              }
              return const Center(
                child: SizedBox(),
              );
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      );
    }

    Widget body() {
      return StreamBuilder<List<NoteModel>>(
        stream: controller.fetchListNote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var judul = snapshot.data![index].title;
                var isi = snapshot.data![index].desc;
                var docId = snapshot.data![index].id;
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(judul),
                  subtitle: Text(isi),
                  trailing: IconButton(
                    onPressed: () {
                      controller.deleteNote(docId);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: () => Get.toNamed(Routes.EDIT_NOTE, arguments: docId),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Tidak ada data'),
            );
          }
        },
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_NOTE),
        child: const Icon(Icons.add),
      ),
    );
  }
}
