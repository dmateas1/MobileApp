import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String id;
  final List<String> users;
  final Timestamp createdAt;
  final String? lastMessage;

  Conversation(
      {required this.id,
      required this.users,
      required this.createdAt,
      this.lastMessage});

  factory Conversation.fromJson(String id, Map<String, dynamic> data) {
    List<String> users = [];

    if (data[_usersKey] != null) {
      var userData = data[_usersKey] as List<dynamic>;
      for (var user in userData) {
        users.add(user as String);
      }
    }

    return Conversation(
        id: id,
        users: users,
        createdAt: data[_createdKey],
        lastMessage: data[_lastMessageKey]);
  }

  Map<String, dynamic> toJSON() {
    return {
      _usersKey: users,
      _createdKey: createdAt,
      _lastMessageKey: lastMessage
    };
  }
}

const String _usersKey = "users";
const String _createdKey = "create_at";
const String _lastMessageKey = "lastMessage";
