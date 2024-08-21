import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/firebase_functions.dart';
import 'package:to_do/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? fireBaseUsers;
  UserModel? userModel;
  UserProvider() {
    fireBaseUsers = FirebaseAuth.instance.currentUser;
    if (fireBaseUsers != null) {
      initUsers();
    }
  }

  initUsers() async {
    userModel = await FirebaseFunctions.getUser();
    notifyListeners();
  }
}
