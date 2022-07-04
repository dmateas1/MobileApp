import 'package:flutter/material.dart';
import 'package:flutter_assigment_2/model/user.dart';
import 'package:flutter_assigment_2/pages/authentication.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.observedUser}) : super(key: key);

  final User observedUser;

  @override
  State<Profile> createState() => _State();
}

class _State extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.observedUser.name)),
      body: Center(
        child: Text(widget.observedUser.bio),
      ),
    );
  }
}
