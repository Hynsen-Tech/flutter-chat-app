import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/models/user.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 1,
          bottom: 0,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  label: Text('Write a message...'),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                final message = _messageController.text;
                if (message.trim().isEmpty) {
                  //TODO Error
                  return;
                } else {
                  final User user = FirebaseAuth.instance.currentUser!;
      
                  FirebaseFirestore.instance.collection('chat').add(
                    {
                      'text': message,
                      'createAt': Timestamp.now(),
                      'userId': user.uid,
                      'username': UserModel().getUsername,
                      'userImage': UserModel().getUserImage,
                    },
                  );
      
                  _messageController.clear();
                }
              },
              icon: Icon(
                Icons.send,
              ),
            )
          ],
        ),
      ),
    );
  }
}
