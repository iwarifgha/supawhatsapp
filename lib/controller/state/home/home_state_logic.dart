import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/controller/state/contact/contact_cubit.dart';

import '../../../view/chat/chat_room.dart';
import '../../../view/home/home_view.dart';
 import '../contact/contact_state_logic.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class HomeStateLogic extends StatelessWidget {
  const HomeStateLogic({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().startApp();
    return BlocBuilder<HomeCubit, HomeCubitState>(
        builder: (context, state ){
          if(state is HomePageState){
            return const HomeView();
          }
          else if (state is HomeChatState){
            return const ChatRoom();
          }
          else if (state is HomeContactsState){
            return  BlocProvider(
              create: (context) => ContactCubit(),
              child: const ContactStateLogic(),
            );          }
          else {
            return const Scaffold(
                body: Center(
                    child: CircularProgressIndicator()));
          }
        }
    );
  }
}