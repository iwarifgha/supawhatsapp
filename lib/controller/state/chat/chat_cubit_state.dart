import 'package:equatable/equatable.dart';

abstract class ChatCubitState extends Equatable{
  const ChatCubitState();
}

class InitialChatState extends ChatCubitState{

  @override
  List<Object?> get props => [];
}