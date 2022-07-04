import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String content;
  final Timestamp createdAt;
  final String creator;

  Post(
      {required this.id,
      required this.content,
      required this.createdAt,
      required this.creator});

  factory Post.fromJson(String id, Map<String, dynamic> data) {
    return Post(
        id: id,
        content: data["content"],
        createdAt: data["createdAt"],
        creator: data["creator"]);
  }

  Map<String, dynamic> toJSON() {
    return {"content": content, "createAt": createdAt, "creator": creator};
  }
}