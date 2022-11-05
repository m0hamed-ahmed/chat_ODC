import 'package:chatodc/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  final MessageModel messageModel;
  final String myName = 'Mohamed Ahmed';

  const MessageItem({Key? key, required this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: messageModel.name == myName ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: messageModel.name == myName ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topStart: const Radius.circular(10),
            topEnd: const Radius.circular(10),
            bottomEnd: Radius.circular(messageModel.name == myName ? 0 : 10),
            bottomStart: Radius.circular(messageModel.name == myName ? 10 : 0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(messageModel.name),
                const SizedBox(width: 10),
                Text(DateFormat('hh:mm:ss').format(messageModel.time)),
              ],
            ),
            const SizedBox(height: 10),
            Text(messageModel.text),
          ],
        ),
      ),
    );
  }
}