// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:firebase_note/app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/constans/constan.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget emailInput() {
      return TextField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        controller: controller.emailC,
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
      );
    }

    Widget nameInput() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: TextField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          controller: controller.nameC,
          decoration: const InputDecoration(
            labelText: 'Nama',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget phoneInput() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: TextField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          controller: controller.phoneC,
          decoration: const InputDecoration(
            labelText: 'Telepon',
            border: OutlineInputBorder(),
          ),
        ),
      );
    }

    Widget passInput() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(
          () => TextField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            controller: controller.passC,
            obscureText: isHidden.value,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  isHidden.toggle();
                },
                icon: isHidden.isTrue
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(
                        Icons.remove_red_eye,
                        color: Colors.blue,
                      ),
              ),
            ),
          ),
        ),
      );
    }

    Widget createdAt(String time) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Created At : ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              DateFormat.yMMMEd().add_jms().format(
                    DateTime.parse(time),
                  ),
            ),
          ],
        ),
      );
    }

    Widget imageProfile(String image) {
      return GetBuilder<ProfileController>(
        builder: (c) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              c.image != null
                  ? Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 20,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(
                                  File(c.image!.path),
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        TextButton(
                            onPressed: () => c.resetImage(),
                            child: const Text('Hapus'))
                      ],
                    )
                  : image.isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.only(
                                top: 20,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      image,
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            TextButton(
                                onPressed: () => c.clearImage(),
                                child: const Text('clear'))
                          ],
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 20,
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/person.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
              TextButton(
                onPressed: () => c.imagePicker(),
                child: const Text('choose'),
              ),
            ],
          );
        },
      );
    }

    Widget updateButton() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(
          () => ElevatedButton(
            onPressed: () {
              if (isLoading.isFalse) {
                controller.editProfile();
              }
            },
            child: Text(isLoading.isFalse ? 'Simpan' : 'Loading ...'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder<UserModel?>(
        stream: controller.fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          UserModel? user = snapshot.data;

          controller.emailC.text = user!.email;
          controller.nameC.text = user.name;
          controller.phoneC.text = user.phone;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              emailInput(),
              nameInput(),
              phoneInput(),
              passInput(),
              createdAt(
                user.createdAt,
              ),
              imageProfile(user.imageUrl!),
              updateButton(),
            ],
          );
        },
      ),
    );
  }
}
