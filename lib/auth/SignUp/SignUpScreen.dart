import 'package:new_app/Database/Model/user.dart' as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Provider/AuthProvidr.dart';
import 'package:provider/provider.dart';

import '../TextFormFieldCustom.dart';
import '../login/login.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "Signup";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController Email = TextEditingController();

  TextEditingController Password = TextEditingController();

  TextEditingController ConfirmPassword = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash Screen.png"),
              fit: BoxFit.fill)),
      child: Scaffold(
        body: ListView(children: [
          Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Center(
                    child: Text(
                  "Create New Account",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff14376A)),
                )),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                    child: Text(
                  "Enter your personal  ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
                const Center(
                    child: Text(
                  " been missed! ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldCustom(
                  "Email",
                  controller: Email,
                  Mycontroller: Email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Your Email";
                    } else if (!isValidEmail(text)) {
                      return "Invalid email format";
                    }
                    return null;
                  },
                ),
                TextFormFieldCustom(
                  "Password",
                  controller: Password,
                  Mycontroller: Password,
                  obscureText: true,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Password";
                    }
                    if (text.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    return null;
                  },
                ),
                TextFormFieldCustom(
                  "Confirm Password",
                  controller: ConfirmPassword,
                  Mycontroller: ConfirmPassword,
                  obscureText: true,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter a password";
                    }
                    if (text.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    if (text != Password.text) {
                      return " Password not Match";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  alignment: Alignment.topRight,
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: const Color(0xff1F41BB),
              padding: const EdgeInsets.all(15),
              onPressed: () {
                CreateAcoount();
              },
              child: const Text(
                "Sign In ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Login.routeName);
              },
              child: const Text(
                "Already have an account",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> CreateAcoount() async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    var authProvider = Provider.of<AuthProvidr>(context, listen: false);
    try {
      await authProvider.register(Email.text, Password.text);
      // After successfully creating the account, you may want to perform additional actions
      // such as sending a verification email or navigating to the next screen.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Failed to create user account: ${e.message}');
      }
    }
  }
}

bool isValidEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
      .hasMatch(email);
}
