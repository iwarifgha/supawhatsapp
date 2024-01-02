import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view/chat/chat_room.dart';
import '../../../view/contact/contacts_list.dart';
import '../../../view/home/home_view.dart';
 import 'home_cubit.dart';
import 'home_state.dart';

class HomeStateLogic extends StatelessWidget {
  const HomeStateLogic({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().startApp();
    return BlocBuilder<HomeCubit, HomeCubitState>(
        builder: (context, state ){
          if(state is HomeAppState){
            return const HomeView();
          }
          else if (state is HomeShowContactsState){
            return const ContactsListView();
          }
          else if (state is HomeChatState){
            return ChatRoom(
                contact: state.contact
            );
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