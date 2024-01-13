import '../message/message.dart';
import '../user/user.dart';

class Chat{
  final String id;
  final MyUser receiver;
  final List<Message>? messages;

  Chat({
    this.messages,
    required this.receiver,
    required this.id
  });

  static Chat fromDatabase(Map<String, dynamic> value){
    final list = value['messages'] as List;
    final List<Message> messagesList = list.map((item) => Message.fromDatabase(item)).toList();

    return Chat(
        messages: messagesList,
        receiver: value['receiver'],
        id: value['id'],
     );
  }
}
