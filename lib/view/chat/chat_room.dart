import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/controller/state/chat/chat_cubit.dart';
import 'package:whatsapp_clone/controller/state/chat/chat_state.dart';
import 'package:whatsapp_clone/model/user/user.dart';


import '../../controller/state/home/home_cubit.dart';

import '../../helpers/widgets/chat/chatview_app_bar_widget.dart';
import '../../helpers/widgets/message/input_message_widget.dart';
import '../../helpers/widgets/message/message_list_widget.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key, required this.currentUser,}) : super(key: key);

  final MyUser currentUser;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController  textController = TextEditingController();
  ValueNotifier<bool> isTypingNotifier = ValueNotifier(false);


  void listenerForPageChange(){
    isTypingNotifier.value = textController.text.isEmpty;
  }

  @override
  void initState() {
    textController.addListener(() => listenerForPageChange());
     super.initState();
  }

  @override
  void dispose() {
    textController.addListener(() => listenerForPageChange());
    textController.dispose();
    //context.read<HomeCubit>().deleteChatIfEmpty();
     super.dispose();
  }


  @override
  Widget build(BuildContext context) {
     return  WillPopScope(
       onWillPop: (){
         return context.read<HomeCubit>().startApp(user: widget.currentUser);
       },
       child: BlocBuilder<ChatCubit, ChatCubitState>(
         builder: (context, state) {
           state as ChatRoomState;
           final messages = state.chat.messages;
           final recipient = state.chat.receivers.first;
           return Scaffold(
            //Appbar section
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: ChatViewAppBar(
                    contact: recipient
                )
            ),
             body: Column(
               children: [
                 Expanded(
                   child:  MessagesList(
                     messages: messages!,
                     recipient: recipient,
                   ),
                 ),
                 InputMessageWidget(
                   textController: textController,
                   prefixIcon: Icons.emoji_emotions,
                   firstSuffixIcon: Icons.attachment_rounded ,
                   secondSuffixIcon: Icons.camera_alt_rounded,
                   isTypingNotifier: isTypingNotifier,
                   onRecord: (){},
                   onSend: () async {
                     context.read<ChatCubit>().sendMessage(
                         message: textController.text,
                         chatId: messages.first.chatId,
                         phone: recipient.phoneNumber,
                         currentUser: state.user
                     );
                    },

                 ),
               ],
             ),
           );
         }
       ),
     );
  }
}









