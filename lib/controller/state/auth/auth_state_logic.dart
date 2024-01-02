import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view/auth/camera_view.dart';
import '../../../view/auth/set_profile.dart';
import '../../../view/auth/sign_in.dart';
import '../../../view/auth/verify_number.dart';
import '../../../view/auth/welcome.dart';
import '../home/home_cubit.dart';
import '../home/home_state_logic.dart';
import 'auth_cubit.dart';
import 'auth_state.dart';

class AuthStateLogic extends StatelessWidget {

  ///Handles the routing for the authentication flow.
  ///Most significant is the AuthStateDone.
  ///When state is AuthStateDone,the HomeCubit is provided to the App.
  const AuthStateLogic({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, state ){
          if(state is AuthStateSignIn){
            return const SignInView();
          }
          else if (state is AuthStateVerifyOtp){
            return VerifyNumberView(phoneNumber: state.phone,);
          }
          else if (state is AuthStateSetProfile){
            return SetProfileView(phone: state.phone,);
          }
          else if (state is AuthStateTakePicture){
            return CameraView(
              cameraDescription: state.camera,
             );
          }
          else if (state is AuthStateSignOut){
            return const WelcomeView();
          }
          else if (state is AuthStateDone){
            return  BlocProvider(
              create: (context) => HomeCubit(),
              child: const HomeStateLogic(),
            );
          }
          else {
            return const Scaffold(
                body: CircularProgressIndicator());
          }
        }
    );
  }
}
