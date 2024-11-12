import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final bool isUpdate;
  final String? id;
  final String title;
  final String desc;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  AddPage({
    this.isUpdate = false,
    this.id,
    this.title = "",
    this.desc = "",
  });

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      titleController.text = title;
      descController.text = desc;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Edit Note' : 'Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter title here...",
                label: Text('Title'),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              controller: descController,
              maxLines: 3,
              minLines: 2,
              decoration: InputDecoration(
                hintText: "Enter description here...",
                label: Text('Description'),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      if (titleController.text.isNotEmpty &&
                          descController.text.isNotEmpty) {
                        if (isUpdate && id != null) {
                          // Update existing note
                          await firestore.collection("notes").doc(id).update({
                            "title": titleController.text,
                            "desc": descController.text,
                          });
                        } else {
                          // Add new note
                          await firestore
                              .collection("notes")
                              .doc("${DateTime.now().microsecondsSinceEpoch}")
                              .set({
                            "title": titleController.text,
                            "desc": descController.text,
                            "created_at": DateTime.now().microsecondsSinceEpoch,
                          });
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(isUpdate ? "Update Note" : "Add Note"),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
