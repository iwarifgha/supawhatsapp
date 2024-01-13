
import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:whatsapp_clone/controller/features/auth/auth_service.dart';
import 'package:whatsapp_clone/controller/state/startup/startup_state.dart';
import '../../../helpers/utils/locator.dart';


class StartUpCubit extends Cubit<StartUpState>{

  ///This decides where the app should go depending on
  ///whether there is a user or not.

  StartUpCubit(): super (StartUpInitialState()){
    initialize();
   }

  final  authProvider =  locator<AuthService>();

  initialize() async {
    final isConnected = await InternetConnection().hasInternetAccess;
    if(isConnected){
      final user = authProvider.currentUser;
      if(user == null) {
        emit(StartUpAuthState());
      }
      else {
        StartUpHomeState(
            user: user,
            isLoading: null
        );
      }
    }
    else{
      print('disconnected');
       emit(const StartUpErrorState(
          errorMessage: 'No internet')
      );
    }
  }
}