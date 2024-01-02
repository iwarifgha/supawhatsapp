import '../message/message.dart';

class Chat{
  final String chatRecipientNumber;
  final String currentUserNumber;
  final String id;
  //not to be inserted directly
  final List<Message>? messages;

  Chat({
    required this.currentUserNumber,
    this.messages,
    required this.chatRecipientNumber,
    required this.id
  });

  static Chat fromDatabase(Map<String, dynamic> value){
    print(value);
    final list = value['messages'] as List;
    final List<Message> messagesList = list.map((item) => Message.fromDatabase(item)).toList();

    return Chat(
        messages: messagesList,
        chatRecipientNumber: value['recipient_number'],
        id: value['id'],
        currentUserNumber: value['current_user_number']
    );
  }
}
