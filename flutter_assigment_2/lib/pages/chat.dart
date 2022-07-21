import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_assigment_2/model/conversation.dart';
import 'package:flutter_assigment_2/services/firestore_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../model/message.dart';
import '../style/style.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key, required this.conversation, required this.name})
      : super(key: key);
  final String name;
  final Conversation conversation;
  final FirestoreService _fs = FirestoreService();
  TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(children: [
        Text(name),
        RatingBar.builder(
          itemCount: 5,
          allowHalfRating: true,
          onRatingUpdate: (rating) {},
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return const Icon(
                  Icons.sentiment_dissatisfied,
                  color: Color.fromARGB(255, 229, 127, 127),
                );
              case 2:
                return const Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return const Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return const Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
            }
            return Text("data");
          },
        ),
      ])),
      body: SafeArea(
          child: Column(
        children: [_messagingArea(context), _inputArea(context)],
      )),
    );
  }

  Widget _messagingArea(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.blueGrey,
      width: screenWidth(context),
      child: StreamBuilder<List<Message>>(
        stream: _fs.messages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messages = [];
            for (var message in snapshot.data!) {
              if (message.convoId == conversation.id) {
                messages.add(message);
              }
            }
            return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool me = messages[index].fromId == _fs.getUserId();

                  return Container(
                      color:
                          me ? Colors.blue : Color.fromARGB(255, 208, 208, 208),
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                              crossAxisAlignment: me
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FirestoreService
                                      .userMap[messages[index].fromId]!.name,
                                  textAlign:
                                      me ? TextAlign.right : TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(messages[index].content,
                                    textAlign:
                                        me ? TextAlign.right : TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    )),
                                Text(
                                  DateFormat('M/dd/yyyy h:mm a').format(
                                      messages[index].createdAt.toDate()),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic),
                                  textAlign:
                                      me ? TextAlign.right : TextAlign.left,
                                )
                              ])));
                });
          } else {
            return const Center(
              child:
                  Text("There are currently no messages in this Conversation"),
            );
          }
        },
      ),
    ));
  }

  Widget _inputArea(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      width: screenWidth(context),
      height: 100,
      child: Row(children: [
        const SizedBox(width: 20),
        Expanded(
            child: TextField(controller: _message, minLines: 1, maxLines: 6)),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send))
      ]),
    );
  }

  void sendMessage() {
    if (_message.text.isNotEmpty) {
      _fs.addMessage(_message.text, conversation);
      _message.clear();
    }
  }
}
