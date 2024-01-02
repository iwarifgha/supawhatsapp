


import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/model/message/message.dart';

import '../../../helpers/enums/active_status.dart';
import '../../../model/chat/chat.dart';
import '../../../model/contact/contact.dart';


abstract class HomeCubitState extends Equatable {
  const HomeCubitState();
}


class HomeStateInitial extends HomeCubitState {
   const HomeStateInitial();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeStateStatus extends HomeCubitState {
  const HomeStateStatus();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeShowContactsState extends HomeCubitState {

  final List<MyContact> contacts;
  final bool? hasConnection;

  const HomeShowContactsState({
    this.hasConnection,
    required this.contacts
  });

  @override
  // TODO: implement props
  List<Object?> get props => [hasConnection, contacts];
}



class HomeChatState extends HomeCubitState {
  final MyContact contact;
  final List<Message> messages;

  const HomeChatState({
    required this.contact,
    required this.messages
  });

  @override
  // TODO: implement props
  List<Object?> get props => [contact, messages];

}

class HomeAppState extends HomeCubitState {
  final ActiveStatus status;
  final List<Chat>? chats;
  final bool? hasConnection;
  const HomeAppState({required this.status, this.chats, this.hasConnection});

  @override
  // TODO: implement props
  List<Object?> get props =>  [status, chats, hasConnection];
}