import 'package:authentication_project/const/const.dart';
import 'package:authentication_project/pages/forget_password.dart';
import 'package:authentication_project/pages/homescreen.dart';
import 'package:authentication_project/pages/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "";
  String password = "";

  void login() async {
    try {
      if (email != null || password != null) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          ex.code.toString(),
          style: authExpectionTextStyle,
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
        centerTitle: true,
        title: const Text(
          loginPage,
          style: scaffoldAppBarTitleTextStyle,
        ),
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
                TextFormField(
                  controller: passwordController,
                  style: textFormTextStyle,
                  obscureText: true,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter password here",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Filled is Empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text.trim();
                        password = passwordController.text.trim();
                      });
                      login();
                    }
                  },
                  child: const Text(
                    "Login",
                    style: buttonTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPassword()));
                      },
                      child: const Text(
                        "Forget Password?",
                        style: forgetPasswordButtonTextStyle
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text(
                          "SignUp",
                          style: signupButtonTextStyle,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
