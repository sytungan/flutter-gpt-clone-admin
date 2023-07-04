import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  static final LoginController _login = LoginController._internal();

  factory LoginController() {
    return _login;
  }

  LoginController._internal();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loginUser({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String) onFailure,
  }) async {
    try {
      final userCred = await auth.signInWithEmailAndPassword(email: email, password: password);
      if (userCred.user != null) {
        userCred.user!.reload();
        // final data = await FirebaseFirestore.instance
        //     .collection("users")
        //     .where("useremail", isEqualTo: email)
        //     .get();
        // if (data.docs.isNotEmpty) {
        //   final user = data.docs.first;
        //   AppPref().loggedInUser = UserModel.tojson(user.data());
        //   print('EMAIL :::: ${ AppPref().loggedInUser.useremail }');
        // }
        onSuccess();
      } else {
        onFailure('this account is not available please check your account and try again');
      }
    } on FirebaseAuthException catch (e) {
      onFailure(e.message ?? "Something went wrong!");
    } catch (error) {
      print('$error');
      onFailure(error.toString());
    }
  }
}
