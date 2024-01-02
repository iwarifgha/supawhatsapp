import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/supabase_client.dart';


import '../../controller/state/home/home_cubit.dart';
import '../../controller/state/home/home_state.dart';

import '../../helpers/widgets/chat/chatview_app_bar_widget.dart';
import '../../helpers/widgets/message/input_message_widget.dart';
import '../../helpers/widgets/message/message_list_widget.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key, required contact,}) : super(key: key);


  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController  textController = TextEditingController();
  ValueNotifier<bool> isTypingNotifier = ValueNotifier(false);
  final sender = MySupabaseClient.supabase.auth.currentUser;



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
         return context.read<HomeCubit>().startApp();
       },
       child: BlocBuilder<HomeCubit, HomeCubitState>(
         buildWhen:(previous, current) {
          var previousState = previous as HomeChatState;
          var currentState = current as HomeChatState;
          return previousState.messages.length != currentState.messages.length;
         },
         builder: (context, state) {
           final myState = state as HomeChatState;
           final messages = myState.messages;
           final contact = myState.contact;

           return Scaffold(
            //Appbar section
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: ChatViewAppBar(
                    contact: contact
                )),
             body: Column(
               children: [
                 Expanded(
                   child:  MessagesList(
                     messages: messages,
                     recipient: contact,
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
                     context.read<HomeCubit>().sendMessage(
                         message: textController.text,
                         chatId: messages.first.chatId,
                         phone: contact.phoneNumber,
                         sender: '2348143253986'
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









