import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String content;
  final int type;
  final Timestamp createdAt;
  final String fromId;
  final String convoId;

  Message(
      {required this.id,
      required this.content,
      required this.type,
      required this.createdAt,
      required this.fromId,
      required this.convoId});

  factory Message.fromJson(String id, Map<String, dynamic> data) {
    return Message(
        id: id,
        content: data["content"],
        type: data["type"] ?? 0,
        createdAt: data["createdAt"],
        fromId: data["fromId"],
        convoId: data["conversationId"]);
  }

  Map<String, dynamic> toJSON() {
    return {
      "content": content,
      "type": type,
      "createdAt": createdAt,
      "fromId": fromId,
      "conversationId": convoId
    };
  }
}
