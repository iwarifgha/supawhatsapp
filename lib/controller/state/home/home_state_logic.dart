import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/controller/state/chat/chat_state_logic.dart';
import 'package:whatsapp_clone/controller/state/contact/contact_cubit.dart';
import 'package:whatsapp_clone/helpers/utils/loading_overlay.dart';
import 'package:whatsapp_clone/helpers/utils/locator.dart';

import '../../../view/chat/chat_room.dart';
import '../../../view/home/home_view.dart';
 import '../chat/chat_cubit.dart';
import '../contact/contact_state_logic.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class HomeStateLogic extends StatelessWidget {
    HomeStateLogic({super.key});

  final alertDialog = locator<AlertOverlay>();

  @override
  Widget build(BuildContext context) {
    //context.read<HomeCubit>().startApp();
    return BlocConsumer<HomeCubit, HomeCubitState>(
      listener: (context, state){
        if (state.isLoading == false) alertDialog.dismiss();
        if (state.isLoading == true) alertDialog.showLoading(text: 'Loading', context: context);
        if (state.hasException == true && state.errorMessage != null) alertDialog.showError(text: state.errorMessage!, context: context);
      },
        builder: (context, state ){
          if(state is HomePageState){
            return HomeView(currentUser: state.user,);
          }
          else if (state is HomeChatState){
            return  BlocProvider(
              create: (context) => ChatCubit(
                  currentUser: state.currentUser,
                  recipient: state.recipient
              ),
              child: ChatStateLogic(),
            );
          }
          else if (state is HomeContactsState){
            return  BlocProvider(
              create: (context) => ContactCubit(state.user),
              child: ContactStateLogic(),
            );
          }
          else {
            return const Scaffold(
                body: Center(
                    child: CircularProgressIndicator()
                ));
          }
        }
    );
  }
}