import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../style/style.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/homescreen.jpg'),
            height: 300,
            width: 500,
          ),
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(labelText: "Email"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email cannot be empty";
              }
              if (!value.contains("@")) {
                return "Email is in the wrong format";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _password,
            obscureText: true, //will make password hidden
            decoration: const InputDecoration(labelText: "Password"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password cannot be empty";
              }

              return null;
            },
          ),
          TextFormField(
            controller: _username,
            decoration: const InputDecoration(
                labelText: "Username - Fill to register "),
          ),
          TextFormField(
            controller: _bio,
            decoration: const InputDecoration(
                labelText: "Biography - Fill to register "),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                  register();
                });
              },
              child: Text("REGISTER")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                  login(context);
                });
              },
              child: const Text("LOGIN")),
          ElevatedButton(
              onPressed: () {
                forgot();
              },
              child: const Text("FORGOT PASSWORD")),
        ],
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    // login and open up to homepage
    if (_formKey.currentState!.validate()) {
      try {
        var loginResponse = await _auth.signInWithEmailAndPassword(
            email: _email.text, password: _password.text);

        setState(() {
          if (loginResponse.user!.emailVerified) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
          } else {
            snackBar(context, "User Logged In But Email Is not Verified.");
            loginResponse.user!.sendEmailVerification();
          }

          loading = false;
        });
      } catch (e) {
        setState(() {
          snackBar(context, e.toString());
          loading = false;
        });
      }
    }
  }

  Future<void> forgot() async {
    //reset link
    if (_email.text.isNotEmpty) {
      _auth.sendPasswordResetEmail(email: _email.text);
      snackBar(
          context, "Password Reset Link Has Been Sent To The Email Above. ");
    }
  }

  Future<void> register() async {
    //register user
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential registerResponse =
            await _auth.createUserWithEmailAndPassword(
                email: _email.text, password: _password.text);

        _db
            .collection("Users")
            .doc(registerResponse.user!.uid)
            .set({
              "Username": _username.text,
              "Bio": _bio.text,
              "Email": _email.text,
              "createdAt": Timestamp.now()
            })
            .then((value) => snackBar(context, "User Registered Successfully."))
            .catchError((error) =>
                snackBar(context, "Failed To Register User. $error"));

        registerResponse.user!.sendEmailVerification();
        setState(() {
          loading = false;
        });
      } catch (e) {
        setState(() {
          snackBar(context, e.toString());
          loading = true;
        });
      }
    }
  }
}
