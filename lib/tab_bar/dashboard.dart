import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Welcome Sir",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent),)),
    );
  }
}
