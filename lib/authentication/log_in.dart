// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/authentication/registeration.dart';
import 'package:to_do/custom/custom_button.dart';
import 'package:to_do/custom/custom_text_form_field.dart';
import 'package:to_do/models/dialog_model.dart';
import 'package:to_do/screens/home_screen.dart';
import 'package:to_do/custom/secured_pass.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});
  static const String routeName = "Log In Screen";

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isSecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "login".tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Text("welcomeback!".tr(),
                      style: Theme.of(context).textTheme.titleLarge),
                  CustomFormField(
                    label: "email".tr(),
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return ("pleaseenteryouremail".tr());
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return "pleaseentervalidemail".tr();
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomFormField(
                    obscureText: isSecured,
                    suffixIcon: const SecuredPassword(),
                    label: "password".tr(),
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return ("pleaseenterPassowrd".tr());
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomButton(label: "login".tr(), onPressed: login),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RegisterScreen.routeName, (route) => false);
                      },
                      child: Text(
                        "orCreateAccount".tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ))
                ]),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      DialogModel.showLoding(context);
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // ignore: use_build_context_synchronously
        DialogModel.hideLoading(context);
        // ignore: use_build_context_synchronously
        DialogModel.showMessage(
            context: context,
            message: "hello".tr(),
            posActionName: "ok".tr(),
            posAction: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
            });
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        DialogModel.hideLoading(context);
        DialogModel.showMessage(
            context: context,
            message: e.message!.tr(),
            title: "erorr".tr(),
            posActionName: "tryAgain".tr(),
            negActionName: "cancel".tr());
      } catch (e) {
        DialogModel.hideLoading(context);
        DialogModel.showMessage(
            context: context,
            message: e.toString().tr(),
            title: "erorr".tr(),
            posActionName: "tryAgain".tr(),
            negActionName: "cancel".tr());
      }
    }
  }
}
