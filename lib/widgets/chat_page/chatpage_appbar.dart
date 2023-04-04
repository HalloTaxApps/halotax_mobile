import 'package:flutter/material.dart';
import 'package:halotax/models/user_model.dart';
import 'package:halotax/pages/statuschat_page.dart';

class ChatpageAppbar extends StatefulWidget {
  final UserModel user;
  const ChatpageAppbar({super.key, required this.user});

  @override
  State<ChatpageAppbar> createState() => _ChatpageAppbarState();
}

class _ChatpageAppbarState extends State<ChatpageAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 67,
      backgroundColor: Colors.deepOrange,
      title: Row(
        children: const [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage('https://i.pravatar.cc/100?u=lala'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Muhammad Nur Faiz',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StatusChatPage(
                          user: widget.user,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: const [
                Text(
                  'Status Chat',
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.mail_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
