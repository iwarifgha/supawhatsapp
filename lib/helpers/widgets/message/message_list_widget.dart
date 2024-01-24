
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clone/model/message/message.dart';
import 'package:whatsapp_clone/model/user/user.dart';

 import '../chat/chat_bubble_widget.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key,
    required this.messages,
    required this.recipient
  });
  final List<Message> messages;
  final MyUser recipient;

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        padding: const EdgeInsets.only(bottom: 60.0),
        shrinkWrap: true,
        itemCount: messages.length,
        itemBuilder: (context, index){
          final messageSender = messages[index].senderId;
          final chatRecipient = recipient.phoneNumber;
          final message = messages[index];
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

