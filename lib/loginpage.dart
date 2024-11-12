import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_noteapp/domain/custom_textfield.dart';
import 'package:firebase_noteapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              controller: emailController,
              label: 'Email',
              hintText: 'Enter email here...',
            ),
            SizedBox(height: 11),
            CustomTextField(
              controller: passController,
              label: 'Password',
              hintText: 'Enter password here...',
            ),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  FirebaseAuth mAuth = FirebaseAuth.instance;

                  try {
                    var cred = await mAuth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passController.text);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isLoggedIn', true);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                    print("User signed in successfully : ${cred.user!.uid}");
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error : ${e.toString()}")));
                  }
                },
                child: Center(
                  child: Text("Sign In"),
                )),
          ],
        ),
      ),
    );
  }
}
