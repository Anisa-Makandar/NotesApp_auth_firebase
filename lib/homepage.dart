import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_noteapp/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_notepage.dart'; // Ensure the path to AddPage is correct

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  SharedPreferences? prefs;
  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  Future<void> logout() async {
    await prefs?.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection("notes").snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            return snapshot.data!.docs.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      var doc = snapshot.data!.docs[index];
                      var data = doc.data();

                      return ListTile(
                        title: Text(data["title"]),
                        subtitle: Text(data["desc"]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                // Navigate to AddPage with note data for editing
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddPage(
                                      isUpdate: true,
                                      id: doc.id,
                                      title: data["title"],
                                      desc: data["desc"],
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                // Delete note from Firestore
                                await firestore
                                    .collection("notes")
                                    .doc(doc.id)
                                    .delete();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No notes added yet...."),
                  );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddPage to add a new note
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
