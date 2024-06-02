import 'package:new_app/Database/UserDao.dart';
import 'package:new_app/Provider/AuthProvidr.dart';
import 'package:new_app/auth/SignUp/SignUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/homescreen.dart';
import '../../pages/Home/HomePages.dart';
import '../TextFormFieldCustom.dart';

class Login extends StatefulWidget {
  static const String routeName = "Login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController Email = TextEditingController(text: "Haaa@gmai.com");

  TextEditingController Password = TextEditingController(text: '123456');

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
                  "Login Here",
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
                  "Welcome back you’ve ",
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
                  Mycontroller: Password,
                  obscureText: true,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                ),
                Container(
                    margin: const EdgeInsets.only(right: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      "Forgot your Password ?",
                      style: TextStyle(
                          color: Color(0xff1F41BB),
                          fontWeight: FontWeight.w700),
                    )),
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
                setState(() {
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                });
                signIn(context);
              },
              child: const Text(
                "Login",
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
                Navigator.of(context)
                    .pushReplacementNamed(SignUpScreen.routeName);
              },
              child: const Text(
                "Create New account",
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

  Future<void> signIn(BuildContext context) async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    var authProvider = Provider.of<AuthProvidr>(context, listen: false);

    try {
      print("Attempting sign-in with email: ${Email.text}");
      await authProvider.login(Email.text, Password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Error occurred during sign-in: $e');
      }
    }
  }
}

bool isValidEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
      .hasMatch(email);
}
