import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/controller/state/chat/chat_cubit.dart';
import 'package:whatsapp_clone/controller/state/chat/chat_state_logic.dart';
import 'package:whatsapp_clone/controller/state/contact/contact_cubit.dart';
import 'package:whatsapp_clone/controller/state/contact/contact_state.dart';
import 'package:whatsapp_clone/helpers/utils/loading_overlay.dart';
import 'package:whatsapp_clone/view/contact/contacts_list.dart';

import '../../../helpers/utils/locator.dart';

class ContactStateLogic extends StatelessWidget {
    ContactStateLogic({super.key});



  final alertDialog = locator<AlertOverlay>();
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ContactCubit, ContactCubitState>(
       listener: (context, state){
         if (state.isLoading == false) alertDialog.dismiss();
         if (state.isLoading == true) alertDialog.showLoading(text: 'Loading', context: context);
         if (state.hasException == true && state.errorMessage != null) alertDialog.showError(text: state.errorMessage!, context: context);
         },
        builder: (context, state ){
          if(state is ContactListState){
            return ContactsListView(currentUser: state.currentUser);
          }
          else if (state is ContactSelectedState){
            return  BlocProvider(
              create: (context) => ChatCubit(
                  currentUser: state.currentUser,
                  recipient: state.contact
              ),
              child: ChatStateLogic(),
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