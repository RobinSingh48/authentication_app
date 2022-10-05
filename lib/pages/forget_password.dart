import 'package:authentication_project/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../const/const.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  String email = "";

  void resetPassword() async {
    try {
      if (email != null) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(forgetPasswordScreenSnackBarText,
              style: forgetPasswordScreenSnackBarTextStyle),
          backgroundColor: redAccent,
          dismissDirection: DismissDirection.vertical,
        ));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          ex.code.toString(),
          style: authExpectionTextStyle
        ),
        backgroundColor: redAccent,
        dismissDirection: DismissDirection.vertical,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forget Password",
          style: scaffoldAppBarTitleTextStyle
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  style: textFormTextStyle,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter Email here",
                    errorStyle: textFormErrorTextStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Empty Filled";
                    } else if (!value.contains("@")) {
                      return "Invalid email format";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = emailController.text.trim();
                        });
                        resetPassword();
                      }
                    },
                    child: const Text(
                      "Send Email",
                      style: buttonTextStyle
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
