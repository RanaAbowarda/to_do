import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do/authentication/log_in.dart';
import 'package:to_do/models/dialog_model.dart';
import 'package:to_do/models/firebase_functions.dart';
import 'package:to_do/models/user_model.dart';
import 'package:to_do/screens/home_screen.dart';

class RegisterUser {
  static void register(
      {required BuildContext context,
      required String email,
      required String password,
      required String userName}) async {
    DialogModel.showLoding(context);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userModel = UserModel(
          email: email, name: userName, id: credential.user?.uid ?? '');
      await FirebaseFunctions.addUser(userModel);

      DialogModel.hideLoading(context);
      DialogModel.showMessage(
          context: context,
          message: "registersuccessefuly.".tr(),
          posActionName: "ok".tr(),
          posAction: () {
            userProvider.initUsers();
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
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

  static void logIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    DialogModel.showLoding(context);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DialogModel.hideLoading(context);

      DialogModel.showMessage(
          context: context,
          message: "hello".tr(),
          posActionName: "ok".tr(),
          posAction: () {
            userProvider.initUsers();
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
    } on FirebaseAuthException catch (e) {
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
