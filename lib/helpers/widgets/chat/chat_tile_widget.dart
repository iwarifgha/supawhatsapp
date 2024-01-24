import 'package:flutter/material.dart';


import '../../../model/message/message.dart';
import '../../../model/user/user.dart';
import '../text/app_text_medium.dart';
import '../text/app_text_small.dart';


class ChatTile extends StatelessWidget {
   const ChatTile({Key? key, required this.user, required this.message}) : super(key: key);
   final MyUser user;
   final Message message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(radius: 25,backgroundImage: NetworkImage(user.imageUrl),),
      title: AppTextMedium(text: user.name,),
      subtitle: AppTextSmall(text: message.content),
      trailing: const AppTextSmall(text: '2 min'),
    );
  }
}
