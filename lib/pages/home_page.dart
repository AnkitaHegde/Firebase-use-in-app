import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/auth_page.dart';
import 'package:firebase/pages/login.dart';
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
  List<String> docIDs = [];

  //get IDs
  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection('users') //get each row from thr collection users
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  // void initstate() {
  //   getDocID();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 52, 16, 112),
          title: Text(
            "   ${user?.email}",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                  onTap: signout, child: Icon(Icons.logout_rounded)),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder(
              future: getDocID(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: GetUserName(documentId: docIDs[index]),
                        tileColor: Colors.deepPurple[100],
                      ),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
