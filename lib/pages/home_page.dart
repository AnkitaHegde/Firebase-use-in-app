import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase/auth/auth_page.dart';
import 'package:firebase/pages/login.dart';
import 'package:firebase/pages/settings.dart';
import 'package:firebase/read_data/get_user_name.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future signout() async {
    FirebaseAuth.instance.signOut();
    return AuthPage();
  }

  final user = FirebaseAuth.instance.currentUser;
  //document IDs . Tow fetch each item from input(of register page) elem

  // void initstate() {
  //   getDocID();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 209, 196, 233),
        bottomNavigationBar: CurvedNavigationBar(
          items: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingPage();
                  }));
                },
                child: Icon(Icons.settings)),
            Icon(Icons.person_outline_rounded),
            GestureDetector(onTap: signout, child: Icon(Icons.logout_rounded))
          ],
          backgroundColor: Color.fromARGB(255, 209, 196, 233),
          animationDuration: Duration(microseconds: 500),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "   ${user?.email}",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
