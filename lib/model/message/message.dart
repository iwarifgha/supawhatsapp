class Message{
  final String senderNumber;
  final String? id;
  final String messageContent;
  final String chatId;

  Message({
    required this.chatId,
    required this.senderNumber,
    required this.messageContent,
    this.id
  });

  Message.fromDatabase(Map<String, dynamic> value):
      messageContent = value['message_content'],
      senderNumber = value['sender_number'],
      id = value['id'],
      chatId = value['chat_id'];

}