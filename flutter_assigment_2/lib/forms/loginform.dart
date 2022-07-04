import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../style/style.dart';
import '../widgets/loading.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/homescreen.jpg')),
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
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (value.length < 7) {
                      return "Password is too short";
                    }
                    return null;
                  },
                ),
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
                ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    child: const Text("REGISTER")),
              ],
            ),
          );
  }

  Future<void> login(BuildContext context) async {
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
    if (_email.text.isNotEmpty) {
      _auth.sendPasswordResetEmail(email: _email.text);
      snackBar(
          context, "Password Reset Link Has Been Sent To The Email Above. ");
    }
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
  }
}
