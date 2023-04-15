import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halotax/pages/statuschat_page.dart';

import '../../models/user_model.dart';

class ChatpageTextfield extends StatefulWidget {
  final UserModel user;
  final String currentId;
  final String friendId;
  const ChatpageTextfield(
      {super.key,
      required this.user,
      required this.currentId,
      required this.friendId});

  @override
  State<ChatpageTextfield> createState() => _ChatpageTextfieldState();
}

class _ChatpageTextfieldState extends State<ChatpageTextfield> {
  final TextEditingController _controller = TextEditingController();
  // final bool isUSer = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.33,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  String message = _controller.text;
                  _controller.clear();
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.user.uid)
                      .collection('messages')
                      .add({
                    'status': 'new',
                    'type': 'user',
                    'last_msg': message,
                    'senderId': widget.user.uid,
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusChatPage(user: widget.user),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                child: const Text('Kirim'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
