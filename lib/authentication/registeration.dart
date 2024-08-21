// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/authentication/auth.dart';
import 'package:to_do/authentication/log_in.dart';
import 'package:to_do/custom/custom_button.dart';
import 'package:to_do/custom/custom_text_form_field.dart';
import 'package:to_do/provider/user_provider.dart';
import 'package:to_do/themeing/my_theme_data.dart';

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
    userProvider = Provider.of<UserProvider>(context);
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
                  suffixIcon: securedPass(),
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
                  suffixIcon: securedPass(),
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
      RegisterUser.register(
          context: context,
          email: email.text,
          password: password.text,
          userName: userName.text);
    }
  }

  Widget securedPass() {
    return IconButton(
        onPressed: () {
          isSecured = !isSecured;
          setState(() {});
        },
        icon: isSecured
            ? Icon(
                Icons.visibility_off,
                color: MyThemeData.secondaryColor,
              )
            : Icon(
                Icons.visibility,
                color: MyThemeData.secondaryColor,
              ));
  }
}
