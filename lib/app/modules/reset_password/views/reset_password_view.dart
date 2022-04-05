import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/constans/constan.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

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

    Widget resetPassButton() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(() => ElevatedButton(
              onPressed: () {
                if (isLoading.isFalse) {
                  controller.reset();
                }
              },
              child: Text(isLoading.isFalse ? 'Kirim' : 'Loading ..'),
            )),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lupa Password'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            emailInput(),
            resetPassButton(),
          ],
        ));
  }
}
