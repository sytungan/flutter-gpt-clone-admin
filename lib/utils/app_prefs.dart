import 'dart:convert';

import 'package:eurosom_admin/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static final AppPref _myPref = AppPref._internal();

  factory AppPref() {
    return _myPref;
  }

  AppPref._internal();

  late SharedPreferences _prefs;
  static const key_is_signin = '_key_is_sign_in';
  static const key_logged_in_user = 'key_logged_in_user';

  ///
  /// this method is used to initialize the shared preference
  /// it must be called only once when the application is launched first time.
  ///
  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///
  /// this method is used to mark  that the get started method is already shown
  ///

  isSetLogin(bool isSignUp) {
    return _prefs.setBool(key_is_signin, isSignUp);
  }

  bool isGetLogin() {
    return _prefs.getBool(key_is_signin) ?? false;
  }

  set loggedInUser(UserModel user) => _prefs.setString(key_logged_in_user, json.encode(user));

  UserModel get loggedInUser => _prefs.getString(key_logged_in_user) != null
      ? UserModel.fromJson(json.decode(_prefs.getString(key_logged_in_user)!))
      : UserModel.fromJson({});
}
