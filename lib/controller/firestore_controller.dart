import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eurosom_admin/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  final users = <UserModel>[].obs;
  final tmpUsers = <UserModel>[].obs;
  final isLoading = true.obs;
  final currentPlan = '0'.obs;
  final selectedTokens = '300'.obs;
  final nameController = TextEditingController().obs;

  final _db = FirebaseFirestore.instance;
  final String _collectionAdmin = "admin";
  final String _collectionUser = "users";

  void checkRadio(String value) {
    currentPlan.value = value;
  }

  addAdmin(
    String email,
    String password,
  ) {
    final admin = FirebaseAuth.instance.currentUser;
    _db
        .collection(_collectionAdmin)
        .doc(admin!.email)
        .set({"useremail": email, "password": password});
  }

  fetchUsers() async {
    isLoading(true);
    final querySnap = await _db.collection(_collectionUser).get();
    final list = List<UserModel>.from(
      querySnap.docs.map((e) => UserModel.fromJson(e.data())),
    );
    users.clear();
    users.addAll(list);
    tmpUsers.clear();
    tmpUsers.addAll(list);
    isLoading(false);
    print('SUCCESS ::::${json.encode(list)}');
  }

  Future<void> updateTokenForUser(UserModel user) async {
    await _db.collection(_collectionUser).doc(user.id).update({"tokens": selectedTokens.value});
    selectedTokens.value = '';
    fetchUsers();
  }

  searchUser(String query) {
    final searchUserList = tmpUsers.where(
      (element) =>
          (element.username ?? '').toLowerCase().contains(query.toLowerCase()) ||
          (element.useremail ?? '').toLowerCase().contains(query.toLowerCase()) ||
          (element.phone ?? '').toLowerCase().contains(query.toLowerCase()),
    );
    users.clear();
    users.addAll(searchUserList);
    print('SEARCH LIST ::: ${searchUserList.length}');
  }
}
