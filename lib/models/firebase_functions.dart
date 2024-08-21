import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(fromFirestore: (snapshot, _) {
      return TaskModel.fromJson(snapshot.data()!);
    }, toFirestore: (task, _) {
      return task.toJson();
    });
  }

  static Future<void> addTask(TaskModel task) async {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    var collection = getTaskCollection();
    return collection
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTaskCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel taskModel) {
    return getTaskCollection().doc(taskModel.id).update(taskModel.toJson());
  }

  // Make user collection...
  static CollectionReference<UserModel> getUserCollections() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, options) => user.toJson());
  }

  // Add user to fire store...
  static Future<void> addUser(UserModel userModel) {
    return getUserCollections().doc(userModel.id).set(userModel);
  }

  static Future<UserModel?> getUser() async {
    var querySnapshot = await getUserCollections()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return querySnapshot.data();
  }
}
