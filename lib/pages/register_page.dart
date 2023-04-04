import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future signup() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      //add user details when authenticated
      addUserDetails(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        int.parse(_ageController.text),
      );
    }
  }

  Future addUserDetails(
      String firstName, String lastName, String email, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      //users is the collection we specified in firebase web
      //here the format of how to fetch user details
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 211, 206, 235),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello There!!",
                    style: GoogleFonts.bebasNeue(fontSize: 45),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Register below, with your details",
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  //firstName field

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 232, 225, 227),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "First Name",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //last name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 232, 225, 227),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Last Name",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 232, 225, 227),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextField(
                        controller: _ageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Age",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 232, 225, 227),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 232, 225, 227),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 232, 225, 227),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signup,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 72, 30, 116),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I am a member>>",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          "Login Now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 239, 39, 106)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
