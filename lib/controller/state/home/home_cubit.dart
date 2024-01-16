import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../../helpers/utils/locator.dart';
import '../../features/chat/message_chat_service.dart';
import '../../features/contacts/contacts_service.dart';
import '../../features/user/user_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState>{
  HomeCubit() : super(const HomeStateInitial()){
    startApp();
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








  startApp() async {
    final isConnected = await InternetConnection().hasInternetAccess;
      if(isConnected){
        _networkSubscription?.cancel();
        _networkSubscription = InternetConnection().onStatusChange.
        listen((InternetStatus status) {
          if(status == InternetStatus.connected){
            final chats = chatAndMessagesProvider.chatsStream;
            _chatSubscription?.cancel();
            _chatSubscription = chats.listen((listOfChats) {
              emit(HomePageState(
                  chats: listOfChats,
               ));
            });
          }
        });
      }
    else {
      emit(const HomePageState());
    }
  }



  getContacts() async {
    emit(const HomeContactsState());
  }

  startOrGetChat(String phone) async {
    final isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected) {
      final userContact = await userProvider.getUserFromSupabaseByPhone(phone);
      if (userContact == null){
        throw Exception('User not found');
      }
      final existingChat = await chatAndMessagesProvider.getChatByRecipientPhone(phone:userContact.phoneNumber);
      final messageStream = chatAndMessagesProvider.messageStream(existingChat.id);
      if(existingChat.messages!.isNotEmpty){
        _messageSubscription = messageStream.listen((event) {
          emit(HomeChatState(chat: existingChat));
        });
      } else {
        final chat = await chatAndMessagesProvider.startChat(recipientNumber: userContact.phoneNumber );
        _messageSubscription = messageStream.listen((event) {
          emit(HomeChatState(chat: chat ));
        });
      }
    }
    else {
      throw Exception('NO INTERNET');

    }
  }

  sendMessage({
    required String message,
    required String chatId,
    required String phone,
    required String sender
  }) async {
    final isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected) {
      if (state is HomeChatState) {
        await userProvider.getUserFromSupabaseByPhone(phone);
        final messageStream = chatAndMessagesProvider.messageStream(chatId);
        final chat = await chatAndMessagesProvider.getChatById(chatId);
        await chatAndMessagesProvider.sendMessage(message: message, chatId: chatId, senderNumber: sender);
        _messageSubscription = messageStream.listen((event) {
          emit(HomeChatState(chat: chat));
        });
      }
    }
    else{
      throw Exception('NO INTERNET');
    }

   }

   deleteChatIfEmpty() async {
     final isConnected = await InternetConnection().hasInternetAccess;
     if (isConnected) {
       final currentState = state as HomeChatState;
      final chat = await chatAndMessagesProvider.getChatByRecipientPhone(
          phone: currentState.chat.receiver.phoneNumber
      );
       if (chat.messages!.isEmpty){
        chatAndMessagesProvider.deleteChat(chat.id);
      }
    }
     else {
       return;
     }
  }


}