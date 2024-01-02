import 'package:flutter/material.dart';
import 'package:whatsapp_clone/message_model.dart';
import 'package:whatsapp_clone/user_model.dart';

import '../text/app_text_medium.dart';
import '../text/app_text_small.dart';


class ChatTile extends StatelessWidget {
   const ChatTile({Key? key, required this.user, required this.message}) : super(key: key);
  //final TheUser user;
  final AppUser user;
  final AppMessage message;
  //final Message message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(radius: 25,backgroundImage: AssetImage(user.userImage!),),
      title: AppTextMedium(text: user.name!,),
      subtitle: AppTextSmall(text: message.message),
      trailing: const AppTextSmall(text: '2 min'),
    );
  }
}
