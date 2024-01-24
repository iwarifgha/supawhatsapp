import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/model/user/user.dart';

import '../../../model/chat/chat.dart';
import '../../../model/message/message.dart';

abstract class ChatCubitState extends Equatable{
  final bool? hasException;
  final bool? isLoading;
  final String? errorMessage;

  const ChatCubitState({
    this.errorMessage,
    this.hasException,
    this.isLoading
  });
}

class InitialChatState extends ChatCubitState{
  const InitialChatState();
  @override
  List<Object?> get props => [];
}

class ChatRoomState extends ChatCubitState{
  final MyUser user;
  final List<Message> messages;
  final Chat chat;
  const ChatRoomState({
    required this.messages,
    required this.user,
    required this.chat,
    super.isLoading,
    super.errorMessage,
    super.hasException
  });
  @override
  List<Object?> get props => [messages, isLoading, errorMessage, hasException];
}