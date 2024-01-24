import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:whatsapp_clone/model/chat/chat.dart';
import '../../../helpers/utils/locator.dart';
import '../../../model/user/user.dart';
import '../../features/chat/chat_service.dart';
import '../../features/contacts/contacts_service.dart';
import '../../features/user/user_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState>{
  final MyUser user;
  HomeCubit(this.user) : super(const HomeStateInitial()){
    startApp(user: user);
  }



  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    _messageSubscription?.cancel();
    return super.close();
  }


  final chatAndMessagesProvider = locator<MessageChatService>();
  final userProvider = locator<UserService>();
  final contactProvider = locator<ContactService>();
  StreamSubscription? _messageSubscription;
  StreamSubscription? _chatSubscription;


  StreamSubscription<InternetStatus>? _networkSubscription ;

  List<Chat> _chats = [];///the local cache of chats




  startApp({
    required MyUser user,
  }) async {
    final isConnected = await InternetConnection().hasInternetAccess;
      if(isConnected){
        _networkSubscription?.cancel();
        _networkSubscription = InternetConnection().onStatusChange.
        listen((InternetStatus status) {
          if(status == InternetStatus.connected){
            final chats = chatAndMessagesProvider.userChats();
            _chatSubscription?.cancel();
            _chatSubscription = chats.listen((listOfChats) {
              emit(HomePageState(
                chats: listOfChats,
                user: user,
               ));
            });
          }
        });
      }
    else {
      emit(HomePageState(user: user));
    }
  }

  goToChatroom({
    required MyUser currentUser,
    required MyUser recipient,
  }){
    emit(HomeChatState(
        currentUser: currentUser,
        recipient: recipient));
  }



  getContacts({
    required MyUser currentUser
}) async {
    emit(HomeContactsState(user: currentUser));
  }







}