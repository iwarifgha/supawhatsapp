import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/message/message.dart';
import '../text/chat_text.dart';



class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message, required this.messageSender, required this.chatRecipient}) : super(key: key);

  //final AppMessage message;
  final Message message;
  final String messageSender;
  final String chatRecipient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //width: double.minPositive,
        decoration: BoxDecoration(
          color: messageSender == chatRecipient ? Colors.greenAccent.shade700.withBlue(155).withAlpha(250): Colors.blueGrey.shade900,

          borderRadius: messageSender == chatRecipient ?
          const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)) :
          const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(10)),
        ),
        constraints: BoxConstraints(
          minWidth: 20,
          maxWidth: MediaQuery.of(context).size.width * 0.65,
          minHeight: 40,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppTextChat(text: message.content),
        ),
      ),
    );
  }
}
