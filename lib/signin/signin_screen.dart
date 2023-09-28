import 'package:eurosom_admin/controller/firestore_controller.dart';
import 'package:eurosom_admin/home/home_page.dart';
import 'package:eurosom_admin/signin/controller/signin_controller.dart';
import 'package:eurosom_admin/utils/app_prefs.dart';
import 'package:eurosom_admin/utils/component/app_button.dart';
import 'package:eurosom_admin/utils/component/app_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool _obscureText = true;
  final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final passRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  void onSignIn() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      LoginController().loginUser(
        email: emailController.text,
        password: passController.text,
        onSuccess: () {
          AppPref().isSetLogin(true);
          FirestoreController().addAdmin(emailController.text, passController.text);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
        onFailure: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        width: Get.width,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/ic_logo.png"),
                height: 130,
              ),
              const Text(
                "Sign in",
                style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: MediaQuery.of(context).size.width * .350,
                child: AppTextField(
                  cursorColor: Colors.grey,
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyBoardType: TextInputType.emailAddress,
                  hintText: "Email",
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter email";
                    } else if (!emailRegex.hasMatch(val)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width * .350,
                child: AppTextField(
                  autoCorrect: true,
                  obscureText: _obscureText,
                  cursorColor: Colors.grey,
                  controller: passController,
                  textInputAction: TextInputAction.done,
                  keyBoardType: TextInputType.visiblePassword,
                  hintText: "Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter password";
                    } else if (!passRegex.hasMatch(value)) {
                      return "Enter valid password";
                    }
                    return null;
                  },
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xff8B8B8B),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width * .350,
                child: AppButton(
                  onPressed: onSignIn,
                  text: "Sign in",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
