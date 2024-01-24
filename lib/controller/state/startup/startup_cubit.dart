

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatsapp_clone/controller/features/auth/auth_service.dart';
import 'package:whatsapp_clone/controller/state/startup/startup_state.dart';
import '../../../helpers/utils/locator.dart';


class StartUpCubit extends Cubit<StartUpState>{

  ///This decides where the app should go depending on
  ///whether there is a user or not.

  StartUpCubit(): super (StartUpInitialState()){
     start();
   }

  final  authProvider =  locator<AuthService>();
  StreamSubscription<AuthState>? stateSubscription;

  @override
  close()async {
    stateSubscription?.cancel();
    super.close();
  }


  start(){
    try {
      final state = authProvider.currentState;
      stateSubscription = state.listen((event) {
        print('start up cubit: state stream');
        if (event.event == AuthChangeEvent.signedIn){
          final user = authProvider.currentUser;
          emit(StartUpHomeState(
              user: user!,
              isLoading: null
          ));
        }
        else if (event.event == AuthChangeEvent.tokenRefreshed){
          final user = authProvider.currentUser;
          emit(StartUpHomeState(
              user: user!,
              isLoading: null
          ));
        }
        else {
          emit(StartUpAuthState());
        }
      });
    } on Exception catch (e) {
      emit(StartUpErrorState(
          errorMessage: e.toString()
      ));
    }

  }
 }