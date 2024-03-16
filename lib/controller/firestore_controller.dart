import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eurosom_admin/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class FirestoreController extends GetxController {
  final users = <UserModel>[].obs;
  final tmpUsers = <UserModel>[].obs;
  final isLoading = true.obs;
  final currentPlan = '0'.obs;
  final selectedTokens = '300'.obs;
  final selectedUsers = <String>[].obs;
  final nameController = TextEditingController().obs;

  final _db = FirebaseFirestore.instance;
  final String _collectionAdmin = "admin";
  final String _collectionUser = "users";
  int page = 1;
  final RefreshController refreshController = RefreshController();

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

  fetchUsers({bool isRefresh = false}) async {
    if (isRefresh) {
      page = 1;
    }
    if (page == 1) {
      isLoading(true);
    }
    final querySnap = await _db
        .collection(_collectionUser)
        .orderBy("purchased", descending: true)
        .limit(20 * page)
        .get();
    final list = List<UserModel>.from(
      querySnap.docs.map((e) => UserModel.fromJson(e.data())),
    );
    users.clear();
    list.sort(
      (a, b) => (b.purchased ?? false)!
          .toString()
          .compareTo((a.purchased ?? false).toString()),
    );
    users.addAll(list);
    tmpUsers.clear();
    tmpUsers.addAll(list);
    tmpUsers.sort(
      (a, b) => (b.purchased ?? false)!
          .toString()
          .compareTo((a.purchased ?? false).toString()),
    );
    if (page == 1) {
      isLoading(false);
    }
    page++;
    if (isRefresh) {
      refreshController.refreshCompleted();
    } else {
      refreshController.loadComplete();
    }
    print('SUCCESS ::::${json.encode(tmpUsers)}');
  }

  Future<void> updateTokenForUser(UserModel user) async {
    final token = int.tryParse(selectedTokens.value);
    final isMonthly = token != null && token <= 500 ? true : false;
    await _db.collection(_collectionUser).doc(user.id).update({
      "tokens": selectedTokens.value,
      'purchased': true,
      'purchasedAt': DateTime.now().toIso8601String(),
      'isMonthly': isMonthly,
    });
    selectedTokens.value = '';
    fetchUsers();
  }

  searchUser(String query) {
    final searchUserList = tmpUsers.where(
      (element) =>
          (element.username ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          (element.useremail ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          (element.phone ?? '').toLowerCase().contains(query.toLowerCase()),
    );
    users.clear();
    users.addAll(searchUserList);
    print('SEARCH LIST ::: ${searchUserList.length}');
  }

  Future<void> disableAccount() async {
    showLoader();
    final usersNeedToUpdate = users.where((e) => selectedUsers.contains(e.id));
    final future = usersNeedToUpdate.map(
      (user) => FirebaseFirestore.instance
          .collection(_collectionUser)
          .doc(user.id)
          .update({
        'purchase': false,
      }),
    );
    await Future.wait(future);
    hideLoader();
    Get.back();
    showMessage("Bulk Users Updated Successfully!");
  }

  showMessage(String message, {String? title, Duration? duration}) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          title ?? "Eurosom",
          style:
              const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
        ),
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.green),
        ),
        icon: Icon(Icons.error, color: Colors.green.shade500),
        shouldIconPulse: false,
        duration: duration ?? const Duration(milliseconds: 3000),
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 8,
        borderColor: Colors.green.shade500,
        backgroundColor: Colors.green.shade100,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(24),
      ),
    );
  }

  showLoader() => Get.dialog(
        Center(
          child: Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const CircularProgressIndicator(),
          ),
        ),
        barrierDismissible: false,
      );

  hideLoader() => Get.back();
}
