

class ChatService {

//will test to see what these do:
/*Future<Iterable<Message>> getMessages(String sender, String recipient) async {
    final response = await supabaseInstance.
    from(messageTable).
    select<List<Map<String, dynamic>>>(messageField).
    match({recipientNumberField: recipient, senderNumberField: sender});
     final messages = response.map((e) => Message.fromDatabase(e));
     return messages;
}

returnAllMessagesOfASpecificChatId(String chatId) async {
    await supabaseInstance.from('chats').select(''' *, messages!inner(*)''').eq('messages.chat_id', chatId);
}*/

//may use this channel or may use stream to return list of messages tied to both the sender and receiver
/* messagesChannel(String id) async {
    final chat = await getChat(id);
  supabaseInstance.channel('messages channel').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', table: 'messages', filter: 'chats_id=eq.${chat.id}'),
          (payload, [ref]) {
        if(payload.toString()  == 'UPDATE'){

        }
        /*
        * here i want to check the kind of event that happened in the messages table
        * if any event has happened, then call the getAllMessages method and add it to the local cache of messages
        * */
          }).subscribe();
}*/
}