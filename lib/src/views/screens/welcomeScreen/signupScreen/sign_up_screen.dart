import 'package:bcrypt/bcrypt.dart';
import 'package:blogger_app/core/routes/app_route_constants.dart';
import 'package:blogger_app/core/themes/themes.dart';
import 'package:blogger_app/src/controllers/auth_controller/auth_controller.dart';
import 'package:blogger_app/src/controllers/sign_up_controller/sign_up_controller.dart';
import 'package:blogger_app/src/models/UserModel/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nanoid/async.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final signUpController = Get.find<SignUpController>();
  final authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Let's Create Your Account!",
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/singup.png',
                    height: 190,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            onChanged: (value) =>
                                signUpController.checkUsername(
                                    signUpController.name.text.trim()),
                            controller: signUpController.name,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: signUpController
                                                .validUsername.value ==
                                            true
                                        ? const BorderSide(color: Colors.white)
                                        : const BorderSide(color: Colors.red)),
                                label: const Text("Username"),
                                prefixIcon:
                                    const Icon(Icons.person_2_outlined)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (value) => signUpController
                                .checkEmail(signUpController.email.text.trim()),
                            controller: signUpController.email,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: signUpController
                                                .validEmail.value ==
                                            true
                                        ? const BorderSide(color: Colors.white)
                                        : const BorderSide(color: Colors.red)),
                                label: const Text("Email"),
                                prefixIcon: const Icon(Icons.email_outlined)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (value) => signUpController.checkPhoneNo(
                                signUpController.phoneNo.text.trim()),
                            controller: signUpController.phoneNo,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: signUpController
                                                .validPhoneNo.value ==
                                            true
                                        ? const BorderSide(color: Colors.white)
                                        : const BorderSide(color: Colors.red)),
                                label: const Text("phone no"),
                                prefixIcon:
                                    const Icon(Icons.phone_android_rounded)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (value) => signUpController.checkPass(
                                signUpController.password.text.trim()),
                            controller: signUpController.password,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: signUpController
                                                .validPass.value ==
                                            true
                                        ? const BorderSide(color: Colors.white)
                                        : const BorderSide(color: Colors.red)),
                                label: const Text("password"),
                                prefixIcon:
                                    const Icon(Icons.fingerprint_outlined)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            if (authController.isLoading.value) {
                              return Center(
                                child: LoadingAnimationWidget.fourRotatingDots(
                                    color: ThemeColor.blackBasic, size: 30),
                              );
                            }
                            return TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.black),
                                onPressed: () async {
                                  await authController
                                      .createUserWithEmailAndPass(context);
                                },
                                child: const Text(
                                  "Signup",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ));
                          }),
                          TextButton(
                              onPressed: () =>
                                  context.pushNamed(AppRouteConsts.signIn),
                              child: const Text(
                                "Already have an account?",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              )),
                          const Divider(
                            height: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("SigUp In With Google",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300)),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  await authController.googleLoin();
                                  if (authController.googleAccount.value !=
                                      null) {
                                    // ignore: use_build_context_synchronously
                                    context.goNamed(AppRouteConsts.home);
                                  } else {}
                                },
                                child: Image.asset(
                                  'assets/images/googleicons.png',
                                  height: 40,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
