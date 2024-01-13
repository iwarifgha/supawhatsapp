import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/controller/state/startup/startup_cubit.dart';
import 'package:whatsapp_clone/controller/state/startup/startup_state.dart';

import '../../../helpers/widgets/app/app_button.dart';
import '../auth/auth_cubit.dart';
import '../auth/auth_state_logic.dart';
import '../home/home_cubit.dart';
import '../home/home_state_logic.dart';



class StartUpLogic extends StatelessWidget {
  ///Handles the routing using BlocBuilder.
  ///If the State is StartUpAuthState, it provides the AuthCubit.
  ///If the State is StartUpHomeState, it provides the HomeCubit.
  const StartUpLogic({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocBuilder<StartUpCubit, StartUpState>(
        builder: (context, state){
          if(state is StartUpAuthState){
            return  BlocProvider(
              create: (context) => AuthCubit(),
              child: const AuthStateLogic(),
            );
          }
          else if (state is StartUpHomeState){
            return  BlocProvider(
              create: (context) => HomeCubit(),
              child: const HomeStateLogic(),
            );
          }
          else if (state is StartUpErrorState){
            return Scaffold(
              body: Column(
                children: [
                  Center(
                      child: Text(state.errorMessage)),
                  AppButton(
                    onTap: () {
                      context.read<StartUpCubit>().initialize();
                    },
                    text: 'Try again',)
                ],
              ),
            );
          }
          else {
            return const Scaffold(
                body: Center(
                    child: CircularProgressIndicator())
            );
          }
        }
    );
  }
}
