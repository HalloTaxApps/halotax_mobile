import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;

  const SingleMessage({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
            color: isMe
                ? const Color.fromRGBO(255, 157, 127, 1)
                : const Color.fromRGBO(217, 217, 217, 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
