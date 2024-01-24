import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/controller/state/chat/chat_cubit.dart';
import 'package:whatsapp_clone/controller/state/chat/chat_state.dart';
import 'package:whatsapp_clone/view/chat/chat_room.dart';

import '../../../helpers/utils/loading_overlay.dart';
import '../../../helpers/utils/locator.dart';

class ChatStateLogic extends StatelessWidget {
    ChatStateLogic({super.key});

  final alertDialog = locator<AlertOverlay>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatCubitState>(
        listener: (context, state){
          if (state.isLoading == false) alertDialog.dismiss();
          if (state.isLoading == true) alertDialog.showLoading(text: 'Loading', context: context);
          if (state.hasException == true && state.errorMessage != null) alertDialog.showError(text: state.errorMessage!, context: context);
        },
        builder: (context, state ){
          if(state is ChatRoomState){
            return ChatRoom(currentUser: state.user);
          }
          else {
            return const Scaffold(
                body: Center(
                    child: CircularProgressIndicator()));
          }
        }
    );
  }
}
