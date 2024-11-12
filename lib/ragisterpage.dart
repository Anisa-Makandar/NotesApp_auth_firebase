import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_noteapp/domain/custom_textfield.dart';
import 'package:firebase_noteapp/homepage.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobnoController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Name',
                hintText: 'Enter name here...',
              ),
              SizedBox(height: 11),
              CustomTextField(
                controller: emailController,
                label: 'Email',
                hintText: 'Enter email here...',
              ),
              SizedBox(height: 11),
              CustomTextField(
                controller: mobnoController,
                label: 'Mobile No',
                hintText: 'Enter mobile_No here...',
              ),
              SizedBox(height: 11),
              CustomTextField(
                controller: passController,
                label: 'Password',
                hintText: 'Enter password here...',
              ),
              SizedBox(height: 11),
              CustomTextField(
                controller: confirmpassController,
                label: 'Confirm Password',
                hintText: 'Confirm your password...',
              ),
              SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    FirebaseAuth mAuth = FirebaseAuth.instance;
                    if (passController.text == confirmpassController.text) {
                      try {
                        var cred = await mAuth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text);
                        print(
                            "User account created successfully : ${cred.user!.uid}");
                        FirebaseFirestore firestore =
                            FirebaseFirestore.instance;
                        await firestore
                            .collection("users")
                            .doc(cred.user!.uid)
                            .set({
                          "name": nameController.text,
                          "email": emailController.text,
                          "mobNo": mobnoController.text,
                        });
                        print("User data added in firestore !!!");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error : ${e.toString()}")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Password doesn't match !!!")));
                    }
                  },
                  child: Center(
                    child: Text("Sign Up"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
