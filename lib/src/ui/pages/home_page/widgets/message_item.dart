
import 'package:flutter/material.dart';
import 'package:gptva/src/src.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message, required this.isLast});

  final MessageModel message;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: KTheme.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 14, backgroundImage: userPhoto()),
              const SizedBox(width: 10),
              Text(
                username.toUpperCase(),
                style: context.textTheme.labelSmall,
              ),
            ],
          ),
       
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: MarkdownWidget(
              text: message.message,
              animated: !message.isUser && isLast && context.wHome.animate,
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider userPhoto() {
    if (message.isUser) {
    }
    return const AssetImage("assets/chatgpt_logo.png");
  }

  String get username {
    return "ChatGPT";
  }
}
