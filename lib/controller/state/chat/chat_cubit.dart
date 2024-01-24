import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:whatsapp_clone/controller/features/auth/auth_service.dart';

import '../../../helpers/utils/locator.dart';
import '../../../model/user/user.dart';
import '../../features/chat/chat_service.dart';
import '../../features/user/user_service.dart';
import 'chat_state.dart';



class ChatCubit extends Cubit<ChatCubitState>{
  final MyUser currentUser;
  final MyUser recipient;
  ChatCubit({
    required this.currentUser,
    required this.recipient,
  }): super(const InitialChatState()){
    startOrGetChat(recipient: recipient, currentUser: currentUser);
  }


  final chatAndMessagesProvider = locator<MessageChatService>();
  final userProvider = locator<UserService>();
  final authProvider = locator<AuthService>();

  StreamSubscription? _messageSubscription;

  @override
  close() async {
    _messageSubscription?.cancel();
    super.close();
  }

  startOrGetChat({
    required MyUser recipient,
    required MyUser currentUser
  }) async {
    final isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected) {
      final userContact = await userProvider.getUserFromSupabaseByPhone(recipient.phoneNumber);
      if (userContact == null){
        throw Exception('User not found');
      }
      final existingChat = await chatAndMessagesProvider.getChatByRecipientPhone(phone:userContact.phoneNumber);
      final messageStream = chatAndMessagesProvider.messageStream(existingChat.id);
      if(existingChat.messages!.isNotEmpty){
        _messageSubscription = messageStream.listen((event) {
          emit(ChatRoomState(messages: event, chat: existingChat, user: currentUser));
        });
      } else {
        final chat = await chatAndMessagesProvider.startChat(recipient: userContact);
        _messageSubscription = messageStream.listen((messages) {
          emit(ChatRoomState(chat: chat, messages: messages, user: currentUser ));
        });
      }
    }
    else {
      throw Exception('NO INTERNET');

    }
  }

  deleteChatIfEmpty() async {
    final isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected) {
      final currentState = state as ChatRoomState;
      final chat = await chatAndMessagesProvider.getChatById(currentState.chat.id);
      if (chat.messages!.isEmpty){
        chatAndMessagesProvider.deleteChat(chat.id);
      }
    }
    else {
      return;
    }
  }

  sendMessage({
    required String message,
    required String chatId,
    required String phone,
    required MyUser currentUser
  }) async {
    final isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected) {
        //await userProvider.getUserFromSupabaseByPhone(phone);
        final messageStream = chatAndMessagesProvider.messageStream(chatId);
        final chat = await chatAndMessagesProvider.getChatById(chatId);
        await chatAndMessagesProvider.sendMessage(message: message, chatId: chat.id, senderId: currentUser.phoneNumber);
        _messageSubscription = messageStream.listen((event) {
          emit(ChatRoomState(chat: chat, messages: event, user: currentUser,));
        });

    }
    else{
      throw Exception('NO INTERNET');
    }

  }
  //send message
//send voice note

}