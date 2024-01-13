import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../../helpers/enums/active_status.dart';
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
            _chatSubscription = chats.listen((event) {
              for(var chat in event){
                //add it to the local stream of chats
              }
              emit(HomeAppState(chats: event, status: ActiveStatus.online, hasConnection: true));
            });
          }
        });
      }
    else {
      emit(const HomeAppState(status: ActiveStatus.offline, hasConnection: false));
    }
  }



  showContacts() async {
    final contacts = await contactProvider.getContacts();
    emit(HomeShowContactsState(contacts: contacts, hasConnection: true));
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