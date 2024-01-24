import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/controller/state/startup/startup_cubit.dart';
import 'package:whatsapp_clone/controller/state/startup/startup_state.dart';
import 'package:whatsapp_clone/helpers/utils/loading_overlay.dart';
import 'package:whatsapp_clone/helpers/utils/locator.dart';

import '../../../helpers/widgets/app/app_button.dart';
import '../auth/auth_cubit.dart';
import '../auth/auth_state_logic.dart';
import '../home/home_cubit.dart';
import '../home/home_state_logic.dart';



class StartUpLogic extends StatelessWidget {
  ///Handles the routing using BlocBuilder.
  ///If the State is StartUpAuthState, it provides the AuthCubit.
  ///If the State is StartUpHomeState, it provides the HomeCubit.
    StartUpLogic({super.key});

  final alertDialog = locator<AlertOverlay>();
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<StartUpCubit, StartUpState>(
         listener: (context, state){
           if (state.isLoading == false) alertDialog.dismiss();
           if (state.isLoading == true) alertDialog.showLoading(text: 'Loading', context: context);
           if (state.hasException == true && state.errorMessage != null) alertDialog.showError(text: state.errorMessage!, context: context);
           },
         builder: (context, state){
          if(state is StartUpAuthState){
            return  BlocProvider(
              create: (context) => AuthCubit(),
              child: AuthStateLogic(),
            );
          }
          else if (state is StartUpHomeState){
            return  BlocProvider(
              create: (context) => HomeCubit(state.user),
              child: HomeStateLogic(),
            );
          }
          else if (state is StartUpErrorState){
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(state.errorMessage!)),
                  const SizedBox(height: 10),
                  AppButton(
                    onTap: () {
                      context.read<StartUpCubit>().start();
                    },
                    text: 'Try again',)
                ],
              ),
            );
          }
          else {
            return  BlocProvider(
              create: (context) => AuthCubit(),
              child: AuthStateLogic(),
            );
          }
        }
    );
  }
}
