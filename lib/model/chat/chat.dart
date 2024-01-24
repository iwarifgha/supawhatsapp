import '../message/message.dart';
import '../user/user.dart';

class Chat{
  final String id;
  final String name;
  final String createdAt;
  final List<MyUser> receivers;
  final List<Message>? messages;

  Chat( {
    this.messages,
    required this.createdAt,
    required this.receivers,
    required this.id,
    required this.name,
  });

  static Chat fromDatabase(Map<String, dynamic> value){
    final returnedMessages = value['messages'] as List;
    final returnedUsers = value['messages'] as List;

    final List<Message> messages =  returnedMessages.map((item) => Message.fromDatabase(item)).toList();
    final List<MyUser> users = returnedUsers.map((item) => MyUser.fromDatabase(item)).toList();

    return Chat(
        messages: messages,
        receivers: users,
        createdAt: value['created_at'],
        id: value['id'],
        name: value['name'],
     );
  }
}
