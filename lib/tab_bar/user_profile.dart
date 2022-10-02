import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {


    final userEmail =  FirebaseAuth.instance.currentUser!.email;
    final uid =  FirebaseAuth.instance.currentUser!.uid;
    final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
    
    User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Container(
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   RichText(text: TextSpan(
                     style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                     children: [
                       TextSpan(text: "User ID-"),
                       TextSpan(text: "$uid",style: TextStyle(fontSize: 18,color: Colors.lightBlue))
                     ]
                   )),
                  SizedBox(height: 10,),
                  RichText(text: TextSpan(
                      style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "User Email-"),
                        TextSpan(text: "$userEmail",style: TextStyle(fontSize: 18,color: Colors.lightBlue))
                      ]
                  )),
                  SizedBox(height: 10,),
                  RichText(text: TextSpan(
                      style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "Id Creation Time-"),
                        TextSpan(text: "$creationTime",style: TextStyle(fontSize: 18,color: Colors.lightBlue))
                      ]
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
