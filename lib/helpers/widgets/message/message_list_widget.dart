
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clone/model/contact/contact.dart';
import 'package:whatsapp_clone/model/message/message.dart';

import '../../../message_model.dart';
import '../../../model/chat/chat.dart';
import '../../../user_model.dart';
import '../chat/chat_bubble_widget.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key,
    required this.messages,
    required this.recipient
  });
  final List<Message> messages;
  final MyContact recipient;

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        padding: const EdgeInsets.only(bottom: 60.0),
        shrinkWrap: true,
        itemCount: messages.length ?? 0,//build a list of mock messages
        itemBuilder: (context, index){
          final messageSender = messages[index].senderNumber;
          final chatRecipient = recipient.phoneNumber;
          final message = messages[index];
          //final message = AppMessage(sender: AppUser(number: ''), message: 'message');
          return  Row(
              mainAxisAlignment: messageSender == chatRecipient ? MainAxisAlignment.end: MainAxisAlignment.start ,
              children: [
                ChatBubble(
                    message: message,
                    messageSender: messageSender,
                    chatRecipient: chatRecipient
                )
              ]
          );
        }
    );
  }
}

