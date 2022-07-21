import 'package:flutter/material.dart';
import 'package:flutter_assigment_2/model/conversation.dart';
import 'package:flutter_assigment_2/pages/chat.dart';
import 'package:flutter_assigment_2/services/firestore_service.dart';
import 'create_conversation.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({Key? key}) : super(key: key);

  @override
  State<ConversationsPage> createState() => _ConversationsState();
}

class _ConversationsState extends State<ConversationsPage> {
  final FirestoreService _fs = FirestoreService();
  @override
  void initState() {
    super.initState();
    _fs.setUserConversations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateConversationsPage()));
              },
              icon: const Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: StreamBuilder<List<Conversation>>(
          stream: _fs.userConvos,
          builder: (BuildContext context,
              AsyncSnapshot<List<Conversation>> snapshot) {
            if (snapshot.hasData) {
              List<Conversation> convos = snapshot.data!;
              return convos.isEmpty
                  ? Text(_fs.getUserId())
                  : ListView.builder(
                      itemCount: convos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(conversationName(convos[index])),
                          onTap: () => goToConversation(convos[index]),
                        );
                      });
            } else {
              return const Center(
                  child: Text("There Are Currently No Conversations"));
            }
          }),
    );
  }

  String conversationName(Conversation convo) {
    var convoname = "";

    for (var user in convo.users) {
      if (user != _fs.getUserId()) {
        if (convoname.isEmpty) {
          convoname = FirestoreService.userMap[user]!.name.toUpperCase();
        } else {
          convoname +=
              ",  ${FirestoreService.userMap[user]!.name.toUpperCase()}";
        }
      }
    }

    return convoname;
  }

  void goToConversation(Conversation convo) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ChatPage(conversation: convo, name: conversationName(convo))));
  }
}
