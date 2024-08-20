// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/authentication/log_in.dart';
import 'package:to_do/custom/custom_button.dart';
import 'package:to_do/custom/custom_text_form_field.dart';
import 'package:to_do/models/dialog_model.dart';
import 'package:to_do/custom/secured_pass.dart';

var formKey = GlobalKey<FormState>();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  bool isSecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "creatyourAccount".tr(),
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
                CustomFormField(
                  label: "userName".tr(),
                  controller: userName,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return ("pleaseenterusername".tr());
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  label: "email".tr(),
                  controller: email,
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
                  label: "password".tr(),
                  suffixIcon: const SecuredPassword(),
                  controller: password,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return ("pleaseenterPassowrd".tr());
                    }
                    if (text.length < 8) {
                      return "passwordmustbe8digit".tr();
                    }

                    return null;
                  },
                ),
                CustomFormField(
                  suffixIcon: const SecuredPassword(),
                  label: "confirmPassword".tr(),
                  controller: confirmPassword,
                  obscureText: isSecured,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return ("pleaseenterconfirmpassword".tr());
                    }
                    if (text != password.text) {
                      return "confirmpassworddoesn`tmatchpassward ".tr();
                    }
                    return null;
                  },
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomButton(
                        label: "createAccount".tr(), onPressed: register))
              ],
            ),
          ),
        ),
      ),
    );
  }

// Registeration........
  void register() async {
    if (formKey.currentState?.validate() == true) {
      DialogModel.showLoding(context);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        // ignore: use_build_context_synchronously
        DialogModel.hideLoading(context);
        DialogModel.showMessage(
            context: context,
            message: "registersuccessefuly.".tr(),
            posActionName: "ok".tr(),
            posAction: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, LogInScreen.routeName, (route) => false);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogModel.hideLoading(context);
          DialogModel.showMessage(
              context: context,
              message: "thepasswordprovidedistooweak.".tr(),
              title: "erorr".tr(),
              posActionName: "tryAgain".tr(),
              negActionName: "cancel".tr());
        } else if (e.code == 'email-already-in-use') {
          DialogModel.hideLoading(context);
          DialogModel.showMessage(
              context: context,
              message: "theaccountalreadyexistsforthatemail.".tr(),
              title: "erorr".tr(),
              posActionName: "tryAgain".tr(),
              negActionName: "cancel".tr());
        }
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
