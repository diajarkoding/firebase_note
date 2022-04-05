import 'package:firebase_note/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/constans/constan.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget emailInput() {
      return TextField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        controller: controller.emailC,
        decoration: const InputDecoration(
            labelText: 'Email', border: OutlineInputBorder()),
      );
    }

    Widget nameInput() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: TextField(
          autocorrect: false,
          controller: controller.nameC,
          decoration: const InputDecoration(
              labelText: 'Nama', border: OutlineInputBorder()),
        ),
      );
    }

    Widget phoneInput() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: TextField(
          autocorrect: false,
          keyboardType: TextInputType.phone,
          controller: controller.phoneC,
          decoration: const InputDecoration(
              labelText: 'Telepon', border: OutlineInputBorder()),
        ),
      );
    }

    Widget passwordInput() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(
          () => TextField(
            autocorrect: false,
            obscureText: isHidden.value,
            controller: controller.passC,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () => isHidden.toggle(),
                icon: isHidden.isTrue
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(
                        Icons.remove_red_eye,
                        color: Colors.blue,
                      ),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      );
    }

    Widget registerButton() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(
          () => ElevatedButton(
            onPressed: () {
              if (isLoading.isFalse) {
                controller.register();
              }
            },
            child: Text(isLoading.isFalse ? 'Daftar' : 'Loading ..'),
          ),
        ),
      );
    }

    Widget dividerLine() {
      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          children: const [
            Expanded(
              child: Divider(
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'atau',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
              ),
            ),
          ],
        ),
      );
    }

    Widget loginOption() {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sudah punya akun ?'),
            TextButton(
              onPressed: () => Get.toNamed(Routes.LOGIN),
              child: const Text('Masuk'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          emailInput(),
          nameInput(),
          phoneInput(),
          passwordInput(),
          registerButton(),
          dividerLine(),
          loginOption()
        ],
      ),
    );
  }
}
