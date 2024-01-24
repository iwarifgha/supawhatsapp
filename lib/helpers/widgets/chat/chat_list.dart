import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/helpers/widgets/chat/chat_tile_widget.dart';

import '../../../model/chat/chat.dart';
import '../../../model/user/user.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    Key? key,
    required this.chats,
    required this.onTap,
  }) : super(key: key);

  final List<Chat> chats;
  //final VoidCallback onTap;
  final void Function(MyUser user) onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index){
            return
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5),
                child: InkWell(
                  onTap:(){
                    onTap(chats[index].receivers.first);
                  },
                  child: ChatTile(
                      user: chats[index].receivers.first,
                      message: chats[index].messages!.last
                  ),

                ),
              );
          }),
    );
  }
}