import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/controller/state/chat/chat_cubit.dart';
import 'package:whatsapp_clone/controller/state/chat/chat_state_logic.dart';
import 'package:whatsapp_clone/controller/state/contact/contact_cubit.dart';
import 'package:whatsapp_clone/controller/state/contact/contact_state.dart';
import 'package:whatsapp_clone/view/contact/contacts_list.dart';

class ContactStateLogic extends StatelessWidget {
  const ContactStateLogic({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocBuilder<ContactCubit, ContactCubitState>(
        builder: (context, state ){
          if(state is ContactListState){
            return const ContactsListView();
          }
          else if (state is ContactSelectedState){
            return  BlocProvider(
              create: (context) => ChatCubit(),
              child: const ChatStateLogic(),
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