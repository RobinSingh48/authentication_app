import 'package:authentication_project/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();


  var email = "";
  var password = "";
  var cpassword = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController =  TextEditingController();



   signUp()async{
    try{
      if(password == cpassword){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("User Created Successfully",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          backgroundColor: Colors.redAccent,
          dismissDirection: DismissDirection.vertical,
        ));

        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }

    }on FirebaseAuthException catch(ex){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ex.code.toString(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.redAccent,
        dismissDirection: DismissDirection.vertical,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp", style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Email here",
                        errorStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Empty Filled";
                        } else if (!value.contains("@")) {
                          return "Invalid email format";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      obscureText: true,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter password here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Filled is Empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: cpasswordController,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      obscureText: true,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Enter password here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Filled is Empty";
                        }else if(password != cpassword){
                          return "Please enter same password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text.trim();
                              password = passwordController.text.trim();
                              cpassword = cpasswordController.text.trim();
                            });
                            signUp();
                          }
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(fontSize: 18),
                        )),

                  ],
                ),
              ),
            ),
          ),
      ),
      
    );
  }
}
