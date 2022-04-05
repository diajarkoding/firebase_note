import 'package:firebase_note/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utils/constans/constan.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    if (box.read('rememberme') != null) {
      controller.emailC.text = box.read('rememberme')['email'];
      controller.passC.text = box.read('rememberme')['pass'];
      controller.rememberMe.value = true;
    }

    Widget emailInput() {
      return TextField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        controller: controller.emailC,
        decoration: const InputDecoration(
            labelText: 'Email', border: OutlineInputBorder()),
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

    Widget rememberMe() {
      return Obx(
        () => CheckboxListTile(
          value: controller.rememberMe.value,
          onChanged: (_) => controller.rememberMe.toggle(),
          title: const Text('Simpan akun'),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );
    }

    Widget forgotPassword() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
            child: const Text('Lupa Password ?'),
          ),
        ],
      );
    }

    Widget loginButton() {
      return Obx(
        () => SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (isLoading.isFalse) {
                controller.login();
              }
            },
            child: Text(isLoading.isFalse ? 'Masuk' : 'Loading ..'),
          ),
        ),
      );
    }

    Widget passAndLogin() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [forgotPassword(), loginButton()],
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

    Widget registerOption() {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Belum punya akun ?'),
            TextButton(
              onPressed: () => Get.toNamed(Routes.REGISTER),
              child: const Text('Datar disini'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          emailInput(),
          passwordInput(),
          rememberMe(),
          passAndLogin(),
          dividerLine(),
          registerOption()
        ],
      ),
    );
  }
}
