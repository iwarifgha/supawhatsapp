

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/helpers/widgets/text/app_text_medium.dart';

import '../../../model/contact/contact.dart';

class ChatViewAppBar extends StatelessWidget {
  const ChatViewAppBar({super.key, required this.contact});

  final MyContact contact;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.arrow_back),
      title: Row(
        children: [
          //CircleAvatar(backgroundImage: AssetImage( user.imageUrl!)),
          const SizedBox(width: 10,),
          AppTextMedium(text: contact.phoneNumber.toString())
        ],
      ),
      actions: const [
        Icon(Icons.camera_alt_outlined,),
        SizedBox(width: 20,),
        Icon(Icons.search_outlined,),
        SizedBox(width: 18,),
        Icon(Icons.more_vert_outlined)
      ],
    );
  }
}