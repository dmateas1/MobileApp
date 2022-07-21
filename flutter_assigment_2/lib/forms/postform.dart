import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assigment_2/services/firestore_service.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _fs = FirestoreService();
  final TextEditingController _content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        maintainBottomViewPadding: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _content,
                minLines: 5,
                maxLines: 5,
              ),
              ElevatedButton(
                  onPressed: _submitPost, child: const Text("Submit Post"))
            ],
          ),
        ));
  }

  void _submitPost() {
    _fs.addPosts({
      "content": _content.text,
      "createdAt": Timestamp.now(),
      "creator": _auth.currentUser!.uid
    }).then((value) => Navigator.of(context).pop());
  }
}
