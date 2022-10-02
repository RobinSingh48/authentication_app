

import 'package:authentication_project/pages/login_screen.dart';
import 'package:authentication_project/tab_bar/change_password.dart';
import 'package:authentication_project/tab_bar/dashboard.dart';
import 'package:authentication_project/tab_bar/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  static List homePageWidgets = [
        Dashboard(),
        UserProfile(),
        UpDatePassword(),
  ];

  void onItemTap(int index){
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HomeScreen",style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          }, icon: Icon(Icons.exit_to_app))
        ],
      ),

      body: homePageWidgets.elementAt(selectedIndex),
       bottomNavigationBar: BottomNavigationBar(

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Profile"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: "Update Password"
          ),
      ],
         currentIndex: selectedIndex,
         selectedItemColor: Colors.redAccent,
         onTap: onItemTap,
    ),
    );
  }
}
