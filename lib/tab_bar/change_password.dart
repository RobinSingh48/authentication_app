import 'package:authentication_project/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpDatePassword extends StatefulWidget {
  const UpDatePassword({Key? key}) : super(key: key);

  @override
  State<UpDatePassword> createState() => _UpDatePasswordState();
}

class _UpDatePasswordState extends State<UpDatePassword> {
  final _formkey = GlobalKey<FormState>();

  var password = "";

  TextEditingController passwordController = TextEditingController();


  void changePassword()async{
    try{
      await FirebaseAuth.instance.currentUser!.updatePassword(password);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password Change Successfully",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.redAccent,
        dismissDirection: DismissDirection.vertical,
      ));

      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

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
     body : SafeArea(
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
                  obscureText: true,
                  controller: passwordController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "change password",
                    hintText: "change password here",
                    errorStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Empty Filled";
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
                          password = passwordController.text.trim();
                        });
                         changePassword();
                      }
                    },
                    child: Text(
                      "Update Password",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
