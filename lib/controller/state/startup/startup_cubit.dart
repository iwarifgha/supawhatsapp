import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:whatsapp_clone/controller/features/user/user_service.dart';
import 'package:whatsapp_clone/controller/state/startup/startup_state.dart';
import '../../../helpers/enums/active_status.dart';
import '../../../helpers/utils/locator.dart';
import '../../../supabase_client.dart';


class StartUpCubit extends Cubit<StartUpState>{

  ///This decides where the app should go depending on
  ///whether there is a user cached in the local database.

  StartUpCubit(): super (StartUpInitialState()){
    initialize();
   }

  final  userProvider =  locator<UserService>();
   final supabase = MySupabaseClient.supabase;
   StreamSubscription<InternetStatus>? _internetSubscription;

   test() async {
     _internetSubscription?.cancel();
     _internetSubscription = InternetConnection().onStatusChange.listen((status) {
       if(status == InternetStatus.connected){
         emit(StartUpAuthState());
       }
       if(status == InternetStatus.disconnected) {
         print('disconnected');
         emit(StartUpAuthState());
         //emit(const StartUpErrorState(errorMessage: 'No internet'));
       }
     });
}


  ///If there is a user in the local database, this method will call the HomeCubit
  ///else it calls the AuthCubit to begin the authentication flow.
  initialize()
  async {
     try {
       final user = await userProvider.fetchUser();
       if(user == null){
         emit(StartUpAuthState());
       }
       else {
         emit(const StartUpHomeState(
             status: ActiveStatus.online,
             isLoading: false));
       }
     } on Exception catch (e) {
       emit(StartUpErrorState(errorMessage: e.toString()));
     }


    }
}