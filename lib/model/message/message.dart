class Message{
  final String senderId;
  final String? id;
  final String content;
  final String chatId;
  final String createdAt;

  Message({
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.createdAt,
    this.id
  });

  Message.fromDatabase(Map<String, dynamic> value):
      content = value['content'],
      senderId = value['sender_id'],
        createdAt = value['created_at'],
      id = value['id'],
      chatId = value['chat_id'];

}