import 'package:bloc/bloc.dart';

import 'chat_cubit_state.dart';



class ChatCubit extends Cubit<ChatCubitState>{
  ChatCubit(): super(InitialChatState());
}