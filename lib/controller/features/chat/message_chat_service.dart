
import 'package:flutter/foundation.dart';
import 'package:whatsapp_clone/supabase.dart';

import '../../../helpers/exceptions/exceptions.dart';
import '../../../model/chat/chat.dart';
import '../../../model/message/message.dart';


class MessageChatService {
static const _messageTable = 'messages';
static const _senderNumber = 'sender_number';
static const _messageContent = 'message_content';
static const _id = 'id';
static const _chatsTable = 'chats';
static const _chatRecipientNumber = 'recipient_number';
 //static const _messages = 'messages';
static const _chatId = 'chat_id';
static const _chatOwnerNumber = 'current_user_number';








final _supabase = MySupabaseClient.supabase;
final _currentUserNumber = MySupabaseClient.supabase.auth.currentUser?.phone;




///The stream to be listened realtime chats from Supabase

Stream<List<Chat>>  get chatsStream =>
    _supabase.from(_chatsTable).
    stream(primaryKey: [_id]).
    eq(_chatOwnerNumber, _currentUserNumber).
    order('created_at').
    map((event) => event.map((e) => Chat.fromDatabase(e)).toList());






///The stream to be listened to for realtime messages
Stream<List<Message>>  messageStream(String chatId){
   final msgStream = _supabase.from(_messageTable).
  stream(primaryKey: [_id]).
  eq(_chatId, chatId).
  order('created_at').
  map((event) => event.map((e) => Message.fromDatabase(e)).toList());
   return msgStream;
}



///gets all the chats of the current user using their phone number
Future<Iterable<Chat>> getChats() async {
   final response = await _supabase.from(_chatsTable).
   select<List<Map<String, dynamic>>>('*, messages(*), ').
   eq(_chatOwnerNumber, _currentUserNumber);
   final chats = response.map((e) => Chat.fromDatabase(e));
   return chats;
}


///gets a specific chat from the database using its id
Future<Chat> getChatById(String idOfChat) async {
    final response = await _supabase.
    from(_chatsTable).
    select<List<Map<String, dynamic>>>().
    eq(_id, idOfChat).
    limit(1);
    final chat = Chat.fromDatabase(response.first);
    return chat;
}

Future<Chat> getChatByRecipientPhone({required String phone}) async {
  final response = await _supabase.
  from(_chatsTable).
  select<List<Map<String, dynamic>>>('*, $_messageTable(*)' ).
  eq(_chatRecipientNumber, phone).
  limit(1);
  final chat = Chat.fromDatabase(response.first);
  return chat;
}



///inserts a chat into the database
Future<Chat> startChat({required String recipientNumber}) async {
  //create chat instance
  final chatResponse = await _supabase.from(_chatsTable).
  insert([{
    _chatRecipientNumber: recipientNumber,
    _chatOwnerNumber: _currentUserNumber
  }]).
  select() as List<dynamic>;
  final chat = chatResponse.map((e) => Chat.fromDatabase(e)).toList();
  return chat.first;
}



///inserts a message into the database
//when called first make sure to call createChat();
  //then call sendMessage(),
  //this would mean that a chat would first be inserted into the database then a message is created with that chat id
  //this data is then read by the stream and used to build the UI
  Future<Message> sendMessage({required String message, required String chatId, required String senderNumber}) async {
    try {
      final response = await _supabase.from(_messageTable).
      insert({_messageContent: message, _chatId: chatId, _senderNumber: senderNumber}).select() as List<dynamic>;
      final sentMessage = Message.fromDatabase(response.first);

      if (kDebugMode) {
        print(sentMessage);
      }
      return sentMessage;
    } on Exception {
       throw MessageNotSentException();
    }
  }

  ///delete a chat
 Future<void> deleteChat(String chatId) async {
   await _supabase
       .from(_chatsTable)
       .delete()
       .match({ _chatId: chatId });
 }

 //methods needed
 //update chat/message
//cache chat
//mark as read
//save chat to local cache
//fetch cached chats
//save messages to local cache
//fetch cached messages

}