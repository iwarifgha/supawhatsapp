
import 'package:flutter/foundation.dart';
import 'package:whatsapp_clone/model/user/user.dart';
import 'package:whatsapp_clone/supabase.dart';

import '../../../helpers/exceptions/exceptions.dart';
import '../../../helpers/utils/locator.dart';
import '../../../model/chat/chat.dart';
import '../../../model/message/message.dart';
import '../auth/auth_service.dart';


class MessageChatService {









final _supabase = MySupabaseClient.supabase;
final _currentUserNumber = MySupabaseClient.supabase.auth.currentUser?.phone;
final  authProvider =  locator<AuthService>();


///The stream to be listened realtime chats from Supabase
   Stream<List<Chat>> userChats(){
     final currentUser = authProvider.currentUser;
     return _supabase.from('chats').
     stream(primaryKey: ['id']).
     eq('users.id',currentUser?.id).
     order('created_at').
     map((event) => event.map((e) => Chat.fromDatabase(e)).toList());
  }




///The stream to be listened to for realtime messages
Stream<List<Message>>  messageStream(String chatId){
   final msgStream = _supabase.from('messages').
  stream(primaryKey: ['id']).
  eq('chat_id', chatId).
  order('created_at').
  map((event) => event.map((e) => Message.fromDatabase(e)).toList());
   return msgStream;
}



///gets all the chats of the current user using their phone number
Future<Iterable<Chat>> getChats() async {
  var chats =<Chat>[];
  final user = authProvider.currentUser;
  if(user != null){
    final response = await _supabase.from('chats').
    select<List<Map<String, dynamic>>>('*, messages(*), users(*)').
    eq('users.id', user.id);
    chats = response.map((e) => Chat.fromDatabase(e)).toList();
  }
  return chats;

}


///gets a specific chat from the database using its id
Future<Chat> getChatById(String idOfChat) async {
    final response = await _supabase.
    from('chats').
    select<List<Map<String, dynamic>>>().
    eq('id', idOfChat).
    limit(1);
    final chat = Chat.fromDatabase(response.first);
    return chat;
}

Future<Chat> getChatByRecipientPhone({required String phone}) async {
  final response = await _supabase.
  from('chats').
  select<List<Map<String, dynamic>>>('*, messages(*), users(*)' ).
  eq('users.phone', phone).
  limit(1);
  final chat = Chat.fromDatabase(response.first);
  return chat;
}



///inserts a chat into the database
Future<Chat> startChat({required MyUser recipient}) async {
  //create chat instance
  final chatResponse = await _supabase.from('chats').
  insert([{
    'name': recipient.name,
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
  Future<Message> sendMessage({required String message, required String chatId, required String senderId}) async {
    try {
      final response = await _supabase.from('messages').
      insert({'content': message, 'chat_id': chatId, 'sender_id': senderId}).select() as List<dynamic>;
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
       .from('chats')
       .delete()
       .match({ 'chat_id': chatId });
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