import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../forms/registerform.dart';
import '../style/style.dart';

class Authentication extends StatefulWidget {
  Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthState();
}

class _AuthState extends State<Authentication> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome! Join in on the Talk!"),
        ),
        body: const RegisterForm());
  }

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      try {
        var registerResponse = await _auth.createUserWithEmailAndPassword(
            email: _email.text, password: _password.text);

        setState(() {
          snackBar(context, "User Registered Successfully.");
          loading = false;
        });
      } catch (e) {
        setState(() {
          snackBar(context, e.toString());
          loading = true;
        });
      }
    }

    void login() {
      if (_formKey.currentState!.validate()) {
        _auth
            .signInWithEmailAndPassword(
                email: _email.text, password: _password.text)
            .whenComplete(() => setState(() {
                  loading = false;
                  _password.clear();
                }));
        setState(() {
          loading = false;
        });
      }
    }
  }
}
